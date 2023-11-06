Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388007E2B8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjKFSCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:02:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49001BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:02:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f613272so41714295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobile-devices.fr; s=google; t=1699293719; x=1699898519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDm506CW1CfmWdc8ZEPy9UyaSh27+NblN2O42wc6Ric=;
        b=n3XlSfI+EJkXgZ8IZLr47V57EQeA2XyjilPCsf8ZdWHCdAtHZ/kz0qhIfq/mdd4cfh
         Z48kIXXUzlhf62FnfQ0aFuLaULB9+mksAfEJ2L2zqjQZh/+IC1uB7TVXS56UVHqFKERz
         2FDKXZjwADB4PnbvRL75+s5XZGx8Mqj5f3LSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293719; x=1699898519;
        h=content-transfer-encoding:cc:subject:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDm506CW1CfmWdc8ZEPy9UyaSh27+NblN2O42wc6Ric=;
        b=XXh75t8AHaGArG8OhxUC0ENEUXlZOk0d9Pablma+/K5z1Rifc+PNGIZ+YVhVj9c2qY
         JV3Fs+jupOzlKjxCyI4lLDpNH39Bg3gH0VYen7zd1qfw5uQaFsUa0lcAuDSfqX2fqrOx
         LGc1VXSJfW7P3pfj/in2iwxMOP+JpErNybD3/haNfGREUeEu/GGfNMH8hc2ZTDQkTo8O
         zYGBGJpYvpVbk4HF7ZdAMddVpBnxnEYF15MUPIgvSxTtDKDD2EwUpXEb7Fq2FfGKrACZ
         /H9qAgnvUuXIkCdxC4wZ7sLe064JxblIgpLbIxRi15fKNp8QXl25aaHCIkmhf7Q9s5O3
         ZRbg==
X-Gm-Message-State: AOJu0Ywol24AATrfh29mzeFBGv5voihPKPMPACqOYUp/eEETcMvNoEkh
        WPh5iB2/P25YSqaM65UyaTWALmGKFfMnphn9y+c=
X-Google-Smtp-Source: AGHT+IEN04Uu8Xyw8RUlVXXHKf0i80rZNPf69h/WP9HYr9XT0vrLjOEwh1KX8/yJvOWvKUwZqfwCyw==
X-Received: by 2002:a05:600c:4fd4:b0:405:3b92:2fed with SMTP id o20-20020a05600c4fd400b004053b922fedmr372167wmq.26.1699293719033;
        Mon, 06 Nov 2023 10:01:59 -0800 (PST)
Received: from [10.42.42.90] (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b004097881d7a8sm10027857wmg.0.2023.11.06.10.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:01:58 -0800 (PST)
From:   Maxime Jayat <maxime.jayat@mobile-devices.fr>
X-Google-Original-From: Maxime Jayat <maxime.jayat@munic.io>
Message-ID: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
Date:   Mon, 6 Nov 2023 19:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: netlink: Fix TDCO calculation using the old data
 bittiming
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TDCO calculation was done using the currently applied data bittiming,
instead of the newly computed data bittiming, which means that the TDCO
had an invalid value unless setting the same data bittiming twice.

Fixes: d99755f71a80 ("can: netlink: add interface for CAN-FD Transmitter Delay Compensation (TDC)")
Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 036d85ef07f5..dfdc039d92a6 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -346,7 +346,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-			can_calc_tdco(&priv->tdc, priv->tdc_const, &priv->data_bittiming,
+			can_calc_tdco(&priv->tdc, priv->tdc_const, &dbt,
 				      &priv->ctrlmode, priv->ctrlmode_supported);
 		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
 		   * turned off. TDC is disabled: do nothing
-- 
2.34.1

