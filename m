Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC27DD798
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJaVQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363883
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698786961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7upQ/TCDqPQ7/RZT4zXVHcHAhMn0gkigdjeEzC/JmJ0=;
        b=RGzsakwI6SIkm3OHDX7bzF117dQFDdGWvJTAseRp/OWjRmaU+XHlOahpPbqPBYzpsVxk42
        /85f0Txm7EVA8s1dkmvklpj3YXgLZLSt7tw7V0rGPcThlEsoJdOzHfOu2kfMrYNQcgahOW
        J8WwcAcOeqIZY3F1qQtZWPBRK7FmvIw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-FrAbftfcORS7-KirPyF2ww-1; Tue, 31 Oct 2023 17:15:57 -0400
X-MC-Unique: FrAbftfcORS7-KirPyF2ww-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso6902470e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698786955; x=1699391755;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7upQ/TCDqPQ7/RZT4zXVHcHAhMn0gkigdjeEzC/JmJ0=;
        b=DBidjdBE3jt0pRD1Jx3yjTbMnRyslDhzS0kOOaQNRu4AInH4o42+LYzxzWThVd+0KH
         c812KWOabCTwwygCLRb1dZu7LpyTFNae9c9xwjgKdOHmUeKGDmtAmh3xHw80fecrlRDG
         wjbpSIRRNEdw9qP0Q6sGwBcHGYI8kQYcYYrvyQsGtL+tynu1HQEjiS16hXWnJdQidC4U
         IPdQ+9MJqpe9uoEvbRJIk4tMXbOnYTj0ZvU2TAQpeG04kmldxwjx+r62I1N6jzRdRBmX
         UhYxe3sqzy2RCzlpX9oWJOoz2iGTOmHe3kxusEUh8zQsqDjNOLeblFFgkleTup1xg4LG
         KF8A==
X-Gm-Message-State: AOJu0YwmnuXX1iqeLIk8hXeo6P6E+03+53K0xB63JBVPj+WuqE2kau/K
        ma4Y+xd2vmYGuN2Kakuu93xcs2ByJh1oizifu7Ub0+URFehQv0mPmZACA1AeufHMZ53nUfOjFiU
        ZBNtUJ/yf/ey1zVm6YW7FFXLm
X-Received: by 2002:ac2:55b7:0:b0:4ff:ae42:19e2 with SMTP id y23-20020ac255b7000000b004ffae4219e2mr10113699lfg.58.1698786955254;
        Tue, 31 Oct 2023 14:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRky3KdEseSDE4uqAOpBzi7EnlmKPgY2mct/d4Gy3Y77ZfjIOfTgExy+Ta9yfIaFIeiVbD5g==
X-Received: by 2002:ac2:55b7:0:b0:4ff:ae42:19e2 with SMTP id y23-20020ac255b7000000b004ffae4219e2mr10113685lfg.58.1698786954875;
        Tue, 31 Oct 2023 14:15:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id lg17-20020a170906f89100b0098e78ff1a87sm1513087ejb.120.2023.10.31.14.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 14:15:54 -0700 (PDT)
Message-ID: <16e533e2-81bb-47ba-9e23-460a626bcad7@redhat.com>
Date:   Tue, 31 Oct 2023 22:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/i915/dsi: Replace poking of CHV GPIOs behind
 the driver's back
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20231024155739.3861342-1-andriy.shevchenko@linux.intel.com>
 <20231024155739.3861342-7-andriy.shevchenko@linux.intel.com>
 <ZTfssxRsrDxhzSQ6@smile.fi.intel.com>
 <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
Content-Language: en-US
In-Reply-To: <b489675d-e9de-4bca-9622-78545aa8606d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/31/23 17:07, Hans de Goede wrote:
> Hi Andy,
> 
> On 10/24/23 18:11, Andy Shevchenko wrote:
>> On Tue, Oct 24, 2023 at 06:57:38PM +0300, Andy Shevchenko wrote:
>>> It's a dirty hack in the driver that pokes GPIO registers behind
>>> the driver's back. Moreoever it might be problematic as simultaneous
>>> I/O may hang the system, see the commit 0bd50d719b00 ("pinctrl:
>>> cherryview: prevent concurrent access to GPIO controllers") for
>>> the details. Taking all this into consideration replace the hack
>>> with proper GPIO APIs being used.
>>
>> Ah, just realised that this won't work if it happens to request to GPIOs with
>> the same index but different communities. I will fix that in v3, but will wait
>> for Hans to test VLV and it might even work in most of the cases on CHV as it
>> seems quite unlikely that the above mentioned assertion is going to happen in
>> real life.
> 
> I have added patches 1-5 to my personal tree + a small debug patch on top
> which logs when soc_exec_opaque_gpio() actually gets called.
> 
> So these patches will now get run every time I run some tests on
> one my tablets.
> 
> I'll get back to you with testing results when I've found a device where
> the new soc_exec_opaque_gpio() actually gets called.
> 
> As for the CHT support, I have not added that to my tree yet, I would
> prefer to directly test the correct/fixed patch.

And I hit the "jackpot" on the first device I tried and the code needed
some fixing to actually work, so here is something to fold into v3 to
fix things:

From 144fae4de91a6b5ed993b1722a07cca679f74cbe Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 31 Oct 2023 17:04:35 +0100
Subject: [PATCH] drm/i915/dsi: Fix GPIO lookup table used by
 soc_exec_opaque_gpio()

There already is a GPIO lookup table for device "0000:00:02.0" and
there can be only one GPIO lookup per device.

Instead add an extra empty entry to the GPIO lookup table
registered by intel_dsi_vbt_gpio_init() and use that extra entry
in soc_exec_opaque_gpio().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 60 ++++++++++----------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
index 8fc82aceae14..70f1d2c411e8 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -219,8 +219,7 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
 	} else {
 		gpio_desc = devm_gpiod_get_index(dev_priv->drm.dev,
 						 con_id, gpio_index,
-						 value ? GPIOD_OUT_LOW :
-						 GPIOD_OUT_HIGH);
+						 value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
 		if (IS_ERR(gpio_desc)) {
 			drm_err(&dev_priv->drm,
 				"GPIO index %u request failed (%pe)\n",
@@ -232,26 +231,20 @@ static void soc_exec_gpio(struct intel_connector *connector, const char *con_id,
 	}
 }
 
+static struct gpiod_lookup *soc_exec_opaque_gpiod_lookup;
+
 static void soc_exec_opaque_gpio(struct intel_connector *connector,
 				 const char *chip, const char *con_id,
 				 u8 gpio_index, bool value)
 {
-	struct gpiod_lookup_table *lookup;
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
 
-	lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
-	if (!lookup)
-		return;
-
-	lookup->dev_id = "0000:00:02.0";
-	lookup->table[0] =
+	*soc_exec_opaque_gpiod_lookup =
 		GPIO_LOOKUP_IDX(chip, gpio_index, con_id, gpio_index, GPIO_ACTIVE_HIGH);
 
-	gpiod_add_lookup_table(lookup);
-
 	soc_exec_gpio(connector, con_id, gpio_index, value);
 
-	gpiod_remove_lookup_table(lookup);
-	kfree(lookup);
+	soc_exec_opaque_gpiod_lookup->key = NULL;
 }
 
 static void vlv_exec_gpio(struct intel_connector *connector,
@@ -898,6 +891,7 @@ static struct gpiod_lookup_table pmic_panel_gpio_table = {
 	.table = {
 		/* Panel EN/DISABLE */
 		GPIO_LOOKUP("gpio_crystalcove", 94, "panel", GPIO_ACTIVE_HIGH),
+		{ }, /* Extra lookup entry for soc_exec_opaque_gpiod_lookup */
 		{ }
 	},
 };
@@ -907,6 +901,15 @@ static struct gpiod_lookup_table soc_panel_gpio_table = {
 	.table = {
 		GPIO_LOOKUP("INT33FC:01", 10, "backlight", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("INT33FC:01", 11, "panel", GPIO_ACTIVE_HIGH),
+		{ }, /* Extra lookup entry for soc_exec_opaque_gpiod_lookup */
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table empty_gpio_table = {
+	.dev_id = "0000:00:02.0",
+	.table = {
+		{ }, /* Extra lookup entry for soc_exec_opaque_gpiod_lookup */
 		{ }
 	},
 };
@@ -916,6 +919,8 @@ static const struct pinctrl_map soc_pwm_pinctrl_map[] = {
 			  "pwm0_grp", "pwm"),
 };
 
+static struct gpiod_lookup_table *gpiod_lookup_table;
+
 void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 {
 	struct drm_device *dev = intel_dsi->base.base.dev;
@@ -926,16 +931,16 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 	bool want_backlight_gpio = false;
 	bool want_panel_gpio = false;
 	struct pinctrl *pinctrl;
-	int ret;
+	int i, ret;
 
 	if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
 	    mipi_config->pwm_blc == PPS_BLC_PMIC) {
-		gpiod_add_lookup_table(&pmic_panel_gpio_table);
+		gpiod_lookup_table = &pmic_panel_gpio_table;
 		want_panel_gpio = true;
 	}
 
 	if (IS_VALLEYVIEW(dev_priv) && mipi_config->pwm_blc == PPS_BLC_SOC) {
-		gpiod_add_lookup_table(&soc_panel_gpio_table);
+		gpiod_lookup_table = &soc_panel_gpio_table;
 		want_panel_gpio = true;
 		want_backlight_gpio = true;
 
@@ -952,6 +957,15 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 				"Failed to set pinmux to PWM\n");
 	}
 
+	if (!gpiod_lookup_table)
+		gpiod_lookup_table = &empty_gpio_table;
+
+	/* Find first empty entry for soc_exec_opaque_gpiod_lookup */
+	for (i = 0; gpiod_lookup_table->table[i].key; i++) { }
+	soc_exec_opaque_gpiod_lookup = &gpiod_lookup_table->table[i];
+
+	gpiod_add_lookup_table(gpiod_lookup_table);
+
 	if (want_panel_gpio) {
 		intel_dsi->gpio_panel = gpiod_get(dev->dev, "panel", flags);
 		if (IS_ERR(intel_dsi->gpio_panel)) {
@@ -974,11 +988,6 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 
 void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi)
 {
-	struct drm_device *dev = intel_dsi->base.base.dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
-	struct intel_connector *connector = intel_dsi->attached_connector;
-	struct mipi_config *mipi_config = connector->panel.vbt.dsi.config;
-
 	if (intel_dsi->gpio_panel) {
 		gpiod_put(intel_dsi->gpio_panel);
 		intel_dsi->gpio_panel = NULL;
@@ -989,12 +998,5 @@ void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi)
 		intel_dsi->gpio_backlight = NULL;
 	}
 
-	if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
-	    mipi_config->pwm_blc == PPS_BLC_PMIC)
-		gpiod_remove_lookup_table(&pmic_panel_gpio_table);
-
-	if (IS_VALLEYVIEW(dev_priv) && mipi_config->pwm_blc == PPS_BLC_SOC) {
-		pinctrl_unregister_mappings(soc_pwm_pinctrl_map);
-		gpiod_remove_lookup_table(&soc_panel_gpio_table);
-	}
+	gpiod_remove_lookup_table(gpiod_lookup_table);
 }
-- 
2.41.0


Regards,

Hans

