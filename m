Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125D77D371
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbjHOTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbjHOTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4E13D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B0C761512
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97903C433C7;
        Tue, 15 Aug 2023 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692128456;
        bh=8g1V2U9DDvVe36zEqjZJlW1qpXsMRK71ka/aX21h/m8=;
        h=Date:From:To:Cc:Subject:From;
        b=MuisWKOaWFRxlG7VFHq9OX1Q3LtUMePSeiX33n/kQ66QuhOUqg5klYouPr7zLkyDU
         hs5ogdAQoXdlF9LfDSoz39uxb/nqPBcHEyvsm6Ypd4u6HetGjMDvsnyXMtAVbOJOH1
         pPRbLOIC5IfmHjdlGl7X0UYoRsHgBrQx8dpNZ3sYiwkyuAOSA4rt5dgVhpKEfHVBWz
         Xu2O13gCpqWFtjyq7r5rXSVQURxh5s7ySF30mC9NG4IWwhiu3JrOPYJyse9+EzVcmF
         si4ja2GytsnF81jxSb460IUzSMJw0uLsHTp02kyfN9hqJcsIOBlJ6wrjgN0FAmFf3m
         v/cLH1Amuo8QA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1972404DF; Tue, 15 Aug 2023 16:40:53 -0300 (-03)
Date:   Tue, 15 Aug 2023 16:40:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf tests trace+probe_vfs_getname.sh: Accept quotes
 surrounding the filename
Message-ID: <ZNvUxbmMpa4IR/pc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With augmented_raw_syscalls transformed into a BPF skel made the output have a "
around the filenames, which is not what the old perf probe vfs_getname
method of obtaining filenames did, so accept the augmented way, with the
quotes.

At this point probably removing all the logic for the vfs_getname method
is in order, will do it at some point.

For now lets accept with/without quotes and make that test pass.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 3697f054ce1903ac..4014487cf4d933da 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
 trace_open_vfs_getname() {
 	evts="$(echo "$(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed ':a;N;s:\n:,:g')"
 	perf trace -e $evts touch $file 2>&1 | \
-	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
-- 
2.41.0

