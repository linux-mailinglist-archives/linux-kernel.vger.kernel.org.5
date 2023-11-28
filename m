Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3837F7FC5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346092AbjK1UnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjK1UnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18819AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2a628c25so4631715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204205; x=1701809005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njp3hQuRezyJWSCVkGDJUsCKh4qNw0wNTvM+MC2XVcU=;
        b=CER2TLMbqP22diyDiifFbryA9wgYE0s5fF7U7j535TfYFnCtNJY3AApvJHU4hd8DW0
         T9s0ygaCINSXnjzw/EE2x2ls5OepVIreHlX1L8W6mMTgxzIUI05p/gR/rlx/wX0zfajY
         9cqSnirrAok6uuwG6DiJxyhcE9O70gGyC9jWeU+La557/kTPqXteD+BL9fuK5zaWFTZP
         5Qb9lG+Ea/zYKIiWEd5Qq/EF9A0Ej2OCwSEIkxGlGFtIMIiTg2qlatwGazi5BG5GuUhk
         3jhP4JOUB/MTT7dy7AvdKAjauzbbXLl5kpd9hItKnnP6q/LU1O665dfFVEV5p9Sd3vEl
         RpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204205; x=1701809005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njp3hQuRezyJWSCVkGDJUsCKh4qNw0wNTvM+MC2XVcU=;
        b=XiD5GFgZyJySQu746LnySd0QeQ1JsEnCQXJ9KSH6k6Xk/CRvH+lPKTvx5GhHvrZD9b
         COyiCA9L0jZPMJIFktn2QfqIEsSjTyitT7kT6xgJr1kMwF1j/ASBSqnFWOBOSBw/ecb/
         8wZBX0dQXdRu0d90oUZOWRx/3d963GBsAqvBOkfqWcAkaETYQ8NuHNEPtlVszpcaaWl/
         Dqhg4fvWZ3azGrLCJikqfatRJ9J4FJzG6ssDVIlK1gKE87Bp0TllquTIJ+Ano83ksd/1
         WVkAcZVzoiECY6EZPADhDc8Eh31PdDyGgk51TWrhCMFpp6UsDBmAOP8xbX2wFhYTFCcH
         W6mQ==
X-Gm-Message-State: AOJu0Yy8TLwrh5ZoQR4my3r5nOGAad767NdKLEklC2PdJyYu+bmHKUcr
        GGIlpuRUhd9OL3CNF4xE/s0=
X-Google-Smtp-Source: AGHT+IEQfvjYlyaAeEil/4U/m1nR0QEYZPOaulItD2Mjk+Gd1cU3ERzypFclLTg8QTfW8LrBULR8nA==
X-Received: by 2002:a05:600c:1d06:b0:40b:5150:c046 with SMTP id l6-20020a05600c1d0600b0040b5150c046mr404729wms.3.1701204204641;
        Tue, 28 Nov 2023 12:43:24 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040b379e8526sm12609152wmo.25.2023.11.28.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:24 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: rtl8192e: Remove unused function
 rtllib_rx_ADDBAReq()
Message-ID: <a6ca4855f64f7dea9d05e33d030a05f86ab58c19.1701202700.git.philipp.g.hortmann@gmail.com>
References: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_rx_ADDBAReq().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 89 -----------------------
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 2 files changed, 90 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 58a950ef77ce..7e4aeb10a2db 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -211,95 +211,6 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate DELBA packet.\n");
 }
 
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
-{
-	struct ieee80211_hdr_3addr *req = NULL;
-	u16 rc = 0;
-	u8 *dst = NULL, *dialog_token = NULL, *tag = NULL;
-	struct ba_record *ba = NULL;
-	union ba_param_set *ba_param_set = NULL;
-	u16 *ba_timeout_value = NULL;
-	union sequence_control *pBaStartSeqCtrl = NULL;
-	struct rx_ts_record *ts = NULL;
-
-	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 9) {
-		netdev_warn(ieee->dev, "Invalid skb len in BAREQ(%d / %d)\n",
-			    (int)skb->len,
-			    (int)(sizeof(struct ieee80211_hdr_3addr) + 9));
-		return -1;
-	}
-
-#ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("%s: ", DUMP_PREFIX_NONE, __func__,
-			     skb->data, skb->len);
-#endif
-
-	req = (struct ieee80211_hdr_3addr *)skb->data;
-	tag = (u8 *)req;
-	dst = (u8 *)(&req->addr2[0]);
-	tag += sizeof(struct ieee80211_hdr_3addr);
-	dialog_token = tag + 2;
-	ba_param_set = (union ba_param_set *)(tag + 3);
-	ba_timeout_value = (u16 *)(tag + 5);
-	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
-
-	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->current_ht_support ||
-	    (ieee->ht_info->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
-		rc = ADDBA_STATUS_REFUSED;
-		netdev_warn(ieee->dev,
-			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
-			    ieee->current_network.qos_data.active,
-			    ieee->ht_info->current_ht_support);
-		goto OnADDBAReq_Fail;
-	}
-	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-		   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
-		rc = ADDBA_STATUS_REFUSED;
-		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
-		goto OnADDBAReq_Fail;
-	}
-	ba = &ts->rx_admitted_ba_record;
-
-	if (ba_param_set->field.ba_policy == BA_POLICY_DELAYED) {
-		rc = ADDBA_STATUS_INVALID_PARAM;
-		netdev_warn(ieee->dev, "%s(): BA Policy is not correct\n",
-			    __func__);
-		goto OnADDBAReq_Fail;
-	}
-
-	rtllib_FlushRxTsPendingPkts(ieee, ts);
-
-	deactivate_ba_entry(ieee, ba);
-	ba->dialog_token = *dialog_token;
-	ba->ba_param_set = *ba_param_set;
-	ba->ba_timeout_value = *ba_timeout_value;
-	ba->ba_start_seq_ctrl = *pBaStartSeqCtrl;
-
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
-		ba->ba_param_set.field.buffer_size = 1;
-	else
-		ba->ba_param_set.field.buffer_size = 32;
-
-	activate_ba_entry(ba, 0);
-	rtllib_send_ADDBARsp(ieee, dst, ba, ADDBA_STATUS_SUCCESS);
-
-	return 0;
-
-OnADDBAReq_Fail:
-	{
-		struct ba_record BA;
-
-		BA.ba_param_set = *ba_param_set;
-		BA.ba_timeout_value = *ba_timeout_value;
-		BA.dialog_token = *dialog_token;
-		BA.ba_param_set.field.ba_policy = BA_POLICY_IMMEDIATE;
-		rtllib_send_ADDBARsp(ieee, dst, &BA, rc);
-		return 0;
-	}
-}
-
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct ieee80211_hdr_3addr *rsp = NULL;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0a8c44e497f5..44a937953db8 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1776,7 +1776,6 @@ u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
-int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
-- 
2.42.0

