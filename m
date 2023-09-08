Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2C798AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbjIHQwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbjIHQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:52:07 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DE1FE2;
        Fri,  8 Sep 2023 09:52:02 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388ENMo1022982;
        Fri, 8 Sep 2023 18:51:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=r6Gr5rp
        kk1VW/S8lUEi+0DFipylC3JBR3dSDFFvyWsM=; b=DXqR1kjzDGez2o1yInWz6mE
        +f7FN/ooVNI4sPI//vBezx44ZAPwd3WsN1bdFr4IJd71FMWC2/zC1Vgsf4dHW7wp
        F+axhkwfTjmrJTnq6/YPFtLi78/MlPPB6Bfa85zSSeUOQQZc57ZKRu5+N01v3DUr
        n8GOn9AJZzmLi0+jS6UYzI+bCtWSW84RRkb6Eg2nnrh2VthYqRlf/6chgE6X5GSp
        Nx2Ak93t4MZJGD2ImyxMPB+7geJMP3H3W+rto853LjJ3KjVnSV0a7almZAswM/g7
        IGFuD6NhKAIVbjfrhRWrEbSaOqP7HhmqHpcojGoaxnUlodi1gAUzrMv3LEOZ7Wg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sxwjp2g4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 18:51:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 487F710004B;
        Fri,  8 Sep 2023 18:51:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3ED6D209EEB;
        Fri,  8 Sep 2023 18:51:28 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 8 Sep
 2023 18:51:27 +0200
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH 00/10] hwrng: stm32: support STM32MP13x platforms
Date:   Fri, 8 Sep 2023 18:51:10 +0200
Message-ID: <20230908165120.730867-1-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP13x platforms have a RNG hardware block that supports
customization, a conditional reset sequences that allows to
recover from certain situations and a configuration locking
mechanism.

This series adds support for the mentionned features. Note that
the hardware RNG can and should be managed in the secure world
for this platform, hence the rng not being default enabled on
the STM32MP135F-DK board. 

Gatien Chevallier (10):
  dt-bindings: rng: introduce new compatible for STM32MP13x
  hwrng: stm32 - use devm_platform_get_and_ioremap_resource() API
  hwrng: stm32 - implement STM32MP13x support
  hwrng: stm32 - implement error concealment
  hwrng: stm32 - rework error handling in stm32_rng_read()
  hwrng: stm32 - restrain RNG noise source clock
  dt-bindings: rng: add st,rng-lock-conf
  hwrng: stm32 - support RNG configuration locking mechanism
  hwrng: stm32 - rework power management sequences
  ARM: dts: stm32: add RNG node for STM32MP13x platforms

 .../devicetree/bindings/rng/st,stm32-rng.yaml |  18 +-
 arch/arm/boot/dts/st/stm32mp131.dtsi          |   8 +
 drivers/char/hw_random/stm32-rng.c            | 509 +++++++++++++++---
 3 files changed, 452 insertions(+), 83 deletions(-)

-- 
2.25.1

