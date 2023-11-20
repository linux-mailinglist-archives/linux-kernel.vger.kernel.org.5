Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D997F1FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKTVrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjKTVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:46:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B232C10F;
        Mon, 20 Nov 2023 13:46:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40853c639abso20505765e9.0;
        Mon, 20 Nov 2023 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700516797; x=1701121597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05TjyImSoTBVtC1xNXeArH35uiTcm8HxTuw7Nbu59W0=;
        b=ghcuOtelCeMbfmhYleMtFvj1LRTpEZxka7hb5P5nXUai9x9VEpvnmM/hNdFJ0PxnVr
         fU3G71a3xk+xOXsrXwn0++OMSXws370XH6LcbhMJ5JnQB2/qEX7kuHE4mYXu0Uk8MnLq
         jRHaLnniyqREwaDfbqKMkZF58hFKmUiDQB5Ed8m4EIuIZP4n5N0WBrZ+dNg/pw6tuRBa
         CG/Z/UN+d+KcRU8IA5SLOkNRIHtyLi9mp5vGq5Kp9IvF25bJIXUxY1MswBa/qPMGnHq7
         WyG9mQVloWHyOcjb65v0Yc+w84z2VAcSbiFZuAc2Cf73AhZ+Mjvn9Y4Uj+PGtyNRV+W2
         WVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516797; x=1701121597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05TjyImSoTBVtC1xNXeArH35uiTcm8HxTuw7Nbu59W0=;
        b=IdbA/3bVIZ1jTxWKGDlapmdqNgWKnYsOlR3X4teUMJINDm5vhTzLQFQ/FAQkIGeEFg
         a/VEm+4uTdtW+wMcxyj7GA+hRC9BTO7GtXi7ARcyP+rUJHCjtm4/7fCYxD9ACvfyhDJT
         NzqEaZoAH/I0DG1jcyRQUotfvNpLygcxqQWKFJENsdVHQvzLU5Lt4E6C8gNldnVR6I6z
         s+at6CJu4ACpQbSYfHyakSdHIvIT4Wn0ml73v+ekVcs/cUd1VkIAKABNwtUPsz93cW00
         Uw+sDv2ViVcIj7kvLToRFFE+D2NOwBQSEyPswMLrjAtpWndSLvxJDBpeLVlXsQfe53+0
         mcLw==
X-Gm-Message-State: AOJu0Yw03W/lH0AJM4ECAuRp2oVH+9LEH7mvh+rqEM6QCHvFv3ZhLRAW
        dksoAfMC93OK6RH8wp8Mcac=
X-Google-Smtp-Source: AGHT+IHJoVgqVgRHUKYiAlqB4jK5099Vv0cVK0mL31SC+jI+u/8+HbpYjQSSsu7PjIpJalcA1ZWpRA==
X-Received: by 2002:a5d:64e8:0:b0:332:ca10:388 with SMTP id g8-20020a5d64e8000000b00332ca100388mr2882898wri.45.1700516796963;
        Mon, 20 Nov 2023 13:46:36 -0800 (PST)
Received: from zotac.lan. (dynamic-2a02-3100-9030-5a00-2223-08ff-fe18-0310.310.pool.telefonica.de. [2a02:3100:9030:5a00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm2667052wrf.33.2023.11.20.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:46:36 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/20] drivers/video/fbdev/cyber2000fb.c: remove I2C_CLASS_DDC support
Date:   Mon, 20 Nov 2023 22:46:13 +0100
Message-ID: <20231120214624.9378-11-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120214624.9378-1-hkallweit1@gmail.com>
References: <20231120214624.9378-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/video/fbdev/cyber2000fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 52105dc1a..79775deda 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1234,7 +1234,6 @@ static int cyber2000fb_setup_ddc_bus(struct cfb_info *cfb)
 	strscpy(cfb->ddc_adapter.name, cfb->fb.fix.id,
 		sizeof(cfb->ddc_adapter.name));
 	cfb->ddc_adapter.owner		= THIS_MODULE;
-	cfb->ddc_adapter.class		= I2C_CLASS_DDC;
 	cfb->ddc_adapter.algo_data	= &cfb->ddc_algo;
 	cfb->ddc_adapter.dev.parent	= cfb->fb.device;
 	cfb->ddc_algo.setsda		= cyber2000fb_ddc_setsda;

