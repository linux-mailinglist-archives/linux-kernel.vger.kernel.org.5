Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42777FC5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbjK1Unv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346221AbjK1Unk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F819AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b3febbce3so4486185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204225; x=1701809025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ikCgusC8eEFeJmPuPKC5u+Kpxfzr4U1dFEb8bUETbj8=;
        b=N8RsPuQP0NcADmz9wvhGmRxWxuWboBYjvDReV3rnQ+6kYuNXqpCm3hbYXU3YXc9mG4
         2Vh1yXQhZ/PSCv0Bj1c1vJL3yboheOSjZ9Z6SHH8zMdmvdg75EOdg+qOQEFzfT/NOr31
         R/5DpEtdlDi5MqIk2SvRhtbvrTgQ4Hu3ooRX9IJCuETGdWOlooyI8x+1OjvrSmMlQ0q7
         qUGdLJk70TetJMblo7xud9l+XqD+N7dM30z0RtsB9HuEFXkuKIDEfvtY9N0bmvJOCG/C
         7aeylG/aEhF7cKGZ9kIIhcVCWSG3XzcV8RVhLdNxanzNzypwY5laUvFvzNI/PWRQBeua
         V8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204225; x=1701809025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikCgusC8eEFeJmPuPKC5u+Kpxfzr4U1dFEb8bUETbj8=;
        b=GKdzs0BleK5/180Z1jb3zBKwUxrHJbtXJQ64PGIcQErXgSSPVcW48os7mApJMO86Oj
         Z317tObNOkCrV6xC8//xLjiDk/hcZZqepaShgBl4d/+n9HzfXtPBAGVjEHlnpkbOiuDE
         UF0hI//jest6qJ5LRJZiWboIclBHOlAY0dYjnQw7rsw2prCfXNyG5pODqOYTylUevQac
         OHQXbj7kP1w0ZqnXUu1fwzMo7HtAH4Hws86AjBM3ha9nt3JBcqAOf1NNS3TsYkYwpiLg
         yOKmAYLWBcz992iyM1V1cDWKhkNIcf7BocRXTZL9JTpkUCAaG5oA+HWvnI2FYuRpRPNL
         0E7g==
X-Gm-Message-State: AOJu0Ywd3S2bPZazy/Vt1xUu6wvxFea0lU0HoHNnRWD1b9outY1tmXvl
        HlNfoov1T6vcVdwLgOSkHJE4xeX+U9o=
X-Google-Smtp-Source: AGHT+IG+4DL5U+lBnGJYFFLiUW6H+Qu8GWLXVcDnIS9VLc8WKNgCpoFJhfyEg8tWzM5MQyaV3LR3CA==
X-Received: by 2002:a05:600c:54f0:b0:40b:4b69:b1a0 with SMTP id jb16-20020a05600c54f000b0040b4b69b1a0mr2379669wmb.3.1701204224692;
        Tue, 28 Nov 2023 12:43:44 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id a15-20020a05600c348f00b0040b33222a39sm19690937wmq.45.2023.11.28.12.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:44 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:43 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: rtl8192e: Remove unused function
 rtllib_rx_DELBA()
Message-ID: <566083b9cba530e3b17074bd3410e686c1778f0d.1701202700.git.philipp.g.hortmann@gmail.com>
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

Remove unused function rtllib_rx_DELBA().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 62 -----------------------
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 2 files changed, 63 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 4dadeb43b9a2..725139eb2deb 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -199,68 +199,6 @@ static void rtllib_send_DELBA(struct rtllib_device *ieee, u8 *dst,
 		netdev_dbg(ieee->dev, "Failed to generate DELBA packet.\n");
 }
 
-int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
-{
-	struct ieee80211_hdr_3addr *delba = NULL;
-	union delba_param_set *pDelBaParamSet = NULL;
-	u8 *dst = NULL;
-
-	if (skb->len < sizeof(struct ieee80211_hdr_3addr) + 6) {
-		netdev_warn(ieee->dev, "Invalid skb len in DELBA(%d / %d)\n",
-			    (int)skb->len,
-			    (int)(sizeof(struct ieee80211_hdr_3addr) + 6));
-		return -1;
-	}
-
-	if (!ieee->current_network.qos_data.active ||
-	    !ieee->ht_info->current_ht_support) {
-		netdev_warn(ieee->dev,
-			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
-			    ieee->current_network. qos_data.active,
-			    ieee->ht_info->current_ht_support);
-		return -1;
-	}
-
-#ifdef VERBOSE_DEBUG
-	print_hex_dump_bytes("%s: ", DUMP_PREFIX_NONE, skb->data,
-			     __func__, skb->len);
-#endif
-	delba = (struct ieee80211_hdr_3addr *)skb->data;
-	dst = (u8 *)(&delba->addr2[0]);
-	pDelBaParamSet = (union delba_param_set *)&delba->seq_ctrl + 2;
-
-	if (pDelBaParamSet->field.initiator == 1) {
-		struct rx_ts_record *ts;
-
-		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)pDelBaParamSet->field.tid, RX_DIR, false)) {
-			netdev_warn(ieee->dev,
-				    "%s(): can't get TS for RXTS. dst:%pM TID:%d\n",
-				    __func__, dst,
-				    (u8)pDelBaParamSet->field.tid);
-			return -1;
-		}
-
-		rx_ts_delete_ba(ieee, ts);
-	} else {
-		struct tx_ts_record *ts;
-
-		if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
-			   (u8)pDelBaParamSet->field.tid, TX_DIR, false)) {
-			netdev_warn(ieee->dev, "%s(): can't get TS for TXTS\n",
-				    __func__);
-			return -1;
-		}
-
-		ts->using_ba = false;
-		ts->add_ba_req_in_progress = false;
-		ts->add_ba_req_delayed = false;
-		del_timer_sync(&ts->ts_add_ba_timer);
-		tx_ts_delete_ba(ieee, ts);
-	}
-	return 0;
-}
-
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8	overwrite_pending)
 {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7d64855d835d..f1cd9eb96a7e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1776,7 +1776,6 @@ u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
-int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
 void rtllib_ts_init_add_ba(struct rtllib_device *ieee, struct tx_ts_record *ts,
 			   u8 policy, u8 overwrite_pending);
 void rtllib_ts_init_del_ba(struct rtllib_device *ieee,
-- 
2.42.0

