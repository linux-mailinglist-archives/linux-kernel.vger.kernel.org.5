Return-Path: <linux-kernel+bounces-167036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0818BA3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AE82840A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DC2D045;
	Thu,  2 May 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="j5vsGP7U"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592D1CABD;
	Thu,  2 May 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691328; cv=fail; b=QQR36e8NNdLTD7vHtibHVV6M6+ZlYFf8+hoXCbJDl2ExygerlXiEoUiO87ESWdoHc4vlTycjoufrjNDV2AZS1/w5JxXF6fPj98mxvBu5wPK3nCIucM5KNUvVFoeCwgXIcNbQFUqdCk7/6S0SKQWpQ4oCDhDqpJEtOoVDH/5D8ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691328; c=relaxed/simple;
	bh=Kbmh37jMjdCPkY7pGxF1REtBBORsInfVkBz7pGmRi/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llRhmX8xKqBbue+FLXf519/Ys6UjMv2wzn7h6vYxd57fCkKwFfIHBX4swjvc+dpvAyvL5P3Q/jTMdb2GZFjLPK+ZPcQXsaeJhHSHq8qGHcmKWknVSDls/QvyLjtDYHLuCZWjYbn36tLkYBU2fPsCzzRwtZTojyWOdl+Qw5B5xF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=j5vsGP7U; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkdvsT4OpsYkN57KQQp/Yf4TcPQPJcLn8qH3bhzwcOO7zbuNsqy0Zpdb5BHtqxD65h+t/UtYEPmAeNJHN3kyueAv2dP/SIYuX/vGwmmP6gEYUnoBAWpWytaVLDdmiUsYX12vd37Iy0ktVi/WRR79l41ojWi0m7K2LzVPlDTs3poRddrCpXPYFiFPGp9y+oIdhJNLbJ+fV2tlqnnOoftna3rn0Nn39WVzJiZb6iGZM3PTOsRXlzov8tjAuhpbG3JryungIR8KSNFQ3E159wWSyLEcdCyOx2YyPpy/F4MACu2vkTzJbuCYOm8D47ZezgHwNhhEfhbo75GClVkwV4oGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SJp1wGQXvNpi4BilaNmpuOeT9cNuHnD5xU85Qh6ZFk=;
 b=RsYxwesANlmT5OvRJ+OG57n92qN53pqfbidg5Q2GFBUxvfR22gpBMRkXLwELT7I/E5daj/fG95n6/ttYv+u6Ujt/PBAFx6wENQL+BZZP2v2rWaCOBO04eCwBbQiYNebNgb574Q3lgrwhr6NHDI1ECg+M2y3rKJTAvWBfOVfTeKqsrKQW/KK6487/ULwSr7RVILdWT5dP5PNh9pGdt/lGrcuxdC3G10Rd7j+0VtYDGrQz+qD5XW5NPGAfsas5peEkTKu/iHWa0ObjS7RGt0Qz83Jgxptc9gHeF0aY8WcTbg0pKKLpGU5e72OyUBpUbF/PA8WyT0CcMbWdgwjRGj0x9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJp1wGQXvNpi4BilaNmpuOeT9cNuHnD5xU85Qh6ZFk=;
 b=j5vsGP7U9c8BdI83e+1qnX/k91O4CXaaaRSe7p6PNh2/tBVBgwEmoyOFILmBvogBfW/ClQPGrG+jUaeV91GpPWBbMnqzqSBgnZq8vRPfQz7W2Gv1v61IPZr/Uc7Rec7quTa/v1wxuJAWbG1xHDkJARToVKstuDUQejqbAokzkPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CH4PR22MB5918.namprd22.prod.outlook.com (2603:10b6:610:232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 23:08:41 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:08:41 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 1/4] arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
Date: Thu,  2 May 2024 16:08:26 -0700
Message-Id: <20240502230829.1983678-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502230829.1983678-1-nmorrisson@phytec.com>
References: <20240502230829.1983678-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|CH4PR22MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ef6afe-10dd-4d55-cbe3-08dc6afccec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uibZHagK9v0ew5RH1JAQKMKYIImhdw16nhG3jcIfrLSFPSipqNaC4pGLykCb?=
 =?us-ascii?Q?Fw77aFze72Vgukdb4rfIm3LNYNYTxaHxQZ0KezpHuX1l8bAHZqzxgbVflQsB?=
 =?us-ascii?Q?D4qZ+pKEjGnUP7JU/r1tt9BQE1nYQr5Z7mPgtpSfw0/dzRvNsyIfkL6T/kzm?=
 =?us-ascii?Q?eZwedlbIfPCxpphwnCA2IEhnir9TJhNeXn01xn703xWC1coG2669lhWL+IJs?=
 =?us-ascii?Q?Nxv//yhkZX0NQrjwApnNPQtSv6J4i9L9AZmJwIik2qXmpMAD7xhtsuEL5Hqq?=
 =?us-ascii?Q?p8DyH53baY5+uVELNLP+PIOveCL1sBehx4Y1phBjNloc5gjGN+vZOh7L2jbq?=
 =?us-ascii?Q?+mhRpOxyrFhkBI0l2ofNgLnQ1IhIbkwVkTJlPO6NcFjjeU4lhPp50fRUKBK+?=
 =?us-ascii?Q?v/wU5Y9zvuzwcjWglR8JqFCajUtlA3uz4XPwCfTCT2uWcGg+46CokkF0JO85?=
 =?us-ascii?Q?hkOi1JcEydV7bKN/3X+m8M5bPrWYUH3HeIwJbJqLpL7PmClkqW0O3ySoiGpm?=
 =?us-ascii?Q?AXLYPkvogawieuWlJDpNNCfKbCgaUlaANucJR+Ie/znZWN3ckLLSxRqhMR8f?=
 =?us-ascii?Q?EbyiEjDdHXWqYkyEwitWrViu4WKRYbxj34FGormmqYIncoIV0IGWNsKn/YWn?=
 =?us-ascii?Q?PmGmKuNHSMaQwje3Beqov7H1iLwunBWazbcdERyp5cxAz960UunYq5gVCaZo?=
 =?us-ascii?Q?WvIBERuYc4Vxzr0f5ZPsGXgGxr0S0w7aIdCjfGdmFxGiKtC3P1h3PGXw9W+x?=
 =?us-ascii?Q?DtfTaGm1r+TTcHYBiRaLtXmdvEnxDQHC0un5XF677KzjtFJ5B0qeU8+Imylv?=
 =?us-ascii?Q?MLEfINHiT5B7w8kHaCpXg/JiqvOk6LwBGIHhracGkXqoEK8fne8LIILjdAz4?=
 =?us-ascii?Q?zHsvr7v3bdIAENNnJvHY4SoaWggPrrRM4tsAP6jxmhqo5cyJTNoaUCAJ01sW?=
 =?us-ascii?Q?WELamgQjDmxmk27+G93o3intP0F7g7MruOj8cPd4BBKQGMLgrEKHc6owKUKi?=
 =?us-ascii?Q?SlhOZy/KoQ8r4eBsVMM3KQv6BHcL9zzhomp0C5BNPA0LCzv+X4ZcJiomFBcN?=
 =?us-ascii?Q?HwOpSZuBG4wubWF7xDlYKkM7PhjHNjuT6TZEUgVYzeLIAf48msQY26uqkRqS?=
 =?us-ascii?Q?dL0ohAMP2FCtvShXbH7AQBkebBR2R/+ap6Js0qGT87iQ1X5OvOoJ412MH8q9?=
 =?us-ascii?Q?bO36iwTWlx6RiHDtjam1m+Rpn83VOonz2sZBUhzngzQKfpFn1sawLmcqMg0N?=
 =?us-ascii?Q?lWkGoXMzQyryEC6klRaJVL43zuD1GzMX83RQ18M3ZtWr8BCbLcUpGYILyB61?=
 =?us-ascii?Q?uCxroO4U7Rk5qf3aO6xQMXOn2VoKlGuTDBO04asREcStuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/jf5OOTc18gWy3WbzGVysEMEPZoivEW/mR5eKyiHvEecJ4GMFWB6kOM9m37?=
 =?us-ascii?Q?8LQV2ooXsLmZXWJrK1F3+rC+hfhnHA1n4lqEwn0Pr2CvMm/7K0442AVOmv+v?=
 =?us-ascii?Q?1m4KYcANTsGXV27P6ICqumXNTJnUPMZLcy1fby7seLRWQybbyjLDGlr+dGOb?=
 =?us-ascii?Q?KNTZo4+ybywoIvQcwnDRKXZWpruzKMT+c72Q1d3KTzH/5F/FGl0D79wFj5cy?=
 =?us-ascii?Q?8Z8Xa79qVZeLoFAREUEeAvzhXg+0soZPTs50mU75zD8SPBulk7RQgd/cZ99o?=
 =?us-ascii?Q?urvGbo4x+axSxsbPf90AtztwGQXKIgtumKzIe8eaWbqj/c/pd0NEzUilBdZT?=
 =?us-ascii?Q?X2rUxpIbYozI7V8LXqrsSxtv98lh41deyANcsJfKMmjI/KAItOg6Mb2gftsn?=
 =?us-ascii?Q?R1Za9ISsKoyiEXZHthbDTA6aIPPyVReIidmsaCQPbk0IKoQrNtH11yU7Pbb1?=
 =?us-ascii?Q?wQtYuExf/DS6onwWaWiOFY6tbHXxZYUsTNYvvE5OIppPT38mkXjtwYemvlIz?=
 =?us-ascii?Q?cA6B5r0JMtsVBqkONSlqq7QAC4J7gLTm9KGAa670HIYW+USKC0s2IFi3ed90?=
 =?us-ascii?Q?BqPoeUHB7KH57IaTaigQYZntNiG+aXAtVQGvGVPHG62e3leUPKkBZBxYWxtF?=
 =?us-ascii?Q?QtP/5oO6R6zkBKW1nKW2l1CcgX4QGHQVWmRoZEyKv4tc0NZFZybI/V84M+SN?=
 =?us-ascii?Q?6Zh+CDtV9Ljdd/cQ6u37MUVrRvbGapXC4UGNdHIosOeMrrJbtbWg4WJE2lkH?=
 =?us-ascii?Q?dvR0Ro7psB+tIzHadDtQHABkMIyidIyW+0GB69++jx1hsPcMIx7w/3+O4JhA?=
 =?us-ascii?Q?pZIV2riL5pU0yiC5T+KiLSkU3xck+bK2FTNdsEmjyoS3WtqEX9/6U1Ik4X4r?=
 =?us-ascii?Q?0av9MBvMcAfFLZJL3FB+gyo6GPyrbCqeMDwqpIvMl7/K8Vts716+pwBdamxu?=
 =?us-ascii?Q?PZt1cQDaSneTfrkwweod//aHK99/QrXvaurRcO4whkFYxuYVVZ+AAkYzeS0f?=
 =?us-ascii?Q?v3v4l5H7Ro4YHwJCbUAx4n//zYbOCt9b7b+DR5BqkiiokCXMXY3RKGdi7hPH?=
 =?us-ascii?Q?YWQGL4SDa8DHDA6jFAPk0nH6hES0nOi3M7sJo+DvSm6/0g/bZC2SH7eN/tR0?=
 =?us-ascii?Q?a3qFqit3YtEbB66vcsP8ZbqBqKWfs7P3caVofOtY3AF6mi0zQTwTd7AYIdwo?=
 =?us-ascii?Q?tSOpHULcoZ0cT5PhCMv7rGh7EXXB3Xa2Yo7LBsF/N9py6ui8PRSM5RBVYxUB?=
 =?us-ascii?Q?guqNUaGiLZ0DPz6O8NmhlZd5ScOg7TpiYrFXJa/nnsdZTwDopqi2MuoTTM0a?=
 =?us-ascii?Q?05IqopNQODkTyDJtRGXi4cnFI8nihPBwAA8uo818QIefX4QMdwdJ+NZDEgQE?=
 =?us-ascii?Q?X4IT/OReJJ+F0Z+hGWNLFZ72uaGVTKnuISIgww6BgWDijtRijUEBUT/y7zSg?=
 =?us-ascii?Q?6HJEvxt1YyvYIUvJ5Eb9CGpkOKDNL1/gIZcC/U77Bllrr9fVEEg3O4JBGNiZ?=
 =?us-ascii?Q?wZ6mVmnGDLZZoknn3/LUU4Z8pLGt4KurQQKfZCBNexKG8YZwOWcgAqtLArhi?=
 =?us-ascii?Q?0qHNPNDlgel45O1C9h0jhkT3iTtBNkx48MKksMeP?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ef6afe-10dd-4d55-cbe3-08dc6afccec5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:08:41.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8phQkEsKyDaUzzQqJ4B32o8JzKj8vCWtIrYwjr+cy+7iEIWK4PAAOv6hioSJ3fNTkmtqikRF87k2cymzNRBWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5918

Label the spi nor as serial_flash. This allows us to disable the
flash with an overlay common to all am6xx-phycore-som boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 125e507966fb..ca0bbf21f7fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -296,7 +296,7 @@ &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-	flash@0 {
+	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
-- 
2.25.1


