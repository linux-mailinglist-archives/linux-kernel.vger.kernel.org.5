Return-Path: <linux-kernel+bounces-57334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158C84D71A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6CAB23A20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10E12E7C;
	Thu,  8 Feb 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bXR3trNs"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2073.outbound.protection.outlook.com [40.92.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DC1D68F;
	Thu,  8 Feb 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351743; cv=fail; b=DQgOvKsJZm36p69RAA6ESw0dL1h6dV3rMV5MoE13GaKX8LmMsC4oDiRN4wnvqZnl0tnxKs7U2dNdRVpNV4URYW8HldtTnCTbTgeX7/3NsxMfKX+CkboW1Lz+jPevW9ZVJdp1ylJ5qpg4AISCsxmyPZbEariIAzO6DeSbQ4S+s9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351743; c=relaxed/simple;
	bh=nwdzLIgUq/HX5FjrPPAbKhyogs50Ncnegd/7iamRcWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2ZauZuJbIWL6jXmEMr3lOae5wQdqRP+3jP+0f1krEtowZrjmmMKLgrB1v48IKmNPG44PqRhrI6hYbOaZ98ptc7/khhSL7u+MUVV4hbl6fQJWg+TFgOhPCS6eloPRMsu93KxgQELIwurzBPkzJTK32sYC9KFT9XkGEYNaOCGbVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bXR3trNs; arc=fail smtp.client-ip=40.92.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvwI/PDLFhgReavOG6KLkH43a6rm03Sb4bqnv1pJmwlTrB41otwpPsZDzT4e8BmPBowde2QG/VmZ6qSrBzkXuauE0QQ1vl8LqRFX4l9DkZWo3OPuNeAV6qrrKuaCAwZB8HMIh4EnTO5Wz0+rFBNWUvaWMAFGtZHsBH2IUux6tByC2mJoYwoC9k/gidn0ihFetNMjAjcqLZvtw1mYBMivH0JvGr0/uTZFKX6XzmSOsyeiTy2Bmm8zFp4SQS7HcxhY7hxvGVoQiiRc1q3zm8FEos/tUQMTAxIXiqKzrYYx6+KItKj24EV7WoSL7TRDatneFzPQ3tlp93bi3i2AR4RuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6InRqzkFODSmBhWrxxiMaDOevTd3H0JM6PSJTBGR3s=;
 b=g79JfhCo70DPtv+tWaJLA2JnI85H3mktp3bUOj+caTog5CK+aiI2M6KJr5Gu1v87wvFjT/ISFztX86kCbztCpFtM+8o8bHUwkRoh9oRiszWmhVhwi18b+G6AibFm5hv8D/t/OKYnRZZq8Fq5/yZHww+ApkRtvOYAKNdh0rN/QdEtG+oGPPRatbDFMu8s0PgK0nc0DU1JcfJ0ITmjReMA8WLC0wLLjJD370D3WTP0BwLAnxbSXF9Yng62JMnSYGX5kvFUU4QF6Ma1nLIN+zEeD0TajcQKwL/WLztypbDdrCT6aNWwZBduvnurB5EBdmvGRpenLGXAHExpKpd3DfmYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6InRqzkFODSmBhWrxxiMaDOevTd3H0JM6PSJTBGR3s=;
 b=bXR3trNs7cnepsVI1YBAXmS0lK//vDsXJf5xL1CN/CrmW3PnUgu9IaMmFCEluSRc409o6n3PHdrIlvGRJBGBy5wvjQSIRtP3HwiLBbR9WH6bwTEQ/5CknJ7G90uVFbLwBpduLZ6OdsrRq+1ufni/RYzTjLk/4CvI13eHiTgp1MQ65JzWISDK9XPsK9qZQosOW3A7jYsb5/3kwM1AnDzlXrRsidE5BzMQc9VGSbOEgnJYR1dkJOvd7bJjBR77Uh1EsWCa3yPIv4Gkpvtq4BtahRey1AkGhJxiW6NCScByr+kK1AL3itdaYmSI6XxSTcKTTHF0m3wdfa/LAmxR3cOqQQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6986.namprd20.prod.outlook.com (2603:10b6:806:3ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 00:22:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 00:22:19 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: dts: sophgo: cv18xx: Add spi devices
Date: Thu,  8 Feb 2024 08:22:11 +0800
Message-ID:
 <IA1PR20MB49532705DE532BCF81CCEFD0BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49539A9C5F5CFF6644ED2C2ABB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539A9C5F5CFF6644ED2C2ABB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5x2+T+kckGB7eaTvPu/qiMhrLPDvy6vWPxZWhps1m5OT2VH0WRMYQKvRkAO8WwkD]
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208002219.162732-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd377f9-cc95-461e-1abe-08dc283c02d6
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnqw99sp8YlJuUUStbhLtmajhDc4b1br3RoC2lqxSKHnRbCia9aD5Ooz5vfcXren59BPLgBjDDUSr/b7flubNdkkua1HU6qO/TN7qSSDA2WB5wk7srEykf98/tF7k0T49D/Iq6lxMyf3s0T1Hq3G0oz3RJ04lzwEhX/ws1U0975hQvDYOcmyeM5POMqwq1a1XoDSBkYEruC248RyEK+MQpmuaETzo+QONh3Sbz94bddEKHKPIhzrmwJMm9JeH1zK8uRlq+V6jMsaKD7mv8sEyrdNEsvqy7Ikl+IeSVdcu1YovuKObECzc+IENrg7YKknD/30YTDVgbM8FuFcuE6XeJF3tRbG0TtAkhDfqtvEoGlsfviUF7HnTbRLUthCHM6Tmk+xlQmuaCRgdbi+Obd6/JxvlMRyo/kBi/5lO6crY/xkrXv+VjRZT46vycgbf4VafC8TfpYLdebbQ2m0Vo0ancNWavqVjLTpN5/f7KQQaEX6nyNbdLFtYlgAikvvaHee7RzpnoPkuFFy1jBO8w7RIEX4iqLovFSKM5RQ36M4aqud0mnKzvqgdOxxcrq0BSUkNuc7sorCHuYrk1Lx06fB+EveEQSCdGDiECZP7bKYRwCudi9TTfk0A7/JbPo1W3He0kFuDvW1b26TM3bRPXj+sesUdM06WgogwtmPkjo3Im3RRrohBNAaVin480R9K53xI4s2dzlpGlc56UdAzDq2n/01wZPg7NIerRTvqBFxcoixu02+o0/9WCaAl2uQDPlTzKA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CF5a9bt6RXwK16rC1nspjfzZB2T5THBntq9sqGF/CQnIl7riyHAPOi9b8jXTgP2gmKboKPuElG7jVI+Ssx3A+mETk02I/1ggBOBDrg/71ajndIwgawd36isUf8R2mJwFYa1YBIiYcZiFSkJO1/PssnU519WSK0JgYDsO5vIlTpmUwzj0xtxkS/IK9/fSKoplSWdRjOiOJ8z1Ao2y7jBpCRURpS0+czicjafqOg06KpJmBgzULFxIUC7eq1g6kUSM1aYuLF1NY/bJy6N8zC9JbeLDEfLsqK/hBfXFfWU8YNcCTBLCto5eRRZp/mWYloKzglzl78j2SbozsN4PzZLEamVBQ33GdK4P3+ortTZEjSQYYMLHICAnqlZeWpUPCcnAdcl5VXFZPamY4Jz5ZeV12u/H0OUBBVOVzs+J4wkMP3+Ik58bbBO95h/evzoJ9YkzFnEpjO1H76PveHqrHsijFD6k5WBpmmRo76nAxdSS243k3zUaDyLSlHsLdSaiaoV6br+/2vvrcVAXLiE0asonCvdOEnQRWZAskwRLLvPysnIEBxHIFNAyzpJLGGqoEt60h2pJkq7rgj47C6uZnghHfjMmAfSRXYIxcXpnnd75PvXR7OCnAhqiCTIWdi9zKttS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDHtUPSroRCHNHvnq/R6T94Kcd4RxdQ2+79lRog4OqFjbhDWRmfeqP8K26Un?=
 =?us-ascii?Q?Y3TnHqWDa0nkIqUaHdMDu+4fx9mrEXHF+z5R8KJPSadCJQsiyuFl86cYU+lg?=
 =?us-ascii?Q?iTmuLzrGUxRgUKauHCXHoE6ERSTM0qOAaEx9vb0gYuBVbUgdMZqmDQw9oKRw?=
 =?us-ascii?Q?mAbvbpEEB8CmFP65tIOSovJeZb7+u1Hoqd83lYzwZs/KdRTgHuXkiBRVR28n?=
 =?us-ascii?Q?GZoWnsGkrrYJ+DYGjjUvOLvY/+4x+5+Sj5B7ZBw67lA54RN83vuYRMwAGqda?=
 =?us-ascii?Q?/ffaAtNVH0TN8oy23+3PU/4myfzJnsTqrpT7lZeDSkuTGmlKmYkGZObiD4YS?=
 =?us-ascii?Q?0aLMkMajzilUwZ5S6V/J7+4Ta9bFj/g9NAlYYyG/ngyx4TpKkVyjY5X4DzAF?=
 =?us-ascii?Q?SaZyHPbr+tBRHMZh9t9kNevAk7R9W0qiaobMt78eXRqoXkeEAxAUanhQ99Qy?=
 =?us-ascii?Q?NOebb4lwLQ4r/z6B6qpZX/fdqD3bYDL6Q+9u4J2l38lYj7907etkXjsYoF+y?=
 =?us-ascii?Q?qVIUVcdL2ah9pKjeaLO7CXXvlH2En3OFIUa5df3FVB56vW0A/OZi/5OqqPDH?=
 =?us-ascii?Q?tJBFzGsrKyDAZD8izKWBrhbKBPwKQjMGDyVY9cqyCUqOaKzG/J06H2Trjj7J?=
 =?us-ascii?Q?6afVmiEkN6r7ofVFQhlOOWjie8P4/gO2IwyCgr8IID4GEsQ1Sr38YxKA7s68?=
 =?us-ascii?Q?27xeaQKOsjGpvL3kfKPVGI4cT49zZPDMvUC44p6WbDqGrIM08p9M5TJlLDnp?=
 =?us-ascii?Q?nvt+ThDjoQLmAk17x0OlXDcJDaUz1T4djbplZ1UHJCktYvtVEsSe00X5c9Zt?=
 =?us-ascii?Q?VqZ7ayw9UrSVrdVRGOdcZeBubYXMLVnGLtroHh6vOp4GTmLhMu1dwbOXEclN?=
 =?us-ascii?Q?V6wtcYr4PXEm7VRjEMS8mahMb8c2K7GuJupEjev40kOF6z/1SFbuGF9y78vX?=
 =?us-ascii?Q?t3xkRfDwKLs8JluObd885MXBbQ4yQPpMsPGDLVJNexjKoOKRdc3YtV5eH/0n?=
 =?us-ascii?Q?/SruASLjdkLMqOwOAjhls2iX1Wa7Sb9AhUASUjTck2YfVp9thnmVLwWbEQXV?=
 =?us-ascii?Q?HpD/BS7DVpBK/oEgxfXLhDFk1co5VVkbwvfsebOg10s9Y9EOsf4pdXTymea5?=
 =?us-ascii?Q?CMj20H0TrKGLMLfDWw3OiSXkWJAqztQ/2tzqMzAzSHf0cAQ/aTkrLPCovXAs?=
 =?us-ascii?Q?GNLZotGj+/Bol9CrkSl8WjT/9nL0HEOZ6nwVvt0PPOGMbrnBsM3yiGm5gjwb?=
 =?us-ascii?Q?EpXRaJeVY8OyZ6/VzyN99kI5mCNiqjcuy93F8OBYlw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd377f9-cc95-461e-1abe-08dc283c02d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:22:19.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6986

Add spi devices for the CV180x, CV181x and SG200x soc.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 7c88cbe8e91d..71965cced56f 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -176,6 +176,50 @@ uart3: serial@4170000 {
 			status = "disabled";
 		};

+		spi0: spi@4180000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x04180000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
+			clock-names = "ssi_clk", "pclk";
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		spi1: spi@4190000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x04190000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI1>;
+			clock-names = "ssi_clk", "pclk";
+			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		spi2: spi@41a0000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x041a0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI2>;
+			clock-names = "ssi_clk", "pclk";
+			interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		spi3: spi@41b0000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x041b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI3>;
+			clock-names = "ssi_clk", "pclk";
+			interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		uart4: serial@41c0000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
--
2.43.0


