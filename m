Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A926075DF53
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGVX12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGVX10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A819A6;
        Sat, 22 Jul 2023 16:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B67A60BD8;
        Sat, 22 Jul 2023 23:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B7FC433C8;
        Sat, 22 Jul 2023 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690068443;
        bh=C5VTDtOqdmj6Bz6JgxfHCEKJHYyIn7v2H/pyJ1qHGCM=;
        h=From:Date:Subject:To:Cc:From;
        b=fumBeebR/fj9xdn8EzaaqJ9QKok8wxdstGCw6EiJin3k5PiQAkG2KkNz6Gz1Ds0LN
         GDotCebW5AX3X2f+BFcvxqW1q1McAvTRUDK93mXtfZEIrLVfebrXeHyyjEb1ZyLFNv
         uyYNrjOx1HH8Tpx1X62ur6o/H9HLwIVllLVbCd1EsZTQ6KrV09RJGrn38NucQtDdgn
         5mdHBKFRU9R1009c0gEAMfbpcl0aQ+t7hhD1xcygkiiaAXMoP5zAnSR5rNtXKGFgKN
         sWyuVPCRaJEvsu1UFB2vMYHFZIUDhb+AbpATIjlhnP429Ec8yeecDHpZcGQaDdrVNh
         cp/5igG+AETrA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 23 Jul 2023 00:26:54 +0100
Subject: [PATCH] thermal/of: Fix double free of params during
 unregistration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230723-thermal-fix-of-memory-corruption-v1-1-ed4fa16d199d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL1lvGQC/x2N0QqDMAxFf0XybKBG0LFfGT64mtrAaiV1YyL+u
 8HHA+eee0BhFS7wrA5Q/kmRvBg0dQU+jsvMKJMxkKPW9US4RdY0fjDIH3PAxCnrjj6rftfNxti
 33tzw6Bp6g2VWZXPvi9dwnheUwZCCcgAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=broonie@kernel.org;
 h=from:subject:message-id; bh=C5VTDtOqdmj6Bz6JgxfHCEKJHYyIn7v2H/pyJ1qHGCM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvGXVA478VBnEpmpTCC3lkhtcVWQsWgJ581sVm
 3BnS4HC/CyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLxl1QAKCRAk1otyXVSH
 0JDuB/9a/lDjye3WC1siBtiAlqrJwcRmcgSVvUyChe5ZEPX/NPDNQV2sE4Y/pEBW9r7bEfVgWug
 tqEcqEuB5WtxrvMT6cCbg3BEFKMjy+JCJFExYChP5N6bJMwqicSzBsfF0YDBC5Th4H6pGTLP9u8
 ZHlsg4d/3wYEVC/quGwLSSWgn3CulLd/rFDMzIMkYCc5y6XOChONE8A6Su5Bl+G03bQbY7AIEdL
 NS9IMolnTV9NYXaJImgQhjn1AhNHrCbosXp5PNQ6ya6ZK7B0OMWOB4Tee6EGDjJRuegJLqa4GhQ
 pu96tBHNv4NrjuxjnhnBtIPamTSl7r0Yh03594DCXVyhBFVf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other data structures provided during registration the
thermal core takes a copy of the thermal_zone_params provided to it and
stores that copy in the thermal_zone_device, taking care to free it on
unregistration.  This is done because the parameters will be modified at
runtime.

Unfortunately the thermal_of code assumes that the params structure it
provides will be used throughout the lifetime of the device and since
the params are dynamically allocated based on the bindings it attempts
to free it on unregistration.  This results in not only leaking the
original params but also double freeing the copy the core made, leading
to memory corruption.

Fix this by instead freeing the params parsed from the DT during
registration.

This issue causing instability on systems where thermal zones are
unregistered, especially visble on those systems where some zones
provided by a device have no trip points such as Allwinner systems.
For example with current mainline an arm64 defconfig is unbootable on
Pine64 Plus and LibreTech Tritium is massively unstable.  These issues
have been there for a while and have been made more prominent by recent
memory management changes.

Fixes: 3fd6d6e2b4e80 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/thermal/thermal_of.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..0af11cdfa2c1 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -442,13 +442,11 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
-	struct thermal_zone_params *tzp = tz->tzp;
 	struct thermal_zone_device_ops *ops = tz->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 	kfree(trips);
-	kfree(tzp);
 	kfree(ops);
 }
 
@@ -530,6 +528,9 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_tzp;
 	}
 
+	/* The core will take a copy of tzp, free our copy here. */
+	kfree(tzp);
+
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230722-thermal-fix-of-memory-corruption-73c023f8612b

Best regards,
-- 
Mark Brown <broonie@kernel.org>

