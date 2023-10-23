Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965917D3FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjJWTL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjJWTLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:11:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF1A9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so5021946e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698088278; x=1698693078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO9pyv976h/9S8gorIMhEgb5zOHhcco+YLW7BrIty0s=;
        b=lhTajoClE11hYbsVnP0qJf7Iad9fhqZGJQrPvumzNwkSJkcclytmkHL6XmpissfBT/
         OeztRv75/ag1FZ0fltlYXa3hWA9Iae5odSVC1QsU361eMLftvw5kEr6S83HzTwwSv9em
         nUu/I6MfjNu9ANfjH5D+JJBzk0Ujz81vtqhYQqpB/Ymm2X/mAW6XCIRrwotpROl9ZIjH
         QqKDX6D63HSktQT6oCGSyTy9QxMDPlvkcCvjmT5RgS1gke1HkylYBCIL6TkS6Npxed2P
         VY63Mr/f8zJ+i/oBvP1qrsDC4j8mpmgObWaELpggl1QlXNXkCxFY8vy17F/vc0SdI3//
         5fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088278; x=1698693078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO9pyv976h/9S8gorIMhEgb5zOHhcco+YLW7BrIty0s=;
        b=fTVpAK6psu8YHU/vYznxBtRBOu3QZg1FaJfzKgZUZneulf/M68dGBaBcdXkQqsx+Mq
         cLYLh1hF2TxiJd7Seuzjj1rrIshqu17Y5vP4jF/jp5MkUNQvv2DloDVZzguXnAC8zGhI
         h+nozoBQj0b/ZnmO1la2Rol8Podh4sYArW2ozMtFI3JzT8Q/C9TaUTx1xS9CBxz8bcjc
         2W63352ncD6x9Ca2Qmt3puYON5WmKcwXPSQRIiZv0F2qX9En4XpNUfgkh0ennzd+C7rk
         PX49WfEVJjM7MOU8Se885Y49ik1P6Orx8dVAdrVVk4OFtJOxNwkvZr9kQfNkzLTNb9x4
         +DeA==
X-Gm-Message-State: AOJu0YzeC8YJntOV+LsgIOiUXgdS4B6mnHAgsWZOwEOCwIbRRBHkWar8
        4XZkdmSIUXnFLLu4E9ZQmTg=
X-Google-Smtp-Source: AGHT+IFoG73WsHG9mQHz3C0QTTAsRZPJgjLfM1mDXnB4R4zv6xRHasqvRkUQLuIrH7X3daCy21jPWA==
X-Received: by 2002:a05:6512:2255:b0:506:8d2a:e31f with SMTP id i21-20020a056512225500b005068d2ae31fmr9336989lfu.46.1698088278334;
        Mon, 23 Oct 2023 12:11:18 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id vg18-20020a170907d31200b009adc77fe164sm7062459ejc.66.2023.10.23.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:11:17 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date:   Mon, 23 Oct 2023 21:10:58 +0200
Message-ID: <20231023191059.19915-2-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023191059.19915-1-boukehaarsma23@gmail.com>
References: <20231023191059.19915-1-boukehaarsma23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c15292ae93..7466354c7e5b 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.41.0

