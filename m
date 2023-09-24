Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEA7ACB96
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjIXT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXT0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:26:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2EFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso893672566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583574; x=1696188374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d66F58Zyq56V9Vs4Hyo0TkmljKT89gyNoM7Khlph/EE=;
        b=XQ+ERoKkivTUgW0gcspZnVZ84aEm/rPMUHkgMDsgLqxjI8bCErRo0ww0iEW3Faztxe
         KHJIujXXIu20Npr+GVtxZYZ+dx+TxAa2AY0eHxDgN9K+Z5oW0alqZNs6uu4Ru+nvWtqJ
         hTahv5ZKqJJZN5IwClKPxoh1UIyZhoMk/QOm3YQzzgBcM7tiAEAM4u7kR/Y9GjOD2fzg
         kmjGamcnusJxHBpPghQsvddBNq2SOuuWSGH8NNldDDKeCH24ZLWpFi2VjrmTTnww/e9v
         z2ClAo3WJ+i4H/W4EqqoG/CeQEuFep2FJP/8qLXE2n943ez7HWT5xUYpqQbHBm0vl25k
         Swbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583574; x=1696188374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d66F58Zyq56V9Vs4Hyo0TkmljKT89gyNoM7Khlph/EE=;
        b=nU8hoOnumPzyQuiq5cbhcY3I1UIxI5r7AMTV5blIy/gzUINCDbfp7sUh97tPvRzvA6
         PlCfIB26p/TLnRCgnmPErbCG4XXDaaYhCve/71CjB4Qb+/1/BFwvCKBuYydXmg6Hfb0A
         CbCz3CJx8DyUBo2qESP91Kthcq8O1to4oqMcgOa/N8QLlmET7N2q+Em0ZrdP1Q3AFP/h
         jjiPOwRHUMsp3MA2vqB3VwmugViza5gxPwhg+OrvzcX9UJvvynjvdFmrjkvzk+ioHk9T
         O9c7JGBmeU8SBOZAyIZAY3YAE9GWPVwT3Te1t+Kp2QxQE7MWpqAhb9rG1/tROdzPjiSp
         Zy8A==
X-Gm-Message-State: AOJu0YyogqECgKM4uEv10eKo9PKKdzcARoVRi1sbpyBWsJy4mc0AJNu3
        jFTlUWBnQocgsGOMhqCasG4=
X-Google-Smtp-Source: AGHT+IGtAxBgqINvPVkn897Kub7Z+3KXI91OPf9r4wroQNRiKNPXXt+0g0rub6eEA+V8/peXL8DyGw==
X-Received: by 2002:a17:906:74d3:b0:9ae:614e:4560 with SMTP id z19-20020a17090674d300b009ae614e4560mr7802850ejl.29.1695583573619;
        Sun, 24 Sep 2023 12:26:13 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm5317632eje.80.2023.09.24.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:26:13 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/7] drm/sun4i: dw-hdmi: Deinit PHY in fail path
Date:   Sun, 24 Sep 2023 21:25:58 +0200
Message-ID: <20230924192604.3262187-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform
device") removed code for PHY deinitialization in fail path.

Add it back.

Fixes: 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 4727dfaa8fb9..0b647b030b15 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -203,6 +203,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 cleanup_encoder:
 	drm_encoder_cleanup(encoder);
+	sun8i_hdmi_phy_deinit(hdmi->phy);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
-- 
2.42.0

