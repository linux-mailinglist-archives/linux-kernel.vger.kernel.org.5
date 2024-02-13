Return-Path: <linux-kernel+bounces-63108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C93852B08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B1C28364E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637822097;
	Tue, 13 Feb 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ne6ed0zo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2058.outbound.protection.outlook.com [40.92.42.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44724B59;
	Tue, 13 Feb 2024 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812596; cv=fail; b=fkzWfrZN1phMA9xz6vQU7/Z2gbr1h7yzhXli6vIMXfr8t4a2oLGlpINNKK2DNZWxzELbmb0H8rKh6faOzoKT+iPgE+q0XoAft12eQS/AsCL8tjTQLkkeN0wf8A2Z/fU1wjGkvrwLIeMClHcaONAjSvGx0YNlBZs5dJGOXHQkchc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812596; c=relaxed/simple;
	bh=Vj+5ExNGqlLJC0l5yZTNfuxA5U1g2/FhixYUSCnP28s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIsk87nUq6NKVWSbHwBWaXb4v63ET4rszWH/HqfTa1w+0MFp1Fm1peIbdEI7ettgdTlqq3UPVPaENGhLnFf+cRiShz6DaVRVxB/2QvADVxh32zbIyosRQDgs+RVF1uUBQQPC84EqqO5j0RgQ5iiNFrfaKuiw/7elYFXSiiDW3g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ne6ed0zo; arc=fail smtp.client-ip=40.92.42.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egdy6A/xQF05ubgCVty2I/yMI3cj1YnMo494xgOLbRSJpB8Wn+dHI0aGAvemKpEYLqBPe1+LyYLibkoSTDulCARI3DaT7NGuUGLMIAlUA+NPYYsviVcVKaMPix7ZXBIjwZrukFaAvGx9RckLtOGjaDlHJxCUiIlpQOOakap+v+nZXUg7xDqaEgktK4AcFoZazXXvdwQ4mLpo/KgbYLxdTd6ePlmiBNmxmrp0tIPWSEjQZYj1LAhb+8Q9drMTmFufCJq88KDrG8+Vh/WVvrI9rOy/PKUzKQvPVKCH9PnTyOfPNsmos0y0cCJbCpVR0zZ50+tB6SRLoddhLfRjJyV02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJr/B/Rt675kEbLkTjiTxmMv4zX99+wnqj4J1ziWw6U=;
 b=aCQrYFEdXcvbyQ5TmsRr63aDmh2gDfq1GE8Tg4KlnizkauDBQOq33lUl3L1dcczu7Ev8cM7duf/ts++XDIiM+PezWNvz3OCmlB7fWGKmXvTPNn/LzSja+fIvxlZW6tC4oSs0evwbW7rrZz5bbQfh69JBPT1702QFfa6vJt7CozPxi4lV2Ir2sTGaD14DYikqprqFEVtjlmEU8xQkDgdlCxUjMV/IvXOIjXYnJgOk2yAtjTX/HJJ+bNrl4mY3hOYwOpSDHtZrHks8VWBhYxl970HXQTZPcvJ4DpQuj88AnEm8bg86gN6BllOgAZC+RekkBCDYUzshIl1zKd8rBYkaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJr/B/Rt675kEbLkTjiTxmMv4zX99+wnqj4J1ziWw6U=;
 b=Ne6ed0zoEgx8vr+GljfgBnOWEe3Qwclv7g6wrNWLHtBatqL5pNobdwLXYZZY7Rg+9nt2bFHuCrtPQv9PyxZH010qwMd2UA47K0xGfNiMtbPT1VYg1sD2/8d6wU5cUeyPMTAbRu4MiY5NqkRt0FjxTGgFSexe526yKlatborpns5Dtmb4+ObU9Z9cL+ZiFj+oG2hRGPth7ntKejkMtWAIu09KP6gNNzZQ60eu+e9Layu6D48uGX0E0oClpDCrij1hBnLmskpe5lDSZ8AFJkxIxeEIdhcjTgCjaIBqh+ooJEAlH0lhNIwUjzSI7i0m/tbFQrO7zISMrzvLcOsV2iwTRA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:23:13 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:23:13 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 7/8] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date: Tue, 13 Feb 2024 16:22:39 +0800
Message-ID:
 <IA1PR20MB4953F9AD6792013B54636F05BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HOSaSdfQJCXYbxjiMOuimOj5F6OJMhHy8klDkYL9vFdHSNSa1drSGrcJfyYE6Cez]
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082243.591875-7-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdd4452-1bbc-4bbb-f6bd-08dc2c6d053e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0DAeb51JlZukh/GiozQWXuomseUfN5ZXA0kV5odumBXyUAqAAzwRSy9PwltpVNkOl5FWYMc5uflX3JcxTeAEB7sg6GdszEC7vqr0GWURKagka5BmL0Fkn5iMZncKI8wHSAiRNR85ixEUxWHn+m4CnFNdDhpvY6Pyn1FFFs6VT5ZXT32Fee/W5+PiExhIZH8Y1G75rAcJtqw4gUFn4pF9Mlgt1LDQP8H0QJd4R/z8hMpxD81QI+YrL4DUCsIav9bmjDM69Jel51As5hR7gfUBK7iJEoGn2QnDddqOUFotVThvWcotWZACY26tJGkXYKf2pjn8TYTJz5p5VwQzy7WMftvkPRcuhmPBrrDyqcbhCatCiRvJJ7rb49JEY6M0DeD/cqIGFVNOE98xUsONkCDHd87LMz58cOG6a4b0tEnrhJ+aBx9m1aF0LyyovqUcXo1WngCNIUfQqtWHY35GrWtmi1PjzI+c3V3MM//rpH3svF/WVxfOaO/p68aeNOcFtFX3H2jE+ZvZ8dUe1rWhNn88NBHA7PfqJAO/8Hz5nlA8e9N5vQ5Jgxn//kCsrn8c6y0+Ikf879+iEObWDp77KpegSjA23RYQKi65G9NfhuH/OkQWZmGE/LFcV0cHs32PPlHiBsIEnBQJYL0mObg5yXQd4r0De8SN82ZfSGq+DPk3+kE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvCNKMbP1iPHNtIeTgZHuE02xS9jaWkthaHl9fYGPhU8EXvSlIQGcgZnAczF?=
 =?us-ascii?Q?2+POJ3+lbm71ejomohGxbdJ1GJrOW2OfjuoKy83teQnLgNzlhOH2ErZmPmN9?=
 =?us-ascii?Q?vq1Qq5cgz6Ctm+0AjycxnVNcWTT/Spotid9CE6vf0CVuXLgFz39043R3nnSe?=
 =?us-ascii?Q?wnPlFJON4XPqgYOX0mQY2/+hqG2KP/6NxFIZ1kfp6n/qfFQOmgNlfdbazQsU?=
 =?us-ascii?Q?ttlakPp/KQi+ZTEI92Uzdd0BdtL8hvOxprZ4V61Mcxd/Z2B8cQzfLYqweHM7?=
 =?us-ascii?Q?SO9FpnX/d5ZRX7IJUmDHwhLfSKXgq98FoCFAjlagzbJQV4fARQwLzMuJz0EY?=
 =?us-ascii?Q?PEaBXbHJxYyUnT6SkzC4E0zLpmRWTPP+DOf2eEP1s9wq8wYyVF1j7wLVosQs?=
 =?us-ascii?Q?6siY3cZlBcWxmXsw2yyL6Cn+Vsgp1RIWVND3LC2sDdf0w9cMmzPqaa91htL0?=
 =?us-ascii?Q?gLwnoCTGmuGjC4o/FU4ES38SOuXYzVkaP7Bkk2AGIIGD8SFTDdjfpsZFGkO+?=
 =?us-ascii?Q?jv2KhgFBf0ese/yDp51t41cFhwXz06HLjM+G2uDqsQ3PqDVddV08m6gSioSt?=
 =?us-ascii?Q?1Hrg5r1jBvjDoQWALiPl4s70pqTyfgWWj4tS8IfpSeepmYtXq0eY5lJblMWO?=
 =?us-ascii?Q?CcNHIG3V0RL+uL7CY6E6K1l4KmdH6pedy8zDLFwhKwnajtyIM+G3kBGeEszO?=
 =?us-ascii?Q?HIEVl50pbqhshZUptjEx3Tiev3WXuuAf/KBONm+VJUx4rupWU+RYf6P0Vm4j?=
 =?us-ascii?Q?D2S6GdH4mTDNKBYnF5zT0ZCEOh7TKd1fwiNPqDFF0+yNCfiUcJ1R9+dnM4Az?=
 =?us-ascii?Q?1SOoaNeztUZoWRmG4NSilLyPn+a3hVQnXQEHazy1aEInhAXlThl+V+4/+z9t?=
 =?us-ascii?Q?zuT+KYyDOoiZZimJoXg3QjvugrMyeezjF5OVWBlxvKvqqBbHDMn0gqqmzff3?=
 =?us-ascii?Q?a3j7puLP9b2tX78vvXdO74P/1MP/4InHhloAT58xKG2D9vzd4UW/DFRam0nP?=
 =?us-ascii?Q?XxMYU5o1d3kq5AO7VFr8vKg7lb7meMRiOOLCaKHdnf99D1zo8pg3Vzj5WApc?=
 =?us-ascii?Q?oQ0qVsjF1H//zGUL2e0ItWBJr+tRWj95Qshx7FKXbYg3v7bNTROq7h2Rf0tl?=
 =?us-ascii?Q?pG8igzO7vVEmqxwN5sKIwpwB8oPO4MNhsRpqvTMeEBLtPY868pEH3GSd/WgQ?=
 =?us-ascii?Q?EedOjpQjEjBCYhUTXITBZbaw1PZfikw6y27597Jtnp8SijwP4si0aebxlfFU?=
 =?us-ascii?Q?wQVOiNL8zWdyX6d+ByLAYt/V8jiXMPUad07Z66VRvNHksthHS0OnXEWJa5ba?=
 =?us-ascii?Q?9Gc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdd4452-1bbc-4bbb-f6bd-08dc2c6d053e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:23:13.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

Add clock generator node for CV1800B and CV1812H.

Until now, It uses DT override to minimize duplication. This may
change in the future. See the last link for the discussion on
maintaining DT of CV1800 series.

Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
Link: https://lore.kernel.org/all/IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index 165e9e320a8c..baf641829e72 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -16,3 +16,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1800-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
index 3e7a942f5c1a..7fa4c1e2d1da 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -22,3 +22,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1810-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..6ea1b2784db9 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,12 @@ soc {
 		dma-noncoherent;
 		ranges;

+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.43.1


