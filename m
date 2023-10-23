Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54D7D378E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjJWNRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWNRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:17:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0AD610B;
        Mon, 23 Oct 2023 06:17:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC412F4;
        Mon, 23 Oct 2023 06:17:48 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC23F3F762;
        Mon, 23 Oct 2023 06:17:04 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, atrajeev@linux.vnet.ibm.com,
        tianruidong@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Subject: [PATCH] perf tests: test_arm_coresight: Simplify source iteration
Date:   Mon, 23 Oct 2023 14:15:49 +0100
Message-Id: <20231023131550.487760-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two reasons to do this, firstly there is a shellcheck warning
in cs_etm_dev_name(), which can be completely deleted. And secondly the
current iteration method doesn't support systems with both ETE and ETM
because it picks one or the other. There isn't a known system with this
configuration, but it could happen in the future.

Iterating over all the sources for each CPU can be done by going through
/sys/bus/event_source/devices/cs_etm/cpu* and following the symlink back
to the Coresight device in /sys/bus/coresight/devices. This will work
whether the device is ETE, ETM or any future name, and is much simpler
and doesn't require any hard coded version numbers

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---

This was discussed here previously:
https://lore.kernel.org/all/20230929041133.95355-2-atrajeev@linux.vnet.ibm.com/

I chose not to add a fixes tag like the original because shellcheck
isn't part of the build so it doesn't really fix any real issue yet and
is just a refactor.

 tools/perf/tests/shell/test_arm_coresight.sh | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index fe78c4626e45..65dd85207125 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -11,19 +11,6 @@
 
 glb_err=0
 
-cs_etm_dev_name() {
-	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
-	trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
-	archhver=$((($trcdevarch >> 12) & 0xf))
-	archpart=$(($trcdevarch & 0xfff))
-
-	if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
-		echo "ete"
-	else
-		echo "etm"
-	fi
-}
-
 skip_if_no_cs_etm_event() {
 	perf list | grep -q 'cs_etm//' && return 0
 
@@ -149,7 +136,9 @@ arm_cs_iterate_devices() {
 
 arm_cs_etm_traverse_path_test() {
 	# Iterate for every ETM device
-	for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
+	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
+		# Canonicalize the path
+		dev=`readlink -f $dev`
 
 		# Find the ETM device belonging to which CPU
 		cpu=`cat $dev/cpu`
-- 
2.34.1

