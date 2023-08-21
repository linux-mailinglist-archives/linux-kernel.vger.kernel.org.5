Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BCF782AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjHUNsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjHUNsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E00DB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D905637A0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44702C433CA;
        Mon, 21 Aug 2023 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625689;
        bh=XP1QG1+XghAnVdkbzKtnMovQyjzQggJz8Y4I10RC/0k=;
        h=Date:From:To:Cc:Subject:From;
        b=ZX6IFdPa18CZiBwM1hCxqxVF0KDvAs6Htac6y6NWr8/VFxjw/7QB3Mkyxc2M1nOe3
         QYM3n95I3wS2aWSiyURTwBjCssY4OQpbzuj/EdcLHTzZBnHFbsVSY2rkfbB3kmKp6y
         Lwsg58MQGRp9YCkF2lTKhx8yoLto+a1/jeeBrSGTMkH3XtfBa3Mh0goqRr0Idtba8T
         nivOruPlonccNm+jGTAxmtDQd+aSGypEslZOSUfdQf4bzuI++QabTIgYB0GB9lB7Bt
         VBlL1BUPsv7nSZr8b8oB4xePQZqT0M4thbK7oYdO2fBnIfnPMmPa0jGlwSVaftWLIz
         BGnoWPeBqLWqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08AB940722; Mon, 21 Aug 2023 10:48:06 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:48:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf bpf augmented_raw_syscalls: Add an assert to make sure
 sizeof(saddr) is a power of two.
Message-ID: <ZONrFmJBNlQpSpZj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're using the BPF verifier suggestion:

    22: (85) call bpf_probe_read#4
    R2 min value is negative, either use unsigned or 'var &= const'

That works only when const is a (power of two - 1) so add an assert to
make sure that that is the case.

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9c1d0b271b20f693..43549b63b433d81e 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -10,6 +10,16 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
+/**
+ * is_power_of_2() - check if a value is a power of two
+ * @n: the value to check
+ *
+ * Determine whether some value is a power of two, where zero is *not*
+ * considered a power of two.  Return: true if @n is a power of 2, otherwise
+ * false.
+ */
+#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
+
 #define MAX_CPUS  4096
 
 // FIXME: These should come from system headers
@@ -187,6 +197,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
+	_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
 	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
-- 
2.37.1

