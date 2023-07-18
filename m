Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4D758059
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjGRPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGRPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA7FC;
        Tue, 18 Jul 2023 08:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDCF61616;
        Tue, 18 Jul 2023 15:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4045C433C7;
        Tue, 18 Jul 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692699;
        bh=dC6xVfoZAu1dLbggSONL4fKCtfqFkZexMTtlfTvKgfQ=;
        h=From:Date:Subject:To:Cc:From;
        b=gxNRHk6jXJH/sG6nAzOBErvD+wxObBarcDNUB6t09I3NPMoYDs8QMY/+xAlDmLZpZ
         HrBgUUGG9jB+y8aiTLSQ1wXsLnpNVB6j6mmkzC1H3NycyIxBQ83ra7piSD8fOl5N7y
         6+l7IyikBmGQoBJcXg8WJU7UmOQjl5RkMMHVDRdWRsnxy+oX2wXy1tXDpqlrle//BO
         t/19NuIW5ZYvCKAqHhpmB0oeialXBbX/ZWLqVwb7zAxby2FJxD4wCEdbxPSUn4ukDX
         M2UTDfSYcEcoXlXKOXLBcsFEvgYbuf5lqJMSXxWPdRiMUyJrmhwxexp9GhAAi5v5PM
         A/+EPCsgpEyUA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 16:04:22 +0100
Subject: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPWptmQC/x3MQQqEMAxA0atI1hOwFlS8irgINdWAdoakI4J4d
 4vLt/j/AmMVNhiqC5QPMfmmAvepIKyUFkaZi6GpG193rse8su60of1TL6i8iGWlXDKcoyfn2xA
 oEpTBTznK+c7H6b4fh5UeimwAAAA=
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dC6xVfoZAu1dLbggSONL4fKCtfqFkZexMTtlfTvKgfQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktqoWNHLFaGMbLnk71Po+ikg0HmEFb2Er2KcvO
 TdEj449f3GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLaqFgAKCRAk1otyXVSH
 0LBjB/9h8x5fbbbKuVsnCClJlyBKWsag8KbTFfpYMqgbuOYaRUZZEvIbLBoNKoSImBBiumXjCkP
 haBO3wVDrdvIpH90ub6r0UBAN7Z8F6ncmgNkWN7TlZwqymZdzXpucPHXbubWMT7BiiIirajZHvs
 D6A1s9yzq1Ac2htEyg4MraFxIM0Ew5LHtzTT/as0yE1VFUGzuuwl84dItvJu4N8XMAwIzlYfkIU
 Yrw0HUMNKWviJgjPcTjNvktREwhEjTNu5P/3XsEs6nklQCNk5JxbA7XnP6lbXoeHF6tH+e2Wx4k
 ofnYisR3/Q80C3IFmHKy6u09jteOqH0mYOw/KTG/6gHbxoDc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the sun8i thermal driver will fail to probe if any of the
thermal zones it is registering fails to register with the thermal core.
Since we currently do not define any trip points for the GPU thermal
zones on at least A64 or H5 this means that we have no thermal support
on these platforms:

[    1.698703] thermal_sys: Failed to find 'trips' node
[    1.698707] thermal_sys: Failed to find trip points for thermal-sensor id=1

even though the main CPU thermal zone on both SoCs is fully configured.
This does not seem ideal, while we may not be able to use all the zones
it seems better to have those zones which are usable be operational.
Instead just carry on registering zones if we get any non-deferral
error, allowing use of those zones which are usable.

This means that we also need to update the interrupt handler to not
attempt to notify the core for events on zones which we have not
registered, I didn't see an ability to mask individual interrupts and
I would expect that interrupts would still be indicated in the ISR even
if they were masked.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
I noticed this while trying to debug an issue with memory corruption on
boot which since the merge window has prevented Pine64 Plus (an A64)
from booting at all:

   https://storage.kernelci.org/mainline/master/v6.5-rc2/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt

(which I bisected to a random memory management change that clearly
wasn't at fault) and has been causing less consistent but still very
severe boot issues on Libretech Tritium (a H3).  The corruption appears
to happen when unbinding a the one thermal zone that does register, I've
not figured out exactly where.

The memory corruption issue obviously needs to be dealt with properly
(I'm still digging into it) but this does allow both platforms to boot
reliably and seems like a sensible thing to do independently, ideally we
could get this in as a fix.
---
 drivers/thermal/sun8i_thermal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..b69134538867 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -190,6 +190,9 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	int i;
 
 	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
+		/* We allow some zones to not register. */
+		if (IS_ERR(tmdev->sensor[i].tzd))
+			continue;
 		thermal_zone_device_update(tmdev->sensor[i].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
@@ -465,8 +468,17 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 						      i,
 						      &tmdev->sensor[i],
 						      &ths_ops);
-		if (IS_ERR(tmdev->sensor[i].tzd))
-			return PTR_ERR(tmdev->sensor[i].tzd);
+
+		/*
+		 * If an individual zone fails to register for reasons
+		 * other than probe deferral (eg, a bad DT) then carry
+		 * on, other zones might register successfully.
+		 */
+		if (IS_ERR(tmdev->sensor[i].tzd)) {
+			if (PTR_ERR(tmdev->sensor[i].tzd) == -EPROBE_DEFER)
+				return PTR_ERR(tmdev->sensor[i].tzd);
+			continue;
+		}
 
 		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-thermal-sun8i-registration-df3a136ccafa

Best regards,
-- 
Mark Brown <broonie@kernel.org>

