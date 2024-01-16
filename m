Return-Path: <linux-kernel+bounces-27161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676882EB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF081C22ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C412B7B;
	Tue, 16 Jan 2024 09:18:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2E125C4;
	Tue, 16 Jan 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHd58G1DEYAp56EabOPCeLnrlcMrP/7aXasc0Qed8+Lfq+4Q6+MlF2kCCCmMK2etR/PLfPo9OBwxtFef44dJqY57pqjmoGq0rzzqlJm/vt+dB5s+Y63jXq2IwAPh294vPKhkLVI0x/wrTph8DLzgvLw81c73zUrvHS/9vowAbYFsc2dIj8wa/sunkv/ZYTfs6Spfh4qh1n+RSJSwwje4L2AGWFB6Cxq4xPh8+os80xYFBDU4Qhe+ilyLMhm5/SmhXgwWioNI0nzsZznp10mrXXt6sLT2dkWXaPHWJGjg+OQffhfYG9NfIMoTbghnf04zLRmEQq5M8TzMcKl4zxYgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5Q+rsk6e68+MYbxqAa4UHh06eZ/BVLjeia10+IUsVU=;
 b=NLVY2bQIL7r+PjGEXOD6VtFF1zDBt1K17D3jaNDDdguFMH4XtI65d9rsn4kiuFqFYCAl8O39+/4MzEykS5KgxYWfWU1VvoJdBZYorYlIaxCpnXidWLFiwiEI+iRnvXcEOBzO/KK+bB2EIkSkEzn1j0OQ24xKc8x8BXtiKaeNFguc/sVY+fFLlQecqU6Ln05gZtlpl1yfh1Sc7SHuL+Naiqku4kF8QRlKmEsN6EAUA6bhnSU6zcw+WYX3Vi0p3wTw4Vz596TBXWY/AoPEcuveuF3xqEPyHiQ8Wg3/XZcnknY2CKF9oBRvnp5jaF66HIWgAeEwNDPqesEXOn5KK3fZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 09:01:53 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6]) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6%7]) with mapi id 15.20.7135.032; Tue, 16 Jan 2024
 09:01:53 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Date: Tue, 16 Jan 2024 17:01:34 +0800
Message-Id: <20240116090135.75737-5-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::21) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: 964dd8c0-b8b3-46cb-384d-08dc1671c872
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gQVfuo/eTxAPgAKqOF+r0OtoMCkHGsZBNE2mWy6lThYIR9d2w7vu3HbWT2jEPf7eGg7KvG+TVG3GkO1d2cpEomwgT4XGSM6/mZEkOuPV6aTK8ztgyAoTLzIQUlW6Eo20dbnlUl8u+a16zaAjcKYSYct8uOdBkNyUXyls0J5aF/eLBU6KQcQWQzWjF+ps+aIZet7xJL5UcGG7Vw58suYU8Tn+MRfV+ab5vw77OYG9CTiGS9KohSgiB59F+latRnyjRe6+P7bszkZJtM4OUKU6YiorYtXnXVkfU2mdPIyX07L/E6OStiPGxFEs04yK6CADGMvTQhNjmxI60sUuO+/Bmi0MRXJUyZAvZJ6oVVI8Z+cRY8A1U/ayUOKdvg36RSY69a0vyUj3aZ/WwYMW9TltBeEzJsRdUt3Bg5tBFkzqWJCPJIagwtqAirz6ab9SXq3Nj8FSWlw920RINH6Sw018C2Ev+hOOP5aVxAof0+RVW9grTehYKdymjPe22zdPHON+4Ub0RENrOzCdiZw9nllRnXDp/FAUZKCmimk+2lMW05iGSgueyi5tJHwRbYp/2Y8A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(41320700001)(2906002)(30864003)(5660300002)(36756003)(40180700001)(8936002)(8676002)(86362001)(41300700001)(38350700005)(83380400001)(26005)(40160700002)(508600001)(66476007)(110136005)(66946007)(66556008)(1076003)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1IxwBDwNKIlD5n7AajTlrrxY8ldo04LcE/kJYH9WK857hwlPbsa4Bwqo+li?=
 =?us-ascii?Q?NEKzhYCZ08TDg5sxnSIGzOibJv3l4STs2BAt7J97GBQjfjYyvlcW1zHCKEkT?=
 =?us-ascii?Q?lnNVQDLJm7oA62BN55y2dR+asKAq+xWSxSL0Dfgj1OH8SjJQMDchLbOgORHL?=
 =?us-ascii?Q?rR8Up8dBAybv1PMpxfjtdaSahOHGtw2gpor89JVya7zZ1X7AT1ahkQAooc86?=
 =?us-ascii?Q?z2n58Ke2tA4fgnsLQEZKqV3eYpAByL6qsz82wdfXJshYlXqDBupLvh1+m3VQ?=
 =?us-ascii?Q?89vt8NvXOdr4RwUaa4djbOKB3l0qnSCKlDDMcIzITmRZzrEQgi5Xofy4ND9v?=
 =?us-ascii?Q?VsPrVQryoR4QyFs3S/FMT3TlQ2b44YUCN+ELListrNM6m6jDADIX0e1zN/pN?=
 =?us-ascii?Q?5WuPHrrwm2EQCqPzIky4eoPZQFi/kOXLlzdz0+VXetYq2RygpOLdrDU6Hwov?=
 =?us-ascii?Q?E/b9smsh8F2HGpP/S2B+MmKWf7/2BNN0w/5ZTpiCqGDif9rbYg63i+LWoo40?=
 =?us-ascii?Q?08I+GwzhxvsrqoP7GKuPzscUCQu8+Tinn+ZQUh4Z1f9ts1LI0WrC3sjIJsom?=
 =?us-ascii?Q?h95yua1/S3f1YdHnBgI/ZYdUS00UZmVPaI1t8bsIJWREdcQw0R62FlMsddxG?=
 =?us-ascii?Q?Y+S9Eb1w1Jz4150ovDJsDGzwQgVdp8KAvawWTOny89sB8GMKcKtx9VXe50g3?=
 =?us-ascii?Q?5pP9qmRrCeydASWChPIEpS4BHxbmq4uzVpH9n3iht3vr9CaZ3UceTpVvq+Zd?=
 =?us-ascii?Q?MpSMPZMCe7Tp7BOBHLRsqMEqWmykxNSiEbKefDymLrsk5dn/umEoojYEIdyr?=
 =?us-ascii?Q?jT8BWDU+KsOAV1fgPShC4Yu6h2qOS8zVw5jlL10qrJ8zbPv3E4jJKgf4sCvt?=
 =?us-ascii?Q?aqHVowEaUHinQxDvx9KrtZmpxgdHBhfqTYdqJu422kVAtIgEdBHAmok0iQJj?=
 =?us-ascii?Q?lV0VnCUiuTAfcxirEsLIyJh1FlcvOnKvMCud0F5qjpOJDL5feeShhf8/QwlB?=
 =?us-ascii?Q?DhJ6jnvWvhtM5wyUBBH2A6aoZ1HwZZrRLUnBDolYHqWW8jPObHo9nmTEWl0V?=
 =?us-ascii?Q?nr+GsXOKSIZZwF6NVgyumHe7jXaBwbcaXKVGSVSpszCPww3SSfjhoqEPVL/z?=
 =?us-ascii?Q?3ohjQwwJ+TPR8je9elukA5rvOICihgXxiLZBKxzTI/By06W96+rtlcr30u5U?=
 =?us-ascii?Q?1M9fw9NyWYM1Hz/mZgKr9AxXqL/SL860+fkvq5s1cTiTR8ug+iioolStrSMv?=
 =?us-ascii?Q?pjA89u7dURUIHS6RiMuHvE0tESFTXf1SH9xb4JNmIL+AVwjWdlvPxpAF2iuO?=
 =?us-ascii?Q?mZ87NhwZKj8SRiKuqWnpPqh46Gb+YKCy5y6Q9iaCmuqTkJin9esAidaCpHiJ?=
 =?us-ascii?Q?HSfFS1anRsSW6PZ3n1CTRHj7Er5S8lSQHykCckPsUSyxvd2EtJ5MVB6/3Ebu?=
 =?us-ascii?Q?acokd7ZyEOJuD/bYB3poaHU1MPxEOnNA8nAELGCCHU2Y1oLd+BSQhvYOm9s7?=
 =?us-ascii?Q?qe2xvitt9pPdk7OSqxJBLFZ85W3QVsS9upsvoCt16RDnMtXxq0xorGj7NlJ3?=
 =?us-ascii?Q?zKkPiePo5tUhWnb+998Pg6NN03l74bWsm5xJkO5dVc15lYH6CIqA1tn4jqGo?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964dd8c0-b8b3-46cb-384d-08dc1671c872
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:01:53.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8KDw7A/N0Z3l7czxsdCvkrZ3c+FqCPTXn+KPo5YK0WUNjOL6UJcDHJocYpnuHRcmTrHwR/7EnU8OnywoWY6aRZ7AWYHnsS3r5Wb/rtW95A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640

Add driver support for SM3 hash/HMAC for JH8100 SoC. JH8100 contains a
separate SM algo engine and new dedicated dma that supports 64-bit
address access.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/Kconfig       |  25 +-
 drivers/crypto/starfive/Makefile      |   3 +
 drivers/crypto/starfive/jh7110-cryp.c |  48 ++-
 drivers/crypto/starfive/jh7110-cryp.h |  59 +++
 drivers/crypto/starfive/jh7110-hash.c |  20 +-
 drivers/crypto/starfive/jh8100-sm3.c  | 532 ++++++++++++++++++++++++++
 6 files changed, 677 insertions(+), 10 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c

diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
index 0fe389e9f932..e6bf02d0ed1f 100644
--- a/drivers/crypto/starfive/Kconfig
+++ b/drivers/crypto/starfive/Kconfig
@@ -5,7 +5,7 @@
 config CRYPTO_DEV_JH7110
 	tristate "StarFive JH7110 cryptographic engine driver"
 	depends on (SOC_STARFIVE && AMBA_PL08X) || COMPILE_TEST
-	depends on HAS_DMA
+	depends on HAS_DMA && !CRYPTO_DEV_JH8100
 	select CRYPTO_ENGINE
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
@@ -24,3 +24,26 @@ config CRYPTO_DEV_JH7110
 	  skciphers, AEAD and hash functions.
 
 	  If you choose 'M' here, this module will be called jh7110-crypto.
+
+config CRYPTO_DEV_JH8100
+	tristate "StarFive JH8100 cryptographic engine drivers"
+	depends on (SOC_STARFIVE && DW_AXI_DMAC) || COMPILE_TEST
+	depends on HAS_DMA
+	select CRYPTO_ENGINE
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_SM3_GENERIC
+	select CRYPTO_RSA
+	select CRYPTO_AES
+	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_CTR
+	help
+	  Support for StarFive JH8100 crypto hardware acceleration engine.
+	  This module provides additional support for SM2 signature verification,
+	  SM3 hash/hmac functions and SM4 skcipher.
+
+	  If you choose 'M' here, this module will be called jh8100-crypto.
diff --git a/drivers/crypto/starfive/Makefile b/drivers/crypto/starfive/Makefile
index 8c137afe58ad..67717fca3f5d 100644
--- a/drivers/crypto/starfive/Makefile
+++ b/drivers/crypto/starfive/Makefile
@@ -2,3 +2,6 @@
 
 obj-$(CONFIG_CRYPTO_DEV_JH7110) += jh7110-crypto.o
 jh7110-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o
+
+obj-$(CONFIG_CRYPTO_DEV_JH8100) += jh8100-crypto.o
+jh8100-crypto-objs := jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes.o jh8100-sm3.o
diff --git a/drivers/crypto/starfive/jh7110-cryp.c b/drivers/crypto/starfive/jh7110-cryp.c
index fe33e87f25ab..fb7c19705fbf 100644
--- a/drivers/crypto/starfive/jh7110-cryp.c
+++ b/drivers/crypto/starfive/jh7110-cryp.c
@@ -106,6 +106,26 @@ static irqreturn_t starfive_cryp_irq(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+static irqreturn_t starfive_cryp_irq1(int irq, void *priv)
+{
+	u32 status;
+	u32 mask;
+	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)priv;
+
+	mask = readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+	status = readl(cryp->base + STARFIVE_SM_IE_FLAG_OFFSET);
+
+	if (status & STARFIVE_SM_IE_FLAG_SM3_DONE) {
+		mask |= STARFIVE_SM_IE_MASK_SM3_DONE;
+		writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+		tasklet_schedule(&cryp->sm3_done);
+	}
+
+	return IRQ_HANDLED;
+}
+#endif
+
 static int starfive_cryp_probe(struct platform_device *pdev)
 {
 	struct starfive_cryp_dev *cryp;
@@ -156,6 +176,16 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to register interrupt handler\n");
 
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	tasklet_init(&cryp->sm3_done, starfive_sm3_done_task, (unsigned long)cryp);
+
+	irq = platform_get_irq(pdev, 1);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, starfive_cryp_irq1, 0,
+			       pdev->name, (void *)cryp);
+#endif
 	clk_prepare_enable(cryp->hclk);
 	clk_prepare_enable(cryp->ahb);
 	reset_control_deassert(cryp->rst);
@@ -191,8 +221,17 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_algs_rsa;
 
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	ret = starfive_sm3_register_algs();
+	if (ret)
+		goto err_algs_sm3;
+#endif
 	return 0;
 
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+err_algs_sm3:
+	starfive_rsa_unregister_algs();
+#endif
 err_algs_rsa:
 	starfive_hash_unregister_algs();
 err_algs_hash:
@@ -213,7 +252,9 @@ static int starfive_cryp_probe(struct platform_device *pdev)
 	reset_control_assert(cryp->rst);
 
 	tasklet_kill(&cryp->hash_done);
-
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	tasklet_kill(&cryp->sm3_done);
+#endif
 	return ret;
 }
 
@@ -226,7 +267,10 @@ static void starfive_cryp_remove(struct platform_device *pdev)
 	starfive_rsa_unregister_algs();
 
 	tasklet_kill(&cryp->hash_done);
-
+#ifdef CONFIG_CRYPTO_DEV_JH8100
+	starfive_sm3_unregister_algs();
+	tasklet_kill(&cryp->sm3_done);
+#endif
 	crypto_engine_stop(cryp->engine);
 	crypto_engine_exit(cryp->engine);
 
diff --git a/drivers/crypto/starfive/jh7110-cryp.h b/drivers/crypto/starfive/jh7110-cryp.h
index ade2da468bba..a675ee4bc6cf 100644
--- a/drivers/crypto/starfive/jh7110-cryp.h
+++ b/drivers/crypto/starfive/jh7110-cryp.h
@@ -19,12 +19,22 @@
 #define STARFIVE_DMA_IN_LEN_OFFSET		0x10
 #define STARFIVE_DMA_OUT_LEN_OFFSET		0x14
 
+#define STARFIVE_SM_ALG_CR_OFFSET		0x4000
+#define STARFIVE_SM_IE_MASK_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x4)
+#define STARFIVE_SM_IE_FLAG_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x8)
+#define STARFIVE_SM_DMA_IN_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0xc)
+#define STARFIVE_SM_DMA_OUT_LEN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x10)
+#define STARFIVE_SM_ALG_FIFO_IN_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x20)
+#define STARFIVE_SM_ALG_FIFO_OUT_OFFSET		(STARFIVE_SM_ALG_CR_OFFSET + 0x28)
+
 #define STARFIVE_IE_MASK_AES_DONE		0x1
 #define STARFIVE_IE_MASK_HASH_DONE		0x4
 #define STARFIVE_IE_MASK_PKA_DONE		0x8
 #define STARFIVE_IE_FLAG_AES_DONE		0x1
 #define STARFIVE_IE_FLAG_HASH_DONE		0x4
 #define STARFIVE_IE_FLAG_PKA_DONE		0x8
+#define STARFIVE_SM_IE_MASK_SM3_DONE		0x2
+#define STARFIVE_SM_IE_FLAG_SM3_DONE		0x2
 
 #define STARFIVE_MSG_BUFFER_SIZE		SZ_16K
 #define MAX_KEY_SIZE				SHA512_BLOCK_SIZE
@@ -68,6 +78,20 @@ union starfive_aes_csr {
 	};
 };
 
+union starfive_sm_alg_cr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 sm4_dma_en			:1;
+		u32 sm3_dma_en			:1;
+		u32 rsvd_0			:1;
+		u32 alg_done			:1;
+		u32 rsvd_1			:3;
+		u32 clear			:1;
+		u32 rsvd_2			:23;
+	};
+};
+
 union starfive_hash_csr {
 	u32 v;
 	struct {
@@ -132,6 +156,32 @@ union starfive_pka_casr {
 	};
 };
 
+union starfive_sm3_csr {
+	u32 v;
+	struct {
+		u32 start			:1;
+		u32 reset			:1;
+		u32 ie				:1;
+		u32 firstb			:1;
+#define STARFIVE_SM3_MODE			0x0
+		u32 mode			:3;
+		u32 rsvd_0			:1;
+		u32 final			:1;
+		u32 rsvd_1			:2;
+#define STARFIVE_SM3_HMAC_FLAGS			0x800
+		u32 hmac			:1;
+		u32 rsvd_2			:1;
+#define STARFIVE_SM3_KEY_DONE			BIT(13)
+		u32 key_done			:1;
+		u32 key_flag			:1;
+		u32 hmac_done			:1;
+#define STARFIVE_SM3_BUSY			BIT(16)
+		u32 busy			:1;
+		u32 hashdone			:1;
+		u32 rsvd_3			:14;
+	};
+};
+
 struct starfive_rsa_key {
 	u8	*n;
 	u8	*e;
@@ -188,6 +238,7 @@ struct starfive_cryp_dev {
 	struct dma_slave_config			cfg_out;
 	struct crypto_engine			*engine;
 	struct tasklet_struct			hash_done;
+	struct tasklet_struct			sm3_done;
 	struct completion			dma_done;
 	size_t					assoclen;
 	size_t					total_in;
@@ -211,6 +262,7 @@ struct starfive_cryp_request_ctx {
 		union starfive_hash_csr		hash;
 		union starfive_pka_cacr		pka;
 		union starfive_aes_csr		aes;
+		union starfive_sm3_csr		sm3;
 	} csr;
 
 	struct scatterlist			*in_sg;
@@ -237,4 +289,11 @@ int starfive_aes_register_algs(void);
 void starfive_aes_unregister_algs(void);
 
 void starfive_hash_done_task(unsigned long param);
+
+#if IS_REACHABLE(CONFIG_CRYPTO_DEV_JH8100)
+int starfive_sm3_register_algs(void);
+void starfive_sm3_unregister_algs(void);
+
+void starfive_sm3_done_task(unsigned long param);
+#endif
 #endif
diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index 74e151b5f875..45cf82e64fb8 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -511,12 +511,6 @@ static int starfive_sha512_init_tfm(struct crypto_ahash *hash)
 				      STARFIVE_HASH_SHA512, 0);
 }
 
-static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
-{
-	return starfive_hash_init_tfm(hash, "sm3-generic",
-				      STARFIVE_HASH_SM3, 0);
-}
-
 static int starfive_hmac_sha224_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sha224-generic)",
@@ -541,11 +535,19 @@ static int starfive_hmac_sha512_init_tfm(struct crypto_ahash *hash)
 				      STARFIVE_HASH_SHA512, 1);
 }
 
+#ifndef CONFIG_CRYPTO_DEV_JH8100
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_hash_init_tfm(hash, "sm3-generic",
+				      STARFIVE_HASH_SM3, 0);
+}
+
 static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
 {
 	return starfive_hash_init_tfm(hash, "hmac(sm3-generic)",
 				      STARFIVE_HASH_SM3, 1);
 }
+#endif
 
 static struct ahash_engine_alg algs_sha2_sm3[] = {
 {
@@ -776,7 +778,10 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 	.op = {
 		.do_one_request = starfive_hash_one_request,
 	},
-}, {
+},
+
+#ifndef CONFIG_CRYPTO_DEV_JH8100
+{
 	.base.init     = starfive_hash_init,
 	.base.update   = starfive_hash_update,
 	.base.final    = starfive_hash_final,
@@ -834,6 +839,7 @@ static struct ahash_engine_alg algs_sha2_sm3[] = {
 		.do_one_request = starfive_hash_one_request,
 	},
 },
+#endif
 };
 
 int starfive_hash_register_algs(void)
diff --git a/drivers/crypto/starfive/jh8100-sm3.c b/drivers/crypto/starfive/jh8100-sm3.c
new file mode 100644
index 000000000000..7289c5fba0d8
--- /dev/null
+++ b/drivers/crypto/starfive/jh8100-sm3.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SM3 Hash function and HMAC support for StarFive driver
+ *
+ * Copyright (c) 2022 - 2023 StarFive Technology
+ *
+ */
+
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/internal/hash.h>
+#include "jh7110-cryp.h"
+#include <linux/crypto.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#define STARFIVE_SM3_REGS_OFFSET	0x4200
+#define STARFIVE_SM3_CSR		(STARFIVE_SM3_REGS_OFFSET + 0x0)
+#define STARFIVE_SM3_WDR		(STARFIVE_SM3_REGS_OFFSET + 0x4)
+#define STARFIVE_SM3_RDR		(STARFIVE_SM3_REGS_OFFSET + 0x8)
+#define STARFIVE_SM3_WSR		(STARFIVE_SM3_REGS_OFFSET + 0xC)
+#define STARFIVE_SM3_WLEN3		(STARFIVE_SM3_REGS_OFFSET + 0x10)
+#define STARFIVE_SM3_WLEN2		(STARFIVE_SM3_REGS_OFFSET + 0x14)
+#define STARFIVE_SM3_WLEN1		(STARFIVE_SM3_REGS_OFFSET + 0x18)
+#define STARFIVE_SM3_WLEN0		(STARFIVE_SM3_REGS_OFFSET + 0x1C)
+#define STARFIVE_SM3_WKR		(STARFIVE_SM3_REGS_OFFSET + 0x20)
+#define STARFIVE_SM3_WKLEN		(STARFIVE_SM3_REGS_OFFSET + 0x24)
+
+#define STARFIVE_SM3_BUFLEN		SHA512_BLOCK_SIZE
+#define STARFIVE_SM3_RESET		0x2
+
+static inline int starfive_sm3_wait_busy(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  !(status & STARFIVE_SM3_BUSY), 10, 100000);
+}
+
+static inline int starfive_sm3_wait_key_done(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u32 status;
+
+	return readl_relaxed_poll_timeout(cryp->base + STARFIVE_SM3_CSR, status,
+					  (status & STARFIVE_SM3_KEY_DONE), 10, 100000);
+}
+
+static int starfive_sm3_hmac_key(struct starfive_cryp_ctx *ctx)
+{
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	int klen = ctx->keylen, loop;
+	unsigned int *key = (unsigned int *)ctx->key;
+	unsigned char *cl;
+
+	writel(ctx->keylen, cryp->base + STARFIVE_SM3_WKLEN);
+
+	rctx->csr.sm3.hmac = 1;
+	rctx->csr.sm3.key_flag = 1;
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	for (loop = 0; loop < klen / sizeof(unsigned int); loop++, key++)
+		writel(*key, cryp->base + STARFIVE_SM3_WKR);
+
+	if (klen & 0x3) {
+		cl = (unsigned char *)key;
+		for (loop = 0; loop < (klen & 0x3); loop++, cl++)
+			writeb(*cl, cryp->base + STARFIVE_SM3_WKR);
+	}
+
+	if (starfive_sm3_wait_key_done(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "starfive_sm3_wait_key_done error\n");
+
+	return 0;
+}
+
+static void starfive_sm3_start(struct starfive_cryp_dev *cryp)
+{
+	union starfive_sm3_csr csr;
+	u32 mask;
+
+	csr.v = readl(cryp->base + STARFIVE_SM3_CSR);
+	csr.firstb = 0;
+	csr.final = 1;
+	csr.ie = 1;
+	writel(csr.v, cryp->base + STARFIVE_SM3_CSR);
+
+	mask = readl(cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+	mask &= ~STARFIVE_SM_IE_MASK_SM3_DONE;
+	writel(mask, cryp->base + STARFIVE_SM_IE_MASK_OFFSET);
+}
+
+static void starfive_sm3_dma_callback(void *param)
+{
+	struct starfive_cryp_dev *cryp = param;
+
+	complete(&cryp->dma_done);
+}
+
+static void starfive_sm3_dma_init(struct starfive_cryp_dev *cryp)
+{
+	cryp->cfg_in.direction = DMA_MEM_TO_DEV;
+	cryp->cfg_in.src_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.dst_addr_width = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	cryp->cfg_in.src_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_maxburst = cryp->dma_maxburst;
+	cryp->cfg_in.dst_addr = cryp->phys_base + STARFIVE_SM_ALG_FIFO_IN_OFFSET;
+
+	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
+
+	init_completion(&cryp->dma_done);
+}
+
+static int starfive_sm3_dma_xfer(struct starfive_cryp_dev *cryp,
+				 struct scatterlist *sg)
+{
+	struct dma_async_tx_descriptor *in_desc;
+	union  starfive_sm_alg_cr alg_cr;
+	int ret = 0;
+
+	alg_cr.v = 0;
+	alg_cr.start = 1;
+	alg_cr.sm3_dma_en = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	writel(sg_dma_len(sg), cryp->base + STARFIVE_SM_DMA_IN_LEN_OFFSET);
+	sg_dma_len(sg) = ALIGN(sg_dma_len(sg), sizeof(u32));
+
+	in_desc = dmaengine_prep_slave_sg(cryp->tx, sg, 1, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!in_desc) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	reinit_completion(&cryp->dma_done);
+	in_desc->callback = starfive_sm3_dma_callback;
+	in_desc->callback_param = cryp;
+
+	dmaengine_submit(in_desc);
+	dma_async_issue_pending(cryp->tx);
+
+	if (!wait_for_completion_timeout(&cryp->dma_done,
+					 msecs_to_jiffies(1000)))
+		ret = -ETIMEDOUT;
+
+end:
+	alg_cr.v = 0;
+	alg_cr.clear = 1;
+	writel(alg_cr.v, cryp->base + STARFIVE_SM_ALG_CR_OFFSET);
+
+	return ret;
+}
+
+static int starfive_sm3_copy_hash(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	int count, *data;
+	int mlen;
+
+	if (!req->result)
+		return 0;
+
+	mlen = rctx->digsize / sizeof(u32);
+	data = (u32 *)req->result;
+
+	for (count = 0; count < mlen; count++)
+		data[count] = readl(ctx->cryp->base + STARFIVE_SM3_RDR);
+
+	return 0;
+}
+
+void starfive_sm3_done_task(unsigned long param)
+{
+	struct starfive_cryp_dev *cryp = (struct starfive_cryp_dev *)param;
+	int err;
+
+	err = starfive_sm3_copy_hash(cryp->req.hreq);
+
+	/* Reset to clear hash_done in irq register*/
+	writel(STARFIVE_SM3_RESET, cryp->base + STARFIVE_SM3_CSR);
+
+	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
+}
+
+static int starfive_sm3_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req =
+		container_of(areq, struct ahash_request, base);
+	struct starfive_cryp_ctx *ctx =
+		crypto_ahash_ctx(crypto_ahash_reqtfm(req));
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	struct starfive_cryp_request_ctx *rctx = ctx->rctx;
+	struct scatterlist *tsg;
+	int ret, src_nents, i;
+
+	rctx->csr.sm3.v = 0;
+	rctx->csr.sm3.reset = 1;
+
+	writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+
+	if (starfive_sm3_wait_busy(ctx))
+		return dev_err_probe(cryp->dev, -ETIMEDOUT,
+				     "Error resetting engine.\n");
+
+	rctx->csr.sm3.v = 0;
+	rctx->csr.sm3.mode = ctx->hash_mode;
+
+	if (ctx->is_hmac) {
+		ret = starfive_sm3_hmac_key(ctx);
+		if (ret)
+			return ret;
+	} else {
+		rctx->csr.sm3.start = 1;
+		rctx->csr.sm3.firstb = 1;
+		writel(rctx->csr.sm3.v, cryp->base + STARFIVE_SM3_CSR);
+	}
+
+	/* No input message, get digest and end. */
+	if (!rctx->total)
+		goto hash_start;
+
+	starfive_sm3_dma_init(cryp);
+
+	for_each_sg(rctx->in_sg, tsg, rctx->in_sg_len, i) {
+		src_nents = dma_map_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (src_nents == 0)
+			return dev_err_probe(cryp->dev, -ENOMEM,
+					     "dma_map_sg error\n");
+
+		ret = starfive_sm3_dma_xfer(cryp, tsg);
+		dma_unmap_sg(cryp->dev, tsg, 1, DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+hash_start:
+	starfive_sm3_start(cryp);
+
+	return 0;
+}
+
+static void starfive_sm3_set_ahash(struct ahash_request *req,
+				   struct starfive_cryp_ctx *ctx,
+				   struct starfive_cryp_request_ctx *rctx)
+{
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+	ahash_request_set_crypt(&rctx->ahash_fbk_req, req->src,
+				req->result, req->nbytes);
+}
+
+static int starfive_sm3_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_init(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_update(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_update(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_final(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_final(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_finup(struct ahash_request *req)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	starfive_sm3_set_ahash(req, ctx, rctx);
+
+	return crypto_ahash_finup(&rctx->ahash_fbk_req);
+}
+
+static int starfive_sm3_digest(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+
+	memset(rctx, 0, sizeof(struct starfive_cryp_request_ctx));
+
+	cryp->req.hreq = req;
+	rctx->total = req->nbytes;
+	rctx->in_sg = req->src;
+	rctx->blksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
+	rctx->digsize = crypto_ahash_digestsize(tfm);
+	rctx->in_sg_len = sg_nents_for_len(rctx->in_sg, rctx->total);
+	ctx->rctx = rctx;
+
+	return crypto_transfer_hash_request_to_engine(cryp->engine, req);
+}
+
+static int starfive_sm3_export(struct ahash_request *req, void *out)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_export(&rctx->ahash_fbk_req, out);
+}
+
+static int starfive_sm3_import(struct ahash_request *req, const void *in)
+{
+	struct starfive_cryp_request_ctx *rctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(tfm);
+
+	ahash_request_set_tfm(&rctx->ahash_fbk_req, ctx->ahash_fbk);
+	ahash_request_set_callback(&rctx->ahash_fbk_req,
+				   req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP,
+				   req->base.complete, req->base.data);
+
+	return crypto_ahash_import(&rctx->ahash_fbk_req, in);
+}
+
+static int starfive_sm3_init_algo(struct crypto_ahash *hash,
+				  const char *alg_name,
+				  bool is_hmac)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	ctx->cryp = starfive_cryp_find_dev(ctx);
+	if (!ctx->cryp)
+		return -ENODEV;
+
+	ctx->ahash_fbk = crypto_alloc_ahash(alg_name, 0,
+					    CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(ctx->ahash_fbk))
+		return dev_err_probe(ctx->cryp->dev, PTR_ERR(ctx->ahash_fbk),
+				     "starfive-sm3: Could not load fallback driver.\n");
+
+	crypto_ahash_set_statesize(hash, crypto_ahash_statesize(ctx->ahash_fbk));
+	crypto_ahash_set_reqsize(hash, sizeof(struct starfive_cryp_request_ctx) +
+				 crypto_ahash_reqsize(ctx->ahash_fbk));
+
+	ctx->keylen = 0;
+	ctx->hash_mode = STARFIVE_SM3_MODE;
+	ctx->is_hmac = is_hmac;
+
+	return 0;
+}
+
+static void starfive_sm3_exit_tfm(struct crypto_ahash *hash)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+
+	crypto_free_ahash(ctx->ahash_fbk);
+}
+
+static int starfive_sm3_long_setkey(struct starfive_cryp_ctx *ctx,
+				    const u8 *key, unsigned int keylen)
+{
+	struct crypto_wait wait;
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct crypto_ahash *ahash_tfm;
+	struct starfive_cryp_dev *cryp = ctx->cryp;
+	u8 *buf;
+	int ret;
+
+	ahash_tfm = crypto_alloc_ahash("sm3-starfive", 0, 0);
+	if (IS_ERR(ahash_tfm))
+		return PTR_ERR(ahash_tfm);
+
+	req = ahash_request_alloc(ahash_tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_free_ahash;
+	}
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	crypto_ahash_clear_flags(ahash_tfm, ~0);
+
+	buf = devm_kzalloc(cryp->dev, keylen + STARFIVE_SM3_BUFLEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_free_req;
+	}
+
+	memcpy(buf, key, keylen);
+	sg_init_one(&sg, buf, keylen);
+	ahash_request_set_crypt(req, &sg, ctx->key, keylen);
+
+	ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
+
+err_free_req:
+	ahash_request_free(req);
+err_free_ahash:
+	crypto_free_ahash(ahash_tfm);
+	return ret;
+}
+
+static int starfive_sm3_setkey(struct crypto_ahash *hash,
+			       const u8 *key, unsigned int keylen)
+{
+	struct starfive_cryp_ctx *ctx = crypto_ahash_ctx(hash);
+	unsigned int digestsize = crypto_ahash_digestsize(hash);
+	unsigned int blocksize = crypto_ahash_blocksize(hash);
+
+	crypto_ahash_setkey(ctx->ahash_fbk, key, keylen);
+
+	if (keylen <= blocksize) {
+		memcpy(ctx->key, key, keylen);
+		ctx->keylen = keylen;
+		return 0;
+	}
+
+	ctx->keylen = digestsize;
+
+	return starfive_sm3_long_setkey(ctx, key, keylen);
+}
+
+static int starfive_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "sm3-generic", 0);
+}
+
+static int starfive_hmac_sm3_init_tfm(struct crypto_ahash *hash)
+{
+	return starfive_sm3_init_algo(hash, "hmac(sm3-generic)", 1);
+}
+
+static struct ahash_engine_alg algs_sm3[] = {
+{
+	.base.init	= starfive_sm3_init,
+	.base.update	= starfive_sm3_update,
+	.base.final	= starfive_sm3_final,
+	.base.finup	= starfive_sm3_finup,
+	.base.digest	= starfive_sm3_digest,
+	.base.export	= starfive_sm3_export,
+	.base.import	= starfive_sm3_import,
+	.base.init_tfm	= starfive_sm3_init_tfm,
+	.base.exit_tfm	= starfive_sm3_exit_tfm,
+	.base.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "sm3",
+			.cra_driver_name	= "sm3-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_module		= THIS_MODULE,
+		}
+	},
+	.op = {
+		.do_one_request = starfive_sm3_one_request,
+	},
+}, {
+	.base.init	= starfive_sm3_init,
+	.base.update	= starfive_sm3_update,
+	.base.final	= starfive_sm3_final,
+	.base.finup	= starfive_sm3_finup,
+	.base.digest	= starfive_sm3_digest,
+	.base.export	= starfive_sm3_export,
+	.base.import	= starfive_sm3_import,
+	.base.init_tfm	= starfive_hmac_sm3_init_tfm,
+	.base.exit_tfm	= starfive_sm3_exit_tfm,
+	.base.setkey	= starfive_sm3_setkey,
+	.base.halg = {
+		.digestsize	= SM3_DIGEST_SIZE,
+		.statesize	= sizeof(struct sm3_state),
+		.base = {
+			.cra_name		= "hmac(sm3)",
+			.cra_driver_name	= "sm3-hmac-starfive",
+			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_ASYNC |
+						  CRYPTO_ALG_TYPE_AHASH |
+						  CRYPTO_ALG_NEED_FALLBACK,
+			.cra_blocksize		= SM3_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct starfive_cryp_ctx),
+			.cra_module		= THIS_MODULE,
+		}
+	},
+	.op = {
+		.do_one_request = starfive_sm3_one_request,
+	},
+},
+};
+
+int starfive_sm3_register_algs(void)
+{
+	return crypto_engine_register_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
+
+void starfive_sm3_unregister_algs(void)
+{
+	crypto_engine_unregister_ahashes(algs_sm3, ARRAY_SIZE(algs_sm3));
+}
-- 
2.34.1


