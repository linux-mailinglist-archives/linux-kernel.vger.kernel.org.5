Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69988082B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377987AbjLGISM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjLGISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:18:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12AD10C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:18:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0b2752dc6so5416855ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701937095; x=1702541895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSSwT5sKejGUVXo00knc6CvP0jgSpgasFg7ZUeKjVkg=;
        b=C8cCnAq6pEYEjFq6TnMydfGW0LwsW5QjeYyiDtfBuU3H3Say9ceeTilXWIfpnmGPdt
         92/mD8iIgDlZNrJJqAB0z1Fo+uGIhgbh3rttjLoHacqIn4JZna/D9F3MY9Lh+uJnLi4H
         ZR+DT2A3qDWTAWu18XgIlUdiyAccjHciVWUWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937095; x=1702541895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSSwT5sKejGUVXo00knc6CvP0jgSpgasFg7ZUeKjVkg=;
        b=cMhwaKhx8e6K7aKn9ZYM0qVfoU+hbo6z2gbmQnsglOSNcKQsMpRycBSWF8bECdXspZ
         LwlGWVl4TmdvxWlCCdKeBCFByJ3GdN3jumlN+BBqBIXIC8sKbAKxor7BMfVRqYdl8NVe
         XKUQkuow+A6mV9ccCRE/DyLUq/Oc390pimk57ILe7U5hQ4LjLZnj6Qss5tzMrvORim4o
         V474tEhdcUrkpYEblnKZC/YbSTGncd5fOtPCdIV7BTWw07ll9XVDjl9RqckG2AjkBvlw
         hdf0YKvOlNgRM11HzP0Xt1YuYJ1VwKdHZOpM1Hc0iZKBx0EK4CM0w8Cz0IiT2bu/f0Lc
         mYYg==
X-Gm-Message-State: AOJu0YwXvqJvjiySBrcklecFcqj03sSUCYTCTanYTMjifhsZiaiiRiwd
        8eV1rGUusDgvEysz5jC7UxYCbw==
X-Google-Smtp-Source: AGHT+IHj1r8543vt0rFMcubmDBoD1tNpr2DC6i766CO4yTYMZmtyXBB7Gvelw0nc8zdm+davXwDS4Q==
X-Received: by 2002:a17:903:1247:b0:1d0:a53e:2662 with SMTP id u7-20020a170903124700b001d0a53e2662mr2466675plh.104.1701937094987;
        Thu, 07 Dec 2023 00:18:14 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:663f:6f8e:5f2d:e06c])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001d09c5424d4sm748128plo.297.2023.12.07.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:18:14 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 1/4] drm/edp-panel: Move the KDC panel to a separate group
Date:   Thu,  7 Dec 2023 16:17:35 +0800
Message-ID: <20231207081801.4049075-2-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231207081801.4049075-1-treapking@chromium.org>
References: <20231207081801.4049075-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the KDC panel entry to make the list sorted by the vendor string.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-edp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index c76f186c4baa..a0b6f69b916f 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1980,9 +1980,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8c4d, &delay_200_150_e200, "R140NWFM R1"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
-	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
+	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
+
 	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
-- 
2.43.0.472.g3155946c3a-goog

