Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30E7B025B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjI0LEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0LEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:04:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D01180
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so7740297a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812643; x=1696417443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRZ/r6+7TOpg5cdhVwD17zimKeX22UUsUqcVE65wOuQ=;
        b=NRTXv3fSIJxhOLjzpc3t8c12lcpFQJwIQdwJ5T2cOMdlwg0UeG70/KnaxxBruhZK7G
         cd0wo6Vl0OtMhhGpujtcHkq5d+iwBGOT9RCmIUf5ZckrmZ7CXXUlZBZOJRy5Kk8aDhHm
         KPOwMuXlgwz3ym4GKOxevmz/zNW3dgcLRDx99fBvdKiiIbDGO6XbqqRXkfbfA8slYDPR
         dYaiHq9fJ7TZF+LsZCfeVPFLuihl8SZM+wviLk0lLBfYn1S5NbbpB9JXMpcRiVYxNVP3
         TzgoNYvK5k37HYO4HAwDDcrBRckt/fIAupevM1iDmN4WSEtsEEurOeQ3z4havRCh0WgQ
         BaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812643; x=1696417443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRZ/r6+7TOpg5cdhVwD17zimKeX22UUsUqcVE65wOuQ=;
        b=N84ERdSi2AqbR3yv3nJpWaXP9/NrYAHxfxS6eHgjuqU5rUZzyAdny4tLDL8WyC6SvB
         X39H691iRjNO1oSlpLo/She+wSd+K0HdXXgYLRRI5fb3Y5VwClLKZGitoX7oGpQGTrQ4
         V9M7xEE8lfD9nQT6i4LENB9I6AZeRNHn0Ty93IkW7Z/ZzN6CS/HL6/Qr+ARgGYkt7TNQ
         1h5o9KtB1cW5WlubTLf3LarjmP3wFYp/Lnb047icvf+4CqlUfHLJughsJBYX99GKk02S
         RPKTjhR4dTYBXyTsCDD9sxind6aGLZKaqoH+1IDHTI6q+exa1b+8I71IdxVHDbVdtGli
         siGw==
X-Gm-Message-State: AOJu0YwO6MvEbOT7SsC60mU9O4sDWoYtXWdZoXyi1lNquCZpsA4zmyRc
        gvtdOojwPw62M1VJ9g4i/KHyZQ==
X-Google-Smtp-Source: AGHT+IFPIVZlzDDqOm8WIE5A6AbsMph3KF7rtW03J3V82mEfzOSruRLOxlBuV2v6iQc/oEBPZBM63A==
X-Received: by 2002:a05:6a20:12c6:b0:161:3120:e840 with SMTP id v6-20020a056a2012c600b001613120e840mr1706101pzg.2.1695812642959;
        Wed, 27 Sep 2023 04:04:02 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b0068fb4f5f38fsm11454912pfh.30.2023.09.27.04.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:04:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: Remove doc style comments for internal routines
Date:   Wed, 27 Sep 2023 16:33:55 +0530
Message-Id: <0484680a9c7bb66cf1fb583a5178e753dd763afd.1695812634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were previously exposed outside of the OPP core and needed doc
style commenting. They aren't public now and don't need the same.

This fixes warnings generated for builds with `W=1`:

core.c:2105: warning: Function parameter or member 'opp_table' not described in '_opp_set_supported_hw'
core.c:2105: warning: Excess function parameter 'dev' description in '_opp_set_supported_hw'
core.c:2148: warning: Function parameter or member 'opp_table' not described in '_opp_set_prop_name'
core.c:2148: warning: Excess function parameter 'dev' description in '_opp_set_prop_name'
core.c:2189: warning: Function parameter or member 'opp_table' not described in '_opp_set_regulators'
core.c:2189: warning: Excess function parameter 'count' description in '_opp_set_regulators'
core.c:2293: warning: Function parameter or member 'opp_table' not described in '_opp_set_clknames'
core.c:2293: warning: Function parameter or member 'config_clks' not described in '_opp_set_clknames'
core.c:2391: warning: Function parameter or member 'opp_table' not described in '_opp_set_config_regulators_helper'
core.c:2455: warning: Function parameter or member 'opp_table' not described in '_opp_attach_genpd'
core.c:2682: warning: Function parameter or member 'token' not described in 'dev_pm_opp_clear_config'
core.c:2682: warning: Excess function parameter 'opp_table' description in 'dev_pm_opp_clear_config'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309091558.x3JJrxFI-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 79 ++++------------------------------------------
 1 file changed, 7 insertions(+), 72 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6cae2785b264..ab82aafecedf 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2089,12 +2089,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	return ret;
 }
 
-/**
- * _opp_set_supported_hw() - Set supported platforms
- * @dev: Device for which supported-hw has to be set.
- * @versions: Array of hierarchy of versions to match.
- * @count: Number of elements in the array.
- *
+/*
  * This is required only for the V2 bindings, and it enables a platform to
  * specify the hierarchy of versions it supports. OPP layer will then enable
  * OPPs, which are available for those versions, based on its 'opp-supported-hw'
@@ -2117,14 +2112,6 @@ static int _opp_set_supported_hw(struct opp_table *opp_table,
 	return 0;
 }
 
-/**
- * _opp_put_supported_hw() - Releases resources blocked for supported hw
- * @opp_table: OPP table returned by _opp_set_supported_hw().
- *
- * This is required only for the V2 bindings, and is called for a matching
- * _opp_set_supported_hw(). Until this is called, the opp_table structure
- * will not be freed.
- */
 static void _opp_put_supported_hw(struct opp_table *opp_table)
 {
 	if (opp_table->supported_hw) {
@@ -2134,11 +2121,7 @@ static void _opp_put_supported_hw(struct opp_table *opp_table)
 	}
 }
 
-/**
- * _opp_set_prop_name() - Set prop-extn name
- * @dev: Device for which the prop-name has to be set.
- * @name: name to postfix to properties.
- *
+/*
  * This is required only for the V2 bindings, and it enables a platform to
  * specify the extn to be used for certain property names. The properties to
  * which the extension will apply are opp-microvolt and opp-microamp. OPP core
@@ -2156,14 +2139,6 @@ static int _opp_set_prop_name(struct opp_table *opp_table, const char *name)
 	return 0;
 }
 
-/**
- * _opp_put_prop_name() - Releases resources blocked for prop-name
- * @opp_table: OPP table returned by _opp_set_prop_name().
- *
- * This is required only for the V2 bindings, and is called for a matching
- * _opp_set_prop_name(). Until this is called, the opp_table structure
- * will not be freed.
- */
 static void _opp_put_prop_name(struct opp_table *opp_table)
 {
 	if (opp_table->prop_name) {
@@ -2172,12 +2147,7 @@ static void _opp_put_prop_name(struct opp_table *opp_table)
 	}
 }
 
-/**
- * _opp_set_regulators() - Set regulator names for the device
- * @dev: Device for which regulator name is being set.
- * @names: Array of pointers to the names of the regulator.
- * @count: Number of regulators.
- *
+/*
  * In order to support OPP switching, OPP layer needs to know the name of the
  * device's regulators, as the core would be required to switch voltages as
  * well.
@@ -2239,10 +2209,6 @@ static int _opp_set_regulators(struct opp_table *opp_table, struct device *dev,
 	return ret;
 }
 
-/**
- * _opp_put_regulators() - Releases resources blocked for regulator
- * @opp_table: OPP table returned from _opp_set_regulators().
- */
 static void _opp_put_regulators(struct opp_table *opp_table)
 {
 	int i;
@@ -2274,11 +2240,7 @@ static void _put_clks(struct opp_table *opp_table, int count)
 	opp_table->clks = NULL;
 }
 
-/**
- * _opp_set_clknames() - Set clk names for the device
- * @dev: Device for which clk names is being set.
- * @names: Clk names.
- *
+/*
  * In order to support OPP switching, OPP layer needs to get pointers to the
  * clocks for the device. Simple cases work fine without using this routine
  * (i.e. by passing connection-id as NULL), but for a device with multiple
@@ -2362,10 +2324,6 @@ static int _opp_set_clknames(struct opp_table *opp_table, struct device *dev,
 	return ret;
 }
 
-/**
- * _opp_put_clknames() - Releases resources blocked for clks.
- * @opp_table: OPP table returned from _opp_set_clknames().
- */
 static void _opp_put_clknames(struct opp_table *opp_table)
 {
 	if (!opp_table->clks)
@@ -2377,11 +2335,7 @@ static void _opp_put_clknames(struct opp_table *opp_table)
 	_put_clks(opp_table, opp_table->clk_count);
 }
 
-/**
- * _opp_set_config_regulators_helper() - Register custom set regulator helper.
- * @dev: Device for which the helper is getting registered.
- * @config_regulators: Custom set regulator helper.
- *
+/*
  * This is useful to support platforms with multiple regulators per device.
  *
  * This must be called before any OPPs are initialized for the device.
@@ -2396,13 +2350,6 @@ static int _opp_set_config_regulators_helper(struct opp_table *opp_table,
 	return 0;
 }
 
-/**
- * _opp_put_config_regulators_helper() - Releases resources blocked for
- *					 config_regulators helper.
- * @opp_table: OPP table returned from _opp_set_config_regulators_helper().
- *
- * Release resources blocked for platform specific config_regulators helper.
- */
 static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
 {
 	if (opp_table->config_regulators)
@@ -2428,12 +2375,7 @@ static void _detach_genpd(struct opp_table *opp_table)
 	opp_table->genpd_virt_devs = NULL;
 }
 
-/**
- * _opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
- * @dev: Consumer device for which the genpd is getting attached.
- * @names: Null terminated array of pointers containing names of genpd to attach.
- * @virt_devs: Pointer to return the array of virtual devices.
- *
+/*
  * Multiple generic power domains for a device are supported with the help of
  * virtual genpd devices, which are created for each consumer device - genpd
  * pair. These are the device structures which are attached to the power domain
@@ -2509,13 +2451,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 }
 
-/**
- * _opp_detach_genpd() - Detach genpd(s) from the device.
- * @opp_table: OPP table returned by _opp_attach_genpd().
- *
- * This detaches the genpd(s), resets the virtual device pointers, and puts the
- * OPP table.
- */
 static void _opp_detach_genpd(struct opp_table *opp_table)
 {
 	/*
@@ -2667,7 +2602,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
 
 /**
  * dev_pm_opp_clear_config() - Releases resources blocked for OPP configuration.
- * @opp_table: OPP table returned from dev_pm_opp_set_config().
+ * @token: The token returned by dev_pm_opp_set_config() previously.
  *
  * This allows all device OPP configurations to be cleared at once. This must be
  * called once for each call made to dev_pm_opp_set_config(), in order to free
-- 
2.31.1.272.g89b43f80a514

