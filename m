Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5687E36DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjKGIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjKGIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:44:15 -0500
Received: from 13.mo584.mail-out.ovh.net (13.mo584.mail-out.ovh.net [178.33.251.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA4BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:44:11 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.1.161])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 195A027462
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:29:21 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-btv5j (unknown [10.110.115.220])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6EF6D1FDDC;
        Tue,  7 Nov 2023 08:29:18 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.105])
        by ghost-submission-6684bf9d7b-btv5j with ESMTPSA
        id I8daFV71SWUqAQAAWJgi0A
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 07 Nov 2023 08:29:18 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-105G0063a9f607e-0194-493b-a956-73c3cacca2fa,
                    990ED9DB402E285008FC912DE57946D84A8BC800) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 213.216.211.70
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, jdelvare@suse.com,
        linux@roeck-us.net, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/pm: clean up redundant comparisons with 0
Date:   Tue,  7 Nov 2023 10:29:09 +0200
Message-Id: <20231107082910.92508-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17681132139527513793
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudduhedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupddvudefrddvudeirddvuddurdejtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a couple of function return checks of functions that return
unsigned values, and local variables to hold them are also unsigned, so
checking if they are negative will always return false. This patch will
remove them, as well as the never reached code.

drivers/gpu/drm/amd/pm/amdgpu_pm.c:2801:5-8: WARNING: Unsigned expression compared with zero: val < 0
drivers/gpu/drm/amd/pm/amdgpu_pm.c:2814:5-8: WARNING: Unsigned expression compared with zero: val < 0

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8bb2da13826f..e7bb1d324084 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2798,8 +2798,6 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	unsigned int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
-	if (val < 0)
-		return val;
 
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2811,8 +2809,6 @@ static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
 	unsigned int val;
 
 	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
-	if (val < 0)
-		return val;
 
 	return sysfs_emit(buf, "%u\n", val);
 }
-- 
2.39.2

