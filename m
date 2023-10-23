Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF37D2FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJWKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjJWKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:23:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E51BD7D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:23:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso26938505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698056579; x=1698661379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X82FS37MpATKittBab30iZpigNPQeNpIZ7vC4jhKrjE=;
        b=oIfulWeSARbFBk5Tn2nGzAEftSL4CgvfON24Xo+SOvu/LySpcOe+jLZ6ccebBcYzG9
         zeEFoIVlVK+fr27H+vdzzdlnU2cEvT4BIm6glYWSBfjoH6ja7oHPryMB0TNRucXhXpEZ
         N5SqdOcLieansqETjXiOLitCOPaUog/MIzeF078S1i3v6XqNuthw7BXI0EZQGxKH6cjF
         7VopqMbhfKFkSFBVnDvYnBT5fx00ClgdCsnfSUIjv0/G5631Dj5h5EOzuZPOWOljIhIx
         MTzG8BbY/F3FyXItqvUDzg8ZQsMD09Iw4wamPYaCtX4XjUY/juadb4b+W/miCsRpvet2
         9CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056579; x=1698661379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X82FS37MpATKittBab30iZpigNPQeNpIZ7vC4jhKrjE=;
        b=eRCGJ0RLxxkn1+24bhgPhOPAuC04eJeT6d/rKyY/iMWxS9n7MSqukRvC7kd3E9wWXv
         xRKwSCywJpUaTnjz3eZhIs5VSXyPwlPRCVULTTdfEjLMrpi6RnxhJ+lyF7WUqDyn5/Rl
         /Ro+ooPxW3K+N/r5VIGzCfdBv5NzSkwt4J5rQKlUsWPmM7xeH7OiHpWNQyYmHfaU4Nf4
         XdMfJ5kyifB6SucxUPnFo2675wBQ6cPLDMkgnxHQ/sJg/aN3V5XQC2MdN/qbbk6DLwA3
         fXbMrkd6fvcwlAi3US4vPfdzSqEsV/MbebUpYCecQOpx6FGE6hntJWqO7uK9Roo2IekW
         wn3g==
X-Gm-Message-State: AOJu0YyW0Zv3r79rD9XsoAOkfprgCGoa7nLhZ1kUHlCfsIsfw8Ypk312
        MyqHRkVrY7Ui7es2/fnfib4s3g==
X-Google-Smtp-Source: AGHT+IFljXMqxHrslhD3f5aaczqeFQBtBIQnWV+U2sbvpYvMW9byaeQIqLPtr2IOqZNiNuJ+/np7GA==
X-Received: by 2002:a05:600c:4f86:b0:408:f9ce:56c5 with SMTP id n6-20020a05600c4f8600b00408f9ce56c5mr3226751wmq.24.1698056579471;
        Mon, 23 Oct 2023 03:22:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm13593275wmf.5.2023.10.23.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 03:22:59 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/7] irqchip/renesas-rzg2l: use tabs instead of spaces
Date:   Mon, 23 Oct 2023 13:22:22 +0300
Message-Id: <20231023102223.1309614-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index e5e158bf028d..ce50745bba87 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -56,8 +56,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 /**
  * struct rzg2l_irqc_reg_cache - register cache
-- 
2.39.2

