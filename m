Return-Path: <linux-kernel+bounces-80388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A238667AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB077B2141B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D284D534;
	Mon, 26 Feb 2024 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vQ/BFjJV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2010.outbound.protection.outlook.com [40.92.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC258817
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912607; cv=fail; b=rtT0li6rlQJ/7yXOgQ790cLXL8HG6p45S3ePDB5dSYUzJfqgnnPyLOvTYCTfn+XcOIArFwbcIZvKsvKSAvmivDX6UlV+SWpLEOYb4eavWbHBBQyf6Pb3/nHoxtioa5pbO+E/LS+mtQ+vPmrmbmpWzLWKsz19yEFb7hct3IQBuLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912607; c=relaxed/simple;
	bh=csMSuvz0clH82ysE88Z6ZGrdueZcRlPn6/7ETAB51fw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UQfC1h2pUliu2vg/7wRKewnANKlnBdJ/x1oPxpQoQr84sCeMSAdWtL8TOR7iATRu/Fmf/u11ebXutZa2WJGuvM81UZc5e7B2PgtilqsIMkfcGO57/O/3yk+IVgLBhkUdnmLNmn9x0FSofqbr/bPRandtHdG/aJinNy0sL7iQzDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vQ/BFjJV; arc=fail smtp.client-ip=40.92.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkLs0ivkdIn5jOxhqumOB2wsaAEcvlS7Ws95Aw3xuYv12ZJyc3TdsyI6CGuI0tQ4gz17acuX6gxW4oWr3AwdcCRIv6aHVNFT8UxUCkRK159jT1rAwpodl3kXdkK4Rcot1zRoydOcKwmWSsldI4Z/+sJAWbJt7Sjsu3l6Dg/v+d175QB9w2n5S6ys+VPJ7YuLtJZZw/CBVKcfxAO2W619Gp9cnRKfhzne9nONVxyp/dzrzvQQ/3V2MnzuUuqCztOXuT75KVH3kHeiUSgkBEwIBTUsbmQg5GunRPgmup51A81JQaSVzOA4hyzoGhj5S6fsPOaiJSTivIcNoMIjTMMErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqHqPCHMIyOGzk8kjqu0uxLHw2BV3CbbtRl5lj53BtU=;
 b=IhqQ07iWImGFkkpiAaCWrO+p/z2X6A0Xe0PAB8zM+/1OFnW8EZiN8nOuw5lVsCYDZSOWY8VC+Mr0euDiEhPywKfYJSZ40Xrj2xKlFTOZ/EzSGmFBW/ier347atApBQgU3FKVAWUCDqxHOZqoHI2ULcpjEX3DAmnWwvcAN0iQH+gOfoWqTfoGIjmfu5b3qCt/IJkWM1nQHl87LhAxgNl0WYbvy9tRsocJx3QppTsoWRfuyD4bLC60q8rvUOCtcM8ludS2EcEzgPz6IJ83cCvnKZzjfa7nbdzCGwzaolvxJTp3qCCxxYZTNCy+xO/Ce780eC1KRLj4xSO/hHxYfbUIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqHqPCHMIyOGzk8kjqu0uxLHw2BV3CbbtRl5lj53BtU=;
 b=vQ/BFjJV/fux0q7NsqbHC7jRLW07oei8p8dHmxpt3IoVXbYDUMo3qVc2fkwjfjX/2GG3Hr03NZhRBQIs6JRrBG5Kld3t3m0/V6EPtbzWIhJFw9TDjbvDHsuL/SYV7GqNbDjzHzunlRLfhGT15XuVX6irAXeIcd3MJeMl/4qm2rzxfaa1Yh5DzBmzpiZcLCnfNVmzMjQPHPA9IJ6FrmmA/knY7wCZigMkJwupJshY9T53bilcvFmXsy/KC8uxjkYZeSPU6pNFTU0HHvBb9qHwEgMWkXGpbbglv9CQ1NvgJj/uRl3lwnVTxM2O0Sc6SnuYSDVAEq8jPVpRlAlNRp4r8w==
Received: from CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Mon, 26 Feb
 2024 01:56:43 +0000
Received: from CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::3ca3:fb4f:d0d4:974]) by CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::3ca3:fb4f:d0d4:974%5]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 01:56:43 +0000
From: Kunwu Chan <kunwu.chan@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH] iommu/amd: drop unused but set variable entry
Date: Mon, 26 Feb 2024 09:56:30 +0800
Message-ID:
 <CY8PR11MB777960FF31E255903D0EE664975A2@CY8PR11MB7779.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0OXqA7Q06W8xKHWxotmOjsEUIz36rsk6GUbKnQvkfGc=]
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To CY8PR11MB7779.namprd11.prod.outlook.com
 (2603:10b6:930:77::22)
X-Microsoft-Original-Message-ID:
 <20240226015630.1770718-1-kunwu.chan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7779:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e426354-003b-4760-c2ea-08dc366e2e3d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RSgEarufBrhyxqtNgxFh/7OaI+WvsikKzzZft2V/WldNXzbCv8efocY85s1nTEfuweVlHLDDNjV+x2mq0+CaFdw9/MhXeH6p1b+scrwsd+WUF8Qx9BYkg9Mx25v9QHFj48RgOEbCqqXSfiW9/EJJiDeqMZmcL8fpvYwhDQavVTA735oDdFUN7DziOlHg4sMf6/SJ4LcLjemS/nSwzhe4ZHU0smLi1/PlHgsbvWmqleKL3kUBDSMxdI8xscvfXKfeG8PQlWD2ztlXok7qmlze6Dr8q0e31WKa2lDeXFye6bAJ3BiadoRJ+7SuphZryLxJEpDmP+Nme6T3zyMSQBUVHLJkh1OLwsy2F2hVXsB92bIKXKxO8anPmd0cpqLQpkMDHajK6VinmKKLnp3AOJjHVolvYYN8xPUxaxuV+eegrbde6i3aw5hqCeppx2QZOxiQEo6OUnmgreeUn/yqzI27utpS/d467r8EDt4FJd2FEmqzy8SsEsmLTxYW087R+weZpw4tryVZRUWVJGP3vRRMZgrp8t5eygL5HOJC1axJ8/F15N/mNsR8KQzINESqwUpApnLV5kGuNwe2vHDzT3LePxSYUpxoewt+uTNOiiBeUuttK6opbH+s+XzgCb7dMpbakkER/6axGdIMG+UlE7ftV/xKs1CrOBdS67ChZ66JfhYqWVMrcBpUrE/g4/+jGqHzeZaDLDv4cF/LZ4xY9yV0LA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6VHTeioHzKDb1R9z18SDZv6D4PjbULrJx/yljMbmF8xSVqdLllketZTNRly?=
 =?us-ascii?Q?aty4bG6pcusyNPqdQtuKzLU4cZJQIsZBnpqRjcleO3vfTeHXAEeXFGVb3uSB?=
 =?us-ascii?Q?ciDHGl8vOy3BryeQXexTaVIfmq3Yfj16WSIojve+DWur+uG+LilMUW100TZh?=
 =?us-ascii?Q?Dg2BtGAPWhZeRsWWeEh5Gvl84RjbkybRRhmoWS9hEcTtuSYiRxwrUY8luB11?=
 =?us-ascii?Q?MjefEO5n0akk2cOVLWKT0hX3bOKLbNTR0Br8ZWzhwrs6CE5e5gGgQFpG7jOX?=
 =?us-ascii?Q?zLikOYKz9Ev+ASdA2EfBL1cPoP5O1UBV+QZKAfU4o5ky6UlCYw3L9DFVWmZk?=
 =?us-ascii?Q?4izwVHjbOHTVbU9WsDTyrSLJo4p+o1ml81Ywb7CIRCxTFH4ErzUXRRsJewrH?=
 =?us-ascii?Q?CbmfqQdlzQRSVBXI8e56SWfM7F3lcSBIQ837c9Ob6kJeJG3DcH7EOpCbh6HY?=
 =?us-ascii?Q?TpODDwR1j832zw/XNaRRVaDimZbSZtNc7NKomTlVYLsslgXT0D8d7WGHlNiR?=
 =?us-ascii?Q?cHvURKlTfiH3VO+Fu8XGwhYdQ2Doux3kXjWzdIFIuAxYgJ1XVwOQwfQjeTHK?=
 =?us-ascii?Q?JDzGsw7ln9R6zIJe1brO7yYorLbe0Lev9GbC1hRrjo9q5PaMypSg+6JeqqOu?=
 =?us-ascii?Q?VAB/7hcc74fhEi98BaE1a/dPb+iakd1Aizj+1QxwUj+GbzCXzAeSSTxVSf3+?=
 =?us-ascii?Q?/iVWwVsCIdOIW1wCjC2kreElR1Is4rNYsl9krUFtAgCqbiHzL1iK9Tov2f9A?=
 =?us-ascii?Q?9JWAM/cN1yKWi9M5Hei37THiidGacWjYLom9D0yRdp/OEytDa7c5RjauIvgT?=
 =?us-ascii?Q?tpvCrfAKsLcZhWO9Z1iTgn6MtQWfnwcMQniseSYQBthuRpkQEdHRhvFguk/J?=
 =?us-ascii?Q?6AIgP7QWOEQxVUjSKsW3DjmirWKUC2qeU47svY/VSvoDqpOGQAxAfneaoVXk?=
 =?us-ascii?Q?Wa2R64R+jtZId87kd0WPUsgQpqoZ0k1yl3yXQcypYyz5RQN8V6QeTMSF1EyB?=
 =?us-ascii?Q?c91T3vfQ9f7AZUWpkP27nFP9t7YSkdClUkphMJlMpMd1pQDyC+/shwLksrAU?=
 =?us-ascii?Q?gtw5TwFw09YquqqQfHmXqgxBYEUESTsu8TjMarRfnA/L6XE5E/qlUrR0kocM?=
 =?us-ascii?Q?xWfbGx89Ait+BLxOW+XshYqBXApIC5P57X3BC9Jx78MQlJzk44pcy8Mvf56R?=
 =?us-ascii?Q?35PXoiTBTWq9INi6u2IdZixMLvm9rn+mCovVtTzU9jhnZo48t5lg0B8JCipS?=
 =?us-ascii?Q?hS9pqMLII3L3lzWr+k+s?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e426354-003b-4760-c2ea-08dc366e2e3d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 01:56:43.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772

Fix compile warning:
drivers/iommu/amd/iommu.c: In function 'iommu_poll_ppr_log':
drivers/iommu/amd/iommu.c:833:21: Warning:
Variable 'entry' is set but not used [-Wunused-but-set-variable]

Commit d55b0d2e075a("iommu/amd: Remove PPR support")
removes the use of 'entry', but does not delete this variable.

Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
---
 drivers/iommu/amd/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4283dd8191f0..de771a6420dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -831,7 +831,6 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 
 	while (head != tail) {
 		volatile u64 *raw;
-		u64 entry[2];
 		int i;
 
 		raw = (u64 *)(iommu->ppr_log + head);
@@ -847,10 +846,6 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 			udelay(1);
 		}
 
-		/* Avoid memcpy function-call overhead */
-		entry[0] = raw[0];
-		entry[1] = raw[1];
-
 		/*
 		 * To detect the hardware errata 733 we need to clear the
 		 * entry back to zero. This issue does not exist on SNP
-- 
2.39.2


