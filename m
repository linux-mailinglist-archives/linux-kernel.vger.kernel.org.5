Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938EB7E592A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjKHOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjKHOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9F1FC4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:34:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5094727fa67so9447387e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699454044; x=1700058844; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGzclwbFLS82d1Yy6hJpVSYEp7mUVdHhXoDoAeHaQ9o=;
        b=oVABV4XWqQX4uB44dRsT21hjjoqdkvOgsOImOXTAtpUICemdRUdvYHEH8YLYH5PtT3
         4fyTASLfBvHLpqJ+VPkTw1r+RqvuyPD4stWb5qv0K/DHFOyqz1udM4zi4zXIbb95DMzZ
         bkH6Qv7nvR4e7n752njaUhxNhOR0TRIzGwjn71sdhhcP0G/8yeKfUMGFcZgJvdB29RWe
         tcU8zC1LztlpGR0/g7NiI8vWMjazb4cccWzCjlvsloZetpCM/OmJ3WnRIZIU4C3MzmWU
         dVSneU0XTqZRu1ZlBGClW9kI4CWBNBVoiZlZ6er2n3MHMa3zBvArToJ26mp35Q6526Y0
         ogYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454044; x=1700058844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGzclwbFLS82d1Yy6hJpVSYEp7mUVdHhXoDoAeHaQ9o=;
        b=baqOz3IXYoEJC9iWOkGBp/p6w9wGKy5UwcUnf/ThteTwgtf8HdCzEiZ+XL/hxl91rL
         +f5yV0h7P69cakakcx2jSGF9yVrmv9l3TaeIvtLzZ4hs1e+wLWAW1yMcyAij6lAR0Qle
         giEumA5p9siko4ovYK9KyKKMX9rjTIeq93KX15p94l+qf5mW4sA0QpaGXrKMBdy+s9tz
         0EspHvTQa32RFmoLiCCWL1v2jvr2EHPeQa8M2O3JCBYcfAcTVaQ4lnGFNOXBKDtXI3RE
         cHUx5E7DcAJY0fYUBHepEVuGxhcPTPh8EPlq9jBju7I86W7b5DburxF+TmTTu1WQNpKo
         1CDA==
X-Gm-Message-State: AOJu0YwsYgnC4121EzjY05m2nmiGU9fHvc7jX5qEMg8KmGmH+lMek212
        gJN9lh3aB0VdMVOhGOb97j9Udg==
X-Google-Smtp-Source: AGHT+IHO/EX+mYFpXV9cnozSua00aYKVLxHpApEI0ijPX+/t/mJFnU4RbkNl70WWo+NHt88Fl9uYmA==
X-Received: by 2002:ac2:5a1a:0:b0:509:4541:5e97 with SMTP id q26-20020ac25a1a000000b0050945415e97mr1368218lfn.29.1699454043887;
        Wed, 08 Nov 2023 06:34:03 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q10-20020ac24a6a000000b00507a3b8b007sm686773lfp.110.2023.11.08.06.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:34:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 08 Nov 2023 15:33:53 +0100
Subject: [PATCH 5/6] mtd: rawnand: gpio: Support standard nand width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-fix-mips-nand-v1-5-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
In-Reply-To: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard property for describing the band width of a NAND
memory is "nand-bus-width" not "bank-width". The new bindings
support both so make Linux check both in priority order.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/gpio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 5553101c709c..d5bd245b0c0d 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -183,7 +183,15 @@ static int gpio_nand_get_config(struct device *dev,
 {
 	u32 val;
 
-	if (!device_property_read_u32(dev, "bank-width", &val)) {
+	/* The preferred binding takes precedence */
+	if (!device_property_read_u32(dev, "nand-bus-width", &val)) {
+		if (val == 16) {
+			chip->options |= NAND_BUSWIDTH_16;
+		} else if (val != 8) {
+			dev_err(dev, "invalid nand-bus-width %u\n", val);
+			return -EINVAL;
+		}
+	} else if (!device_property_read_u32(dev, "bank-width", &val)) {
 		if (val == 2) {
 			chip->options |= NAND_BUSWIDTH_16;
 		} else if (val != 1) {

-- 
2.34.1

