Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9B7F0555
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjKSKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjKSKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:15:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8BD4B;
        Sun, 19 Nov 2023 02:15:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so135153466b.1;
        Sun, 19 Nov 2023 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700388900; x=1700993700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihe5CWoYwzVYQa0PIBn4FXCZubjqfqZzL14QGGmAy2E=;
        b=BDYlLUChSpufUXvVJtpAVULBjy/sR/4VY+a54t6eNdikWvoFFtQcsNzylwEZoiXQvL
         cxHU4wC0XYpUgsK/+5IEuiXASelbnWRZPVvW7JP3c3hIaSmHJgJ1Mm6ElzGW+Jwd/mpx
         FmCBZ+OIvgovl/1cyxyLUpJvGkhXnHTnaBtCsrX5Yr3fyFIQTMc9RfmfpsjoNqaIo7Bx
         R5XFvmXwNNLK3SKJHMYKGcFbw0wHGuOiYnZACuXtfyX4yChaukB0fvsE9rhYVLHssfuK
         ASRQ1s9V7phiHmwvjShOdA6cKuBIIm4i9BLwcO0qJ6iZIOPQO8zTueITWYCcs9s/s7Kg
         sRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700388900; x=1700993700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihe5CWoYwzVYQa0PIBn4FXCZubjqfqZzL14QGGmAy2E=;
        b=vYOim2jVb8G/PeTMpiBI1BK5koHKLcKH40nILlzC3tPx4+INJAbG5NFvi8M5dV4+vj
         XfIUYiLP3/C/Z02hQKryFYlcbShcruKcZBUCGxOLvHloa1fImtH+/cIQAPMF0TiI/O51
         0dKKl7CdXbLvcEyTHOJ8g8V5IOQUAzcCIdbbQBCqgajD0TS40CTU+DdvNh6Tn4AAjsbJ
         dSWf4gB2x0muH4iYTuWcd/4+NQM5PxCwzsXYxiDcahm0ZB4HlbsEREX6Rga1DkZ5MHz4
         FwKTnrQYfLlvDFhvSc8QNqRG7KpHFPQ45pvleJO+08Z+y0e1YVnsfof0gtO8YjzNFVrH
         85Zg==
X-Gm-Message-State: AOJu0YyMWsUA7usTHgOE6RaUTnsxXzBtCObyF4+SV8YRgG0GERuduI6X
        WnMC10Tbptlu/qrFxK9nf1Q=
X-Google-Smtp-Source: AGHT+IEA+I/p5Y2kpMMwz/wbD8AVKRFd+63nqxTeNaPbKOxKJmEk1Il1T/beHX2wdaQOaGPL4A2UqQ==
X-Received: by 2002:a17:906:221c:b0:9c7:5a14:ecf2 with SMTP id s28-20020a170906221c00b009c75a14ecf2mr3807104ejs.56.1700388900287;
        Sun, 19 Nov 2023 02:15:00 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090628d400b009928b4e3b9fsm2743581ejd.114.2023.11.19.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:14:59 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 12/20] drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 11:14:37 +0100
Message-ID: <20231119101445.4737-13-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119101445.4737-1-hkallweit1@gmail.com>
References: <20231119101445.4737-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index d675c954b..54e46e440 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -297,7 +297,6 @@ static int mtk_hdmi_ddc_probe(struct platform_device *pdev)
 
 	strscpy(ddc->adap.name, "mediatek-hdmi-ddc", sizeof(ddc->adap.name));
 	ddc->adap.owner = THIS_MODULE;
-	ddc->adap.class = I2C_CLASS_DDC;
 	ddc->adap.algo = &mtk_hdmi_ddc_algorithm;
 	ddc->adap.retries = 3;
 	ddc->adap.dev.of_node = dev->of_node;

