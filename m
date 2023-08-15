Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CDE77D36A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjHOTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbjHOTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2CA198B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9B262EAA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DF0C433C8;
        Tue, 15 Aug 2023 19:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692128018;
        bh=qwY/x736kK9NLDTulQUo9rEYtvF+59bBYdBMcjqNfEs=;
        h=Date:From:To:Cc:Subject:From;
        b=WclmO+4kvxC84XG4Xb71CiQza/B07wkMDRwJ6IdzfSO8jsRY/tJAhcuaviepGNb/q
         cXjSFUu/xYCmeH+5JvihOFPEUOXtO7bDebYaIhVPUEPH2IdnnKmSKCdla8wwFpYxnA
         rU4E795nXow4Lvp9JXLeWbzfMSaWPVjtEQMayMypBjOxPphxYoZyT6FRKoyR7Ysf8/
         rrkFGID96ZFZJO3krpunf9Axs+HJ3SdwOVrj4BYJQN2KAb1uRFoBlsEbRui7rL5yGR
         rlR/A1QHed7bFFhMbwOiHTKoN1wMRkZ0xaEf95/TypGMZq06BaomAA1fQ+FrNouhof
         zWnk2fHOPPUog==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7A0C404DF; Tue, 15 Aug 2023 16:33:34 -0300 (-03)
Date:   Tue, 15 Aug 2023 16:33:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf test trace+probe_vfs_getname.sh: Remove stray \
 before /
Message-ID: <ZNvTDsSMO3nw9Tnp@kernel.org>
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

Running on fedora:38 in verbose mode I noticed:

  # perf test -v 117
  grep: warning: stray \ before /
  117: Check open filename arg using perf trace + vfs_getname          :

Remove that \ before /.

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
index db2ff141f70378c3..3697f054ce1903ac 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
 trace_open_vfs_getname() {
 	evts="$(echo "$(perf list syscalls:sys_enter_open* 2>/dev/null | grep -E 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/')" | sed ':a;N;s:\n:,:g')"
 	perf trace -e $evts touch $file 2>&1 | \
-	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
-- 
2.41.0

