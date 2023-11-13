Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06577EA402
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjKMTw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKMTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:52:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63AD71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce3084c2d1so6522075ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1699905170; x=1700509970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WucwCdy1Q+u2Z+QDmzu473Nr1JvUaJp7GWacbD5RC4s=;
        b=NucvODtNdpRXmcp9A+T1u7FwAc7aJ5R0kOMn/PU7pttnPwKKcu8yHmGuEfpAPP0A5m
         mpzaOUVFkMYUzA9k+o8LfeAYpzexAWtw7PmTk8SlfFYRpW2G5An7d0hAiPhm5TZVLYGw
         q/RCFlwdgI89E1qiBxlkwwO4dAtUEgZKH7lDoE9MMcGjVOn0W8pMLQ9LhinXv5zs1ehJ
         dU+sDxIpYwZmS8lIKNvoVhxRd16K4Y8S5R3bsEARe4+YrhXNtzOrZXj4EUzekOP2aT7d
         yidYVmfQcX38Naz82jVnacnyjJtEZy4mP9o9BHUbrDxrkahD3sLCYlrt8RUxs9Jn/0kv
         v4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905170; x=1700509970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WucwCdy1Q+u2Z+QDmzu473Nr1JvUaJp7GWacbD5RC4s=;
        b=S2Nkl5JZ+HtWyhBzEQBe+PuWpQ/yT8RyZH8tKFawSIR0DUZdl9FkigS02JHrhh2h0y
         G0U78/zSCKFd3hpFaV2TYrPwwze9cUDjuL6qpLsKxGHufsqsg/dxgxNhtSmz1rYBiBox
         Saf8qyYSwl1jPT85SMeUtzHre3ZYUcAh6g73MrCimtt6Cp4gRt9GKjgC8ppX6h6kAvsx
         IxVsy1fLwrWhIqRzDrvtOT/n2OluRl3ZgHUxDdHljKfYFvXnQbePDLrUFhWjreQ15IVX
         +9oz0A3wINk1XvF+enP5yWB702PB5u8QwKiyQOuiLVbRoPNi5/cA4xLIgiHJ/RuthPGM
         qEDQ==
X-Gm-Message-State: AOJu0YwpOECwaE7DF2tCB5I87N4NkIQF1akngbcC3iotaxB2KE/0jG3z
        080b5Az1hkWzkODY7v0bqGjsug==
X-Google-Smtp-Source: AGHT+IHaUdk0lhuac32EQF51jqgQqIEp6KnVDKw63AB4vIXToTcSQY1ITTbQVc0FZgozujJCI0tOhQ==
X-Received: by 2002:a17:902:f7cf:b0:1cc:3bd3:73d8 with SMTP id h15-20020a170902f7cf00b001cc3bd373d8mr173983plw.59.1699905170326;
        Mon, 13 Nov 2023 11:52:50 -0800 (PST)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm4395815plz.79.2023.11.13.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:52:49 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/7] Staging: rtl8192e: Rename variable bCurrentAMPDUEnable
Date:   Mon, 13 Nov 2023 11:59:05 -0800
Message-ID: <20231113195910.8423-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113195910.8423-1-tdavies@darkphysics.net>
References: <20231113195910.8423-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bCurrentAMPDUEnable to current_ampdu_enable to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 drivers/staging/rtl8192e/rtllib_tx.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c0058d2be6d1..404f873455fc 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -327,12 +327,12 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	if (!ieee->current_network.qos_data.active ||
 	    !ieee->ht_info->current_ht_support ||
-	    !ieee->ht_info->bCurrentAMPDUEnable) {
+	    !ieee->ht_info->current_ampdu_enable) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
 			    ieee->ht_info->current_ht_support,
-			    ieee->ht_info->bCurrentAMPDUEnable);
+			    ieee->ht_info->current_ampdu_enable);
 		reason_code = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index f8eb4d553fe0..a4fe72943b36 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -112,7 +112,7 @@ struct rt_hi_throughput {
 	u8 bCurrent_AMSDU_Support;
 	u16 nCurrent_AMSDU_MaxSize;
 	u8 bAMPDUEnable;
-	u8 bCurrentAMPDUEnable;
+	u8 current_ampdu_enable;
 	u8 AMPDU_Factor;
 	u8 CurrentAMPDUFactor;
 	u8 MPDU_Density;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e607bccc079a..d5520cc82d22 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -514,12 +514,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	else
 		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
 
-	ht_info->bCurrentAMPDUEnable = ht_info->bAMPDUEnable;
+	ht_info->current_ampdu_enable = ht_info->bAMPDUEnable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
 		if ((ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) ||
 		    (ht_info->IOTPeer == HT_IOT_PEER_UNKNOWN))
-			ht_info->bCurrentAMPDUEnable = false;
+			ht_info->current_ampdu_enable = false;
 	}
 
 	if (!ht_info->reg_rt2rt_aggregation) {
@@ -544,7 +544,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->current_mpdu_density = max_t(u8, ht_info->MPDU_Density,
 					      pPeerHTCap->MPDUDensity);
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
-		ht_info->bCurrentAMPDUEnable = false;
+		ht_info->current_ampdu_enable = false;
 		ht_info->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 	}
 	ht_info->cur_rx_reorder_enable = ht_info->reg_rx_reorder_enable;
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 9bf679438ad1..a99c3b3f867c 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -288,7 +288,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
 		return;
-	if (ht_info->bCurrentAMPDUEnable) {
+	if (ht_info->current_ampdu_enable) {
 		if (!rtllib_get_ts(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
 			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
-- 
2.39.2

