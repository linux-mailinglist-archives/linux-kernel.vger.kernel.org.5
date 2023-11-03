Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93297E0253
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjKCLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjKCLnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:43:08 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CC1BF;
        Fri,  3 Nov 2023 04:43:02 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4SMJlF69LZzDqL8;
        Fri,  3 Nov 2023 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1699011781; bh=COzeTtt/oT3cTy/i7MUnUtz64XgOpYTzoGtZWhIvRJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GTWq6IRj6R8KgCWDxsuPaTHD+t0yLYfPLT/MdVPyQIZG7lE5TQa/alopSdJFNlN/k
         PNAwbfiyjHBU7vwdLqhu+I0y+w/chac0BAYHN1vsD7t3dC0wL6moWtte8YTEEg0YDO
         +UdYDzBIskw52OCud6TasNvmCocYW0DcapjxYgL0=
X-Riseup-User-ID: E2464CBEDD2201B50682C719F6E9A98C05FC08E352D2C0FB6703F80CE7B93AEA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SMJl10w64zFpsR;
        Fri,  3 Nov 2023 11:42:36 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Nikita Travkin <nikitos.tr@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: aw2013: Select REGMAP_I2C
Date:   Fri,  3 Nov 2023 18:42:03 +0700
Message-ID: <20231103114203.1108922-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AW2013 driver uses devm_regmap_init_i2c, so REGMAP_I2C needs to
be selected.

Otherwise build process may fail with:
ld: drivers/leds/leds-aw2013.o: in function `aw2013_probe':
leds-aw2013.c:345: undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/leds/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b92208eccdea..3132439f99e0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -110,6 +110,7 @@ config LEDS_AW200XX
 config LEDS_AW2013
 	tristate "LED support for Awinic AW2013"
 	depends on LEDS_CLASS && I2C && OF
+	select REGMAP_I2C
 	help
 	  This option enables support for the AW2013 3-channel
 	  LED driver.
-- 
2.42.0

