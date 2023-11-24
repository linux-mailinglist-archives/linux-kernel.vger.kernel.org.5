Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353497F7DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKXS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:28:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411211BC9;
        Fri, 24 Nov 2023 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700850472; x=1701455272; i=w_armin@gmx.de;
        bh=YOwNjDfGnJRJthcNBht0dNRhiwLqkmRlexlwOFwzi44=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RG0xaV/0Th+t69dZ+vzHSCjLERYvu/mBSKNlrG1LxgamPxKcUzarGDd8dkLM8KJM
         ye0glsE1DZCQX7W5MTKNHX4BD1he20dTbxg5h+YgdV/G2IxMcZZn21Jamp0jaXFKY
         Hfl73iQgLLGg34AVBbZoMzyvj5Rwpk+KMHPaFDfj0RWIgdC+mBRZQRGlE1qPlmVH4
         gOHgAautMpOakAi5XEayHTkk/D/GEM9sjlVcxaPgbMMFi9FdMA4n/Wrwjz7ZYye9G
         QBT65sQyZGRvYahEP8xzhFAU2as37wUz8Alxh7VRzscJjiewzMPN6Cw4+iRz3meZy
         84AxzmxPMxEgG1ixWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MatVh-1rifTf1kSJ-00cULO; Fri, 24 Nov 2023 19:27:52 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (acpi_power_meter) Fix 4.29 MW bug
Date:   Fri, 24 Nov 2023 19:27:47 +0100
Message-Id: <20231124182747.13956-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FSfNVWMWv8UmnIPizhw0uZDKiGrcoL0B18QnbH5XNikbR+CPo+r
 UhCsbAxKGd8saZs5Jt0uMC7HphiM7y//Rx9IQjSIWQfmwlOwfqA3UZ3SMf0lyyyaD7ajvfI
 JrboNahOd1r8+D0fX+lQ4nWIKKII6nr8Ja5PFws2jFv6BeLj0lUHmB7/CGV44eVg/VfIo0T
 jHu8U291TkotvmhNi0X2w==
UI-OutboundReport: notjunk:1;M01:P0:6rj7i4piqfE=;XFSf2fXxtxeD6KElg3zwEDlmweZ
 qYUnmgmsNyQ7o/HjxD2PMhsH2Mpn8U4KZEzR6KCeqgKfNQWOHddUg+3Tug7yWPkMR3c9CFvzd
 RnXpknb2ZfuyqacYzfI+SNLli75YvXTHORiSdWUj5/b8sBjGdfMo41UJIdLpOW5urBtownWu0
 Xwr+L0GFG3WNxQtVRtUPy1HMRHUcNlZ+xpRfpc9ejcM5B7aSCXQ1sD8G7kRvGx76argJMohcQ
 P/+9yI1ChUTdTPfUpYUb5WhhQ+zu0XPOnePGyiLCxQDVqR+mqq6W5LBtObrZxUwOOF3MteGQ5
 MAhJw/zcZyw/+0OGNYXxQMhiyW3pwyoi8XVc0ld8Clycht2R6pIesz54a2mFZdH1Hyws+2zyp
 aebSgkaVcCE3iNjLNeXz2mOB9y4438B/rkTXs84cxna6L0xHOoVeW6DEwZjJ2SnvjLG3F31J3
 HsKNtUsVlxtpznN960hs1bOeGSS73nmpDlOEC6JptUyVAh6sR3wlrDKdRIIt5SsW4Yb+lkD/l
 NG6ZUG1vMIL2WQmrxL5yOJoM+jfWneJeelH0om/k+5uv4S1dk7F+MrmnIuwR8UHWgZLjccTop
 8C7Bdes/n7HfrgijlyfPFDRtSYIlLmecxSlMYRQUFbCzxcH37VXLk3LXvQSJlC4wpeYrkg04m
 XjKZvaLMG0ARBoP3gHaT4nRZWVvrvLSGMOa1eB8SMkHM8b5KHiG7na0yszd3jjW6VFL7SRa9A
 ctThhVEZ7TrmNsRiBchu+iYyawT9d/n1xGqOuyj323TBF0HNGpxpIzhcBwff5+u/5n5n+2eSU
 g/NMC3RMDPinFWkq+eZ8NWVbOp0iT1bgU2e7OQRAovRlXRzWkZ9ucSRxFP6f/h2MOGNVPRqjI
 IpnJUyoG6IHRm0uMDA1UPjThsprCSKYO7DZQmQLw9tdxxqpXusxCXuJ0R6p4Zf2xMZTHvWSPq
 TYnL2UBSZxMwlXVAruZZ1bdPU90=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI specification says:

"If an error occurs while obtaining the meter reading or if the value
is not available then an Integer with all bits set is returned"

Since the "integer" is 32 bits in case of the ACPI power meter,
userspace will get a power reading of 2^32 * 1000 miliwatts (~4.29 MW)
in case of such an error. This was discovered due to a lm_sensors
bugreport (https://github.com/lm-sensors/lm-sensors/issues/460).
Fix this by returning -ENODATA instead.

Tested-by: <urbinek@gmail.com>
Fixes: de584afa5e18 ("hwmon driver for ACPI 4.0 power meters")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/acpi_power_meter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_m=
eter.c
index 8db740214ffd..703666b95bf4 100644
=2D-- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -31,6 +31,7 @@
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF

 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -348,6 +349,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);

+	if (resource->power =3D=3D UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }

=2D-
2.39.2

