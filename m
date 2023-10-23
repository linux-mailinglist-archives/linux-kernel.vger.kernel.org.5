Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DEA7D3FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjJWTL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJWTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:11:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37CA9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507e85ebf50so3655339e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698088281; x=1698693081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdB/BGfiU50tq91OXEW4jEb/ithHfUpM77EyD2syuso=;
        b=IS7CutfvZvK07uFf0Jj4d+Ej5q4Xu5nL7NMxj/OQrzQC9xbr6mbBb6EhbDgOxD/Xl8
         sWO5cJ2O2Up0ZfgfwBH0JGN7N+TY/r1rwGs/tyBYFbE6C1QN7K5j9tkR984jeXLJkamZ
         urg5UM5zbEzKfUkNvXvD0v3nmGG2AsTULlQSJ82Vddqw3xBLozBJ4uJzzm2IgVrw4vyr
         QpM2EHctQu3anSgrkQgR5ZcMdZEBbcWd9wXwOruhsbVgqj2IRgRcFjbva3E3GGa4NU4Y
         O4gp70iGO4TKbWsYbkFwvOeUt9xiXSToFqnDKMY7GFIW0fOodll7TpYMhCMr0++RBLQI
         2/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088281; x=1698693081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdB/BGfiU50tq91OXEW4jEb/ithHfUpM77EyD2syuso=;
        b=fXhFeyP2GPhXlaZSMpFWsSo33bw5N0OkVxDs9YLhinDT9jJaFCAdmPM5IeR/BlD3Y6
         +O5UBpb4QZPmJqDue6bKaqG+zmZC+xdYcFcPWXdpE9MNy9Wqlk23Q22pBSPKYlq3dAVH
         0kkgUv2wrI/0iUKRboANxr7Z3xbhHA5szeMipJOoIHRKrBgCUFpCQiYdgwzTHCVCvFVT
         OYGQq6vq6Se2yNSo1O3DVRigT3D3Z1FlJIIVhXYEjIq2QV845p3u7L+eIp9rxtmABEYf
         6LLaHRUCWngBVFsctwqU49GKw1pCb4VH+htaNY999jrJ+/y+Sij6me0yDB4OIp3VrGFJ
         KIZw==
X-Gm-Message-State: AOJu0YxuSJ09eNw1lkz6cZh/xFmuVVmKgs6M62g0Lo63WS8Z921SuuY6
        yFEl2MAvdP59hRFO8ioov3U=
X-Google-Smtp-Source: AGHT+IH56wKrPVXYBFmpJ2Rc5ew0HtICHX6pQamTxBjFaB06LNEkOjvvgCoHVyCC782dakNLnMYRtQ==
X-Received: by 2002:a19:f807:0:b0:507:96c7:eb1a with SMTP id a7-20020a19f807000000b0050796c7eb1amr6357924lff.54.1698088281341;
        Mon, 23 Oct 2023 12:11:21 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id vg18-20020a170907d31200b009adc77fe164sm7062459ejc.66.2023.10.23.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:11:21 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date:   Mon, 23 Oct 2023 21:10:59 +0200
Message-ID: <20231023191059.19915-3-boukehaarsma23@gmail.com>
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

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 7466354c7e5b..5adf9ff07c3e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.41.0

