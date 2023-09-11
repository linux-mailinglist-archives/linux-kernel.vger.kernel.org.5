Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4579A3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjIKGzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjIKGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:55:54 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786CB131
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:55:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VrmdUvU_1694415344;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0VrmdUvU_1694415344)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 14:55:46 +0800
From:   Ruidong Tian <tianruidong@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH] perf test: Update cs_etm testcase for Arm ETE
Date:   Mon, 11 Sep 2023 14:55:41 +0800
Message-Id: <20230911065541.91293-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ETE as one of the supported device types in perf cs_etm testcase.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index f1bf5621160f..fe78c4626e45 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -11,6 +11,19 @@
 
 glb_err=0
 
+cs_etm_dev_name() {
+	cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
+	trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
+	archhver=$((($trcdevarch >> 12) & 0xf))
+	archpart=$(($trcdevarch & 0xfff))
+
+	if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
+		echo "ete"
+	else
+		echo "etm"
+	fi
+}
+
 skip_if_no_cs_etm_event() {
 	perf list | grep -q 'cs_etm//' && return 0
 
@@ -136,7 +149,7 @@ arm_cs_iterate_devices() {
 
 arm_cs_etm_traverse_path_test() {
 	# Iterate for every ETM device
-	for dev in /sys/bus/coresight/devices/etm*; do
+	for dev in /sys/bus/coresight/devices/$(cs_etm_dev_name)*; do
 
 		# Find the ETM device belonging to which CPU
 		cpu=`cat $dev/cpu`
-- 
2.33.1

