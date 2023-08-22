Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949747840DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjHVMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjHVMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2811BD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E2E7655C3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3987FC433C7;
        Tue, 22 Aug 2023 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692707599;
        bh=vnIdzGAF0y6qaOS7FfPLpa7ABxpUY3LbjrqN9lIQpCA=;
        h=Date:From:To:Cc:Subject:From;
        b=urCgWTBa6jErPRUjQi1CCUDEitgFysTzl+gky0LLDucR53VWS20E1JGNk+0pID/5R
         t/AZgw0FsHAWItB2qoToFsHMShdA8jg7l8btplsDygs1Dyd5yuq9PXlT66fpGH3qhH
         Rj3g8WGtvGsLlp9s4iTPqVZ2oQlDkHQ6GuSMmTY+dCzNpcQ98+NC5vyEoJ/T8SeVsV
         0kuzubchgKJD+6LeWjTcRDLqA+wZrflLLTxBBBYiaq69R5kUIMm5jXj9ATFO4W8ZvO
         jOzvLUqfUOfnr+v6O0JVJIXxgpFbrpiCdQ0U5OmGg78bDtDLhmz6BJrbDmDAZXlq6c
         pcj/qq61BR9VQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72B8440722; Tue, 22 Aug 2023 09:33:16 -0300 (-03)
Date:   Tue, 22 Aug 2023 09:33:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, amadio@ghostprotocols.net,
        Namhyung Kim <namhyung@kernel.org>,
        Guilherme Amadio <amadio@gentoo.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf tools: Options being passed to clang when building the BPF part
 of skels
Message-ID: <ZOSrDGujou8WwS5r@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	On gentoo I'm noticing this:

clang-16clang-16: : clang-16error: : error: clang-16clang-16: clang-16clang-16clang-16: clang-16error: clang-16: : ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]: : : clang-16error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: error: : 
error: 
error: error: error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]error: ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]

ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]

ignoring '-fstack-protector-strong' option as it is not currently supported for target 'bpf' [-Werror,-Woption-ignored]

And while just doing:

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a5dd1ba..7726b57 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1101,7 +1101,7 @@ else
 endif
 
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
-	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	$(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror -Wno-option-ignored $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)


"Fixes" it, I'm curious as where is that we're setting up the options
that are being passed to clang at:

tools/perf/Makefile.perf

$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
        $(QUIET_CLANG)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
          -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@

Perhaps it is plain just using CFLAGS? I.e. maybe the native build
CFLAGS is being passed to the BPF target clang calls?

Ideas?

- Arnaldo
