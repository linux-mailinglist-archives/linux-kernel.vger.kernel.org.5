Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE97AB852
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjIVRwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjIVRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:52:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D261BCF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d25b1dbdso2241003b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405094; x=1696009894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zImIKIqhOC0JjIYPrD3YIO1bPD4ZjWOlSN8lcYpsf6s=;
        b=nWW16v5k1LbEMTgaTiQp3gfTSU/lEQTL5de4k8P+2xveqaPy6R0Cll85Vkmdjs7m0j
         28x5zAUjeDNwEVpSgy4gh7l+Asv9qPEUHN517bvXyf2ZU7IDXJp0BVo5LxHarB2b8LO2
         tsON67yjDAnd9dzYksuEDqwQaIXBZi2bvPmIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405094; x=1696009894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zImIKIqhOC0JjIYPrD3YIO1bPD4ZjWOlSN8lcYpsf6s=;
        b=YxvMvWfwAIfjBnwXEkp023LNolLh4hT0KbyjO/WWbWksiJZnWUtP8ob1GCU3nnQMi5
         vaAd3hTSMZYVOatULzFYYa3xgCHC70V8XECRCrz8wBPVLvKPejR9TcrkHOj53DvRJC0v
         usoMt/ztAaa1uoyHckfwPVUtMKOjIiNCMnM7Qqm6Br1gn20o0/vPI62ua7ovk6uwLSVa
         KxiJ3Ga0CuNxenapKOIzzS1NMGn6do7VytbAlMAYc+uGaHsUGvg3m1lA9A37MsaYbJPz
         rLIZglb8m0DpK+Z2jkd5YQv4bNrRzYCf03lJEug+twyOBIRSHfuTmbuVv6M2fCq6Rjn0
         ZccA==
X-Gm-Message-State: AOJu0Yx/z1x3ofWutsYUIBVNUAAWrG+pR3QpcVRdfq1KPmFjwepuV14d
        +gjdh1ZDOrxpK7DjC/Z6VMGOb3Od+ShCl3DRY8g=
X-Google-Smtp-Source: AGHT+IEYYptw0+9UxsBkFMm+xCNLTAlvlc4VwNyOSgculGB2Hj2uBhFKvrLo2zEAv9fjQs4NAvIGMQ==
X-Received: by 2002:a05:6a00:14c2:b0:690:28d0:b7b3 with SMTP id w2-20020a056a0014c200b0069028d0b7b3mr153527pfu.13.1695405093734;
        Fri, 22 Sep 2023 10:51:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b00690dcba0e17sm3585690pfa.19.2023.09.22.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] irqchip/imx-intmux: Annotate struct intmux_data with __counted_by
Date:   Fri, 22 Sep 2023 10:51:32 -0700
Message-Id: <20230922175131.work.718-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459; i=keescook@chromium.org;
 h=from:subject:message-id; bh=mvFgO9v5w2MsRDjwkJuQ6DC2ihWdFPibyg0TMHS5b5Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQj18/exFGglEhzz/3o7XP1T9eIIjqKTUULZ
 ltYTkOtcfmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UIwAKCRCJcvTf3G3A
 Jlj6D/9BqGkE2W574Xw05XGeAb3CJxzSEdnLhcmqWJNeogYU+KV88H3NybOUiCfp9zf+KC1yjg8
 OarGW7ESXkT0amr5GFqz6fzX3V1SXLO/V51G6kJDDj5BbJLWNJK8IJZPQ1nMnyb+wIvjCmCsnzq
 w62V7vklfDGTF92LSXY5cwv5m2x2pObAZUng1ykQLgilxTo15p2ZXgLjk7QpIAt6ghoKcNZ/iqZ
 xt+XzolLJnXDkrl9g1uwT2WKJIBe863fabXwcpvxtcW63AP/Waut3igfrvAxc7ECcFEImfIGK0b
 71Kj/aEfV6BIQazzTszq/xAcbsITzg2MQUGtrLMdynneIk7l11BifL/CelQNZ7H4Qeh6l+kPVId
 u8AoVMPYH8YR/QXiaOnaHdho2a2l+XT1oLJeFfstRokrOwbLx90eDHpnbIzPeEqWPDmFpQ1NaxY
 CE0iop56AlfvXQwTVQMMLTBn7g6DvEi1+ZbV4qE/Bjyl/NEMpH7pAaw+lrqcGVCcMGXbeq/sh6Z
 qY6i3svt2Red91t7+Is8XG01LbBqfqVzDbx2m9DZg6xxqHTCM/Z0w0UFqXo7B8l/QNCM950hpoZ
 jyyr/mgHUXhjPOFxM4zZfKxP0KqE7PAwo6lN9rYqPM43vpXiBhML88yfSw9Ffe0DMO+aV5qxFFe
 AqWpvZf SE+5Plyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct intmux_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/irqchip/irq-imx-intmux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 6d9a08238c9d..aa041e4dfee0 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -73,7 +73,7 @@ struct intmux_data {
 	void __iomem			*regs;
 	struct clk			*ipg_clk;
 	int				channum;
-	struct intmux_irqchip_data	irqchip_data[];
+	struct intmux_irqchip_data	irqchip_data[] __counted_by(channum);
 };
 
 static void imx_intmux_irq_mask(struct irq_data *d)
-- 
2.34.1

