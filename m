Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFA7B3AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjI2UIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2UIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:08:35 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F41A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:08:32 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6E1BC674;
        Fri, 29 Sep 2023 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1696018112;
        bh=XaRQ3hF7+3HvdPllkPSlqP2DtFhNZG/Nd/UsLFqUiwk=;
        h=From:To:Cc:Subject:Date:From;
        b=ih8LvmwmLvPNHvlZgHhZs0XrrvesXFkQ72sE/2t303C89uFRkEvlBBkfuKFLonnLf
         PdPzGWKFMJU31pD3Cvc/LzS6nfRMiQb+kJPDJEv54r8wvxEflSoQX+D6sjSsI3XH0j
         HFhjHthMflQ6oq4eE56OKnUP3+fnTq+z+LmIwvVo=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Joel Stanley <joel@jms.id.au>,
        linux-kernel@vger.kernel.org, Thomas Zajic <zlatko@gmx.at>,
        stable@vger.kernel.org
Subject: [PATCH] hwmon: nct6775: Fix incorrect variable reuse in fan_div calculation
Date:   Fri, 29 Sep 2023 13:08:23 -0700
Message-ID: <20230929200822.964-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
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

In the regmap conversion in commit 4ef2774511dc ("hwmon: (nct6775)
Convert register access to regmap API") I reused the 'reg' variable
for all three register reads in the fan speed calculation loop in
nct6775_update_device(), but failed to notice that the value from the
first one (data->REG_FAN[i]) is actually used in the call to
nct6775_select_fan_div() at the end of the loop body.  Since that
patch the register value passed to nct6775_select_fan_div() has been
(conditionally) incorrectly clobbered with the value of a different
register than intended, which has in at least some cases resulted in
fan speeds being adjusted down to zero.

Fix this by using dedicated temporaries for the two intermediate
register reads instead of 'reg'.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 4ef2774511dc ("hwmon: (nct6775) Convert register access to regmap API")
Reported-by: Thomas Zajic <zlatko@gmx.at>
Tested-by: Thomas Zajic <zlatko@gmx.at>
Cc: stable@vger.kernel.org # v5.19+
---
 drivers/hwmon/nct6775-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index b5b81bd83bb1..d928eb8ae5a3 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1614,17 +1614,21 @@ struct nct6775_data *nct6775_update_device(struct device *dev)
 							  data->fan_div[i]);
 
 			if (data->has_fan_min & BIT(i)) {
-				err = nct6775_read_value(data, data->REG_FAN_MIN[i], &reg);
+				u16 tmp;
+
+				err = nct6775_read_value(data, data->REG_FAN_MIN[i], &tmp);
 				if (err)
 					goto out;
-				data->fan_min[i] = reg;
+				data->fan_min[i] = tmp;
 			}
 
 			if (data->REG_FAN_PULSES[i]) {
-				err = nct6775_read_value(data, data->REG_FAN_PULSES[i], &reg);
+				u16 tmp;
+
+				err = nct6775_read_value(data, data->REG_FAN_PULSES[i], &tmp);
 				if (err)
 					goto out;
-				data->fan_pulses[i] = (reg >> data->FAN_PULSE_SHIFT[i]) & 0x03;
+				data->fan_pulses[i] = (tmp >> data->FAN_PULSE_SHIFT[i]) & 0x03;
 			}
 
 			err = nct6775_select_fan_div(dev, data, i, reg);
-- 
2.42.0

