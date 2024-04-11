Return-Path: <linux-kernel+bounces-141710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24838A2242
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF531C21403
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FD481C0;
	Thu, 11 Apr 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gwW6UqsI"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2109.outbound.protection.outlook.com [40.92.40.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA5524C;
	Thu, 11 Apr 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877869; cv=fail; b=L9ypBjOlpXpvNBa79p3HlyKTnd87Gztis4r+9cwo1qdemVTpYLJxUKKn6lq9avG/aFeL8e9A7emyHSbyP3+rgavXbsTbyXufs7spWcbHS7gtcC9yDT17OV5Z5HSrlRg71j7+1erktbFaFf4Torag/9pf9sh5KvzA+1lOuie4Oys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877869; c=relaxed/simple;
	bh=2AYawMi/hK/nZPQitzKj7E7kVOaaQFpiCrgqNEXjM6E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KdGy2nhXXDQy3wQp6OIXuaYV28FXGZGZqyQCKUFnQE3YfwGQN2mr5SJXOvOiVbhYZC5LF8x5jhVSH+rkmqGwFnGXl4t6Tlw5FJtWwre0nGOLA42ZLdO0hrbUkRcbyOY/iQ38/eKbCeQUXXm3V80sEhcLm1tjBn7Nhm334kO+vac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gwW6UqsI; arc=fail smtp.client-ip=40.92.40.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2SjfsER30rMlbBK+M9SNLZCYJYLZ0n3VpuPnBzZAj8oTsd1vux5+NVS2RvTbtfIGMWnF4NsLWLgj+FMVcaGHYIg3CIixfvfsHMMlUo3ehNkYrP3TIiYJRl1yhZ56jb5SY9xd1YcEH+qWmPAqf1jQNiATEC70vhbMeoerQQNZyzasZj9rxrkwpNrhEKv5U8tkXOSLTUl8Wa7O3Df3SSSKdSQ4MJ3lgEj69ke6mTc5x7tBuFbydU9uF79ROU5tO0mKLmbtz9/KmTuOPFitrFTHvoh+2CeLyhF+jsbUbVV9TaqIw22GB8mPLB9zQAQZzhtgiYaBuweO3MprfCcu8ntFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv57fzAH9saHLKUggP8aUacXLLc9M49kD/wyTvIElm8=;
 b=OnFUAzed+5eqaFOIUkVGVAaKu/TT2kMtrcjZ4vQeYhzJFCRJC6dD+hmv0qzVIEovWRXsJVCNenUi21cwDmezTuouSQuK6soarn8pQhBywUsNWmjCkYfJjJ76E+I8bQEnD+gIfkMd5GqXM8QQEunOHePW8ytexDCSKmttSAPaGoiBei2jn5rsl6e++nk5dKhuZBtydsPRqqHOpNjZjVHCtGTOHBzEIicq7LEHCCQWLwehvLx+I37Yp+cFSLB9ELHHx8zIGPlFqa++ZfXE5xbzk41tsP0b0FbX3GX3/ULQWf+jx5mVqTMnwGfFzRqguEiIeVC+A24Zv+usiAhyfChW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv57fzAH9saHLKUggP8aUacXLLc9M49kD/wyTvIElm8=;
 b=gwW6UqsIXuNdWoUACuOVykJRDhvqGDy4EjkQBCFQoJro3eNqr25LJcoprDrGprU21IcDIufde8AifTu4BugVzGym/w+fW0oVF6vUBOcNVwUTggEZmC8/DU/vB+kqH4TrsQxKxqldWGaKf0bG5Lb/UCQ7BSfH6NDacVkRZ+OXECW3YSXRVCIszssbwLCjmCxp8RB/LiDLE0lqLiiw8NoFO5naWbTbHN156uld1JhDz7a8R+QFSl7Ko3ITIVR7fQxcVIiyzx4lAeCfRvAOg9a1dP2QC82G9aJOR+uJ1kUgQsGMS+lPt9vtBqE5lLTQVncgE5uBeuG3jYPDHW1lQbJzSg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5253.namprd20.prod.outlook.com (2603:10b6:a03:47b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 23:24:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 23:24:24 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sophgo: Make synthesizer struct static
Date: Fri, 12 Apr 2024 07:24:38 +0800
Message-ID:
 <IA1PR20MB49531E437735A71A163694AEBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AEDZjpx2crW5zowcsgcG/x0VwXZo3DeozUOS85e+G5k=]
X-ClientProxiedBy: TY2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:404:a6::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240411232439.71651-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: c87ef73f-58b5-4c6d-cc19-08dc5a7e8627
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	znCB40dinQwUWZSFXmv2i5lv0OBsPPLnYmcszKex40TyzYnLKlAtgePFROC/hWCxpAi7HvcnbJ+m35tZeQFMowTGaTQmZL0yqQzzVEeKHqSxfGjmqep7XMFafAl+PwLGyq1kicWPJHrGtMJ16HCsHETELaG43jI1N8xbw+OFNi60s3ow27FqD7GNboXPMuK6O5YCGuMfxIrCm5vXbtGgcKzF0VhQMZQmmbjN92UUWXKNDZFIchlK7NUmbFmgDc8OnvTbF1DrGuhduD1Dh1ZYoj+MEu6S+DTjTge5iLSL9tIdKXb//xM7Je0Kr60r840VQrF5mJdcIehewLe7zN95h0uth+/f7/G5srn4LahroxONFK4MTMEN6bNEKjemd1IXIpa47VxrnEjR0FZOT/E50aAEBcFBFc5grfYA+yz7kUKWScrIFRAlmHDNPZGNFbFWSTBKLAH3jeWIPbg3MShkzcgepF2o8E8AvScntR2vOndlbzeI0WB1zo/e7oV2LyPUmL93/ANldXTGPurOQGIM7D57Gs3+25N8UWtgMowz43i5QW82LvJZHBaGUQU3bhOHwPWmXofHK/Rotec7CsGf4ZnP6bMRydP6+du4gCpumNIcYxpqn+wOXhDegpmwIYq2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+mJjZPuh3nT0uZtKAfh1TQVxOPTV66gakzDHmbWvWPsWfDmlle/87Mg13al?=
 =?us-ascii?Q?XAprGkoeo+PPg79lrXohiYC/pe8NxQgq4tZ8m/+74tvZtdA5Z6gb+k57IHrd?=
 =?us-ascii?Q?VlU8jNzHW3LBmunFVvgDeQQnNx9hH6f6NIRcM4zLUFQxfa18NDEu5vIrsNXr?=
 =?us-ascii?Q?/85rZz45kdw3FjTnv5n2WGGMBbP5Q2aHXMWGyaX5wQfrt/96O3/jyi7GcFky?=
 =?us-ascii?Q?3reIBPVNKU5WUk6WCww7wBRRG4znvrNJ4WQ6dYm9ZMyxkJE4UtxapNsYTFeA?=
 =?us-ascii?Q?UHJRkyCn91LKp7WzH8QWXCcieCQwUGzb79IOTeoILx2AH+oP73jvf3Hoqg6E?=
 =?us-ascii?Q?014Zqt/rgIiqPl/WgS7GcTeGVD8cHQsNAlCse84z6taoAvl0I9kFROEQitUe?=
 =?us-ascii?Q?FQbMDFcoQJj6HvoP4lEh0CU3x4Jt3v0iGx6zLKDf3WasCzI+wU1HMkfWJJ1m?=
 =?us-ascii?Q?j18Z2U+bh+fO2OevvjYdB/DJld8bkaqMpxlQP+PYDJ6ddefAYVtUs16mM2kZ?=
 =?us-ascii?Q?WsdM04F2e3xaTE+XJ8c3ve5AI0Sf93oDMIm1D+BZr1Knpqqcixke7vbNyrhF?=
 =?us-ascii?Q?8Xhaak9Q6H+4PcwRekOlPNzM4o/agikOMo8WnGs3aAjmZRpU99zk5hgviK9U?=
 =?us-ascii?Q?zUF2ag7POyuNLOw13o2GzHbDLfQ5ydbaIJcOeSVATAUWQ/d7fad/DLv5HTwn?=
 =?us-ascii?Q?zTzbqMq/5vci7LPy0is+ohk0oyhHSA8wAIcfTDEl3f408c/TLgFMEEfKkx/6?=
 =?us-ascii?Q?cGEPqTX9VkxSF0QgabV1oBAKAwGh925ecBzU0D1iD5JtfCswac7V3PSvHLWo?=
 =?us-ascii?Q?OqGrSeNNt3tV+S23jMd1F4l4mWmesArFmJNg8GSR05Xo3HTHhY/mBdODeeYu?=
 =?us-ascii?Q?7tZcYgH9zV1FBafw6CoEOTwVYRCF6BLUaZfcFjD97RnhdcXR8TUGhrZaImEh?=
 =?us-ascii?Q?TBkI9GD2yaz0afF88KIGLsVRefxv9PAkNjUZouGjJNjIFy26bvR9Aa1MyfpF?=
 =?us-ascii?Q?/1eRYLNEFKLnTuXU//CjE8kdZILk8lrMcwVnuziC0+LTPZJHkZNrrnQThq4q?=
 =?us-ascii?Q?MiCVBa3Wff7XeLveFNUPZ70OO5y2/NcF48wjKNNVUYNCltrqHuIiO4ACBYVO?=
 =?us-ascii?Q?3A6Q2tGf8qL4eq0YY8AhacAcqg58hIvNJyR7GF5C7I+Cx9/xSm1bzroEFR0x?=
 =?us-ascii?Q?xnrRFA8lUOPCQ7efqvhe3dpzvjJitEVAytAkuDH4UYMEQlW/nMM82XUNGIIq?=
 =?us-ascii?Q?CGW55jZppcMrRdFQk/tN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ef73f-58b5-4c6d-cc19-08dc5a7e8627
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 23:24:24.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5253

Let all synthesizer structs are static to make the compiler happy.

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
This patch based on the clk/for-next branch.
---
 drivers/clk/sophgo/clk-cv1800.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index 956de5b21a80..2da4c24621cf 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -79,7 +79,7 @@ static const struct clk_parent_data clk_bypass_fpll_parents[] = {
 	{ .hw = &clk_fpll.common.hw },
 };

-struct cv1800_clk_pll_synthesizer clk_mpll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_mpll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 2),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_MPLL_SSC_SYN_CTRL,
@@ -93,7 +93,7 @@ static CV1800_FACTIONAL_PLL(clk_mpll, clk_bypass_mipimpll_parents,
 			    &clk_mpll_synthesizer,
 			    CLK_IS_CRITICAL);

-struct cv1800_clk_pll_synthesizer clk_tpll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_tpll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 3),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_TPLL_SSC_SYN_CTRL,
@@ -107,7 +107,7 @@ static CV1800_FACTIONAL_PLL(clk_tpll, clk_bypass_mipimpll_parents,
 			    &clk_tpll_synthesizer,
 			    CLK_IS_CRITICAL);

-struct cv1800_clk_pll_synthesizer clk_a0pll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_a0pll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 2),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_A0PLL_SSC_SYN_CTRL,
@@ -121,7 +121,7 @@ static CV1800_FACTIONAL_PLL(clk_a0pll, clk_bypass_mipimpll_parents,
 			    &clk_a0pll_synthesizer,
 			    CLK_IS_CRITICAL);

-struct cv1800_clk_pll_synthesizer clk_disppll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_disppll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 3),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_DISPPLL_SSC_SYN_CTRL,
@@ -135,7 +135,7 @@ static CV1800_FACTIONAL_PLL(clk_disppll, clk_bypass_mipimpll_parents,
 			    &clk_disppll_synthesizer,
 			    CLK_IS_CRITICAL);

-struct cv1800_clk_pll_synthesizer clk_cam0pll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_cam0pll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 4),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_CAM0PLL_SSC_SYN_CTRL,
@@ -149,7 +149,7 @@ static CV1800_FACTIONAL_PLL(clk_cam0pll, clk_bypass_mipimpll_parents,
 			    &clk_cam0pll_synthesizer,
 			    CLK_IGNORE_UNUSED);

-struct cv1800_clk_pll_synthesizer clk_cam1pll_synthesizer = {
+static struct cv1800_clk_pll_synthesizer clk_cam1pll_synthesizer = {
 	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 5),
 	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
 	.ctrl		= REG_CAM1PLL_SSC_SYN_CTRL,
--
2.44.0


