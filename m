Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DE7FC8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjK1V0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjK1VZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:25:41 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2457DA3;
        Tue, 28 Nov 2023 13:18:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-359d27f6d46so19734435ab.3;
        Tue, 28 Nov 2023 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701206323; x=1701811123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVtlMs/npvEtGC658gvSbbSI0VIaLJV0peh3V19hsUE=;
        b=LSTx+708H0e46+WYkkXeiIJ9YwVhn8/Sg4W+fIuzGxjJIrJHtsTA2tgPFti9LMn0tk
         2pU+QEsNokt8GmhhZ5cXmZBYt0r+MTxiJXH2t1+MhZl+/zU9zKM/TgJeM+Fp14T47Qac
         VWWyCh/T1MRmaqBDaOYy+F+B5ui8XNl1S0fjNgzgFeJlLYnAfDxqDOH5L9eXypc+uTH5
         TIwDv/VUUxHcPfGI2CSQIHaMvjckglF0ZCYL2IbsEntHiYxyMk2Wpl7fUO8PKzt4DqiG
         +CS4dcK/yBpqjwzdf6vTIBmOw7p6w3GyzA0WHFExX+2FYS1x1v+BTnZRxkSrqQ4yjKRH
         jSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206323; x=1701811123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVtlMs/npvEtGC658gvSbbSI0VIaLJV0peh3V19hsUE=;
        b=xE8GsSxJm9lqxD4DhRHtkwiHXPtbEwDjmTTuk4FMNRs5l7LTUD1RBJ7pYywEOPZadX
         2Ct5Azjqixgp5sXnJXMIWC3UjXkGRa2ihLI4KTGbv3AUEhToHNKqn/qLM6dNBZLHlVEP
         mtIN+y2UAFCdTyvd9jsNjOyoBABlAmhM7C3PIvnH7s+KGKGPhCzTtG2qkAlxUsdlfRxh
         IRacnWzqc0lLaSE8J0mHOqKTHz8yFX3YbVIx/hCLrDtbOWhyZE0y5LlnCPzKyVRJCPLR
         TjOQPcrSpbxv+hmR7ozUAjMdxmTB2El0QXoKA1C5nM5zsyuIQ/aJ+NgC8MMvhxPjgsAi
         w2ew==
X-Gm-Message-State: AOJu0Yw7/wV077tmaC0B5x9c3dpfqKRMHrtUvtjHzZt2rDVKoS4Uka0k
        TmjoNSCP72gXFSPON4mSb8M=
X-Google-Smtp-Source: AGHT+IHKOKYVY2DEWRwL2iex4q/udDzs397PCWOz5nhUoP37FwvBMkF0iD3MAEMKsXWoEmKApJIrag==
X-Received: by 2002:a92:c7d3:0:b0:35c:ced9:fd51 with SMTP id g19-20020a92c7d3000000b0035cced9fd51mr8647866ilk.8.1701206322678;
        Tue, 28 Nov 2023 13:18:42 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9cf:804b:3499:a67b])
        by smtp.gmail.com with ESMTPSA id f15-20020a056e020b4f00b0035cb9b85123sm299991ilu.46.2023.11.28.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:18:42 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mn-beacon: Support overdrive mode
Date:   Tue, 28 Nov 2023 15:18:32 -0600
Message-Id: <20231128211832.313544-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128211832.313544-1-aford173@gmail.com>
References: <20231128211832.313544-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC is configured to operate in overdrive mode, so it
is safe to include imx8mn-overdrive to run the GPU faster.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index 90073b16536f..2a64115eebf1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2020 Compass Electronics Group, LLC
  */
 
+#include "imx8mn-overdrive.dtsi"
+
 / {
 	aliases {
 		rtc0 = &rtc;
-- 
2.40.1

