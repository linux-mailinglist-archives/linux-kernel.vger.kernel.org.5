Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650DB7D7C62
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjJZFns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjJZFnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849B1AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bf60bba6f8so14845866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299016; x=1698903816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZtVCTK7d+6aSVA0zIPbMt/ewE8ripYxAkjP40CJ1l0=;
        b=T2+lmq0WW77RllGCVixKd40vsza1SLQC5dOhiupIstYZkdfQY3BFMWdf0uMpFbSitp
         Vsy0UdXK/jDcv3vyAiO6WI6FWLHXyljzlggmRjWhWwaugP2wn5J5CZvOrfDUuP92IcZX
         fZcYs2BCO1N+GztmmF00klsCYFN91K/y93eU9Gumg2e0uBVTd7WcL3KZiaG5yfNdqWlz
         SyVZ1BZomiR6uOrK0ebZkQQyNmJQ44oEUybbIBmns3cu41Or+RDr6kA0O2Hq+5d7bQ8L
         aqR4CUS5Q67DUOk2mo5ZflMq//Dh+l07uB8YDAboLWMsns+aEwTQB3TiUPCULtDCPDah
         b5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299016; x=1698903816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZtVCTK7d+6aSVA0zIPbMt/ewE8ripYxAkjP40CJ1l0=;
        b=OamNEoPV8mFUDULSn1SGAZyyosrUm3Zgu7Ot/iZdUnHrro2BaZbz/qp5WjGYwyR4RP
         4zj5wFbVqXeCOVaJvCOsZRwU2jcigOS8Bx+joww8rz/GiOcz7A6tbC0aP7S1zoVAWtUQ
         zp9HeAYTmtkr2i5HunmjIbbJzxzv05vhcMng2drtebKbNCxw6hChQpOI0trgf/dVA5tK
         YfHUvlR8Mr1zG832pCVkrDfceKkiPoyH47yu+iUSgpwTotiBot83e9GbxYyGdfxUq+vA
         YjbRaRbjhn8mAtD0JH0+UXQ3ffLeoC3hr0QeTzRROCpCOgnNxzIOMmLcsyJ2g+rJwFX9
         kZVg==
X-Gm-Message-State: AOJu0Yw2ydSlg+Izv/5u3SyooYOeF4lpr5uZCGZ47jXPi6Z4SngQviaT
        GuZn+sedLJetbjPWnGJpHDk=
X-Google-Smtp-Source: AGHT+IEuJRMJgaGaNRyyTxMHSBFN4+cCZOwoVzmjfcPTxqkb3D7NfOhx2aZT0HmZgAsO0Zlo0u0DIA==
X-Received: by 2002:a17:906:cb:b0:9b2:bf2d:6b66 with SMTP id 11-20020a17090600cb00b009b2bf2d6b66mr11779782eji.7.1698299015576;
        Wed, 25 Oct 2023 22:43:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id gx13-20020a1709068a4d00b009ae6a6451fdsm10964024ejc.35.2023.10.25.22.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:34 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Remove HTIOTActIsDisableMCS14()
Message-ID: <7ff3c7f8daf9bccb004129fdc1128ca0b0cb4e70.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HTIOTActIsDisableMCS14() as it always returns zero which leads to
one evaluation that is always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 00b21542ddc3..18659408bb69 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -207,11 +207,6 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
 }
 
-static u8 HTIOTActIsDisableMCS14(struct rtllib_device *ieee, u8 *PeerMacAddr)
-{
-	return 0;
-}
-
 static bool HTIOTActIsDisableMCS15(struct rtllib_device *ieee)
 {
 	return false;
@@ -696,10 +691,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		HTIOTPeerDetermine(ieee);
 
 		ht_info->iot_action = 0;
-		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
-		if (bIOTAction)
-			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
-
 		bIOTAction = HTIOTActIsDisableMCS15(ieee);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
-- 
2.42.0

