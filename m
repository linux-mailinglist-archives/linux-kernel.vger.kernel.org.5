Return-Path: <linux-kernel+bounces-31618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0368D8330FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273A01C21D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B458AA9;
	Fri, 19 Jan 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b="QEl1lDmJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258735821D;
	Fri, 19 Jan 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704794; cv=fail; b=FVriyFoL09PR95uK8VD1Yq/ulYv4T7V1HpMpLYHpTxJAnl4CIt7h9KPubb6jauaNvzkI3n6Hu5QwVI4rgz/KH/ZrpN68tnM+ezE7uqgxHcBu9geTRQi0bheNcsPxLUlcfSBIGdVqLbIJMFYuj+CHVpPMZkyAU/coEM/Zj5JkZIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704794; c=relaxed/simple;
	bh=VFj0+5HMSZMDcQBJdHX+WpZA4zjHmZFHjri3J1BEJW8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qGBFDrn7QAVfzpJIVaD/gyE4lgLyDKVPTipxl+iN8Uqfq9so+Bz7UI3QrrFSU2zCX9RQf6Br8Q5ycI2K9hQQCciCAUMYFbYWNNuljeGeNHadLqpI5t4nkTNxnUI0xWKre3VI8HgBOIrRq9cQFelO8J+hRdu4X3fmg4MV5vcCbAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=PHYTEC.onmicrosoft.com header.i=@PHYTEC.onmicrosoft.com header.b=QEl1lDmJ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJTODly6JPKV8QBFQq+E16WA04bhIUKCd3ZmuxtXnwa4MT9/0pevmKOTetsj8dlu2LsFIdwBn2j5yrTLS3h00oScOJ3jmI/XvUOWPKNyJvyYr0aarR2niebnafS9gpuKvBDidPPSntp0cOxgWN/dz5oZ2d+AipceAO//vLSFwJRqOT4aYXEZF2b5BZHQB+zhhOrse8HI7G67n3gymk0gtI7iuyLjKYjCMTyOa1HmGEysYySpZTDFB4SN6Ks9kRS54bd4mhgXwzcUlY9AEuHJyqjgraJ7TfZamv6NIB29CQBwAvdaG/NlKzJzfMiV6v5W4KRZCo4TLJ63TPiD0qmrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ3hwvGaPHpCbCPC4d88o8lG4YA93oepOwo9+t0u/qk=;
 b=mJsxQCwtQoVmF7vCZkC3B5GReho1r2xxzvsg7QdKMTY1tBWup8OFKrq4ec2A5bFd229prsxHJ+uq6VaL9zu6seu6QWL2RB91MDUNe8XprJs5zBIrQV/wofrcX3ncqNXZWVYJ/tAbqASas9UJVZ5UBhXlyBZ5AQwjXEkmKGqHrT+fKo9kfpFCV5UxynB1hHzbZAIWOB/bm+AszIshMf7+++l2b7sNUz2OTlWFrJ0I4Cw/dpG+3mdUz0bBpiidBylo9tlm3lfGQ2TbgempNbpotBEoZ7D/Fy63LT6otPbgeO3WDdhLKzqa0eaMaQtcI/iztJ4uV3FRP0nSgZ9pvHN9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ3hwvGaPHpCbCPC4d88o8lG4YA93oepOwo9+t0u/qk=;
 b=QEl1lDmJxh++KE+LNiu2iTn+YEJnuNKAU2tL5NCUlsrUCpjvQl8661fhEmfdPOmXLwCrkadSe1HE6VOMoTEqIcgXCP+APLcEEGZDfhWcisgMAeVWefFOOSTc4u7R+S+K/gyXNYkyVsiWpV5M9PW9iQlPJoW+MGA5V5QyOCcJ9r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
 by MN0PR22MB5662.namprd22.prod.outlook.com (2603:10b6:208:4a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 22:53:09 +0000
Received: from DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821]) by DM5PR2201MB1515.namprd22.prod.outlook.com
 ([fe80::89be:ff90:a5ab:1821%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 22:53:09 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: ti: Disable clock output of the ethernet PHY
Date: Fri, 19 Jan 2024 14:52:57 -0800
Message-Id: <20240119225257.403222-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24)
 To DM5PR2201MB1515.namprd22.prod.outlook.com (2603:10b6:4:36::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR2201MB1515:EE_|MN0PR22MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc2a725-4b4f-4b88-dd58-08dc194167ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wxkCIkT4J3xlw6DIiWDjtM/CKvnefKDLCfAxxDx9glKWY6tGWLsoYLFvmm3sOqAk7L7Lb4pf0vokL4rDyWXddOt7kCS4lS9B3czMAPVuGgwVv8QwaHgDfXYDlibGECPq1ZzQ6v9mtD9dSFoUUO+WhjjBc5AXV2+RejA7TR0tccfF3Mn2o8HjO/nbkxh/2sQ45zccjQtmF/iG7LL5E75gGxoC07Ouh9cElsz6TkhktrD5e62nsr9v8XunlIaGT3/Fml271+Z0yiI32f7kmi5ShxFwV8GaBBQBcmlCBTiMFebLENi3NmoetELGVxwXrhdGdeyFSa0+qeTzXsPxSCJG1UPeo+7urtxF8jn15WIV48vOM5WNbCGmqAZkPWO3gznr+e1ea7R925VhQK1VGdPwlAFIQSpiFEQ+PJCsV+NByaaOU4AknR9uTjs9k4AE7X9vb4NaTB5LPSELTEKG40ZF82SE+/tk1igHQrOB1991/Vu8M+5VkITRZoYq8mAj14qD9hHz2m7YAYH2pDaG3DFU7WE82sWQ+ms3U29albdm/AtJwwYZbdXSMiMntOiBz9pJG0vLhQqZUFpfLBbW2uaoJk+gH+VhdbmqPdKZe+JERZ3zVF7lIpTMYftlcKTUPcJ5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2201MB1515.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(366004)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(52116002)(6666004)(6512007)(26005)(1076003)(2616005)(6506007)(86362001)(36756003)(38350700005)(38100700002)(83380400001)(7416002)(4744005)(2906002)(5660300002)(66556008)(41300700001)(4326008)(8936002)(66476007)(66946007)(8676002)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkMvH8WYfaj8htfmoxTp1nGzBYz7WLCkwlPXO7ztB74Azjynhw8EmTFuybLP?=
 =?us-ascii?Q?s7/bZrHX72OUjuoCR6dq139vKWQysjlpdVz6U05uCt/4DoQ0kEusPGcoANfx?=
 =?us-ascii?Q?PgCO6lvUXRRST+nnDFvvM/Tf69EkEa6+HDx/Qvm65QRVPqgujN/JWGlPof5H?=
 =?us-ascii?Q?b+cty8w5TMPMt0iKQQXgL1Nz2XmjK3MUxjFv1uPKBeAI+7HJWtJi+OIHPHnl?=
 =?us-ascii?Q?4ztnVB7rgKUYoCXmAoNMrocXD//4S55iLxbft7QxWTSWo6Avb4TEe0QtQPdG?=
 =?us-ascii?Q?4wnwiAmKTeGS6RFhr8dWIiC6zFCoSTerRMpW0E9+/F52oZKwpJKfM3oW/PUu?=
 =?us-ascii?Q?9a89e9cVrlr+80hCM3ZWmdhpI9FrS8NXae1Owj7TXYYd9DyUiW+Yb59zvsJq?=
 =?us-ascii?Q?VJCCCkp58ipd3Ag3rmFfWBdKgW3UKaanxigjFHZYB+xVurhWx1WGrggEMZsV?=
 =?us-ascii?Q?Jv+/2Jd9OSjFk6AbM9uAknGxCuamcwvjRq6PZw7Zmak/b38tiSAySWufSzsb?=
 =?us-ascii?Q?jayXkMPToyHsRh9GpBRvKW/wg6fxlXXoqm7R7FXmEurZ5Ymn/BFNVeghwjTl?=
 =?us-ascii?Q?UCfqtp78PMNhQ1uM16klhdSrYBxujqrHwxTuUmOXXri0PM22ArU254Q939n4?=
 =?us-ascii?Q?Ya9qaeo+zNaLGju0MjCUBbRWNaAiBnV/LJ9yZJIUnE5PVRfu4eFZfPEIGUrE?=
 =?us-ascii?Q?9p9Zj2PEgKUpnTJwE/t+cEP8zwrP+x0Rc4Op68YYG7dTdcdXKJlpkNrlLeM6?=
 =?us-ascii?Q?Zlvn7tq0v/xn8qPE7RKZ/7CYkzPEuxAcJXEH4ZB/GRqRH6uIAnVaRFtSlghM?=
 =?us-ascii?Q?PTX80oz/h/d4jBG58HeoX+LTVTNzjjwKM+W+X+2npZmVhvOWkevi5jZVnuTd?=
 =?us-ascii?Q?QLRlP7xS7IJQp1nWTIgzuOiKjFKdDxBvQA5xN5VaK+3q7AA0vJrsRIYdhIaW?=
 =?us-ascii?Q?HPMLpBpvtMnaE7jQA5I1f7K+5c+zD+r96CfeT34HXNdw742pUtDQ/R9OsDfC?=
 =?us-ascii?Q?jeRhSrkEB6B7zurAo2lQkOCOYKbvCiwgCLjS/+N/kw2JnX2RBwm4IVX4gfOO?=
 =?us-ascii?Q?/XnicXnVF4zrN+JUhHBONuIST40sHNUg8SE4W18UKn7PbH0ncOZDybg9IuwW?=
 =?us-ascii?Q?XPuxgziu2Ey6E0DfZyGcH0YjQoQnsNHPVi92z+pt1zFaswG3v4Fnnw37gY0B?=
 =?us-ascii?Q?Gg1JG2FRv5PStsojKEG09yg3ZvZUWrzZGQ8I+q/hSF5ezNu3nj/icDeLDzV5?=
 =?us-ascii?Q?59YIajQl3jIPfls6jIDRZcR/LToWkQ3KUBCq3QhaLQhys/+U3MoCSXI/HWfx?=
 =?us-ascii?Q?QCrEOhLV5ljyVtiFN53ZQn1vzzkkdkBPBSE5nV2VgmyRetVZUraLsXjs0ful?=
 =?us-ascii?Q?1/QnafMT/Ksp7ySkuI9Qe8edsPYccc3S4qIJi0MHLXOq3Om+q4SE60vBSt+p?=
 =?us-ascii?Q?Jk85DkbetR56xdWgNnznNWerVL6z67CutHyf9/0E4p4RHOK9zqDsDU2+CM1f?=
 =?us-ascii?Q?hzW/fLjr20eFugcIlS2Bj/2LvVOOc/E2uVvvh8NXHnF+X+DhCC723/dD3aPo?=
 =?us-ascii?Q?Sj2u1gQhPZ28HNyAB+INfn6QrysPgNZBSOuyMOmy?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc2a725-4b4f-4b88-dd58-08dc194167ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2201MB1515.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 22:53:09.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7Lg8yVzQ+9uEcyqdRCI6AZ8/u0y8D5AbtgC+VsVM42dAK1pDXm6YAJqhtpqdOEdU2BuG8nnHl3Wip9mOCuvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5662

The clock on the ethernet1 PHY is turned on by default. This turns
the clock off as we do not use it.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 4bc0134c987d..3173f6eca7ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -222,6 +222,7 @@ &cpsw3g_mdio {
 	cpsw3g_phy3: ethernet-phy@3 {
 		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
 		reg = <3>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
-- 
2.25.1


