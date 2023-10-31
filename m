Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620D17DD086
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjJaPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJaPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:30:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9AFC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:29:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E4C433C7;
        Tue, 31 Oct 2023 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698766199;
        bh=rxuRTaIT9pmaTWt2pQ7fckfcepAPCBhaM/SIwHI5TwU=;
        h=Date:From:To:Cc:Subject:From;
        b=DUnQos1DvY96N15uUhrCmonwEiOD1Cvw2tU39bfox/Fb8RM87kene+CmxU5Hivuvb
         6vFzYmmF3AvugdsDUFsYxZoYPMsBxs6mzMRBSP1bjBayBdB0A408/YtHyXC/88mmKq
         46CYNC8GDrXfndr0sjueI9miRYNnPv2ENmMXn464cfAyT9dWCx4mrdmMo3qKEaBYvu
         tQp4zsl7X8DaqYfs4RJCrh5fieMxoumadCrPd3XODxH+Kkk9a2EBkDYr7OfOc7+rtw
         K+3TWbjZ9hTejStyMaUPuudOWeT4s53TpC6t+hQGGMR8yt1aw5qX23FnMZMdsqK/m5
         sXNDf1H7bSrvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B1C24035D; Tue, 31 Oct 2023 12:29:56 -0300 (-03)
Date:   Tue, 31 Oct 2023 12:29:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH next 1/1] perf beauty socket/prctl_option: Cope with extended
 regexp complaint by grep
Message-ID: <ZUEddFPTJHVLhH/6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed on fedora 38, the extended regexp that so far was ok for both
grep and sed now gets complaints by grep, that says '/' doesn't need to
be escaped with '\'.

So stop using '/' in sed, use '%' instead and remove the \ before / in
the common extended regexp.

Link: https://x.com/SMT_Solvers/status/1710380010098344192?s=20
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 4 ++--
 tools/perf/trace/beauty/socket.sh       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index 8059342ca4126c38..9455d9672f140d13 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,9 +4,9 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'
+regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*/.*)?$'
 grep -E $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
-	sed -r "s/$regex/\2 \1/g"	| \
+	sed -E "s%$regex%\2 \1%g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
 
diff --git a/tools/perf/trace/beauty/socket.sh b/tools/perf/trace/beauty/socket.sh
index 8bc7ba62203e4a9d..670c6db298ae0298 100755
--- a/tools/perf/trace/beauty/socket.sh
+++ b/tools/perf/trace/beauty/socket.sh
@@ -18,10 +18,10 @@ grep -E $ipproto_regex ${uapi_header_dir}/in.h | \
 printf "};\n\n"
 
 printf "static const char *socket_level[] = {\n"
-socket_level_regex='^#define[[:space:]]+SOL_(\w+)[[:space:]]+([[:digit:]]+)([[:space:]]+\/.*)?'
+socket_level_regex='^#define[[:space:]]+SOL_(\w+)[[:space:]]+([[:digit:]]+)([[:space:]]+/.*)?'
 
 grep -E $socket_level_regex ${beauty_header_dir}/socket.h | \
-	sed -r "s/$socket_level_regex/\2 \1/g"	| \
+	sed -E "s%$socket_level_regex%\2 \1%g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
 
-- 
2.41.0

