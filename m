Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12BA76AB69
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjHAIyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjHAIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:54:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19043173E;
        Tue,  1 Aug 2023 01:54:23 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3718AVRh002680;
        Tue, 1 Aug 2023 08:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OqNAhSgX4VSa5LWjXu19KOATQChWFLhjwE9EJ2lFDx4=;
 b=Lm6vSJLfZOCXaqTgrgsXkc9MVR4SYVpsQD5/k82O8OcvkAYDPdER1RKKHVWP1vHI/IUe
 mOz+sC+c/g1lAm5uInt3SRNCGmR3xX21Ricjs2Mr9pdXdwOpIztfXI1WiSMtUcJKc1GP
 Plu0PKLQ49LGo7O+FeaeTb3rryX5KWwjuDILYDUatfrhvC32lYpxbZ5AwI6QNEiMVayl
 x3Bqf9LE13shPQshFkcZTdkW+A9SzHAEsV3Y+SEWNrc9+/t9nLxrXlsh9Hq56OZeldIg
 +FgY9dnUdF1gFXBRhQfXU6fy62OKn1FKxhiPDw2Cm3rtU1jg8dcDBIN3F8DjdYAcWFPA xQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6e9j237v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:54:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3718sGFR016628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 08:54:16 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 01:54:12 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 1/3] clk: Add the flag CLK_ENABLE_MUTEX_LOCK of enabling clock
Date:   Tue, 1 Aug 2023 16:53:50 +0800
Message-ID: <20230801085352.22873-2-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801085352.22873-1-quic_luoj@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: piSbiNbOrGwpmn46u8i8hebV3odmavsA
X-Proofpoint-GUID: piSbiNbOrGwpmn46u8i8hebV3odmavsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the clock controller where the HW register is
accessed by MDIO bus, the spin lock can't be used because
of sleep during the MDIO operation.

Add the flag CLK_ENABLE_MUTEX_LOCK to hint clock framework
to use mutex lock instead of the spin lock.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/clk.c            | 78 +++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h |  4 ++
 2 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..9f1be8e3f32b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -26,12 +26,15 @@
 
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
+static DEFINE_MUTEX(enable_mutex_lock);
 
 static struct task_struct *prepare_owner;
 static struct task_struct *enable_owner;
+static struct task_struct *enable_mutex_owner;
 
 static int prepare_refcnt;
 static int enable_refcnt;
+static int enable_mutex_refcnt;
 
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
@@ -149,7 +152,7 @@ static void clk_prepare_unlock(void)
 	mutex_unlock(&prepare_lock);
 }
 
-static unsigned long clk_enable_lock(void)
+static unsigned long clk_enable_spin_lock(void)
 	__acquires(enable_lock)
 {
 	unsigned long flags;
@@ -177,7 +180,7 @@ static unsigned long clk_enable_lock(void)
 	return flags;
 }
 
-static void clk_enable_unlock(unsigned long flags)
+static void clk_enable_spin_unlock(unsigned long flags)
 	__releases(enable_lock)
 {
 	WARN_ON_ONCE(enable_owner != current);
@@ -191,6 +194,52 @@ static void clk_enable_unlock(unsigned long flags)
 	spin_unlock_irqrestore(&enable_lock, flags);
 }
 
+static void clk_enable_mutex_lock(void)
+{
+	if (!mutex_trylock(&enable_mutex_lock)) {
+		if (enable_mutex_owner == current) {
+			enable_mutex_refcnt++;
+			return;
+		}
+		mutex_lock(&enable_mutex_lock);
+	}
+	WARN_ON_ONCE(enable_mutex_owner != NULL);
+	WARN_ON_ONCE(enable_mutex_refcnt != 0);
+	enable_mutex_owner = current;
+	enable_mutex_refcnt = 1;
+}
+
+static void clk_enable_mutex_unlock(void)
+{
+	WARN_ON_ONCE(enable_mutex_owner != current);
+	WARN_ON_ONCE(enable_mutex_refcnt == 0);
+
+	if (--enable_mutex_refcnt)
+		return;
+	enable_mutex_owner = NULL;
+	mutex_unlock(&enable_mutex_lock);
+}
+
+static unsigned long clk_enable_lock(struct clk_core *core)
+{
+	unsigned long flags = 0;
+
+	if (core && (core->flags & CLK_ENABLE_MUTEX_LOCK))
+		clk_enable_mutex_lock();
+	else
+		flags = clk_enable_spin_lock();
+
+	return flags;
+}
+
+static void clk_enable_unlock(struct clk_core *core, unsigned long flags)
+{
+	if (core && (core->flags & CLK_ENABLE_MUTEX_LOCK))
+		clk_enable_mutex_unlock();
+	else
+		clk_enable_spin_unlock(flags);
+}
+
 static bool clk_core_rate_is_protected(struct clk_core *core)
 {
 	return core->protect_count;
@@ -1111,9 +1160,9 @@ static void clk_core_disable_lock(struct clk_core *core)
 {
 	unsigned long flags;
 
-	flags = clk_enable_lock();
+	flags = clk_enable_lock(core);
 	clk_core_disable(core);
-	clk_enable_unlock(flags);
+	clk_enable_unlock(core, flags);
 }
 
 /**
@@ -1178,9 +1227,9 @@ static int clk_core_enable_lock(struct clk_core *core)
 	unsigned long flags;
 	int ret;
 
-	flags = clk_enable_lock();
+	flags = clk_enable_lock(core);
 	ret = clk_core_enable(core);
-	clk_enable_unlock(flags);
+	clk_enable_unlock(core, flags);
 
 	return ret;
 }
@@ -1390,7 +1439,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	if (clk_pm_runtime_get(core))
 		goto unprepare_out;
 
-	flags = clk_enable_lock();
+	flags = clk_enable_lock(core);
 
 	if (core->enable_count)
 		goto unlock_out;
@@ -1413,7 +1462,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	}
 
 unlock_out:
-	clk_enable_unlock(flags);
+	clk_enable_unlock(core, flags);
 	clk_pm_runtime_put(core);
 unprepare_out:
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
@@ -2042,9 +2091,9 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	}
 
 	/* update the clk tree topology */
-	flags = clk_enable_lock();
+	flags = clk_enable_lock(core);
 	clk_reparent(core, parent);
-	clk_enable_unlock(flags);
+	clk_enable_unlock(core, flags);
 
 	return old_parent;
 }
@@ -2087,9 +2136,9 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 	trace_clk_set_parent_complete(core, parent);
 
 	if (ret) {
-		flags = clk_enable_lock();
+		flags = clk_enable_lock(core);
 		clk_reparent(core, old_parent);
-		clk_enable_unlock(flags);
+		clk_enable_unlock(core, flags);
 
 		__clk_set_parent_after(core, old_parent, parent);
 
@@ -3388,6 +3437,7 @@ static const struct {
 	ENTRY(CLK_IS_CRITICAL),
 	ENTRY(CLK_OPS_PARENT_ENABLE),
 	ENTRY(CLK_DUTY_CYCLE_PARENT),
+	ENTRY(CLK_ENABLE_MUTEX_LOCK),
 #undef ENTRY
 };
 
@@ -4410,9 +4460,9 @@ void clk_unregister(struct clk *clk)
 	 * Assign empty clock ops for consumers that might still hold
 	 * a reference to this clock.
 	 */
-	flags = clk_enable_lock();
+	flags = clk_enable_lock(clk->core);
 	clk->core->ops = &clk_nodrv_ops;
-	clk_enable_unlock(flags);
+	clk_enable_unlock(clk->core, flags);
 
 	if (ops->terminate)
 		ops->terminate(clk->core->hw);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0f0cd01906b4..084b1f6fe321 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,10 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+/* clock operation is accessing register by MDIO, which needs to sleep.
+ * the lock should use mutex_lock instead of spin_lock.
+ */
+#define CLK_ENABLE_MUTEX_LOCK	BIT(14)
 
 struct clk;
 struct clk_hw;
-- 
2.34.1

