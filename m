Return-Path: <linux-kernel+bounces-130629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FF897ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEE7288BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF60156874;
	Wed,  3 Apr 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YQqbarAX"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2097.outbound.protection.outlook.com [40.107.244.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CE156C62;
	Wed,  3 Apr 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179790; cv=fail; b=LZg/V4GAqRuyJVEXRKsBouhq7/rnw0prUUsEAA9+5CN5b3FHhOONeGltD7MbTolX5LIyoc9VLM7tMaNp0hteGzCK+5OGeSmHQuW5MstLbZSWWTWyejFTtmDnfqXhxkN2/kEBqu645U1/G1lsrZKzzur5Q0Su/00tQnzFMlI+geQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179790; c=relaxed/simple;
	bh=WwhCAT5WSnm2yd9jWnS4IDeSKji8NSr3NtaxtHVz2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qllvmwV4GhCl+isl/HDHKgQ9uyIst2dGDXxlfIuDQObJpEinsYOniUHyM5zftjmO4+/hIuthzy9dSzI0XASU34Bgh9QITjswl9ypnt6kSUGtFmd4Sp9hG3n4HBoQCJ/Swn+lbwcyoaFPN1lLEFTLUn7HbzxWr5AY5rVg9EJ5M4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YQqbarAX; arc=fail smtp.client-ip=40.107.244.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG27bhtPQ2ICkW0rsem6I4j5IpqR8hnZLp2OoiXqhWZe0gOF1XCqzW/aZycTsEfGGlXLEBcJVsmLZORc9cjyUZRiCSZB80njMByuN2Fv00shdHbt1dnMStNdOYw4klV4d1w+tniOZ4B/06C+3Lw/Qk7wVT05Ka6yHwytuxYhA2N7hqzFgJIiA8ibOwgbmr8ZzDf0wIyA2evcf707F2xIP4sL0+D5GpDhTUZY4A6DvDHUsNXcMbLiytoGR/hYAbbd0cFkor4+UizLV2/Fzb2hiPtv2q8hW3cfakpLggnyqc5gVsickZt0WcjlKlMz1m7VmXmY/XFJAC2TmFCAqk3P0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsYmuphJHuA47Un9AfdK2eX8onvVH+g4LnJUTGpZUkI=;
 b=H3fAEzGuR8E72VOGf1JZ5YmVBEFBiT9RLFreBCvU+UeaMvlVvIVs0D87JpmPFOEK6wgfGhZTptKc8K1QgknqkbwD3KvXRyy8483fZusWF+vLlPPu2MBgz8Qdg+erXXEfa1H2S2L4y2veAbZ7by82eWZPwkjT1mJrJzTUPqDBtnVQvE0AFHbTN2RlxYjFGTL9w8190XFyBaA3q/xCOPVMDb59wGpoK9+FYT3B1d5tXh74VU5totTJ+L/4EQo8tAE72TCyWoEXc7aDshBfAaXZYEBRekUnBLJyTnM0UcXd8bdPd5N1IDCIPXrROP/UoaCekm7LzcNIF1SCdR5gwbxrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsYmuphJHuA47Un9AfdK2eX8onvVH+g4LnJUTGpZUkI=;
 b=YQqbarAXW43ckJvRQevTrpgmcEsAUrP6u+e+bAwQK4jFo65Wt0w4hmGt6gJwVJ1SYH/dRchOj2svaEayc0J8It65JGzQ3HYl/lCyyJp2Clz4QxERLbuHi7Qnin+2hd6lQWI5mY+Ot9fHhFtvIf3C62l8JBiTNTg/FPXshHrrPX0ESxNujni3aw3I6N9Zg/EVTas2AvwQmdkNQkpDekoJWNV+wsCcyFnr4Gf0IrCaGQJSgAib+dVL4g/WKDxBON3m+QxVkY9+T4gAAsmBgG9A0yHuLEO6c9szxjEMLCq3cnvvP1080YOFzwKMGAd9DbePgjclXR75DTo3bioev4LnjQ==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:39 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:39 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	cjubran@nvidia.com,
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
	liuhangbin@gmail.com,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	saeed@kernel.org,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	vladimir.oltean@nxp.com,
	wojciech.drewek@intel.com,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next v2 3/6] net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
Date: Wed,  3 Apr 2024 14:28:41 -0700
Message-ID: <20240403212931.128541-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vb+OPPT1PRuphbg5LyeELINibLQThB/09qdqukHUICCyahHeTMzqqb+WHJ8vxVn4GuiDUq6BH1VRf5NWt/5lcncEhNKHWtiMeddknMSij3T4/jukXdBRDjwKT0ejGczJimIRPlhltCNlul0uJDhegqsqE2hZ1GeL9zrEU7HEi0tdT681uurGJVEUmBMEUezE3lJp5nf7YWa3OSJXF3ukUeSgEZD+2P5ILFIMP2LZyOhx8mudOGzUQueys4VlxNPhyy6Ix7JHe6m0O33GYcIqbe0KAkVdUvy6ZwbuN5z79MzOl6uF5La3EqgQH/ehNRd9pjpzFyQAbr2N7vfI25RzW3A56W3RTvFoT/bTBPYs/JB1pG6ZmGd2DBIksBhEPHkROybsR97UYn5ND9D80eiyGEhPXRqVA+BbN9vlpwac2ex04CLRrRP19tuJsgCRDJ7WumQ5tp4J19XrXocEcXdkfCfMjtLeeKCHmg3eI9fdAj/sWarg2RvkjUz8Kp3/hwIkz47qJCioUwwCvKAXf97vWF29nyt2rbVrFvpFq9pcRLZ5qzOUvYaU30ytYnBT/ooFBabEI9As79bfLaizju7r4E752DEGYzA6sY0T3h80SAttIJIBAbceeM/bggFR2+7GbNOzEIelNBMwOBvGATSPoC5uOV2IG7I2fLAHe205ShI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS1lrVk9oleZrrYTDajn8uV3BR4V4jdznLoYzNbos+Nxan83LI90SusRbO+h?=
 =?us-ascii?Q?YRUK9q3FhhQP94zS1XjWOaK0/sE8f4ilJTRzGFkBHsgkEQYLrnRYQaqRaJmr?=
 =?us-ascii?Q?KyFhHaS3+LKjzNfNClGrLpqR5ngbcETnAWkwbXVwetlRY+5eYpXXjkmUFq31?=
 =?us-ascii?Q?FOs97DRZilNwxyogIA6chmR1xS03jw1pw4gCo+hIZO6kTXKzePBw4BcgMENe?=
 =?us-ascii?Q?gT2ArEKwE5ZdiFh1DEFkzNLY/zLnB5a1b/ZOYC6Id6H7BgfUFUJjS2N/itib?=
 =?us-ascii?Q?W4Jf/Czj3UP5FE9FPKY5vhqb3RmDpvaBN5P7HHepflrKYS0RXNH27s9hjLA7?=
 =?us-ascii?Q?2WTqv4oEjQobi6l4oQE2ziBSF/lxHPtDIpVbPsGDnW9+1hob1su1Dmi8vsQk?=
 =?us-ascii?Q?nFqgb6uqQe1xZJj8y1ZsD65hMbeFUsu7GI+oArbnPfQV+h04O/EH+mbn+ZEZ?=
 =?us-ascii?Q?E66Swkt7EKhsZIkK5Rpp8M5znR/andjIZr6EK/MJ6dENX/GBxzI7oTeWerTq?=
 =?us-ascii?Q?u4ZKMwp3CTBbn1QdnfjktQapxi6CQUTqyG+okIhAfuT/6yMoDJnsuYe4VCRX?=
 =?us-ascii?Q?0IzTkyGqV9t67yUOvYEtbMIVlxSkbDJKVOvCg9F9vmStyK70tcyBt1IE3/Zx?=
 =?us-ascii?Q?+S/J4ECUtWkwq/Pu76U7ymR2kfxZgdEL6Sxca4+B0OzPYQKpULkK0DDURBjc?=
 =?us-ascii?Q?3ZesVmKvccykbkU/KBNBedBNO9yf/SJ5IOuN6QHTGXh0jQEbNOwcuG+gkNTs?=
 =?us-ascii?Q?T7nBzca4/HXk/QqjXgeskfyJc7MO6C56pwHhR6kvNNkcJoLH4Hc6G/qE+jcx?=
 =?us-ascii?Q?c8OJtBbn06NYOyAB2LJ1eVcg/GDMxh6I8tefSpmkJj5aDK9BhtuNcYOI9HIM?=
 =?us-ascii?Q?mt/ulTlO2UnwnX3N2xXEQTIl7GI7ZKv9SCOrlxdkFQyTdThHccDAQ5y97Ay4?=
 =?us-ascii?Q?VSEEA2goEd1nzp+qLMK/tGWuRnTPbw+bXJpjCxzuKvTx+R5LHkdlxcfOSLEO?=
 =?us-ascii?Q?cRAwKoZ4/s8KpWdbMM/G12i00yX6O2xJBh5KPaOqCd/BXX4AP8QTfh9ssxe6?=
 =?us-ascii?Q?ZwR3s3FYf/Pvkr7uy7yqgpI3qzdyOS4gHiDcNo0ykahcl7qdvNGrtK29Qjll?=
 =?us-ascii?Q?ZcaSzoxOtAmP0/eIzwhg4lTOHVdleZrw3Zg4K0TNHinNIxbWtTMGAbwZt/vL?=
 =?us-ascii?Q?K0UKg49De+UgKFogzPJNQ6eW31QmXct+6FXPDM2ZnIWhdpVg/et/HKBlvIjg?=
 =?us-ascii?Q?fyRzRmDSOZvCerNihm0H7MLNk+piVDYAScb3+bZHsolT3fG1podpW+2M7Q1Z?=
 =?us-ascii?Q?5wN8NYUbY15T+3sSeKR8q6bjlGmxlN+EAswK+umvDt16NHC3iG+d2AFvxg5y?=
 =?us-ascii?Q?apaExMY/u7tdTmrhoHldQtaxmDJQ1h8URWC9rpJ139SLXOLAHfPidG+KLq1g?=
 =?us-ascii?Q?pEJSSsvYKSPvCYQiTwQJUFszH/oBo1QLKLwv3TDL3mZaVhZy2e4q8rmxXZep?=
 =?us-ascii?Q?SwfAM3UkbXy8N/qkD2AxaSr/19OGO+059Bc+mrRf5H23ngFmVuyLHVGD4LF4?=
 =?us-ascii?Q?el/coE8nARR+GHO1ZbrY7FAjsD6S3eq04dJHjMGp4zsCGDiVCJ0let/hW0Le?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb00f957-f1b8-4e63-d0fd-08dc54252ad9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:39.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc2DQx+BDgS4y07cEyt8U3gN1MkIygGBDYvH4aS1R6/lv9HeoodWjnBm1xp9LzSV9ctxqum5DreGpfhDDdo6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

Count number of transmitted packets that were hardware timestamped at the
device DMA layer.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
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
index 64a435f914ff..a06c6c80e36f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2063,6 +2063,7 @@ static const struct counter_desc sq_stats_desc[] = {
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, csum_partial_inner) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, added_vlan_packets) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, nop) },
+	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, timestamps) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, mpwqe_blks) },
 	{ MLX5E_DECLARE_TX_STAT(struct mlx5e_sq_stats, mpwqe_pkts) },
 #ifdef CONFIG_MLX5_EN_TLS
@@ -2215,6 +2216,7 @@ static const struct counter_desc qos_sq_stats_desc[] = {
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
index 2fa076b23fbe..09a592909101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -750,11 +750,13 @@ static void mlx5e_consume_skb(struct mlx5e_txqsq *sq, struct sk_buff *skb,
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


