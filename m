Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB57917F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353014AbjIDNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjIDNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:22:44 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1ACD1;
        Mon,  4 Sep 2023 06:22:38 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3848V1f3031734;
        Mon, 4 Sep 2023 15:22:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=XzmJmyD
        GzbW4MncFV7Q4aRei5HWxvrVZ4z14lW+C8DE=; b=RZzb7GN2/IRD1mi0JAGiGEn
        D8RjCpc78qsPqPJFe9hxLbhIzj9Shc2KFBA6JVtkejvYb4wKxsQ2J2TfN6CxbCCG
        Y5T31DmgUqRHUErmYG1UK9s+fetP3hKcBIcquuNFGeyaphrdH7xEXqUxhoi7icI6
        9lhEx0js/ksY1a8UH9E2irddi4p5Xq6uZ+qr1kQSR1ANXGVdmhOPBFOAV0TV+VgO
        milTy/Tx1P7Km6nzouW0mH5E6pfiin0QMYRD4T6SWTQKC00B6v/b97IHTYHET7wT
        zv6Kpt3/4tnwZuqrLhVLLXDcSEbEaIWNXlWAHITtHDRWVHu4+JiPZgd+jhrmD5Q=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sut63ftxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 15:22:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64876100058;
        Mon,  4 Sep 2023 15:22:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59936229A98;
        Mon,  4 Sep 2023 15:22:18 +0200 (CEST)
Received: from localhost (10.201.20.125) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 15:22:18 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 0/3] Add SD-card support on STM32MP25
Date:   Mon, 4 Sep 2023 15:22:09 +0200
Message-ID: <20230904132212.157405-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdmmc1 node in SoC DT file, then the pins used on STM32MP257F-EV1
board, and then the node in board file for SD-card support.

Yann Gautier (3):
  arm64: dts: st: add sdmmc1 node in stm32mp251 SoC file
  arm64: dts: st: add sdmmc1 pins for stm32mp25
  arm64: dts: st: add SD-card support on STM32MP257F-EV1 board

 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 54 +++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 13 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 22 ++++++++
 3 files changed, 89 insertions(+)

-- 
2.34.1

