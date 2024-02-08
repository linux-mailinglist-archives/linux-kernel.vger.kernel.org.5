Return-Path: <linux-kernel+bounces-57668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4995184DC01
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B215A1F258BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A971B54;
	Thu,  8 Feb 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bTIo9Wjq"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2027.outbound.protection.outlook.com [40.92.42.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41071B33;
	Thu,  8 Feb 2024 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382174; cv=fail; b=tadjRQJSG+f8PECs5cgia7kZkIULWDWcHamunQLruNB2MN5+vE4LGaUjIZQts2A+PB7DFr4mdso5NYU9wZuPL9OtKXib7jiNYNcVMUkIEBJEAuC5G3hi7I4AH9hDAh0eFKlN/iFyY5IF2vbCU6oxUoV6z4Ai0qem8j081z4X9QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382174; c=relaxed/simple;
	bh=nllykbXVx17W7mhous8lcNkdwYjwQKDOgsnBDjRdWDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eSlH7yOPAcq++aLhQDDrywbjv0KA7acsJ1Mjd5sMTzmQXVHJuWy3Y0x0VlCceDAhwihj2wnKWedMu2tJpezGXLGOedHu045JCyiQJGNieb2IInFmWmo1ZoC6gszu07ftts85vvNzXsrNrrvPwZpwLM8J+a8r+wwfJRFmJ6clS0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bTIo9Wjq; arc=fail smtp.client-ip=40.92.42.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF0AEkWCbvkq1vv8IH4lDvV94/b2G//VIypifD4Np8zF7QyOeThZCkrOYIj9Hcj2TzJdNdQD06Z2R5OT1EOVTgaaEBkXGS5SvdfSUfpTQXzLpMTyQ8QZIGfvdSdjOSfW9hhMI4Ze1GEapApZXIRPio/zkLLg2ToixW75IA90dc1HJtsQUteWbsvMX2iZyXWvpl0+l1fQwg4f8bUSEXfYPny+2AOgYXHunN4rcfco7UGfYzZhNMi6ph2/rns1hn7hjzITP0uJehI4mQStnXaHVK8Vi4QvjQCxTpF3GEyvhJUDK8QVcpr+fZnkxbuqKEyFUtPvdktWqEvAiqSQIMw0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDlCjmX3IIzLx+NL42lramUMPeMM7ylcL9s61Ug4/Hs=;
 b=HWSDFk3TJUdnbobRxDcHzXj0jwO8Iwe3Y+SUBdFn673GuCT6NIPA+XbcVIZnehljfVzxinvmUf0CTLNTbZIa5A+WArQmLQ7MiGWH+ixGtaYN4/+l8ilk9tePSoyUk4NNKohS4M8qSpHTYnDGRuFJRXwGDMzGqRpVbwWV285EHSpMjs3WkQWsjIXALVRvXPmGYxSWIG+7jRTBIFoh53/0zb3UtJiLNajDdmzGSL1tiR7VFJsmYvJ74cdmw2L3dPiKA8SKVVySwLXwxqS4VaBDkP899QGJd6qvcG1ZsYRhNtIvUn1apjyb76mmY43MRt2ItTtg0+/ACiRt4Vc5ZJc/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDlCjmX3IIzLx+NL42lramUMPeMM7ylcL9s61Ug4/Hs=;
 b=bTIo9Wjqvayx1HuOdVTgpgill0Onn94RBliRA7STWSb0z0sX+vnqpjHUpX81op3ux/TduM0QJOmFmASfpSSEL/uxnJxZDPiOXUMTq2ifP/gVO+8nHc4KMrLpRkKQzBZzg2ax6jKpsbkmqp8MdHWW8INsd1IAWLVfpFFx1cuWybnEyRiPcH1AoJYnQBWF2CNm3FjybXoTbWJVKM0wMyy4MeJkBG0VtKz2tLzeQ+wIVARv18uR8LCTKtZN66jilo7yu4TQeAdohvkhAB2Y0AzBcDnp70M4b+JGkl21/To0i9pbAYdhO1Zsi2j00YFLX9sWb+jb4laulCo4cJ3e7AnshA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:49:31 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:49:31 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v7 7/8] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date: Thu,  8 Feb 2024 16:48:55 +0800
Message-ID:
 <IA1PR20MB4953F04D2D282AE7BBEA43ABBB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2dN/CwoFlMf8DHveOb/DYejYwfGlCAK1FpuBlnH3gT3XIG1aXRi2qXFT76QTeIHK]
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084858.1113628-7-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 489d0860-8ea9-4727-3d91-08dc2882ddcf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jf/Ym92TGYBMGvXY5Qg+YbdaDVbBI75S1u0ie/FlfqRxJ1QRRvv1vsjpItmwF3UYOi/5Mk7SNdhJZWTS0lVAYdGbvC/4Mv0mSdhsJGV3acTrU4acXXl3Pa5GcxbNJas62hbp1L1pgrTWiqVO/v8Wj2LeTUmV8sXXQDgxs9xbGO3CmtbU0DpWvDhDiqRrApLoASCJDSFdarxgfUNxMPTuYdNWab2MVXrCf9cIQGjLDdxMwYTBACA7Dj+4R4KCWd82QovD44VM64t+mNq+L1ZVIJT03cidKYaz8QOnu6kGI9xRxa1cpBFtNqWFnQkhCm6mr3KnLzsU4YGqw0M0ZoMAYUSxJtebkaCRV9eZ/UpR0epEjNuvI01YIZ7HUtDSRObuDmjNHiX2+8rFDIVOjj9MXUHHhvC1Y0Ge1MM9p2+EOrXa4I2acP3PDVYQDR2ViLU20givz1KjkXX/TriWRDNPMfayhPq6WGDNRfmb/8PoT7AHJrSOJZqv+nf2ac3PmR/Ax70mNblgoIlgblZkkHNyygs5EEF6HlK8gk27Nr6uv3jsb+Bb84K12YReuwwK2rZDdkGwW/xHY0koZv0UktoVq9Hz5dtuLnLrdAfhrkPGbYqWBYbFG9HBKYpuUhRqTptF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsSEDdgkXz+Oipy0TbAlbTRj6Ayrgnc0ghmgcE7NBMiIzKWxhXwrP0767XfR?=
 =?us-ascii?Q?fkXah2a0tsXIEsKaiAd1+P+VuAEWsBZxdAS3+01KlvNqYGdL4W6lOaiUwuv7?=
 =?us-ascii?Q?WtU3a6D2aLEYD43jvqrSqLBLBvit19WkX11MmFk2zYtlAfcfWXK+zj8YOZ1U?=
 =?us-ascii?Q?WkbmWglg715sy6l1XgnpvFjqlaghoHwXiEy0QbgMzlOFH/iw0uVko5ryVrgN?=
 =?us-ascii?Q?Yn6hsfSxjNKsuJUmXroPOOdu/DrI8QIbcWLO/+uf92p5o1uUhy9fzzYl+HeF?=
 =?us-ascii?Q?AEHFpEZy3D9xFGANmIxc44j+txfhZdkU6kFv3mddT20pEQpZGy6Y/IcEPzIK?=
 =?us-ascii?Q?0ZDe6p/y2aiA0Su1b83saveUWphiWGX4MyPQNKimbpA7HrhUGDWZuA6/rAol?=
 =?us-ascii?Q?9xxxafZkcZjnUs0D0KB1+Dvpi4sFR2DQZWcRfO8NCMLIdRizWChIl8ttflem?=
 =?us-ascii?Q?AYD+tAHYhYs6uhqUMo+ZaJNwVGj8Lb7RIVutXSbqLI+O/Fxo5OG7xHE7yv5R?=
 =?us-ascii?Q?F4Y2cy1xNJlXinnHDeeTogRB/TJQCeyRrMuRk5FYVbeb8ol4qo3EYqcgMe2m?=
 =?us-ascii?Q?P1VWzIZdkpiKL3biqqHpkEcwfNwbzAfKaE0P/5lyFMxuuaK6grOvtqneyAUA?=
 =?us-ascii?Q?iozyuED1haNV9Xd3F3j5/BVjU1P8z5LBztamz5m7PFCw7NcdOKA8MXobyo5Y?=
 =?us-ascii?Q?kdA47vkvm+9reB3PX6/PBJf6v0NNwexzoDojO6VkjXtvPdEipZmWa0Gtu8GB?=
 =?us-ascii?Q?9U4DoamcV0A6z3gxSdvck8RVVQ4z8CMWUbnXygbceWNoL6JPtTAw0DQb4zNN?=
 =?us-ascii?Q?G0BOKBusjsWR1EHF2LPa9lWA+Mt+OXfipA5jPsk/0nroZppzI8NFF0GuKNk/?=
 =?us-ascii?Q?IfPh+iRmO9ibCkl2ScTZfdQLKSNr423v24GDjTJI07Xh8LrSS4HUJotYa465?=
 =?us-ascii?Q?EH40O6uybvjIYtcq5TiZOY7ygUl9mEZIbTVy3hWMeYYujHh7wBarhN7zfwGp?=
 =?us-ascii?Q?sd3og0SodAdWALNHDI13vWRYWmlIsgwbLojO/ruGqm9LQZC7eHnAixF3VxHo?=
 =?us-ascii?Q?wnG/emer4ro+sGnanBo5bL6Nqv6N8LwTEIRZaFIxlWTbO96TlTHQlNH+sVaV?=
 =?us-ascii?Q?mLrkVm7rOBAjM46KprceK4Fv8eS4i3TVbg5eUt5IzI0SjI2Vym0iJ0qFLSgS?=
 =?us-ascii?Q?UMOLSBKq3Q1A88m+t8lgL3dUQV+so5l5yX3O2yxPPlqbfWV5tCMbuqIbP4pA?=
 =?us-ascii?Q?3lgJ6Fa+A/7Wmp2D8HqFWj8ywGxeg9H2SYDmRBivDg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489d0860-8ea9-4727-3d91-08dc2882ddcf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:49:31.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

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
2.43.0


