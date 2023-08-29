Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AAB78CDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbjH2UjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbjH2Uiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:38:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD421BF;
        Tue, 29 Aug 2023 13:38:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3c8adb27so606216066b.1;
        Tue, 29 Aug 2023 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341528; x=1693946328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OQ0uMxvObgSXiZXc7XOlyouI6S5o18+qbYKi7xXiJU=;
        b=XJmg5V4BwRQEoXbxjvkT5/6Kfeu1MwvdTQO5byA1fJvuJYJLn3vYqfEFIxm/ouajOr
         r+FDt2i2lxm/Zl+kMnLGiNEUt4lh/cIyCdHYo7iKUzzQrdlYcSXfJ7OECQui9KjqdSmr
         ng4gH7FWn4ECQA/8qUALll+nOJrMPazDasSebJYmzNG1kSNne39VAd8l9GFAZG8BaZYF
         RygZ2CGTDWCvcRP+yKA95oHCvjWzCiwpZjUGRXEsSyCjLjhhsyK79U9fXPwZsX56glje
         f8p4GC2kKVLe7IVRSFSrHOxSM0+oNzu+s/3JPBriyRDEvmdkfGxSDoa3QAOz5PakLmKC
         oQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341528; x=1693946328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OQ0uMxvObgSXiZXc7XOlyouI6S5o18+qbYKi7xXiJU=;
        b=ZrSbZjWfC3yRPDHXFUsrOJ4OiEKth5mllKW+Q1bYBIQC1WkVnChKa9uIn+NTpiwFcs
         t328/E6fkSVe5fHJNf5B/nE/g8W+zNvSLBdiGxDVVJZGE32fwiMmmY6N32KG+zBsn6Hh
         nJj/MezBxpR68m/sW5VifqS5jwzhabKwryfkCTtq/B7dZ2hcCtzB7HPaSXeL607nQRma
         WJRVwKX/S8WOCQx+jknPUlkzjtLu5C1GOr9FVEYWLqdqTdhB46vCwO9MaKt4PsWEYsf/
         hkqN85KGMgt/PlvaryVtDXXubY2mblZrdXsqutOh2lkHdKzp0ggO4FK4PhSoLxU5GDpf
         ri2g==
X-Gm-Message-State: AOJu0Yw+CtPEyHRa/5+8kMhIjFgodIjAFCHw0s/Wxg55VD8oCMTLUGrc
        NpThZNSbtaJcsJ/HiLqzfg==
X-Google-Smtp-Source: AGHT+IEv8kBuJCMhIXwNVoQjMaCQf5mn5eJBOXA9wHc3xHSX+JITKzFIM/BaMQ9PjrNjxi2AgD6lEw==
X-Received: by 2002:a17:907:a057:b0:99c:a23b:b4f4 with SMTP id gz23-20020a170907a05700b0099ca23bb4f4mr101556ejc.2.1693341528078;
        Tue, 29 Aug 2023 13:38:48 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:38:47 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/5] ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
Date:   Tue, 29 Aug 2023 22:37:25 +0200
Message-ID: <20230829203721.281455-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829203721.281455-4-knaerzche@gmail.com>
References: <20230829203721.281455-4-knaerzche@gmail.com>
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

Like most other Rockchip ARM SoCs, the PL330 needs the
arm,pl330-periph-burst quirk in order to work as expected.
Add it.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index bf55d4575311..9125bf22e971 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -459,6 +459,7 @@ pdma: dma-controller@20078000 {
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		arm,pl330-broken-no-flushp;
+		arm,pl330-periph-burst;
 		clocks = <&cru ACLK_DMAC>;
 		clock-names = "apb_pclk";
 		#dma-cells = <1>;
-- 
2.42.0

