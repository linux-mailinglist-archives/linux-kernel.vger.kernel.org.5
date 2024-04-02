Return-Path: <linux-kernel+bounces-128680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1F895E16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99995B23C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586415E816;
	Tue,  2 Apr 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NU/6IeLx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419A15E5B4;
	Tue,  2 Apr 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091181; cv=fail; b=W3/4xDJJ8jvcJWRReWSKsULVe2ME3Q28nRai/wXnxIpZM4+1wDSL75hssckXPEnCRdtsEBFBeNQaLQDxgq6OvFFJL6jkAW84tNJFxPqTIAvxvwtJMBpUzoVnJFlfoCRS7bs92LnaA5BvKQRRMFZ+GL9MsNkxE6v0E1Pb1Gkgec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091181; c=relaxed/simple;
	bh=WwhCAT5WSnm2yd9jWnS4IDeSKji8NSr3NtaxtHVz2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sG2T3kF1WyC+/qelVKrsMlQ/RARsnquw9Ll/z8ipJ2ug155JRzSLAbeYa416hJFGrycIU1sgtD7MxkrfrU7s0Mdw/KA0vZm48nvsHUgmdiN4RKVmlGOQQmSFC31j7YalAp1sgT+EWmSq1SRn91r3dV2Y2cSLEdkgcxg5vv8BhoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NU/6IeLx; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSd6A1vih4os4oFxYZfq4oyRtBbhML6LBgBm3i9cubriLTYwHhgs9L+qCBpRqCXud+AhEsLluYyteEY9L9nQGHkdNHAjYuzFeEZN8C8qCCyo0U5nBKme5QtkjlhBBoWxj64G888TUoqyWK7Xfoi04OlSZFNa320nCivHPm1Tkvdk5PodK/9c8T2Gr/Hggfh0DJhABShuOsZmoxATrwe+JMfpLKT0qh8eKp/NgjvZ6+EFSLTdhtCl897LuY9Qq0Rm8T7x5g0ee2L0LSIYwDuEzjuo1rDdAGKER4/xpqwD24oZS0hlLbJS3rqiUG68ErI4Zq2ZPziFoXwDPKMhI+COUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsYmuphJHuA47Un9AfdK2eX8onvVH+g4LnJUTGpZUkI=;
 b=nN37PEiv61F8wxfvu4bRtSiOikFFPNQxvXXdcI/5QWc5tT9Mk5dI5RoKYhc+N2yvoODTSetnyMo7d4Kn0ANiY2YaJVaxEaqurJ+iW2ON6luNeh+eYk4jjETTTGh+1g+ob+DMR9xq8M5mN4QcjK3j9+gDwGYJz/jmazhNiBmHxofAYCMr2A4gh8n7Wh7csSjrirYsCl96xhwjUlOUJ/0hezWyhYlQEWDE6ReFfWTpRbfVBTDADjytdot4HslwuwVuqHVoEfMocPGQUaO9yEBQcrmEWFhBa2urwIhQtq8AHdfhCG6E08pWT7de10EjpB8BzRaAXq7NT0M6wZ8QMZBZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsYmuphJHuA47Un9AfdK2eX8onvVH+g4LnJUTGpZUkI=;
 b=NU/6IeLxgk4/9bnJsvuaiqxUS/0tlhTXxfdXymn1HS64h4+uh0YDa2roBkrv2Hw0XTLpz+IRzubX2PgrG6AIPfr7kC8lAF2s+tOdhdrRy4ipNpy+2m4mJMtDJFQrtY44Y6sk/Ngapne41bJbpojTD5Q133DcMMO7dJN3tUekb3cGLwysuYalyn890Kq71ZkLmjZb4qTrBA9Iszr5MrblpjlZDY9fVAc2J5EEoz/zStXCbxIR9xeX//q8blbOnP0EigMS8DEUrJfgeiI82Cm8ihzUctg15A92pDOECaMIaUn02cqQjCw8UtlbO6ZTQOnS8foBNT6RmyC3cIDdPdozcA==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:29 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:29 +0000
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
Subject: [PATCH net-next v1 3/6] net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
Date: Tue,  2 Apr 2024 13:52:03 -0700
Message-ID: <20240402205223.137565-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW3PR12MB4393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DD3dzDQivHNnIleKOCDk155f3BpitnyGYcN9I1qaifgBndIcop2yAnExeoqQecNMlwyFt2/nt0FJIlG7YRd2dHXpExi6jKWYzrMLuKdedzsKghmhFS7tH2jzebZodP/LyPejmFhjzu2pbIfEBH0mjSKA8YH+N6RwEO9fwd1DyrygjpyjmJmNljWjWYZf61lUbCfLqraoTYWYIAo0B8pPSRFkOsNm2GL/JwQxBnK3t0tWSu1Pd2MTp13CWWzGA2vWCwh98ecgt+NErRNkQ+nAYgrQiJowmHgdKqWll0YselFCpMqkDDNvpF4TfmkTCBb+O3WgPPJYkNFR6KON16u8DcsSVwsRzCp7hpbAMsG7IXb1kRjgRf3Swp9VtEBE1yIFA5kDrt+QphdwdLQOmHZJjK/j2GeZVlzGOco5EKxFGQk9g2S/U6F7FeTlOMKLb7ULYRivIPKx5DSwNrdhCdzokeMJlws41zD7+xvdwItj4MpAMS0bo1Qfk51+rhKLhb6dL5yQGkeaMK3aFTVTy9miyxuaDktIo0Uo16dsv3txiKlCjoRtjEOr55mwMm7xyMFAcBs5vOsVrI+lGp3+SNvTdF8+4UtNrpIGM+XK27c9GVGVdrN/yokpiCuj9XUQ1QdOJGQiE7COELIJQgTyR/EfHpBY2LFQQFsZ4lIThJ6z/1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/K3sLiVaE5SwQvOhlQEt0c8+X0RbfPOvRhGzLVF1XVOqmlUK37Q6m2sc1W8?=
 =?us-ascii?Q?5vULPgY2Gx3LHUL/A1OQNSSGZZJctNh7RePeoMFuFy+fNcmLo9y6oGvb+i1l?=
 =?us-ascii?Q?qXLMAGWabyDb2w3rjjOvbLEVB/ecTMbJ11qidL5ElxMhPpFjCS00t0HbXoG+?=
 =?us-ascii?Q?+OnHBEY7rhZtzp90+1V1DXEM9A3izsGvPOeuurxHFopfHI1pm/jlCFWQpU/w?=
 =?us-ascii?Q?/+7bUHao2Po05/XQju2yv/WOvHmDlenXXQoAIj0chwQxQlKSaUadPj9ida97?=
 =?us-ascii?Q?Tq+xmtD7uukaT0FYRmzI2/hEvejWfcpGbxMEHcIQ+6F8zNJyxzboVZkoBSvb?=
 =?us-ascii?Q?psH77mgqe21P0Jnkm79x3nNKcI1fJ+Uf0rWlGXYLRdqTAGTRJYGZDD2vvPYP?=
 =?us-ascii?Q?WFNhq8ZvNn9Ak5eCbnlJ8R0CmUZV27n7E/K3tnnCmHbgVMknO8EjTcRBHY97?=
 =?us-ascii?Q?iaHoePOrcFPrXxYazXDTKneZ1VzOKg2iw+mPe4JmVf0wRgbmwbH7ysal3bAy?=
 =?us-ascii?Q?+ZFkQtFiaerdJXwzPDmfZ9kG4Snpc/2/3AbTOm2NLl5XW+I4WtJGSmr+gqxr?=
 =?us-ascii?Q?OjwwuNBrpCXc9K3fXJsOpw1A9h5WZu3rbkl3jpUEHIYFNOZ+Nf/5zvueeQgi?=
 =?us-ascii?Q?Z00f2isHj1+7JP8BB+VLcWJq9Mven2/E9zIOshViy7ANVLkGErDi1zV3QdlB?=
 =?us-ascii?Q?aCAs4b89Za1FHO9qbfN5dxGhNoXMRNqfaM+Me/UEgVBu5lX9nQIyGyXKObsR?=
 =?us-ascii?Q?htRBIWM/tQs7WBYybfncvm9RBsAjFk5FOdXTV1nWC5klLppuJajLzojjc/fJ?=
 =?us-ascii?Q?8yq1NF3sNy39WVmtuNrExuI8pRYz9Xbx6wz3xykuJErOPQ469Cp5AIcWoFAu?=
 =?us-ascii?Q?CxZi85/C4LzwnCLn7HE4nsT+sy4IYIDR4BVyzuBlAEg5gaIEyRyXLeKFyXY4?=
 =?us-ascii?Q?apwG/mV7iRKUj4LnCAVtQ/hnvccwf+qma0C5e4/3IVSH1UN4O19RdUIE8mAX?=
 =?us-ascii?Q?J699Dke0P3W3unqVVZIi/2Yy+5oiLJi5JhqUjXLUVA+RTPH5v/71HEcE7MkV?=
 =?us-ascii?Q?ztRmBWzwK7ITjkvD5xJQFi+BnWVWH9/Xm+SbvIf6NewnNMZzaxzqB6CbwYHf?=
 =?us-ascii?Q?TVqSZcOy+u0GU34g36fD3vP2PskMK5DvxA/xBVu5T2XgUNQ6W0G2dJV6DFYC?=
 =?us-ascii?Q?aVGZCDct/PWxZ1h2OvN9v9V38BWGY1siaY+PH+v434wMWGH0hw/yJmTobBGI?=
 =?us-ascii?Q?+RyLxRNHgTKEe4Qy4RUL1hAKhDIDQHZBgWwwgn/yKu3OOWSS55uw/9D5BEqJ?=
 =?us-ascii?Q?tuu6R62rNf8AVW8u5rmxTJDOfuxPuYHEbC10DZ3PObO6LOeBm1PVEXisaIAc?=
 =?us-ascii?Q?ZJwBAAmVomfEUU9DxTYA4/QGi/5vozWA8g9LhxPZhARsKte3nRSKmkuKRwWJ?=
 =?us-ascii?Q?VbuDGVAEmYV1n61z4oVSMH5fkjNGQdJFqU7WsSp48BXLRKJB8iP8AkNYOvCd?=
 =?us-ascii?Q?682ydXnG/E1LEIm2ZcJAX+/sBzHbWVEOpm8DBr4aECsCLeA8HCBmIaUOrjeB?=
 =?us-ascii?Q?3WUjItKLydJCt6NvE7BFoFrkdFV1l6qfbsYS5KMPe9De64unCZwJ9yQl52wk?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf4ce95-c0ef-40fa-632c-08dc5356cf37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:28.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2l7t0S80HTl98AMg8zJu71K+AjYfPkN9nYRqvzxWY1cEDztHqkA4dl2+b5gNpjpsTA7b/WVKDbLKRM4EqJklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

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


