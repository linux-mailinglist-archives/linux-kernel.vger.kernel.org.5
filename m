Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF27F8584
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjKXVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjKXVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:31:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C81BC2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:31 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6eac9c053so6350781fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861490; x=1701466290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0oIQteEFtVA6f+wDuOWRlecjAASZc+RJVV85sdBg0=;
        b=ImQmAFP6rh2xDcUyAy+O9RqE7xvNfPGkx1dQdy959KPMGrs3nEtOmsgAG5Tx6lGbi9
         PbWhe3zfdDZmEkRT2u6VNmLfUw78CUJU100yL6TSADavBVWpHElRNzd0i35jhj38SqdD
         ZA2XzUpGjBMB71O4Mm+Hdggz9HNGocJtJqKA4EitORE7r683/XWkmcVHCVpkrTot62so
         l7Sv1ttN/RpKaWnc2pKCg9PtEh/J8bxbGaJ4rbMTXUgUWawxEb8KcQ3GTML8w80CeT3P
         F/sVcvOwme+UBywcAmZMGIHON4GqgulPUKlsu83/y4kevEBudcxBT19EAFZZlHlC5w0R
         IGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861490; x=1701466290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S0oIQteEFtVA6f+wDuOWRlecjAASZc+RJVV85sdBg0=;
        b=GizhyAzzH3jzEaRMNr4/i8OzQOCj/xbw538Vw65O8mhOw8KkCiDa9ITlBYjznE3Lh3
         uuCgzTKLSuj3D9akvNbUomAHz65Tm/4MD3Xtp16bFFkJPcHUPTh6IqBnVgC61S/42+Z7
         mogsxPaWtOLdWlVSpb3Sdn9FH2UlVHM0LncQQwkBFvC9rpa/v+MVlJes/x9ondlbZmLw
         LfAGZ+L6Wm0v9280a9fc17i6yZ4dV5ZrD39QFu9C6UslVsxOfngR1SaAAIKD6IN/MNg6
         Az2OQf2Ir7/FabDj/fKv3ZRSA5L/hCVErXoiF1opc12VJy/kZRYNrL+vkBNsTosR1Mxh
         Ly7g==
X-Gm-Message-State: AOJu0YzQV/taTe4cOFbp1Mi9myh+4hrslVtixu7DWDCBBuSheDidmXUg
        ReXSGyYO0M95MdCO7o/A0Hg=
X-Google-Smtp-Source: AGHT+IHCMYkJ56jgpiXcuQzCkqn39XC5UUuL6jWvl9alMVa9XQgIMxx3I9bsJ/oaKaBkbt/GItZ3lg==
X-Received: by 2002:a2e:5301:0:b0:2c5:2d06:cade with SMTP id h1-20020a2e5301000000b002c52d06cademr2556856ljb.2.1700861489325;
        Fri, 24 Nov 2023 13:31:29 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906578900b009fee12d0dcdsm2564669ejq.15.2023.11.24.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:31:29 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:31:27 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8192e: Remove function
 rtl92e_update_rx_pkt_timestamp()
Message-ID: <89a21fa17b32d66e07514bfad5b604d5d4835e25.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mac_time and last_rx_desc_tsf are only used in
rtl92e_update_rx_pkt_timestamp(). Depending on a condition one is equal
to the other or vice versa. But since those are not used anywhere else
the function rtl92e_update_rx_pkt_timestamp() is just dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 11 -----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  4 ----
 drivers/staging/rtl8192e/rtllib.h              |  1 -
 4 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 73315a236e76..13e3f26279aa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1673,8 +1673,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	stats->TimeStampLow = pDrvInfo->TSFL;
 	stats->TimeStampHigh = rtl92e_readl(dev, TSFR + 4);
 
-	rtl92e_update_rx_pkt_timestamp(dev, stats);
-
 	if ((stats->RxBufShift + stats->RxDrvInfoSize) > 0)
 		stats->bShift = 1;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index fc6e8ea039a3..bad34221d8b7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1433,17 +1433,6 @@ void rtl92e_reset_desc_ring(struct net_device *dev)
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 }
 
-void rtl92e_update_rx_pkt_timestamp(struct net_device *dev,
-				    struct rtllib_rx_stats *stats)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-
-	if (stats->bIsAMPDU && !stats->bFirstMPDU)
-		stats->mac_time = priv->last_rx_desc_tsf;
-	else
-		priv->last_rx_desc_tsf = stats->mac_time;
-}
-
 long rtl92e_translate_to_dbm(struct r8192_priv *priv, u8 signal_strength_index)
 {
 	long	signal_power;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 846f0f7a737b..546c8a33dae8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -234,8 +234,6 @@ struct r8192_priv {
 	int		rxringcount;
 	u16		rxbuffersize;
 
-	u64 last_rx_desc_tsf;
-
 	u32 receive_config;
 	u8		retry_data;
 	u8		retry_rts;
@@ -391,8 +389,6 @@ void rtl92e_irq_enable(struct net_device *dev);
 void rtl92e_config_rate(struct net_device *dev, u16 *rate_config);
 void rtl92e_irq_disable(struct net_device *dev);
 
-void rtl92e_update_rx_pkt_timestamp(struct net_device *dev,
-				    struct rtllib_rx_stats *stats);
 long rtl92e_translate_to_dbm(struct r8192_priv *priv, u8 signal_strength_index);
 void rtl92e_update_rx_statistics(struct r8192_priv *priv,
 				 struct rtllib_rx_stats *pprevious_stats);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 04433c79b3a7..47da9b1a8682 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -471,7 +471,6 @@ enum _REG_PREAMBLE_MODE {
  *       any adverse affects.
  */
 struct rtllib_rx_stats {
-	u64 mac_time;
 	s8  rssi;
 	u8  signal;
 	u8  noise;
-- 
2.42.0

