Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0B75268B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjGMPRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjGMPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:17:06 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDB1FD8;
        Thu, 13 Jul 2023 08:16:52 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDI9Mm009977;
        Thu, 13 Jul 2023 17:16:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=xQ3+qKLVZVZ6Z94h+CiU4oGATjbciwdLoWhA1jjC0AE=;
 b=wqu2xlBX4hJdeIG0emMqqguu/DYQWFQ39XZvajVgi0cIabCRDxUuRZywh063VRL9Ph8T
 8/qb7g/BiLjO2Ua7O3e2CI3HhKslRNvLSgsjb2GqRZ8zLwTBYOIum8JycdkTDjvesbio
 8PbNzMdHiOv3e6DbaFs+wdV7mrN1XA/kQLkMIt1gBieVajLTFEybKc1AINSgvx55enM3
 l1GU8qqmG+7mHA61dJjkGJHKulkBPc564xWpcxzoBrMKqJHp5B+CUtacSArNJd4XGDm8
 1Zp6DYo6PxrrRw3Gty7ks6wT1Fa4VdWjt+WnbAqQ5CKquoBZdlUskx0fradEVq8qkJyK /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rtedtjfp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:16:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53A48100056;
        Thu, 13 Jul 2023 17:16:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4B52F22A6D9;
        Thu, 13 Jul 2023 17:16:38 +0200 (CEST)
Received: from localhost (10.201.22.9) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Jul
 2023 17:16:40 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 4/7] crypto: stm32 - fix loop iterating through scatterlist for DMA
Date:   Thu, 13 Jul 2023 17:15:15 +0200
Message-ID: <20230713151518.1513949-5-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
References: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

We were reading the length of the scatterlist sg after copying value of
tsg inside.
So we are using the size of the previous scatterlist and for the first
one we are using an unitialised value.
Fix this by copying tsg in sg[0] before reading the size.

Fixes : 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

---
Changes in v2:
 - Add Fixes 8a1012d3f2ab ("crypto: stm32 - Support for STM32 HASH module")
 - Add Cc: stable@vger.kernel.org

 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index c179a6c1a457..519fb716acee 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -678,9 +678,9 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	}
 
 	for_each_sg(rctx->sg, tsg, rctx->nents, i) {
+		sg[0] = *tsg;
 		len = sg->length;
 
-		sg[0] = *tsg;
 		if (sg_is_last(sg)) {
 			if (hdev->dma_mode == 1) {
 				len = (ALIGN(sg->length, 16) - 16);
-- 
2.25.1

