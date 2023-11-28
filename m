Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5277FC5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbjK1UnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjK1UnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC5A1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-407acb21f27so6999565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204197; x=1701808997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTvuKmkTJPAvRgA2l6Vxt5PQ3ZQRNuyzzv3L3pAw+UE=;
        b=alND4+3kDWr3/zgpPK0NM0pPsupkjJIJxKSNdAckrySBT0sblFwgendjrLNt8uxrsR
         IGQ1CymDOB6ZD5ay79DTbow32zJe7IBwkg2JczijSQ3jUHJkyE21Q9drwQ73BccmnQa2
         rFqcVj8W3B0TwZHVT3o+8PlTMA0TczsJZvxQZXejAHyUqMtHmOv7ZHGr9c3xQJIfZ+Yc
         a7HMwhbXpCdQvSgCp0EGw+XaoZ4dQH/dAtR9rYWA5XRg9JcO7NiIfPd54+J2Bd3h3fLK
         PVTjbDnggfdcWFCImpXQA8c28LyZDTIXKCAZlyM84DFyhy7XU2OkUMtDS3ixP82vX3ph
         68zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204197; x=1701808997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTvuKmkTJPAvRgA2l6Vxt5PQ3ZQRNuyzzv3L3pAw+UE=;
        b=igxEVu8gA/FCgbkhV0hf3tDvuRCKxjaXFs/OK8nYsA73rGsXeOObZjEqarXcRKxYRw
         QYu7QfgfbxIsOUnivSWpQ70q6oUpLZ3PUYsSuW9KdDi20W2CMOcsjdUHLCzgjqa6jyTU
         s2nj76hyVaCzeCnO4UD4Qjm1YwweqUEPCQH+8coc2tMWOCV05OXjOpWBkwFy5OmiC7UY
         j380jmcO3glXoHy+8Vu4img0oR4yH0NonB7TQB7KmhbuvWYOzMbeDnEQVhgvE0WFGBT4
         Xurpy2gdGPYLNJOXsIPD+QYRLNz86uRBCR8I4nKgXrlH08ZPXjdVBXN6+uDQHutuKEE0
         4SHg==
X-Gm-Message-State: AOJu0YwUXfcdQjozslyfNjarX0Tk3qwfG6sbaPhO6e3BQdsGiRZQ5a+x
        CzetoP/k35d8HSDq9eucfh7xaSE6vs8=
X-Google-Smtp-Source: AGHT+IE8UoUtnPeBJvrSa3kkQbhdQrU8oo5xXMAaG5f0yy8HXCJfuQ38kYaqQSoEVYLSeiiwFXJ2yA==
X-Received: by 2002:adf:fccb:0:b0:332:fb6a:6206 with SMTP id f11-20020adffccb000000b00332fb6a6206mr5716051wrs.2.1701204197330;
        Tue, 28 Nov 2023 12:43:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d6251000000b0033310d8d0e8sm2371953wrv.63.2023.11.28.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:17 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] staging: rtl8192e: Remove action block acknowledgment
Message-ID: <b9dd747c517171647038ae9f345790cc1af1e1aa.1701202700.git.philipp.g.hortmann@gmail.com>
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

Driver does not handle block acknowledgment correctly. Tests with AP have
shown that the AP is giving up after some tries. Remove function
rtllib_process_action().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 30 -----------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d20970652432..1b66e718c59b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1556,33 +1556,6 @@ void rtllib_ps_tx_ack(struct rtllib_device *ieee, short success)
 }
 EXPORT_SYMBOL(rtllib_ps_tx_ack);
 
-static void rtllib_process_action(struct rtllib_device *ieee,
-				  struct sk_buff *skb)
-{
-	u8 *act = skb->data + RTLLIB_3ADDR_LEN;
-	u8 category = 0;
-
-	category = *act;
-	act++;
-	switch (category) {
-	case ACT_CAT_BA:
-		switch (*act) {
-		case ACT_ADDBAREQ:
-			rtllib_rx_ADDBAReq(ieee, skb);
-			break;
-		case ACT_ADDBARSP:
-			rtllib_rx_ADDBARsp(ieee, skb);
-			break;
-		case ACT_DELBA:
-			rtllib_rx_DELBA(ieee, skb);
-			break;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
 static inline int
 rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 		     struct rtllib_rx_stats *rx_stats)
@@ -1789,9 +1762,6 @@ inline int rtllib_rx_frame_softmac(struct rtllib_device *ieee,
 	case IEEE80211_STYPE_DEAUTH:
 		rtllib_rx_deauth(ieee, skb);
 		break;
-	case IEEE80211_STYPE_ACTION:
-		rtllib_process_action(ieee, skb);
-		break;
 	default:
 		return -1;
 	}
-- 
2.42.0

