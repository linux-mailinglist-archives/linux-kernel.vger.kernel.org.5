Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F15E7C5DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjJKTyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJKTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:54:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8BD94;
        Wed, 11 Oct 2023 12:54:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb673so3037465e9.0;
        Wed, 11 Oct 2023 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054054; x=1697658854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3YFPZew2Bj95EqowwXla7dhplIamhthsOPPYN+nyMU=;
        b=Res5H5ChYGxkqwMulH2BX8MY5fB2aRIfETQuDW2YCiuh/1GR1kBLGtfR8upvxO765U
         aSuo1t4de22XHEnh16MCXwH1lrCUQkEX3Yt6PadR5s0b0QSzA+7TubIyPyo9gqY3nT3t
         b9MQuiExKwzx/84+0kLRSDtbPedrdAgA6igLW0ocM/0pTyN8PcUTlFbHk1rg3PO+1d7+
         uw+lJ+9yuoqhLvF/pJN82YGNKXBBN5W//7g+WHlu71mlS2NaoosxHluUOzUAsdxC6EPn
         nZ26Ldb/s0z+U2m/NPcxpIYu6J5XGZ44QqI+KV0lsv+UXp+xwsSji3lDVoiywK3DQ2iP
         WVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054054; x=1697658854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3YFPZew2Bj95EqowwXla7dhplIamhthsOPPYN+nyMU=;
        b=uydkhPUfksxFIU0vFc40GZbpUK2AiuDWBGodsSup6zSXyDvGASklvylnzzhYUmdX7q
         2YQbWADQXwrH1OiAsHrQwaIhbjixHFrGW1Fm7BNca0GUxYAV02Q/BzkuO/YcsB3a1nQd
         UzNe8xgPVHTZeXcPK9H0+XOptaArAkyDBKdOIFkm++aY06WqR/Wz0tjL9HmGW+JmdEJS
         pw31W6DHB4t3BnDrEk8v5kiQc4TxEaVi2+m2WnbztFRMjs4vzC7bksuBMG+VjBiiB+u+
         p3oaFH560l8SvJi12Y635fyF/k0z2tXhwCi6y0wccADKNpwluZCs9I5U1gL3EJUZVeJz
         Z01A==
X-Gm-Message-State: AOJu0Yx6ySwtA2ASH2HZsDEC7cxsL2CA2UQs36JTpviXwhkCKjuXTTdw
        mBiDJly/zNcKP5W15AceOyk=
X-Google-Smtp-Source: AGHT+IH0ZWnon6aBmF5pJAjBaQ3ZU+0IT2e/bvCnKFGgpAa/lhDn8x+0H84J9gcNuYUTO6zBHMsOCw==
X-Received: by 2002:a05:600c:21d0:b0:405:3a3b:2aa2 with SMTP id x16-20020a05600c21d000b004053a3b2aa2mr18993979wmj.37.1697054053875;
        Wed, 11 Oct 2023 12:54:13 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:b8af:68b0:4272:ed0d])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c20d300b004075b3ce03asm4136872wmm.6.2023.10.11.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:54:13 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] irqchip: renesas-rzg2l: Enhance driver to support interrupt affinity setting
Date:   Wed, 11 Oct 2023 20:53:24 +0100
Message-Id: <20231011195324.66807-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support to set the affinity of the IRQC interrupt by implementing
the irq_set_affinity callback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 2cee5477be6b..6390d1d78f2e 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -247,6 +247,7 @@ static const struct irq_chip irqc_chip = {
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE,
-- 
2.34.1

