Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4C7F0958
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjKSWPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKSWPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE79D4D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32fa4183535so894394f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432098; x=1701036898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBka6fetHrkhQ8h4bMJLkDq8qXCW9llZuCFqV0CRlrc=;
        b=HvHC2dWHL+8Bt2ksdvHcM+sML0PaZvDdtgIzVULGkddzMJYkThOW/N+/DMqHncBfdf
         jf7vcFXs1xzdPd8nopuZVJoHAfSPOdfTC7pvbGOkqtxF7IxWg3WV2EkjwcbX+COxZeEy
         eDoVJ0E0wNKT+VBwM7zG7pzpKlc6EdOVTUSKh7gFSCN+QxRG/1BX57RwbO0IuEJEK9op
         VmN3A8uePrnU3CaA/ssce8ZHCHb8ZBLsr6vtftYmzMhkfOdH27bPIvccoBlUTIR9f4e4
         vuhGBEIG+IPLiBFSKJEdFwBi0CeeIbVWWxEvOo6FmtfUpTUBmUhx7qVa0DAuUNamEM08
         GaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432098; x=1701036898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBka6fetHrkhQ8h4bMJLkDq8qXCW9llZuCFqV0CRlrc=;
        b=oA6UPhWXsxVw3XrX8+qMT8JhSRlutXojejWjwdxeUpR9HhlKtYi9Zo0ECEK8jnAshX
         EBTW5s5iURZu39MWYVeOMauP28X4H94ev5+fJJ+74owZLh5Rt/Xaoc1aASwse0/x8E6D
         xOvQ7tS4MPSHSmRx+B1WuPVqBtx0qaYOGWsVokjNdn8hkc0j1YzDuYdGa8FRKCR/AVXp
         kz4GX4J8pzFIXHACcnJbOfdFn8MEt/+WgMTAC9256y5yQRyp/d1qUT3GUnKdmVsqm+ty
         hoPcsdGMRg3Gk2yXSO6mL6oROF5hq1W8zEiBGkmb5dbxrAupJTQxoiUKZSkJ3CoJyYD/
         yQ4Q==
X-Gm-Message-State: AOJu0Yxa40NpPc28PbCISV6wX/0FmF1Nzjkw9fzG2jyQPhT8G0gzY8vU
        qJqx7QUI1BXoBOmXvnDUjBI=
X-Google-Smtp-Source: AGHT+IG7BIz+JWuX8uDz8IATgnBHiVah94Is2WPvUwa5m1JBHtiLYc1gqqSYBCNEYA7WhQA7EVCsTA==
X-Received: by 2002:a05:600c:1c10:b0:3fe:21a6:a18 with SMTP id j16-20020a05600c1c1000b003fe21a60a18mr4882616wms.3.1700432097833;
        Sun, 19 Nov 2023 14:14:57 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id x18-20020a05600c421200b00406443c8b4fsm15254224wmh.19.2023.11.19.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:14:57 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:14:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] staging: rtl8192e: Remove unused function
 dot11d_scan_complete()
Message-ID: <065a8223b80730360ee3223067ee612737e777a7.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function dot11d_scan_complete().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 15 ---------------
 drivers/staging/rtl8192e/dot11d.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 9eb941326bc8..95fb56cb77fc 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -59,18 +59,3 @@ void dot11d_reset(struct rtllib_device *ieee)
 	RESET_CIE_WATCHDOG(ieee);
 }
 
-void dot11d_scan_complete(struct rtllib_device *dev)
-{
-	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(dev);
-
-	switch (dot11d_info->state) {
-	case DOT11D_STATE_LEARNED:
-		dot11d_info->state = DOT11D_STATE_DONE;
-		break;
-	case DOT11D_STATE_DONE:
-		dot11d_reset(dev);
-		break;
-	case DOT11D_STATE_NONE:
-		break;
-	}
-}
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index c28067510653..9e8328af887c 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -73,6 +73,5 @@ static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
 void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
 void dot11d_reset(struct rtllib_device *dev);
-void dot11d_scan_complete(struct rtllib_device *dev);
 
 #endif
-- 
2.42.0

