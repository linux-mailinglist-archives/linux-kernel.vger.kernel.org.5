Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153BC7910BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbjIDFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352124AbjIDFHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:07:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7FCDA;
        Sun,  3 Sep 2023 22:06:55 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383NpvTh009497;
        Sun, 3 Sep 2023 22:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=/J1fNs0phYVJVkCDvacCdgUVccbvt9TWNr6RVDPDYnY=;
 b=L5IjMR6FramELBn1cPXX8pyrM7TYVBMstVJmjbMlpge1O6ndb5yh+WZY9pR80i0gaNgx
 viqU2ePpX2WN6TrKUx/fSrBR4d2pkr3jUQK6HoyZ2EtgO8VXt7KMxD1BZsrnC3vwPb/d
 rUxpLF9F743xEra2HKlSskZLgs+vMIvS63NK0r9Gv6RHc1zwQ7F3kh5uGxYkWytHzwRw
 7IzSzgOsERobDdARHdakF23JjqF6CVYfILovT3Rksh2t3R75bpRmmHhOaqKu72GIRG45
 58jNsEFrZeSjPnWnth1KflyoBK6BEZWK2AvYM4g+fn7XwTx6iJoMfv6YotGh1RmH0Kmr Qw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sv2dp4hs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:42 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id A55153F7062;
        Sun,  3 Sep 2023 22:06:38 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 7/7] coresight: etm4x: Configure ETM to trigger on panic
Date:   Mon, 4 Sep 2023 10:35:47 +0530
Message-ID: <20230904050548.28047-8-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904050548.28047-1-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QfyJEHZeyVL3BEQykJWrkM8OqEG_W2ia
X-Proofpoint-GUID: QfyJEHZeyVL3BEQykJWrkM8OqEG_W2ia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure ETM to generate a trigger on Ext out [0] on panic.
This is achieved by configuring a single address comparator
with the address of "panic" and by configuring Ext out [0] to
trigger on the comparator event.

This trigger can be used by the sinks to stop capture on panic.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../coresight/coresight-etm4x-core.c          | 17 +++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h | 26 +++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7c65d152aebb..423934efcd9d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -62,6 +62,7 @@ static void etm4_set_default_config(struct etmv4_config *config);
 static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				  struct perf_event *event);
 static u64 etm4_get_access_type(struct etmv4_config *config);
+static u64 etm4_get_comparator_access_type(struct etmv4_config *config);
 
 static enum cpuhp_state hp_online;
 
@@ -1291,9 +1292,8 @@ static void etm4_set_victlr_access(struct etmv4_config *config)
 
 static void etm4_set_default_config(struct etmv4_config *config)
 {
-	/* disable all events tracing */
-	config->eventctrl0 = 0x0;
-	config->eventctrl1 = 0x0;
+	int rselector = 2; /* 0 and 1 are reserved */
+	int comp_idx = 0;
 
 	/* disable stalling */
 	config->stall_ctrl = 0x0;
@@ -1309,6 +1309,17 @@ static void etm4_set_default_config(struct etmv4_config *config)
 
 	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
 	etm4_set_victlr_access(config);
+
+	/* Configure the comparator with kernel panic address */
+	config->addr_val[comp_idx] = (u64)panic;
+	config->addr_acc[comp_idx] = etm4_get_comparator_access_type(config);
+	config->addr_type[comp_idx] = ETM_ADDR_TYPE_STOP;
+	config->res_ctrl[rselector] = ETM_RESGRP_SADDRCMP << 16 | BIT(comp_idx);
+
+	/* Connect external output [0] with comparator out */
+	config->eventctrl0 = 0x0 << 7 | rselector;
+
+	config->eventctrl1 = 0x0;
 }
 
 static u64 etm4_get_ns_access_type(struct etmv4_config *config)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 27c8a9901868..6ac5d5ee1877 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -612,6 +612,32 @@
 #define ETM_CNTR_MAX_VAL		0xFFFF
 #define ETM_TRACEID_MASK		0x3f
 
+/* ETM resource group encoding */
+#define ETM_RESGRP_EXTIN		0x0
+#define ETM_RESGRP_PECMP		0x1
+#define ETM_RESGRP_CNTRSEQ		0x2
+#define ETM_RESGRP_SSCMP		0x3
+#define ETM_RESGRP_SADDRCMP		0x4
+#define ETM_RESGRP_ADDRRANGECMP		0x5
+#define ETM_RESGRP_CIDCMP		0x6
+#define ETM_RESGRP_VCIDCMP		0x7
+
+#define ETM_EXTIN_0			0x0
+
+
+/* ETM resource group encoding */
+#define ETM_RESGRP_EXTIN		0x0
+#define ETM_RESGRP_PECMP		0x1
+#define ETM_RESGRP_CNTRSEQ		0x2
+#define ETM_RESGRP_SSCMP		0x3
+#define ETM_RESGRP_SADDRCMP		0x4
+#define ETM_RESGRP_ADDRRANGECMP		0x5
+#define ETM_RESGRP_CIDCMP		0x6
+#define ETM_RESGRP_VCIDCMP		0x7
+
+#define ETM_EXTIN_0			0x0
+
+
 /* ETMv4 programming modes */
 #define ETM_MODE_EXCLUDE		BIT(0)
 #define ETM_MODE_LOAD			BIT(1)
-- 
2.41.0

