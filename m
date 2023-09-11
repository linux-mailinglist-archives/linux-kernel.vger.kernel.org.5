Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8F79AE65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350924AbjIKVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbjIKMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:43:19 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2842CEB;
        Mon, 11 Sep 2023 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694436194;
  x=1725972194;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=SBL7YdeBxdBTOUww15FA3CVSUVZQP5Z5Vgj3rVYX48k=;
  b=bMLs648jnmLrycFxAd/NR5BsxC8iUY2JHzCklwdBxaRT/eE3CK4aJP2F
   YCqYBj1BAqkRRCWOKam2opDiUxldqjSivifeEjTwB4LhMNDEoMBWdiEuc
   SgQlGOgtNR5C8axpj/qOR723B/62QTLz8D/ayiKZmv2R20ujH+9e36iaC
   WRojoIkZS5pt+9JsTjBJOujNznn8lpy9Gt1xRqzQxEmUgfyQxdlRP2F/i
   XOHHDJhpq8SmO4cs7D2OfEfsHpihBiaNsoI+V+lL/eW+TyFWxbC/1pH6H
   uW/qTjqTR4w2F2d1OJy64LDBgrVYDhsTHvA7aXTMBbgvkAgugbn20PErA
   g==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Mon, 11 Sep 2023 14:43:01 +0200
Subject: [PATCH v2] iio: light: vcnl4000: Don't power on/off chip in config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230907-vcnl4000-pm-fix-v2-1-298e01f54db4@axis.com>
X-B4-Tracking: v=1; b=H4sIAFQL/2QC/3WNTQ6CMBBGr2Jm7ZgpWkVX3sOwaKeDNJFCWtJgC
 He3sHf5vp+8BZJELwkehwWiZJ/8EApUxwNwZ8Jb0LvCUFF1pjvdMHP4XIgIxx5bP6PVtWNybWs
 1Q3lZkwRtNIG77debNEncijFK2e+qV1O482ka4nc3Z7Wl/yVZoUJdG6VYOW2u/DSzTyceemjWd
 f0B7PKxRsYAAAA=
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436191; l=2532;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=ML9qCkSy62+/e/ZwttKxao8jlCaohmo4AkMCQFSHeqY=;
 b=pWYIlAiRK7o6BthzsDkxg5tOxYpJfrT2uvzFep5zMW5S7HTXS8tHZDfPhD+jSm+f/JNKMWjfN
 hVGQJ0pTK4zCTNU7REUNq8VXKB6OmyWSvsLycvKFFpIdELRJUiUPv4K
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling/disabling interrupts on the vcnl4040 chip the als and/or
ps sensor is powered on or off depending on the interrupt enable bits.
This is made as a last step in write_event_config.

But there is no reason to do this as the runtime PM handles the power
state of the sensors. Interfering with this may impact sensor readings.

Consider the following:
 1. Userspace makes sensor data reading which triggers RPM resume
    (sensor powered on) and a RPM suspend timeout. The timeout is 2000ms
    before RPM suspend powers the sensor off if no new reading is made
    within the timeout period.
 2. Userspace disables interrupts => powers sensor off
 3. Userspace reads sensor data = 0 because sensor is off and the
    suspend timeout has not passed. For each new reading made within the
    timeout period the timeout is renewed with 2000ms and RPM will not
    make a new resume (device was not suspended). So the sensor will
    not be powered on.
 4. No further userspace reading for 2000ms ends RPM suspend timeout and
    triggers suspend (powers off already powered off sensor).

Powering sensor off in (2) makes all consecutive readings made within
2000ms to the previous reading (3) return invalid data.

Skip setting power state when writing new event config.

Fixes: 546676121cb9 ("iio: light: vcnl4000: Add interrupt support for vcnl4040")
Fixes: bc292aaf9cb4 ("iio: light: vcnl4000: add illuminance irq vcnl4040/4200")
Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Changes in v2:
- Rephrasing of commit msg.
- Added 2 Fixes tags:
  1. First tag refers to the original patch introducing the bug.
  2. Second tag is for a later patch extending the faulty condition introduced in original patch.
- Link to v1: https://lore.kernel.org/r/20230907-vcnl4000-pm-fix-v1-1-58a11c1d5a6c@axis.com
---
 drivers/iio/light/vcnl4000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3a52b09c2823..fdf763a04b0b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1513,7 +1513,6 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
 
 	return ret;
 }

---
base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
change-id: 20230907-vcnl4000-pm-fix-b58dc0dffb5c

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

