Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E847A8D61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjITT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjITT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2F186;
        Wed, 20 Sep 2023 12:58:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so432794e87.1;
        Wed, 20 Sep 2023 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239906; x=1695844706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6ukW6/8Y8yO1kJa0bwaWXWRXX5ogFwdYSjCmCsjJ8M=;
        b=m8dtA+9bIa+bStAKppt7pRQFqncaZmcxEIeXLjcqdEMIJmWsnfy/s4g/7Pvy2wbkb0
         gddG14fZ7suZsU24KlmzP//QONJFS0j+7jNTDPDrqtO0KTnIm/QccPqWQ7UCRutsZ549
         dyy4dBauw6ds6asiMXt2+cPHkZQp5ObAIuzNm3DmqVrEJ1QYCHcMjih2NI91Gq8Wxrk2
         MQRJ94QwvnTPHYHZEcM4Sy3X4b4TQXaaS30FvgZ6aO46spsQIq84EUNA6G2Rq/men2f4
         SGDOJI4UjHjF+hoVXpOvXv0vjzd3k4uGpc2P5jSwc7yv/VSWf0falZZpjdKaBGxQq39J
         WyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239906; x=1695844706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6ukW6/8Y8yO1kJa0bwaWXWRXX5ogFwdYSjCmCsjJ8M=;
        b=Pjd43C2mn7UfBS14NlucC2QLkJw5ozLqr7GuFG0lMMVIrnsFf4Vn4qtWImxV4akmPu
         BppYzjGfzeUWNk06kn/AlCAH/lOMYGAyKMJYncOOmrAAzhITumuD+7CWJEg0rs6l3Eot
         pA856+JCPJqCuIczPefw7QJ+/Hp6pjoAAx8t9jqIG1TXeGolKy5le+jyvwaaKgXM9Xrz
         Z1KtnZ0le2wpJ3ZvgKf7phfpGORwsdEehS+vJAWAwz+spYN1I4+7fVY9iufXMVKlWN5/
         nSrDp4aV56+W5i1rA+xhnX5u14tY9mebvT2aIQ6VyWb4VDaAOIgMznrVqix5yeNej1eN
         oupA==
X-Gm-Message-State: AOJu0YyFtYrHp6z68vN3JeOi93KlHIbuQPziojyBN4KnimyuKA7TfMoh
        AKkmEPR/tVitYseEqAieneQ=
X-Google-Smtp-Source: AGHT+IGwLdoxpsfWKq8k9fjW8bXC2QJ7TzGGKHjEsBvNx8QGU4LeSumexX+UlBAQzaicykI7hYqTKw==
X-Received: by 2002:a05:6512:3692:b0:503:72c:50cb with SMTP id d18-20020a056512369200b00503072c50cbmr3166877lfs.6.1695239906176;
        Wed, 20 Sep 2023 12:58:26 -0700 (PDT)
Received: from localhost ([178.176.85.149])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004fe2f085d5csm417803lfq.299.2023.09.20.12.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/13] EDAC/synopsys: Drop vendor-specific arch dependency
Date:   Wed, 20 Sep 2023 22:56:43 +0300
Message-ID: <20230920195720.32047-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW uMCTL2 DDRC EDAC driver is no longer specific to particular DDRC
versions. It's generic in the most of the aspects now. So permit setting
its kernel config independently from the ZynqMP/IntelFPAG/MXC platforms.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index eaac35c27e5c..ebf7deee7fa6 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -487,7 +487,6 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.41.0

