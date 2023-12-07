Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1498082B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378134AbjLGISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377935AbjLGISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:18:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E986DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:18:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d06d42a58aso5577895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701937097; x=1702541897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQJWnhNLnP6Awp7NjFB9t/P5znClGB7Yq+APmm7pGdg=;
        b=LjBLuoAPssi8cIJ+gHtc/QTgghFzaPFPz/1C1dFBW5qOcwglHbr6kTRwkOitD8g9Qt
         cBZccDzwhfyPjGw6wkpE9/A1Y9U8L5A8+BwhrCBjime8mhmoWKrs/jjEwQWraijPmEBi
         QPzMSgWG4eFx3bnCXI2YRJT2fArLKrxU0wLas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937097; x=1702541897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQJWnhNLnP6Awp7NjFB9t/P5znClGB7Yq+APmm7pGdg=;
        b=FMP3NT8ftGHwdgYN9nN3fCxkVPwZf/MhVyWkc/f4+/dhNQuK7MUxbBKCUFsJsry82l
         9G5P9U8TDDB6bR12Pb+cWwvHAiYOO6UF2SkyrqQj8Jkk0yttdiK1ZBDZ43dfGkWVsNkp
         t4cErjXIaPlW/krYsLP39RPIivSo+wnidfuQnEG6y63JuV+lULRIByOGBvlfrLusu44e
         ZLujGJbzhT0zsEjZWnn+1n8CzD9NgLNJuVAwmVvA9vJByq8MUSYCoict9XdUnieIOtPP
         liN+erBQ9CHrKIjiDE48jt5Ucmb0plFSmtqSHwwmXMXftuibyO1UZ8Eq/p6G+3E6ac8I
         xiiw==
X-Gm-Message-State: AOJu0YzkgrWZsinbf8nYNbEIqSSytGwHIwvAg9mQFsQaSW55joAf09kG
        kQ1TcTxEbWZHA0jn8DLR53pOJw==
X-Google-Smtp-Source: AGHT+IGgqFxlIC4wu2oAnuqzZtdbL46HAt+drIAs9tIBCh2pssTSR+uBR95ax8mNq1iftLTEdDOpDQ==
X-Received: by 2002:a17:902:dac5:b0:1d1:d939:159 with SMTP id q5-20020a170902dac500b001d1d9390159mr1890437plx.21.1701937097547;
        Thu, 07 Dec 2023 00:18:17 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:663f:6f8e:5f2d:e06c])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001d09c5424d4sm748128plo.297.2023.12.07.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:18:17 -0800 (PST)
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
Subject: [PATCH v2 2/4] drm/panel-edp: Add powered_on_to_enable delay
Date:   Thu,  7 Dec 2023 16:17:36 +0800
Message-ID: <20231207081801.4049075-3-treapking@chromium.org>
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

Add the support of powered_on_to_enable delay as the minimum time that
needs to have passed between the panel powered on and enable may begin.

This delay is seen in BOE panels as the minimum delay of T3+T4+T5+T6+T8
in the eDP timing diagrams.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index a0b6f69b916f..44acf9cacaf7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -70,6 +70,21 @@ struct panel_delay {
 	 */
 	unsigned int hpd_absent;
 
+	/**
+	 * @powered_on_to_enable: Time between panel powered on and enable.
+	 *
+	 * The minimum time, in milliseconds, that needs to have passed
+	 * between when panel powered on and enable may begin.
+	 *
+	 * This is (T3+T4+T5+T6+T8)-min on eDP timing diagrams or after the
+	 * power supply enabled until we can turn the backlight on and see
+	 * valid data.
+	 *
+	 * This doesn't normally need to be set if timings are already met by
+	 * prepare_to_enable or enable.
+	 */
+	unsigned int powered_on_to_enable;
+
 	/**
 	 * @prepare_to_enable: Time between prepare and enable.
 	 *
@@ -216,6 +231,7 @@ struct panel_edp {
 	bool prepared;
 
 	ktime_t prepared_time;
+	ktime_t powered_on_time;
 	ktime_t unprepared_time;
 
 	const struct panel_desc *desc;
@@ -455,6 +471,8 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
 
+	p->powered_on_time = ktime_get_boottime();
+
 	delay = p->desc->delay.hpd_reliable;
 	if (p->no_hpd)
 		delay = max(delay, p->desc->delay.hpd_absent);
@@ -579,6 +597,8 @@ static int panel_edp_enable(struct drm_panel *panel)
 
 	panel_edp_wait(p->prepared_time, p->desc->delay.prepare_to_enable);
 
+	panel_edp_wait(p->powered_on_time, p->desc->delay.powered_on_to_enable);
+
 	p->enabled = true;
 
 	return 0;
-- 
2.43.0.472.g3155946c3a-goog

