Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9934D80ABF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574644AbjLHSUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574643AbjLHST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:19:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49F10EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:20:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54ce02c1ba2so599982a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059599; x=1702664399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NL738sRXL2selidGyxVJuSE1dSJZ2wGMlE7qfmgnwJM=;
        b=bgeb2RTnHWBM9BYvVKIFTPWtYVYaLWsypskloEWIQNzkbWkGmTqIzKlORUGoik3ZoG
         c4/iPsncGwjJHG3uMyLZUvQZrz/7A7ruq2oQOVeDnASkq7rDEWAtVgLx9E4e64ECeklT
         UOiVanPaIncd8V5HADLQeZLGxVZcjLCS0Fhu1KEWJ2DNqy2/m3LyWroHeiaNsqK9qCke
         ihUYARIozR6lBNTrR5CpcBsaVaoi4axqIVpPwdasTDFSwNvW4yKOGqPy9xyoNFB1NBSQ
         pGseH/FQE1x9rqClIenjuaASeEaS6tbTpVjoK4ivRNblqZP2W9aRBbQqnynplZbEInOX
         4s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059599; x=1702664399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL738sRXL2selidGyxVJuSE1dSJZ2wGMlE7qfmgnwJM=;
        b=JUJ9ZPwtHJ9V9I4DGbvxD+C0F5o7ErYvY9AcTxwXsAfmRLlHuV28O4yh1kWXX5eVXw
         7u/30gX7HkCAy2TEVERu0HMJxPOSEeFNiPW24l57/Eqt7H8FljWBVar9bjYt0GTBoB6+
         xWdELo2BlMW3R+2KWpWw3I0OTyTTsfBbuy83ga9aP6L+Fa+qmqdmzOMxRmnfmRu3YVaM
         2/dVnQmnGpdQsP7l6Q6LOowHPNCo/cKgDCfWw884UItPq/X3fSAAL9+7lbbg/kBlIb/b
         0eoEEqzqZVrCRrl+12UWTkF3/QNo+IUSduR607jAdTolpM7cqmdk0+BM2WK6wqjRXUG8
         obrw==
X-Gm-Message-State: AOJu0YxjYBD6UP/1ZyHYW8WCeQkXMydqEVPXxOCaAcwCsxWeS0Mb//YW
        CbYJ9y1KcrU6V3bVcqsDv1Vk0eY8/Cg=
X-Google-Smtp-Source: AGHT+IFdR2UufJ2zugN7gYUxeKAflRUNxo0/XvxIbFy4M2zayiHsvQ4A6Qw6kROU5OKa1Cs9rUdUJg==
X-Received: by 2002:a17:907:c207:b0:a18:96e3:ae2a with SMTP id ti7-20020a170907c20700b00a1896e3ae2amr446873ejc.5.1702059599455;
        Fri, 08 Dec 2023 10:19:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id vo16-20020a170907a81000b00a1d32dfacb9sm1276308ejc.38.2023.12.08.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:19:59 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:19:57 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] staging: rtl8192e: Remove function dot11d_channel_map()
Message-ID: <877c0efcf56977cbf0943b34beda4ff2ca514714.1701989555.git.philipp.g.hortmann@gmail.com>
References: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function dot11d_channel_map() as it is empty.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c            | 6 ------
 drivers/staging/rtl8192e/dot11d.h            | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 8d89f962b3bf..ec71bae05c1f 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -6,9 +6,3 @@
  * wlanfae <wlanfae@realtek.com>
  ******************************************************************************/
 #include "dot11d.h"
-
-void dot11d_channel_map(struct rtllib_device *ieee)
-{
-
-}
-EXPORT_SYMBOL(dot11d_channel_map);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 98aa28d0cf72..eeefbfa96938 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -18,6 +18,4 @@
  *		2 - valid (passive scan)
  */
 
-void dot11d_channel_map(struct rtllib_device *ieee);
-
 #endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 1f45b6b00d1b..72e89ccfb184 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -761,7 +761,6 @@ static short _rtl92e_get_channel_map(struct net_device *dev)
 
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dot11d_channel_map(priv->rtllib);
 	for (i = 1; i <= 11; i++)
 		(priv->rtllib->active_channel_map)[i] = 1;
 	(priv->rtllib->active_channel_map)[12] = 2;
-- 
2.43.0

