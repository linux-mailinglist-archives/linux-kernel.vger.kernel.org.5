Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3725F8134BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573795AbjLNP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573777AbjLNP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:28:19 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34510F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so614478b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702567705; x=1703172505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwxChGA7kEkaVI+0NazbW4JwE+2WuKPP+E6QFXGK0uY=;
        b=INP+Ib9S8CsKOUazCjSxtVxOlSpO+fGZRTZyUuwaKpV5m6RWPNvI6Oh6coamBTSBBz
         9951I609lfn6W1yQklxoKIbK2yDT1vP2z773Kv6VTwqUiGbQ3FAS+J1YcuUnJ+OKYmLZ
         St842qjHH0Kj+5nl+86Hr4jNuiFyLw8ALzJ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567705; x=1703172505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwxChGA7kEkaVI+0NazbW4JwE+2WuKPP+E6QFXGK0uY=;
        b=fkpjF/Smxv8sYYZOJynL0WY2A1sKxbWmDZiDPfGvdC6peGl3t9TucRVYIO5n4VkbNt
         sQbQqCjj2DOvUnDGKmaz60cDL3JFvk0+vUhFxSf1ObZge79uUH18MIktCKUB9KJrcheu
         GqK7r753+unUJ2m5VRT0kbJ+5A7xskMWooqheAurZG8ETv9bA62CqvWGRwFnaV/HN7/E
         7JNrjZuubZGfaPTP0wyLMmqy7L4bqPsg1G1YKJx/2+WjidxQuN1z3lTlRSITUVrR8646
         4HopJd6wQgQIYdDHavUIDZyPrLimzjlj67IFhdz6UNqdxMuMAwZBMSil+xpke4W2u2U2
         xU9Q==
X-Gm-Message-State: AOJu0Yx+TQ37Mcol+f3ow46L0YW2nJI0PNwkpdA6RC36hz4s9tpJGiV2
        AFhDyZP4vGdVzvlIGwaIlk0fSA==
X-Google-Smtp-Source: AGHT+IFZLcl1hSZFp0+x3DWXkuTh8eukgK9MN7dqZrZCA5EfR1Y/k6SLf/6jRNXAANHXWUc0bOhv5w==
X-Received: by 2002:a05:6a00:1952:b0:6ce:47f4:2b45 with SMTP id s18-20020a056a00195200b006ce47f42b45mr15186074pfk.13.1702567705505;
        Thu, 14 Dec 2023 07:28:25 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6530:8349:4ba8:984a])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b006ce7bd009c0sm12281179pfi.149.2023.12.14.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:28:25 -0800 (PST)
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
Cc:     Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 1/3] drm/panel-edp: Add powered_on_to_enable delay
Date:   Thu, 14 Dec 2023 23:27:50 +0800
Message-ID: <20231214152817.2766280-2-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214152817.2766280-1-treapking@chromium.org>
References: <20231214152817.2766280-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v3:
- Collect review tag.

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

