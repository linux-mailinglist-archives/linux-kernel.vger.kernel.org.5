Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED67CEF48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjJSFqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjJSFq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:46:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6553FE;
        Wed, 18 Oct 2023 22:46:25 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4fAQP007201;
        Thu, 19 Oct 2023 05:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=nJR4w+XeEMRK5qLQwON86BwF6mVYncIdDhoXJqbpP0g=;
 b=OH1KLGYUDhzWW2c2u4oNG+BHnnHX2Qwjf0+jhZx9OnwIF7bf0tPGSTJOg/RRCsUSb8bt
 b3els4xHu6tlV6M3VTBdwDWJVhq/iz3nE2PQPTzRjLKgP7bdqENTC+oAhKYmbJ4wf1MM
 2CrWjgKS50DXG6yzWrM9yee5kblCI3ojdcYt+3WtKOGVDQmF2B2c7yJeTi1ntWl5xdIN
 +eB1B7bTGHaDlXD5Sz1sPWRpk7zM6e3urbUhRMj5yu/nQff+LWkrY/KsC7sOoX3HsPny
 DqAmgXN2oMCcD6i+M81YLm4wBgkn8NJmFOZlYO0TmxQaXFa2BlfMxXy7kFJxuRcfaL6R DA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kjttkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 05:46:20 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39J5kH8b012558;
        Thu, 19 Oct 2023 05:46:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tqm2mbdp4-1;
        Thu, 19 Oct 2023 05:46:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J5kGTV012550;
        Thu, 19 Oct 2023 05:46:17 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-sartgarg-hyd.qualcomm.com [10.213.105.147])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39J5kG4B012549;
        Thu, 19 Oct 2023 05:46:16 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id AD64D5714EA; Thu, 19 Oct 2023 11:16:15 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
        kernel@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
Subject: [PATCH V3 1/3] mmc: core: Add partial initialization support
Date:   Thu, 19 Oct 2023 11:16:10 +0530
Message-Id: <20231019054612.9192-2-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 84Dqzc6TskgUM_t3uF0aSa_V4Xw5yOA3
X-Proofpoint-GUID: 84Dqzc6TskgUM_t3uF0aSa_V4Xw5yOA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190049
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to partially initialize the MMC device by
using device sleep/awake sequence (CMD5).
Device will be sent to sleep state during mmc runtime/system suspend
and will be woken up during mmc runtime/system resume.
By using this sequence the device doesn't need full initialization
which gives 25% time reduction in system/runtime resume path.

1) Micron eMMC (ManfID 0x13)

Partial init				Full Init

a) _mmc_resume: 			_mmc_resume :

Total time : 62ms 			Total time : 84ms
(Improvement % from full init = ~26%)

2) Kingston eMMC (ManfID 0x70)

Partial init				Full Init

a) _mmc_resume:			_mmc_resume :
Total time : 46ms			Total time : 62ms
(Improvement % from full init = ~25%).

Co-developed-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
Signed-off-by: Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>
Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/mmc.c   | 163 ++++++++++++++++++++++++++++++++++++---
 include/linux/mmc/card.h |   4 +
 include/linux/mmc/host.h |   2 +
 3 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8180983bd402..fb33bcf6d360 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1956,7 +1956,28 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
 	return 0;
 }
 
-static int mmc_sleep(struct mmc_host *host)
+/*
+ * Returns true if card supports sleep/awake command and host can simply do
+ * sleep/awake instead of full card initialization as part of resume.
+ */
+static inline int mmc_can_sleepawake(struct mmc_host *host)
+{
+	return mmc_can_sleep(host->card) && (host->caps2 & MMC_CAP2_SLEEP_AWAKE);
+}
+
+/**
+ * mmc_sleepawake - function to sleep or awake the device
+ * @host: MMC host
+ * @sleep: if true then sleep command is sent else awake
+ *
+ * This function first deselects the card and then sends the sleep command
+ * in case of sleep whereas in case of awake first awake command is send
+ * and then the card is selected.
+ *
+ * Returns 0 on success, non-zero value on failure
+ */
+
+static int mmc_sleepawake(struct mmc_host *host, bool sleep)
 {
 	struct mmc_command cmd = {};
 	struct mmc_card *card = host->card;
@@ -1967,14 +1988,17 @@ static int mmc_sleep(struct mmc_host *host)
 	/* Re-tuning can't be done once the card is deselected */
 	mmc_retune_hold(host);
 
-	err = mmc_deselect_cards(host);
-	if (err)
-		goto out_release;
+	if (sleep) {
+		err = mmc_deselect_cards(host);
+		if (err)
+			goto out_release;
+	}
 
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
-	cmd.arg |= 1 << 15;
 	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
+	if (sleep)
+		cmd.arg |= BIT(15);
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
@@ -1997,6 +2021,9 @@ static int mmc_sleep(struct mmc_host *host)
 	err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
 
 out_release:
+	if (!sleep)
+		err = mmc_select_card(card);
+
 	mmc_retune_release(host);
 	return err;
 }
@@ -2094,6 +2121,73 @@ static int _mmc_flush_cache(struct mmc_host *host)
 			pr_err("%s: cache flush error %d\n",
 			       mmc_hostname(host), err);
 	}
+	return err;
+}
+
+/*
+ * Save read/write fields of ext_csd register that the sw changes
+ * as part of suspend.
+ */
+static int mmc_save_card_ext_csd(struct mmc_host *host)
+{
+	int err;
+	u8 *ext_csd;
+	struct mmc_card *card = host->card;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err || !ext_csd) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
+	card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
+	card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
+	card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
+
+	kfree(ext_csd);
+
+	return 0;
+}
+
+/*
+ * Get the ext_csd register from the card post resume and compare with
+ * read/write fields of ext_csd register that the sw changes.
+ */
+static int mmc_test_awake_ext_csd(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u8 *ext_csd;
+	int err;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
+		mmc_hostname(host), __func__,
+		card->ext_csd.raw_ext_csd_cmdq,
+		ext_csd[EXT_CSD_CMDQ_MODE_EN],
+		card->ext_csd.raw_ext_csd_cache_ctrl,
+		ext_csd[EXT_CSD_CACHE_CTRL],
+		card->ext_csd.raw_ext_csd_bus_width,
+		ext_csd[EXT_CSD_BUS_WIDTH],
+		card->ext_csd.raw_ext_csd_hs_timing,
+		ext_csd[EXT_CSD_HS_TIMING]);
+	err = !((card->ext_csd.raw_ext_csd_cmdq ==
+			ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
+		(card->ext_csd.raw_ext_csd_cache_ctrl ==
+			ext_csd[EXT_CSD_CACHE_CTRL]) &&
+		(card->ext_csd.raw_ext_csd_bus_width ==
+			ext_csd[EXT_CSD_BUS_WIDTH]) &&
+		(card->ext_csd.raw_ext_csd_hs_timing ==
+			ext_csd[EXT_CSD_HS_TIMING]));
+
+	kfree(ext_csd);
 
 	return err;
 }
@@ -2117,9 +2211,15 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
 	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
-		err = mmc_sleep(host);
-	else if (!mmc_host_is_spi(host))
+	else if (mmc_can_sleep(host->card)) {
+		if (mmc_can_sleepawake(host)) {
+			memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
+			err = mmc_save_card_ext_csd(host);
+			if (err)
+				goto out;
+		}
+		err = mmc_sleepawake(host, true);
+	} else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 
 	if (!err) {
@@ -2131,6 +2231,39 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	return err;
 }
 
+static int mmc_partial_init(struct mmc_host *host)
+{
+	int err = 0;
+	struct mmc_card *card = host->card;
+
+	mmc_set_bus_width(host, host->cached_ios.bus_width);
+	mmc_set_timing(host, host->cached_ios.timing);
+	if (host->cached_ios.enhanced_strobe) {
+		host->ios.enhanced_strobe = true;
+		if (host->ops->hs400_enhanced_strobe)
+			host->ops->hs400_enhanced_strobe(host, &host->ios);
+	}
+	mmc_set_clock(host, host->cached_ios.clock);
+	mmc_set_bus_mode(host, host->cached_ios.bus_mode);
+
+	if (!mmc_card_hs400es(card) &&
+			(mmc_card_hs200(card) || mmc_card_hs400(card))) {
+		err = mmc_execute_tuning(card);
+		if (err) {
+			pr_err("%s: %s: Tuning failed (%d)\n",
+				mmc_hostname(host), __func__, err);
+			goto out;
+		}
+	}
+
+	err = mmc_test_awake_ext_csd(host);
+	if (err)
+		pr_debug("%s: %s: fail on ext_csd read (%d)\n",
+			mmc_hostname(host), __func__, err);
+out:
+	return err;
+}
+
 /*
  * Suspend callback
  */
@@ -2161,7 +2294,19 @@ static int _mmc_resume(struct mmc_host *host)
 		goto out;
 
 	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
+
+	if (mmc_can_sleepawake(host)) {
+		err = mmc_sleepawake(host, false);
+		if (!err)
+			err = mmc_partial_init(host);
+		else
+			pr_err("%s: %s: awake failed (%d), fallback to full init\n",
+				mmc_hostname(host), __func__, err);
+	}
+
+	if (!mmc_can_sleepawake(host) || err)
+		err = mmc_init_card(host, host->card->ocr, host->card);
+
 	mmc_card_clr_suspended(host->card);
 
 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index daa2f40d9ce6..fbc832ec6d57 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -86,6 +86,8 @@ struct mmc_ext_csd {
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
+	u8			raw_ext_csd_cmdq;	/* 15 */
+	u8			raw_ext_csd_cache_ctrl;	/* 33 */
 	bool			ffu_capable;	/* Firmware upgrade support */
 	bool			cmdq_en;	/* Command Queue enabled */
 	bool			cmdq_support;	/* Command Queue supported */
@@ -96,7 +98,9 @@ struct mmc_ext_csd {
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
+	u8			raw_ext_csd_bus_width;	/* 183 */
 	u8			strobe_support;		/* 184 */
+	u8			raw_ext_csd_hs_timing;	/* 185 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
 	u8			raw_driver_strength;	/* 197 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2f445c651742..836382a0b2e9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -427,6 +427,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_SLEEP_AWAKE	(1 << 29)	/* Use Sleep/Awake (CMD5) */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
@@ -445,6 +446,7 @@ struct mmc_host {
 	spinlock_t		lock;		/* lock for claim and bus ops */
 
 	struct mmc_ios		ios;		/* current io bus settings */
+	struct mmc_ios		cached_ios;
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-- 
2.17.1

