Return-Path: <linux-kernel+bounces-42091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1A83FC33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D32823D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4BAFC1D;
	Mon, 29 Jan 2024 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C178tCnc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2037.outbound.protection.outlook.com [40.92.42.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5CF9D6;
	Mon, 29 Jan 2024 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495200; cv=fail; b=tT7dtLZ2xhnIaH9MHzEvAi1Q66ojGt83HPDOxgkDd05DmkZo4SfFqa4b5in3nayRZxq8wsub7hXOYWjPbmkW68s80zSDGodP9gIbCdxcEHNv7SqVTqe8eZwMJF8QLfkXumR+7WkBqt/AaUH18IZ6BT3Bwc2MKAKusL9iF8GnW8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495200; c=relaxed/simple;
	bh=7cRC/+clZD3cUiw5H58EHeZ0lVY7oWAn/LMsWJOh8dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5Xz4ik3VJhpznUOQT/KVn01ljnn28eljfhYy3TdoHClYJMx/y1wQpnwQTmOAj5xH1cMgGOVosA1PQCcszRfVlE0WoO4inKg4SiWH00KAGjaDPPSuSlKSk0qJ/gquSr+ddLK5GH1cGAQzG0I9sIcv+tjggRU9NCZTbFSLH4WZ18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C178tCnc; arc=fail smtp.client-ip=40.92.42.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN6UuvMI9I10KPqmILV9JYy4ZjTGNT0eb3BzlsTMsnD/X6fdLwkkp2lUnZDwFU7QMzOmHhu9f2JCXiTEPWlbdPppJoqk+0JkfWLkBIFyxwb0MFkEiFZa8V8e8NNq5JkAX9+kZpGb6K1UNUG4hfmYhlWCzUVQxyXATt+Q7Z8uJieD5oYq+W2Wxl+DSZdvnTyHKPhHQUjzgZpJwgN4kqp5ouZOmbbAa4+QA73PLrTso0x2oRULUnAuPEKUxafh4jQTDIZdo6/wOAuhQdAiTko6klrtdKh4h43rNC3IEK3YhIaXFTjgscsXW0SZbYEPz+i1GkiCagxXZ6LnYeuLKeE/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsT3/OCeGT6IyEZbMCVRGXOMtTlwBFZnCqI+X3cSPC8=;
 b=g09Q1VdiexJ5OSJysPiTRQ5+bDakr/RXDhIdHrOC4VmSdePxmN8ydJbuwpbsQY1/IMRXdy7PQOiJNjTMzSCyrpVp40uX5DD8zLkeptndr00O21gvvtkn9/Kz5eoGqXzw/qZnNGKw0OkuUIWJ4HvDgZphAMKySeeICA1r7jdnqx/vhIGsElM2PcIxZDBS5mhKlJcXvVbegBFC6HtLzBn+RwK4dgyaJUgwdMMNQzK4SC4VikFsX0TrPUtA4Wf1+TXHf/KoNe3HxWZbKnFgLZew0WALCe0kN7lfX3vGJSSckgpsm8Nb4FQQJ42fvYEuuuOcGylTiUoaS3TvsxC+XmiI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsT3/OCeGT6IyEZbMCVRGXOMtTlwBFZnCqI+X3cSPC8=;
 b=C178tCncqyhLJM/vdl/uSP8OSpUxaQPJWuJSqEU+wgB1ImUjH3ocb8yUmfSPulSjzoTV9N6OgCAfCjhefJZpfcDYgXT1Q+IknVQg1DucLnbnlXybY+xVVbCxcrieeGNnqySI7UWHEBHTIsDdYAJWnC1rJVVWrWRnT2nFFJauP3fvYwC0yE3s1xXB8rAlX9G/e4yU0niecQJpQKixYE2d1wC1gySn+QDQP6jqvadYX6Xwjrj3/5lNUr8tevvx9hfjab8A97XcZpKpgefYhmOPfHOf2OWOJ+smJoW6fuporMsjig44XHjJqtxJkVnZuyaEr/A0KhZLviFAgvWXf13m6Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Mon, 29 Jan
 2024 02:26:36 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:26:36 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
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
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: sophgo: cv18xx: Add i2c devices
Date: Mon, 29 Jan 2024 10:26:24 +0800
Message-ID:
 <IA1PR20MB495349C2CF0B7287CF5C0093BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533BACE8D47590C1C341D2BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533BACE8D47590C1C341D2BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NDRsSf5XTHBi52A1ZQpLMaiadDX/nlbaSPb+Pj1I7qwfYDr4IzTTEAwbzdKQhSD6]
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20240129022626.8595-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4ee070-ab86-4119-312a-08dc2071b78b
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnp1wg7CoaBAs0v5f8cuw07Y9im1akbz+aThJ+7AZMM/dxYNKZYhqBuSPj8x0toR0GTiJelWr/C8JpYewWuIzkFYeHgrUcNv47MicNSNE71asirRhn17tRCDc6HVHS2GTjukHpoxVfvriEdGc2RTKDrxMrYjNIFPTYoLZ0/xGiDim7T5I7rNQvnpuVsPbdbZ9ZM2qMY4yx7yVoI/gR9GjkUB1Z+ForimLOrviTkufAWn2KUQ3BHycTGphddnM4P7+R/KK5baWIkvt4s44BHf0Y0NUJKFcxoIIylA+z4nGYfDBztz677uY/9edF+0vGXPbgrroEd4MvV6rmYek08wrzr9KtwJlJenM5+auKSdzJTTsZxorTz6P/Us/RiP46sxbH/NAUmqvuVDHcnircmYPg5Ff17X5tGtBr23YKL7WfZJlnUzIWeeUBspByN1QA3hjlqRruWvx3/kPEiDcLGxSnFiX1kYOK7cUTsp8PS/fjmcGZNWAu/cEIkpCl+W0ql+T6sDHCsy+MLOnzDdAeJuKd2ZENLM0bfHBiBpyDmclcXQebruOLGg1aHp8uvUc6poDKKEDg6WtgDW2KqDw0C3E5y+C75uY4HTYBeOTAWa0gJKXDvYZXUT+aT7JMybknn+Zk0YYYQjEV4gbvQcF1Tk1/YV62gBcy9tXF8S8uulxZlXjI858GcL9JK4SCIuDBIWlEpZzAbLZMNCr0g8hS2vHMh28pz7j+RPUPY+fVThHEL+JJsJPtXaEhWqN0Z0Q5r7Tcw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3VQ3taRv8QrR50ru6rztxxZs6+U5rPuDL/bfzROwdLYDNKJa2aC3HhhsgQ1KpYQIkwYyRAVgb2JuuM/miaTExpN/rRp09XMoxgzP4hCnfNp9J7nOVBZRU1L8qW5TJDvnUzocwGgl0WU9OKIE4hXlexxAkMsXb7152BMaI+5ce8sk5prgvFC8EhnO51MTkGN7MK/zZVL66zXC3s3I0ynr1Q5Il9quBFdl7wPAPZbaPwyQ5d99hq3nmLQL5AUJnfibT6e+uHcpQTMW1Cj4pcPunFuVREeqVLBNs042rL05B0BmhIqTUgzs/zPqkfFn2tvkcUBC5cqP2qnrPadwbubnd0cRs0ndyXJC8dJN/fDVl5f8S9M+PB5YyvU8+zgVskqUUlu7RLW5ruF89s9fY0b1A+bojJBWjmZBYnwOg6uJ9S7b7NQik8bujAzh2fnPvudcOMGPuD/GZtWiRtr9HlcWvbF8nGWuFRnSBV/R0Bt3AAs3lgCWbD4/pRtd13O89DSR7UpMdzehV1IUsGxpTZulplhdDFQfnsfOvNGVTMOTzyCKVlR98dCv5NrRuDpJ5AGyxaTPTtLNjT/x16WdPljQA4yLVLBxW3WG2LsJzthCXtc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVX/BAl2sVrEb3F0d2hrGMReVkSWc8pPZiYfOvpTFGlnulOaTjHsCVTc+hi2?=
 =?us-ascii?Q?UUlmvFpiXCivld00buZCK0+a+6w5KFdteTl+lpgwKgx79eXING3hLGP9fT0D?=
 =?us-ascii?Q?JSZI/2Xu0aXdxAqZwOYna8ypGvX1IMkVNZrDRlCGIImHLesCBBqSsjnfBSCC?=
 =?us-ascii?Q?D90PxPEjv1k19ovKAnjzZGkGH22PvrOou2YH3NqerrTS1D+zD5011BcdVXKa?=
 =?us-ascii?Q?aqKl694zz59+ymope5KfxRYdy6RM7n8e4EjbPR+IeAui6nn3+XmhPQ9mKVjI?=
 =?us-ascii?Q?dFCptAU2zrpBCbkQBsZQDoquOIeYxj0gVDe47T9I+O9L7MxTgg2uRv3ap5Ds?=
 =?us-ascii?Q?6rZoyBUwO9Zts6RixCbF31yoCZ37wEi0awpvlYdUzW+nlgIfFll1ECmZ2Hal?=
 =?us-ascii?Q?3ZeYCubCF7+YfJngNjiqDEZARZllBIBiNGuphoJRFmYVB2ZY6ti1pcUH6Z0N?=
 =?us-ascii?Q?oajM1wT/3rkPMiu1ilNTBJEJfgyC1+08ptc1+wRmBTVxHxXKhKwaKvDSpP5X?=
 =?us-ascii?Q?ZCo0kSFkTOk4EPy+vu8xDt7EebMEC1opkpQjT1PGD871IpuEbr47vSFjKigT?=
 =?us-ascii?Q?d3QDIFhNOIeA264hQ6Mmom7x5ASTzGeZ9mlZ0ww+ziehXhisXtHBOI2+Qdhg?=
 =?us-ascii?Q?OtxKXGBR/kkTi+fxk8IrpH4eMX/ynfl054zSXU6LiQVkKAhKkIdFKGz52OVd?=
 =?us-ascii?Q?1ysl6Da5eNLoU7l3N3eNQCw0Iz4Z02mEVKGz4ZuRv5m+Bsu6jBVa2EsYEOqr?=
 =?us-ascii?Q?REsyq5J9vkJ59sirJTNQzUeRAhVKQw8e+M88QjjcjvvHwCWn9NvKyT706lRD?=
 =?us-ascii?Q?ApKKZHJvzKnSvSBtkg7rYEOoVLrxIIq+umyvJs7D83ghd6PNhwm75UMka7Y9?=
 =?us-ascii?Q?fl9k9+OghM1ZVB/53wMeZSgkG7NNLk+VZ2xidPV3prPBSz2viCS8TBWaljNO?=
 =?us-ascii?Q?T/dS7kWEzJrVZKqJXJftTmxe512i92Dv6RlXuQKIGeAQEZbQpG9fQrgvdp15?=
 =?us-ascii?Q?CnXMDTsKY929m+FP5kc8IxTWteUbZnJapIrdE94JJr5EaM6jw+KkMtFnlZOV?=
 =?us-ascii?Q?uk2D77p+/Yu9BoOgQGBvKficvBpOmPwtDbF5bhGiaXLH+zD6+73aqHhjW6K8?=
 =?us-ascii?Q?uPgR7ayyXPkz5zknw4dhTGf067iVWQRn6DYi8r6F+VhqknNj86/9Pmq1YcgI?=
 =?us-ascii?Q?56oMevCrhzkUk+K/LoDc8FWGI53UNrM1ThK2Ny73mjgcs7XFOwx5AG6LuqgL?=
 =?us-ascii?Q?nBojr3Uf3vGPhpFuKjPRZjvtDZKE3FDJKgShWFdPfA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4ee070-ab86-4119-312a-08dc2071b78b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:26:36.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5925

Add i2c devices for the CV180x, CV181x and SG200x soc.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index e66f9e9feb48..d6eb20989bc4 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -132,6 +132,61 @@ portd: gpio-controller@0 {
 			};
 		};

+		i2c0: i2c@4000000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x04000000 0x10000>;
+			interrupts = <49 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C0>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@4010000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x04010000 0x10000>;
+			interrupts = <50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C1>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@4020000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x04020000 0x10000>;
+			interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C2>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@4030000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x04030000 0x10000>;
+			interrupts = <52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C3>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@4040000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x04040000 0x10000>;
+			interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_I2C>, <&clk CLK_APB_I2C4>;
+			clock-names = "ref", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
--
2.43.0


