Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD67B71C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbjJCTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjJCTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA13BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso53939466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361587; x=1696966387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0r3DREMiH6yQfDoDU6vaHZLHIyC1HQyFX1F4ZCsk8E0=;
        b=Zn1GOAQ5szKDok5C87nu2G3rJKPVSylxIlZM73iF/Lq4dRY1syxPXD9KuG2Etef9IB
         l97rwm6hsIuUmaAS3UmyU5ifl2qnPgF4JGF2FpcegAWEyZnbW/05gGkxOCDrL4pj2vtG
         sCPt69NS2qK7vcEAckvIgw+5JzCdlhzQrpxBgW5FaplEtrZUxveTO0+S10evSnEEMUbI
         mRyDrBqSxFjqHw7h/2cUesZwprGa8ZKX1qYJqtkaIubwho7PW/N3SA8u0aBcmwR55x6l
         a41zNfXSThlPewQUMgDpu7EGHqGVe/8e4CROKpti+bh8sbpqyInFTaMdBhP7+GeEsBVn
         CwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361587; x=1696966387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r3DREMiH6yQfDoDU6vaHZLHIyC1HQyFX1F4ZCsk8E0=;
        b=CzGejyala7OkDJEnFQDwMPORs2ZqV8H2t3fqtYv8/vx6wZGIcOZLITfjisoLgb7ngb
         9vQXAZv7Uz4KYItdmBQP/VW14Ob/J+i1ot4cdMZoMNyU622Br6Uhno6EoDo9g+YnVBDi
         sJBKWaoXNKJjkjJHTM2wa4lrHw/NjcWxRnslXElFP9ZvmtIeApavxGsE+aWk3UxvwL59
         2HRGsz0hThllhxRWXalbsuiKZFzDk+QgP0wYjEwJmxXX1uTZjGRymg/tX4bVofluSYQj
         gs6u8hXlc+xV2tYsM5rO75h5bwWeqt4qRr3w1lCBd4b+YhIMIwDQMCvUiYWOIUvcbZ+q
         h++A==
X-Gm-Message-State: AOJu0YzpSjwNKgdbWkaamUv6Vux120PiD30q5aDPK3o+3/Up7FmIF3Zl
        F7LwO4fuyFCOmhxlJfsooOo=
X-Google-Smtp-Source: AGHT+IGL/Kojw0O9o6XKrJT+/wDlbuGiq4mxQwluohDgRPGLUuuz5BUJBo4NzFmgPQnSeIPqeaIt6w==
X-Received: by 2002:a17:906:5194:b0:9a1:b4f9:b1db with SMTP id y20-20020a170906519400b009a1b4f9b1dbmr154888ejk.1.1696361587272;
        Tue, 03 Oct 2023 12:33:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b009aa292a2df2sm1512913ejb.217.2023.10.03.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:07 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove function
 _rtl92e_wx_set_rawtx()
Message-ID: <96196bf0f45934e8e49f1d185165e2a36f5bca7d.1696360403.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function _rtl92e_wx_set_rawtx() as this functionality is not
commonly used and the tool to access it is deprecated.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 24 +--------------
 drivers/staging/rtl8192e/rtllib.h            |  4 ---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 32 --------------------
 3 files changed, 1 insertion(+), 59 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index e7be89833b59..f28e70a0da4f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -122,25 +122,6 @@ static int _rtl92e_wx_get_power(struct net_device *dev,
 	return rtllib_wx_get_power(priv->rtllib, info, wrqu, extra);
 }
 
-static int _rtl92e_wx_set_rawtx(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-{
-	struct r8192_priv *priv = rtllib_priv(dev);
-	int ret;
-
-	if (priv->hw_radio_off)
-		return 0;
-
-	mutex_lock(&priv->wx_mutex);
-
-	ret = rtllib_wx_set_rawtx(priv->rtllib, info, wrqu, extra);
-
-	mutex_unlock(&priv->wx_mutex);
-
-	return ret;
-}
-
 static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 					   struct iw_request_info *info,
 					   union iwreq_data *wrqu, char *extra)
@@ -1044,9 +1025,6 @@ static const struct iw_priv_args r8192_private_args[] = {
 	}, {
 		SIOCIWFIRSTPRIV + 0x1,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "activescan"
-	}, {
-		SIOCIWFIRSTPRIV + 0x2,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "rawtx"
 	}, {
 		SIOCIWFIRSTPRIV + 0x6,
 		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, IW_PRIV_TYPE_NONE,
@@ -1072,7 +1050,7 @@ static const struct iw_priv_args r8192_private_args[] = {
 static iw_handler r8192_private_handler[] = {
 	(iw_handler)_rtl92e_wx_set_debug,   /*SIOCIWSECONDPRIV*/
 	(iw_handler)_rtl92e_wx_set_scan_type,
-	(iw_handler)_rtl92e_wx_set_rawtx,
+	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)NULL,
 	(iw_handler)NULL,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d3ac6ea71030..98b8b7db027e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1755,10 +1755,6 @@ int rtllib_wx_get_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 		       union iwreq_data *wrqu, char *b);
 void rtllib_wx_sync_scan_wq(void *data);
 
-int rtllib_wx_set_rawtx(struct rtllib_device *ieee,
-			struct iw_request_info *info,
-			union iwreq_data *wrqu, char *extra);
-
 int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
 		       union iwreq_data *wrqu, char *extra);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index bd2b8bba86eb..f32584291704 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -436,38 +436,6 @@ int rtllib_wx_get_mode(struct rtllib_device *ieee, struct iw_request_info *a,
 }
 EXPORT_SYMBOL(rtllib_wx_get_mode);
 
-int rtllib_wx_set_rawtx(struct rtllib_device *ieee,
-			struct iw_request_info *info,
-			union iwreq_data *wrqu, char *extra)
-{
-	int *parms = (int *)extra;
-	int enable = (parms[0] > 0);
-	short prev = ieee->raw_tx;
-
-	mutex_lock(&ieee->wx_mutex);
-
-	if (enable)
-		ieee->raw_tx = 1;
-	else
-		ieee->raw_tx = 0;
-
-	netdev_info(ieee->dev, "raw TX is %s\n",
-		    ieee->raw_tx ? "enabled" : "disabled");
-
-	if (ieee->iw_mode == IW_MODE_MONITOR) {
-		if (prev == 0 && ieee->raw_tx)
-			netif_carrier_on(ieee->dev);
-
-		if (prev && ieee->raw_tx == 1)
-			netif_carrier_off(ieee->dev);
-	}
-
-	mutex_unlock(&ieee->wx_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL(rtllib_wx_set_rawtx);
-
 int rtllib_wx_get_name(struct rtllib_device *ieee, struct iw_request_info *info,
 		       union iwreq_data *wrqu, char *extra)
 {
-- 
2.42.0

