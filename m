Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2B76D9B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjHBVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E01FCB;
        Wed,  2 Aug 2023 14:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4553061B30;
        Wed,  2 Aug 2023 21:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72415C433C7;
        Wed,  2 Aug 2023 21:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012305;
        bh=8dOimt3vdkaAjzI7G4dhYUIgTxfdr7B/s9xezjbAas0=;
        h=Date:From:To:Cc:Subject:From;
        b=B3zRHNx6GZ75Y6L+34MW8KQCVBnDorrZ/IjNL9VfnMhS3Z8szybdtyLKb9Y77O3hT
         PMoY10mqNYdoz4yNLGoxT3nrt7i6Cw7MD5eNzVFr2eO48+evEVVEQhomAxdostN+cZ
         4AJfcGIal61HdoPvOWUJPzPVY8w+PCcFTF2ToAG13Tc4kD27yf+DshmQIKZy7nz9PE
         YWookCSqZP/FzdShIt5jke/i8jf7CYr6fSrOu/4CDwhOjj0bik+KTU0QrR57sAYEyQ
         qN6ifQl2RM5VZYrZxscv/SDIz/4hz3+aP15tSq9BfMhdOptR6uHSiWhhDzjmpGvp0C
         tPf5cmzJkg3vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 217024012D; Wed,  2 Aug 2023 18:38:22 -0300 (-03)
Date:   Wed, 2 Aug 2023 18:38:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mohamed Mahmoud <mmahmoud@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf annotate bpf: Don't enclose non-debug code with an
 assert()
Message-ID: <ZMrMzoQBe0yqMek1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 616b14b47a86d880 ("perf build: Conditionally define NDEBUG") we
started using NDEBUG=1 when DEBUG=1 isn't present, so code that is
enclosed with assert() is not called.

In dd317df072071903 ("perf build: Make binutil libraries opt in") we
stopped linking against binutils-devel, for licensing reasons.

Recently people asked me why annotation of BPF programs wasn't working,
i.e. this:

  $ perf annotate bpf_prog_5280546344e3f45c_kfree_skb

was returning:

  case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
     scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");

This was on a fedora rpm, so its new enough that I had to try to test by
rebuilding using BUILD_NONDISTRO=1, only to get it segfaulting on me.

This combination made this libopcode function not to be called:

        assert(bfd_check_format(bfdf, bfd_object));

Changing it to:

	if (!bfd_check_format(bfdf, bfd_object))
		abort();

Made it work, looking at this "check" function made me realize it
changes the 'bfdf' internal state, i.e. we better call it.

So stop using assert() on it, just call it and abort if it fails.

Probably it is better to propagate the error, etc, but it seems it is
unlikely to fail from the usage done so far and we really need to stop
using libopcodes, so do the quick fix above and move on.

With it we have BPF annotation back working when built with
BUILD_NONDISTRO=1:

  ⬢[acme@toolbox perf-tools-next]$ perf annotate --stdio2 bpf_prog_5280546344e3f45c_kfree_skb   | head
  No kallsyms or vmlinux with build-id 939bc71a1a51cdc434e60af93c7e734f7d5c0e7e was found
  Samples: 12  of event 'cpu-clock:ppp', 4000 Hz, Event count (approx.): 3000000, [percent: local period]
  bpf_prog_5280546344e3f45c_kfree_skb() bpf_prog_5280546344e3f45c_kfree_skb
  Percent      int kfree_skb(struct trace_event_raw_kfree_skb *args) {
                 nop
   33.33         xchg   %ax,%ax
                 push   %rbp
                 mov    %rsp,%rbp
                 sub    $0x180,%rsp
                 push   %rbx
                 push   %r13
  ⬢[acme@toolbox perf-tools-next]$

Fixes: 6987561c9e86eace ("perf annotate: Enable annotation of BPF programs")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mohamed Mahmoud <mmahmoud@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ba988a13dacb6c98..82956adf99632d74 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1846,8 +1846,11 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	perf_exe(tpath, sizeof(tpath));
 
 	bfdf = bfd_openr(tpath, NULL);
-	assert(bfdf);
-	assert(bfd_check_format(bfdf, bfd_object));
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
 
 	s = open_memstream(&buf, &buf_size);
 	if (!s) {
@@ -1895,7 +1898,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 #else
 	disassemble = disassembler(bfdf);
 #endif
-	assert(disassemble);
+	if (disassemble == NULL)
+		abort();
 
 	fflush(s);
 	do {
-- 
2.37.1

