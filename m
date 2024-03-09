Return-Path: <linux-kernel+bounces-97811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672E876FD3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D996A1F21775
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA838F9C;
	Sat,  9 Mar 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+zmhUSL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4613B37700;
	Sat,  9 Mar 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973904; cv=fail; b=Cw7khqgx0Rwt7Ps9fSPbVLtgsKjLp/3T5hquaCe7NxdmWZHZptsSTk8tkCBQq01yQcRwY8FS8PX+/XbiyossUKUTE1RQznn6t2SCo7/u2dgpE+g36WPAawV4UmcpLFt7QFoGzYeo6YpLXxVm6falUBZ9PHv9GpntzatS6cGgxwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973904; c=relaxed/simple;
	bh=+XeEF5l/dtKxjpNYHuL7oJXguX+pvqJFoKNmsDwsa4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcKHzojo/LUL7SY9YeSngnyK9ZpaKxpc8uSkfb4CNGumCyci/cMe7+8IVeu8yMGbDX0hZpWM+QlwmVcjaXPadDjXm6RBvX3NUocvVPYzHVuF+ca+NZh1IoQCNUarF0RzpLq3TwvvDZvfujAjz+0TpLxdc1SU/4jO+Uxq1xp2iuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+zmhUSL; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMEghy+S6BNYywfaCXjxLEGq8GvA8CbTbkFStFpqHXsrYkihSy5iQ7ljkmMRPp9jCm++f/eLVCKHlr4g9UtiUdywVonfrG+KjPeQcLBIq2mwU519nUeNjpTERX/kdZ6bu8Tp4k6lWybR2SejJlrTxwXSlwfb3btyMsFGq0/Ls1O8+UfqMwLlBipA2fMXG0XBUxbQMVHMycpwUIGmDVuG2GHieQ2sBOCV+WEms9WzNnRgbAGGzgvXuDI1T3ACnooirUohGKO92JUgGDTYAJRQ1VwNL3JTUJNB+Ng+W0oDQ+sZ6cvBx4orAPqwI/vLAC1J+EIbQOSeEvu5ma9tYlfOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkMhlXsZodMWj8/aoxD22aQBNWGK9U04LHyjFE/QseI=;
 b=Hs4oqcUwk9zl16UwqQ0LLf+JFjiHP9oWs5cBdRo5ySsEcIgSrhAoHIwokfFzWcGwl8bcgWtiBFybC+nHBO59NvOEkV3gEtm82/LCe3J6RP5WoQOVL7x3thLJrL3XIY82NiR2xXAZl4HYO+lQ+ExXQLvxnjCFiQSoENm0C4kGNFpvqU3XHoERQDf4Pres+deA+AUKRXVxTe/qWlm/PAcVoPqBy7DQbaHudtTsJW/nmnAtsTQj0MUc+QsbXSrwkugBJ6FYbsVw8+jMeeJ6tlVgjAJ+6bUxJ/t+HqtV1QZr/opEuaRq+HFHREswSEYOEt5ijN+Sv1bDzwRDz2bliURAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkMhlXsZodMWj8/aoxD22aQBNWGK9U04LHyjFE/QseI=;
 b=G+zmhUSLGG48GUptxepHcWrbRCjbocnzf7hIhkXun1ti8w4KIuvFxZYg5ZnDBi6dRLcV5wcvZrNu6F+urIsEEnswghEIfYJwO0yeGc/LNzROI4cCXAP6g2FTr1WgXmXWg0h4wB5yyPsBv8gXimMVUTJWs31j2M6SiWEOe5XoVVdkLcrzFOMHWR+K9htexrNnPhOjTSB3hxQ8EEGfRj3Dl44Cij6Z8Mi84Ni0MdJuQqcwaHnMtBrNuuGOtjdyPs6WHARGGaSSa8++pMnVxbZdwsUpRunjha1YyrQYlNErcMOmCsTLgOaCpUCP32asKu9pnaVWLlxPAYeMIsCrKlCFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:44:57 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:44:57 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: rrameshbabu@nvidia.com
Cc: ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	hkallweit1@gmail.com,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	joabreu@synopsys.com,
	justinstitt@google.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	saeed@kernel.org,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	vladimir.oltean@nxp.com,
	wojciech.drewek@intel.com
Subject: [PATCH RFC v2 3/6] net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
Date: Sat,  9 Mar 2024 00:44:37 -0800
Message-ID: <20240309084440.299358-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae9d297-2aff-42f0-9346-08dc401532e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SNlQ4eLX2cEJmZJxfcLRmZH3W+IDtEE5vvV4lZelCaHb4abnUhbcHkBBmN3KCPaO1HSlvMumf2uk20SxjDnQBIPrVRtAkR7HEYwPeMqoLQWXajZYL9zLJJCAWZD+IgioWT6+C2e5mxuzdcdzDWMoab4MowhvAla0rIuNjztQmJ1ptvZPy1BImuXXswR2ThTdGL4CEByjYm7ZW3ImLJm0OQqciiXzPF7f0kLJAigdjF0DKDRdwST4fgeIOdpZsNCVf68La0725O3rDp/duDo55FxWkxklIYbhzaapKOsPO2fsJUthL3IGk/QTUV6aogGf/V0pDJM5GjBq29+4+mEmg/4kCE/OYx4ffZ2PCoNpgIV0kt+YtIOGgks2pOTn1HwrFmc7Qy3ckagJLHSPi2S3+5AmzE3rQR2gEnzbfPsmq39Qa+GKnjgTfifbN3EyuTGgHN0o4BlxzmBDL33GEktFgaw1w/wZIrFeXRSlRG+k8r/Fac8Lh442OxCrjDVkYFXJI1+t+Gb3WMf/FLBywpOZ10GcyNcBMx+CJMbiG2bPF6S5ztkFhbiYOzmenrBjk8jYYWHUk6wR9qNJL8JQHP7tTlcua9f3By80dsIi/TxjBQsvj7OGA0L91+Hxn1cZ8i/HN+HVEzoZT/4Ps5Mmr6lu2dQqyrjyYVzafYWHSDsQMBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?man5AUH11nHWLpaBo8adj6z4kmXDm2hu3phwD7tJFq8W7DRNVScQMARrt3QY?=
 =?us-ascii?Q?hXtNCJkPm3x0fEBLZHXg1yAzGsnFKSGKMBy01GasS1wY2mB6GT9lxjdY90Er?=
 =?us-ascii?Q?FE0qzMcuSiAK+HqG+cSZlQcEVPd5loxyL0oRC8Rxw5AtZYSyyQ4PePmu9ovr?=
 =?us-ascii?Q?dxSjhFgkUv+qNpvt8mGuK9Z6/zTzuY7LdEv0rWLPToqqUP2KXIDCnZO/F7sd?=
 =?us-ascii?Q?/V9Gle+k7/tgik0L1CN+2HqPhFlUYlmQ+agOhZ0NXe8vQkaSF0hnVyKFjtFr?=
 =?us-ascii?Q?FjPRRqSAboV/YoRsy0dDZ3hm0zjVEf67teAyYUQXXqrvuov8G+qSvckLRSLl?=
 =?us-ascii?Q?OYDvh3etsS6q9Z/7jwPmYkV1/BixdwZ4+rJFqiGMSd2jREzvABrdcoxRyTRy?=
 =?us-ascii?Q?6t5tWPb8RG6preHEHJCh9zePkA5mYdrD+B933FlfYiv+k1TvIuLhDmqzmsoI?=
 =?us-ascii?Q?W86MdUed/qzr/MaOx1L/FkbnNm2EPZaZ3XN5Rg1ACVMdrkCDy2pKzEopkzqI?=
 =?us-ascii?Q?Q2eer9YKYLl1silIWXutQJFHcJBclMZ8tnR+azeyfvMGxwfEPRYP5DPQWsKG?=
 =?us-ascii?Q?AYnKqCoxMVEp/pZTP/etfWIvv+zhe/qsG7Yzg5W+aoGlj6jGDRf5CNuPWyuh?=
 =?us-ascii?Q?0j9/yP5rbqjy2bxnE3u+ouMw2Q4m28xNqWe2YcW6yJayuEIgsjTu44t9BPvM?=
 =?us-ascii?Q?0HuU167+LwwgJxceeOF5qr/ZGYH+T/ov/tf02V1pmm0BvhG5StgVEwXGiPyR?=
 =?us-ascii?Q?W0mO/zH3uYFyStGSF1Iwwl5zLSQfqeplGiC8oJwIVl3BgK+I84yk8hb+PEnu?=
 =?us-ascii?Q?NdniMAfTjUkqA3IB/ul3swJ0klgVODIEt4G1MO5wE8PT6L/uyThhHAntk/qJ?=
 =?us-ascii?Q?0pNwWJKxMJFDEFW6ZRLvSPtaFDd6auFWIqZiC2ASxdbm5o/gHZtKg7CCO2fW?=
 =?us-ascii?Q?VdFH+3y0Vf/kcV/eT8N8V/XMvT7ydNt0XEdo1jxZdeXLAfFcfSaJisbPxa2e?=
 =?us-ascii?Q?C/F2qaoStwruFwrL3sLuxsy4EBdR9jo3yMuF7yMz+yB03OwPOE9l8KYexhus?=
 =?us-ascii?Q?m20fTRU7a7HKnGK6hfEfjPgHxJSaVtmAuLvmK0dCFn/tdVIGNa4PJnYYKHPY?=
 =?us-ascii?Q?d6089vpw7+cYWpwP/Ahr3PawxwfNYKMDwYrxbpdW1xRc6QT4Ol91BWpxmx1u?=
 =?us-ascii?Q?k1ZQ7Rx+wseGuN9K/84m9BrX6whrqsbBoAgWtbnNHcLIva7LjqYAgh5iPEF3?=
 =?us-ascii?Q?L/DB1v/+E5vSgX+LD/Bj6+V2lxhCDrfW4ReNHThbwOeK0+y+bNVhQb+H6jMJ?=
 =?us-ascii?Q?SlS7pm8VCLRcP4G/sGcac+FiYp3fDeKd7IW0nNeQrf6wiTeaJhFQiNUfVMIc?=
 =?us-ascii?Q?+O30zsjLwm/A44q+ySjbkg8XBHiaeOGftdobEox/bQCny1WAvk+TuOXNqalY?=
 =?us-ascii?Q?QxLvom35ylzFd79Kn12cxZ66bqrh5bkU5NGuLaEzjAKHheuGP60QFIWF0qHg?=
 =?us-ascii?Q?L2hcn79vsTJnGPKyo6IUz1i8aul+73GNOIb9Pm8YoFT4HnY4eOVfUefQGD1Y?=
 =?us-ascii?Q?rfbjGkYdJ8SLgd6P3P9RmTGBBetWhXZNN+BQk+vaPpqIxHSXFi05OeK/1ifg?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae9d297-2aff-42f0-9346-08dc401532e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:57.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEkB38Conwe5FeCbMerGIG2Kr/UZDg8Rjlv5J3pB1iLPBhL1NN88Bmwqitee5TSGCRNYxPYrXm0qVqugJ2i0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Count number of transmitted packets that were hardware timestamped at the
device DMA layer.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst      | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c          | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c             | 6 ++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 5464cd9e2694..fed821ef9b09 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -300,6 +300,11 @@ the software port.
        in the beginning of the queue. This is a normal condition.
      - Informative
 
+   * - `tx[i]_timestamps`
+     - Transmitted packets that were hardware timestamped at the device's DMA
+       layer.
+     - Informative
+
    * - `tx[i]_added_vlan_packets`
      - The number of packets sent where vlan tag insertion was offloaded to the
        hardware.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 7e63d7c88894..bc31196d348a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2046,6 +2046,7 @@ static const struct counter_desc sq_stats_desc[] = {
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, csum_partial_inner) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, added_vlan_packets) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nop) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, timestamps) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, mpwqe_blks) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, mpwqe_pkts) },
 #ifdef CONFIG_MLX5_EN_TLS
@@ -2198,6 +2199,7 @@ static const struct counter_desc qos_sq_stats_desc[] = {
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, csum_partial_inner) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, added_vlan_packets) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, nop) },
+	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, timestamps) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, mpwqe_blks) },
 	{ MLX5E_DECLARE_QOS_TX_STAT(struct mlx5e_sq_stats, mpwqe_pkts) },
 #ifdef CONFIG_MLX5_EN_TLS
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 03f6265d3ed5..3c634c5fd420 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -429,6 +429,7 @@ struct mlx5e_sq_stats {
 	u64 stopped;
 	u64 dropped;
 	u64 recover;
+	u64 timestamps;
 	/* dirtied @completion */
 	u64 cqes ____cacheline_aligned_in_smp;
 	u64 wake;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 5c166d9d2dca..5acba323246e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -748,11 +748,13 @@ static void mlx5e_consume_skb(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		u64 ts = get_cqe_ts(cqe);
 
 		hwts.hwtstamp = mlx5e_cqe_ts_to_ns(sq->ptp_cyc2time, sq->clock, ts);
-		if (sq->ptpsq)
+		if (sq->ptpsq) {
 			mlx5e_skb_cb_hwtstamp_handler(skb, MLX5E_SKB_CB_CQE_HWTSTAMP,
 						      hwts.hwtstamp, sq->ptpsq->cq_stats);
-		else
+		} else {
 			skb_tstamp_tx(skb, &hwts);
+			sq->stats->timestamps++;
+		}
 	}
 
 	napi_consume_skb(skb, napi_budget);
-- 
2.42.0


