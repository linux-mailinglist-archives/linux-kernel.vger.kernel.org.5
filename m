Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4F179D98E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjILT2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbjILT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:28:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA3B1702
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401314e7838so18390745e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694546913; x=1695151713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUSgJtFk7zn2O1gmuDqCli3+YafBtkOy6GThkBfBxcY=;
        b=kz+JbS2y0/hhsN9PO9Jz808+t+Xa+r1hoSIHeWfi9JJtamTsC2lQuninsYj3+o5dqz
         F9ejAjk4YjrDzL5RKMEWRtzjCwLvkkKy1JP73xUJQESfbpuDUzaQVLdGZ+rdR4MbxfxT
         iJidVpAWTkrWd1b+XTkpMnh6RipcNX68RxN8tTS93zk471CcZCZbBsbXms4JiEZmSeG8
         bAEoeunoXWjlSi5RbDiNIPjvdjxma2L+cHLRA6jhUTkJuC5Su3XxqAfOBjvnUm2BPerb
         dCrYTOq6ae/AxPbKc3imaJfp/yvkmV7Gbl1km0AkY3bViJZnFV7uyFrtKbNF+ytAz4nX
         nLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694546913; x=1695151713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUSgJtFk7zn2O1gmuDqCli3+YafBtkOy6GThkBfBxcY=;
        b=XNkC48tndUZ9wDBFC0RGAZp91jNehhFbEPJYFGVZokzl6ChUfGtuO/RcGy6nkeA4IK
         G+hUfiOxrbP988r2bNSy7IF93tl3DrcQXUG+u3ohBhgvdKApaVQUZdR8C0SYOSqYJxaJ
         0JLBWQjPEnHy9cztTzeBP9Dg7mI5yXBqvkBaqtTCXl27UEHkApHp1weBFJ5E37M7r9SZ
         ssPpNyX8bguaSb05YREYQGmoa/XqS8dKpMu8EELKozJoWJZT7McrN+nUtiKJzak8bgIR
         kWaipLUO8UgNTkFL44oy7jSMpTZW2o5GAReFM/kMW9FQ6ApMFwplb4ewaKM1Z9TEMrtR
         u+Fw==
X-Gm-Message-State: AOJu0YxRnEvnTDkya7HwEmoPY3HP0ws1XQfFrItrab9XfVj0Di7w1QDi
        PeyjsolEKrieJTp+EDgr2bppt3HSkM9Bmw==
X-Google-Smtp-Source: AGHT+IGqOIYmi2l1DyVrMwTfLa+JUN+8lA9615h8SmvYbWu5dZb5HvlJxUsgVxp4X1QmESkR3WuoFw==
X-Received: by 2002:a05:600c:1c0d:b0:401:c07f:72bd with SMTP id j13-20020a05600c1c0d00b00401c07f72bdmr276361wms.4.1694546912952;
        Tue, 12 Sep 2023 12:28:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c218600b003fe1c332810sm16810452wme.33.2023.09.12.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 12:28:32 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:28:31 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] staging: rtl8192e: Use standard function in
 softmac_mgmt_xmit()
Message-ID: <bd648e8e3c9c93c7944b72778ef7288973d8386e.1694546300.git.philipp.g.hortmann@gmail.com>
References: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694546300.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard function ieee80211_is_beacon() to avoid proprietary code to
identify beacon and to increase readability in softmac_mgmt_xmit() and
_rtl92e_translate_rx_signal_stats()

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v1->v2: Unchanged
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 1 -
 drivers/staging/rtl8192e/rtllib_softmac.c      | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 58e90b7772ef..8adf53174239 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1584,7 +1584,7 @@ static void _rtl92e_translate_rx_signal_stats(struct net_device *dev,
 		 (!pstats->bHwError) && (!pstats->bCRC) && (!pstats->bICV));
 	bpacket_toself = bpacket_match_bssid &&		/* check this */
 			 ether_addr_equal(praddr, priv->rtllib->dev->dev_addr);
-	if (WLAN_FC_GET_FRAMETYPE(fc) == RTLLIB_STYPE_BEACON)
+	if (ieee80211_is_beacon(hdr->frame_ctl))
 		bPacketBeacon = true;
 	_rtl92e_process_phyinfo(priv, tmp_buf, &previous_stats, pstats);
 	_rtl92e_query_rxphystatus(priv, pstats, pdesc, pdrvinfo,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 95c9f6679d71..7dfb93f0590c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -459,7 +459,6 @@ enum _REG_PREAMBLE_MODE {
 #define WLAN_FC_GET_STYPE(fc) ((fc) & RTLLIB_FCTL_STYPE)
 #define WLAN_FC_MORE_DATA(fc) ((fc) & RTLLIB_FCTL_MOREDATA)
 
-#define WLAN_FC_GET_FRAMETYPE(fc) ((fc) & RTLLIB_FCTL_FRAMETYPE)
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTLLIB_SCTL_FRAG)
 #define WLAN_GET_SEQ_SEQ(seq)  (((seq) & RTLLIB_SCTL_SEQ) >> 4)
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index de1702491191..5de57331c1cf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -197,7 +197,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct rtllib_device *ieee)
 	/* called with 2nd param 0, no mgmt lock required */
 	rtllib_sta_wakeup(ieee, 0);
 
-	if (le16_to_cpu(header->frame_ctl) == RTLLIB_STYPE_BEACON)
+	if (ieee80211_is_beacon(header->frame_ctl))
 		tcb_desc->queue_index = BEACON_QUEUE;
 	else
 		tcb_desc->queue_index = MGNT_QUEUE;
-- 
2.42.0

