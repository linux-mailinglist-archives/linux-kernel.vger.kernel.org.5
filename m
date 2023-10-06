Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99067BC223
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjJFWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:16:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00ACBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:16:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578d791dd91so2049293a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630582; x=1697235382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKHn8MHAksMieZVNplmzQ9td3WQY/zTB+/6WLDFqzoc=;
        b=ZSFXcvartjnVLWjOnc1Zm3GTsvaBpPPgn7YtM+5QGifXxevKNVwsw21LQ0hA3L+S7I
         3A6tSW3yTRM/2nQZbBdrwLPsq9P4GYmv1wmJzp+Hn78NwSwX7cfaxRTLZLlUQoaQYv0e
         /QxBW/gsil9hUoy+DstembkO2gJqG8CBxYPYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630582; x=1697235382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKHn8MHAksMieZVNplmzQ9td3WQY/zTB+/6WLDFqzoc=;
        b=QyIazbNHo3g5bopwkG5fBa4JW1R128fZR7JMHKlL31pW2B4J6mhE8m1Gfh0qhG7SHO
         Y+8+6/bhgVHrtwemViE6gw6P8KsLvwr7fBeZQGMRUJZKLh/dIKl6dbsMCSKA+p1prsiL
         sPp4l9WyhaRlmooigNFe/AM5lDaEi4nFt0QP5iEOx/dooaNZQ6xeokpcwEz6Op0EdgtK
         CaAW8cYC7Gj69NQ3sUCo+2XZIfuxlmRbHssxlcIBp/8iI+KjDKx5UWij+VyHP6izPo6g
         0U3udVtTxK9uZglfr00h9oxpBb0WkeGynskfmoDulbZUfu71ebbHEVR5+nqyek/D3pk/
         M/Mw==
X-Gm-Message-State: AOJu0YzixySTpqfinLKDNkvk7idUsB9U0ixEn2xSs2Xn6hNjHTskcv07
        jq9rV+A7/K2jEomLz+KEf89idA==
X-Google-Smtp-Source: AGHT+IFtVb4aW+OND3UEg2HZFIAKdVlqCxraW/RlbV8GK+Xlw6U93GKGB3E+X4qacvY9EjVOr1BC8g==
X-Received: by 2002:a17:90b:3907:b0:276:5512:13ab with SMTP id ob7-20020a17090b390700b00276551213abmr8650294pjb.10.1696630582413;
        Fri, 06 Oct 2023 15:16:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:1f37:5459:32bf:faf9])
        by smtp.gmail.com with ESMTPSA id rj6-20020a17090b3e8600b00276e8e4f1fbsm5946523pjb.1.2023.10.06.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:16:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] irqchip/gic-v3: Remove Mediatek pseudo-NMI firmware quirk handling
Date:   Fri,  6 Oct 2023 15:15:53 -0700
Message-ID: <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial revert of commit 44bd78dd2b88 ("irqchip/gic-v3:
Disable pseudo NMIs on Mediatek devices w/ firmware issues"). In the
patch ("arm64: Disable GiC priorities on Mediatek devices w/ firmware
issues") we've moved the quirk handling to another place and so it's
not needed in the GiC driver.

NOTE: this isn't a full revert because it leaves some of the changes
to the "quirks" structure around in case future code needs it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/irqchip/irq-gic-v3.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 787ccc880b22..9ff776709ae6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -39,8 +39,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
-#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
-#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 3)
+#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1790,15 +1789,6 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
-static bool gic_enable_quirk_mtk_gicr(void *data)
-{
-	struct gic_chip_data *d = data;
-
-	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
-
-	return true;
-}
-
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1891,11 +1881,6 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "asr,asr8601-gic-v3",
 		.init	= gic_enable_quirk_asr8601,
 	},
-	{
-		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
-		.property = "mediatek,broken-save-restore-fw",
-		.init	= gic_enable_quirk_mtk_gicr,
-	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1957,11 +1942,6 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
-	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
-		pr_warn("Skipping NMI enable due to firmware issues\n");
-		return;
-	}
-
 	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
 				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
 	if (!rdist_nmi_refs)
-- 
2.42.0.609.gbb76f46606-goog

