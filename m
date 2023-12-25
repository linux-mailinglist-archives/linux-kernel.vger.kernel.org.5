Return-Path: <linux-kernel+bounces-10948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5E81DF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB5D1C216EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D271C2E;
	Mon, 25 Dec 2023 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BZX8En16"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A523B0;
	Mon, 25 Dec 2023 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BP7JeJV021626;
	Mon, 25 Dec 2023 08:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=PQyHzORnG83yHLUkK9mRKYUuUoNyLGS/PDd58jgbxD4=; b=BZ
	X8En16mJpxrg0+WjhFtwytpagLaWZJv51115DH7xnN8ccHLa0Ckcgq3oj9zx6n2p
	3Ze68BQxEJfc5rwp0C3Cjz0WpHCA/rd/cLdlSx6I/exYip3gjeqda9Waigi2/S6c
	rHF6aGgPY7DjlIcWn9KMvoLgip/0lo5WKBkASKt4sHQMZuFb7kYcu5z2+OAGJo+J
	VHZhybtDOkjFbGtu/u3KYo0vdz1iPcyjhEXxjywJHEf3l8rymxjyg1IrsPp8pc1p
	fs8ogg4hsJJVAKdMeYQX9TTHub1uxKGRWKO/9z02ouUeQcTAlf0G8wC0LFE4wC3C
	pyR9xdiNwfraof458Jbw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5qs5k8fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:23:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BP8NUrI002894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 08:23:30 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Dec 2023 00:23:25 -0800
From: Maria Yu <quic_aiquny@quicinc.com>
To: <andersson@kernel.org>, <linus.walleij@linaro.org>
CC: Maria Yu <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3] pinctrl: Add lock to ensure the state atomization
Date: Mon, 25 Dec 2023 16:23:05 +0800
Message-ID: <20231225082305.12343-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hH_aHujIMxFYogMR7psukANS5hx7O3qw
X-Proofpoint-GUID: hH_aHujIMxFYogMR7psukANS5hx7O3qw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxlogscore=891 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250063

Currently pinctrl_select_state is an export symbol and don't have
effective re-entrance protect design. During async probing of devices
it's possible to end up in pinctrl_select_state() from multiple
contexts simultaneously, so make it thread safe.
More over, when the real racy happened, the system frequently have
printk message like:
  "not freeing pin xx (xxx) as part of deactivating group xxx - it is
already used for some other setting".
Finally the system crashed after the flood log.
Add per pinctrl lock to ensure the old state and new state transition
atomization.
Also move dev error print message outside the region with interrupts
disabled.
Use scoped guard to simplify the lock protection needed code.

Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 drivers/pinctrl/core.c | 144 +++++++++++++++++++++--------------------
 drivers/pinctrl/core.h |   2 +
 2 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f2977eb65522..ab158b745486 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "pinctrl core: " fmt
 
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -1066,6 +1067,7 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 	p->dev = dev;
 	INIT_LIST_HEAD(&p->states);
 	INIT_LIST_HEAD(&p->dt_maps);
+	spin_lock_init(&p->lock);
 
 	ret = pinctrl_dt_to_map(p, pctldev);
 	if (ret < 0) {
@@ -1262,93 +1264,95 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = READ_ONCE(p->state);
+	struct pinctrl_state *old_state;
 	int ret;
 
-	if (old_state) {
-		/*
-		 * For each pinmux setting in the old state, forget SW's record
-		 * of mux owner for that pingroup. Any pingroups which are
-		 * still owned by the new state will be re-acquired by the call
-		 * to pinmux_enable_setting() in the loop below.
-		 */
-		list_for_each_entry(setting, &old_state->settings, node) {
-			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
-				continue;
-			pinmux_disable_setting(setting);
+	scoped_guard(spinlock_irqsave, &p->lock) {
+		old_state = p->state;
+		if (old_state) {
+			/*
+			 * For each pinmux setting in the old state, forget SW's record
+			 * of mux owner for that pingroup. Any pingroups which are
+			 * still owned by the new state will be re-acquired by the call
+			 * to pinmux_enable_setting() in the loop below.
+			 */
+			list_for_each_entry(setting, &old_state->settings, node) {
+				if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
+					continue;
+				pinmux_disable_setting(setting);
+			}
 		}
-	}
-
-	p->state = NULL;
 
-	/* Apply all the settings for the new state - pinmux first */
-	list_for_each_entry(setting, &state->settings, node) {
-		switch (setting->type) {
-		case PIN_MAP_TYPE_MUX_GROUP:
-			ret = pinmux_enable_setting(setting);
-			break;
-		case PIN_MAP_TYPE_CONFIGS_PIN:
-		case PIN_MAP_TYPE_CONFIGS_GROUP:
-			ret = 0;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
+		p->state = NULL;
 
-		if (ret < 0)
-			goto unapply_new_state;
+		/* Apply all the settings for the new state - pinmux first */
+		list_for_each_entry(setting, &state->settings, node) {
+			switch (setting->type) {
+			case PIN_MAP_TYPE_MUX_GROUP:
+				ret = pinmux_enable_setting(setting);
+				break;
+			case PIN_MAP_TYPE_CONFIGS_PIN:
+			case PIN_MAP_TYPE_CONFIGS_GROUP:
+				ret = 0;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
 
-		/* Do not link hogs (circular dependency) */
-		if (p != setting->pctldev->p)
-			pinctrl_link_add(setting->pctldev, p->dev);
-	}
+			if (ret < 0)
+				goto unapply_new_state;
 
-	/* Apply all the settings for the new state - pinconf after */
-	list_for_each_entry(setting, &state->settings, node) {
-		switch (setting->type) {
-		case PIN_MAP_TYPE_MUX_GROUP:
-			ret = 0;
-			break;
-		case PIN_MAP_TYPE_CONFIGS_PIN:
-		case PIN_MAP_TYPE_CONFIGS_GROUP:
-			ret = pinconf_apply_setting(setting);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
+			/* Do not link hogs (circular dependency) */
+			if (p != setting->pctldev->p)
+				pinctrl_link_add(setting->pctldev, p->dev);
 		}
 
-		if (ret < 0) {
-			goto unapply_new_state;
-		}
+		/* Apply all the settings for the new state - pinconf after */
+		list_for_each_entry(setting, &state->settings, node) {
+			switch (setting->type) {
+			case PIN_MAP_TYPE_MUX_GROUP:
+				ret = 0;
+				break;
+			case PIN_MAP_TYPE_CONFIGS_PIN:
+			case PIN_MAP_TYPE_CONFIGS_GROUP:
+				ret = pinconf_apply_setting(setting);
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
 
-		/* Do not link hogs (circular dependency) */
-		if (p != setting->pctldev->p)
-			pinctrl_link_add(setting->pctldev, p->dev);
-	}
+			if (ret < 0)
+				goto unapply_new_state;
 
-	p->state = state;
+			/* Do not link hogs (circular dependency) */
+			if (p != setting->pctldev->p)
+				pinctrl_link_add(setting->pctldev, p->dev);
+		}
 
-	return 0;
+		p->state = state;
+
+		return 0;
 
 unapply_new_state:
-	dev_err(p->dev, "Error applying setting, reverse things back\n");
 
-	list_for_each_entry(setting2, &state->settings, node) {
-		if (&setting2->node == &setting->node)
-			break;
-		/*
-		 * All we can do here is pinmux_disable_setting.
-		 * That means that some pins are muxed differently now
-		 * than they were before applying the setting (We can't
-		 * "unmux a pin"!), but it's not a big deal since the pins
-		 * are free to be muxed by another apply_setting.
-		 */
-		if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
-			pinmux_disable_setting(setting2);
+		list_for_each_entry(setting2, &state->settings, node) {
+			if (&setting2->node == &setting->node)
+				break;
+			/*
+			 * All we can do here is pinmux_disable_setting.
+			 * That means that some pins are muxed differently now
+			 * than they were before applying the setting (We can't
+			 * "unmux a pin"!), but it's not a big deal since the pins
+			 * are free to be muxed by another apply_setting.
+			 */
+			if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
+				pinmux_disable_setting(setting2);
+		}
 	}
 
+	dev_err(p->dev, "Error applying setting, reverse things back\n");
 	/* There's no infinite recursive loop here because p->state is NULL */
 	if (old_state)
 		pinctrl_select_state(p, old_state);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 530370443c19..86fc41393f7b 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <linux/pinctrl/machine.h>
@@ -91,6 +92,7 @@ struct pinctrl {
 	struct pinctrl_state *state;
 	struct list_head dt_maps;
 	struct kref users;
+	spinlock_t lock;
 };
 
 /**

base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
-- 
2.17.1


