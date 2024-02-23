Return-Path: <linux-kernel+bounces-79024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118F861C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5D61F24AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E1146E75;
	Fri, 23 Feb 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGlgupts"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AC143C6A;
	Fri, 23 Feb 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716445; cv=fail; b=b1rpNl85Vvf0oXESHxz7Pz7Bzxtcn5TKBijyFkPtRA6VpAXEVzL4OQynYjwZtvW8n0frKyqtp1Owl4WU6K/kFhenXOrBgyH4ldGcoDtTpwRG6youaKtUt827xmZAC+6+s6Ab7GpzNkMxwp82AKSG75KCQm0YxyR58spvENwgisU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716445; c=relaxed/simple;
	bh=fkIWIxg7q00NWXu2983DMgOaMBHbu2OR9505vsIKCbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eqt8eHPrqNexBoYv7giYHtQuk/NVunFXRCejHc0JT06qqun42gMVacn+EgrAYHXsmXvhtnW69k1w4Jhcv78VV9M3qPRjE6FdA/73TAwK+O8HMPN0KK0UVyTNDQ5zAIUt7D8jhRYoGhLSwpFEEqA99MCh10n28YcK5nlDqhfM4l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGlgupts; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohzl99EeDvyxGQZIfAYqvoDEVdf57D7HDuE8yx/0gtX5ZHVkG2XhTmH37xCTWWLUtfczod75gFPxjnHBKNGvadD6tN2vcQMhTXOWcXErrBfxL98tsULrAzm1eNZGaRm+YF0pJPcH/d3h1hm5G6/sjOnLz9XKI+NjM7zDoANM2F+J+a7AQBMbS4qLKbxHGnAqc66bFoYTL6gJ8R9iLCkiqjwX2ALgu8cWF6u7AmIY1vzRVyFtgF7p97rnYBUcuTHNqF+w44DuoQtvx9Z9Xpm1efzzecbkHefXNwkiepd8Qp9QRVihxN+JARZEPh44N/NgOnv73ja2IeCBdwTB8jOIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfVkymu7Gl6vN5rHt/lbJFfwQungApT9WPWAslGor8g=;
 b=DEveQ4JGpK/uSl1rvR57/vbp6jLugIHlu8U6vp2OX9sLPN1AHOgSEaHxRLfJwrZmhSuT7sltKmC6zzCD/BQJZoxJlnf5cv348xRrd7QW/BQepT+p52Fu52kXR117DdAyTa4n+lGE3ROAQcUIVoEaBxAWpvlQHjIErxOf73yLFocKldd3LdPIFr1D3V6oKGfoikTz8lC1Hj782r4ZMtzmjrshCiKKTA4NXYIZOFnoXPKJd9m5FrvQHDnaFUyABMGMZM8gNB5TYoibvktALAVz2QKfSFDWoOji0PP605gAmfh7PlgKHYlmQrIGDGo/OgNK3sfdUk/NY0jBPHpMHvcUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfVkymu7Gl6vN5rHt/lbJFfwQungApT9WPWAslGor8g=;
 b=OGlgupts6FZ3CRZZNeUDUqFrK/c0PMC9ORYy2c65LnMg1AOdY/bmc/c4aZf1o3DZLJHK/kCe0vJKfYOPLkub1SFQeSriYtZZu1Drc7FJB125hdi8o7XSPZm4hPVKDSbqILTqBUt2POf4s7M8xbW8/sBv9McErMv4824zNuTsBzilnyx8feO19R9gXNjLcgEkCGBCqKMIXV1NclU63h/rekSWUcJtn/QR2RXF6WjmEWCpV7GCbLLtFwYzLgcTjbim0WO5WXKEtATclwiCb5+1kZoZy3Y5qZIJ3XJutQUiBPFnZq7luYkw8Jj96Nz9vX92snFwDXdQ8uHAAqHO3DCIgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 19:27:20 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:20 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC net-next v1 3/6] net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
Date: Fri, 23 Feb 2024 11:24:47 -0800
Message-ID: <20240223192658.45893-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 690cbf36-19b2-4467-2dac-08dc34a5742e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WSS/gpwl3aftD8UWckIAfDospyLt022LjL38AEoNkQcyIYZxaGfRgbmq39mKeCEGFTNV+OGDdHqVD3M5/6t2FYhnWas1ZvNxtneFAs9CvEtosCyThAuY2ThtRNzT/BqeqzdYl8U1ibVmphZhgxCq0yspQPei8wyREo6Up84SyoOhH3Wej0Aroiw63dN3VKNqxFETigXeqlifMRwTxR+6bN765qLRrQseyoX5Bc9xxgmfpgsLwKpSRsDMK595jy86XcYcIKoDDH4MrAWr+lB3LV2WGqSiwfKuEVVZNASLjJNCX/dX4eGNJcdPrw+2M5umNP9VXqnY+5gV5G+GHg0jEp6e/8FzRYqsALuGFn9sZA7UH6JnmIIbm3A42+YuhmlVHJlRPjkIessOGm3asZ5Gw4TIMVTetLvUMG8PRklBD/aACruUnzGiqQp77aZ/aQdqPdHhLYzDBvqjMgetDmKrPMjMa6dreK4/prQTdZGx57g7YRpL+i+uswfoy5YLHtBZkytSyr2jVVXJZEi5xwWve2MWiVYRLOxFfavt30+3kOt0M0UwJyujp8Oc5PBqEL4qmchzo7tlJFITm5pOsbERo1YWI9KTXV5exlXrO7+Gt+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXri+onAtEK51YujLJoaxPvBwQkl5gs0yBEfEm45VUW1nlE27hkPNgRVYoGG?=
 =?us-ascii?Q?vfSeA7NzcCRwDkpcg+wJ4l7foFU/T8OlZnJIpNT9b9bEu/zXnkLeXU8BKZlm?=
 =?us-ascii?Q?mQ3ddJMyP0W4blUjwEa4Feg67JKknP8HcVgt9m1k5b0w4ZEfACH7ljKgX1u2?=
 =?us-ascii?Q?u4TI28vP7RI3jMvwBbIcb/rABolTFzukWUap1JebH17y0IjXOWCk/iC3FRIC?=
 =?us-ascii?Q?ybY334fSERCjqz1oLVR8dlUOaJ34xRFQtI2rayGQ95DDbYQGYnsUF7XZdgsD?=
 =?us-ascii?Q?3SepGPcOtd3wc5gnALWo1v5RZUqynr5zyZb18UOAtPwL/8OFrW8pXoyawkLw?=
 =?us-ascii?Q?8GNX0kTUMNB71Vfiy8obpJMtRDug2AdsVdbTuGLFMJ4LgS5Uo/kxndZ89iBk?=
 =?us-ascii?Q?0Qf7H3HdLYZFFmeyPkSO9iWgQdQVxQ/vmEjl26rETguMOGXr6Qe3ywvHMUKB?=
 =?us-ascii?Q?2jJ230u4N+iU8f2UOh1X988FVsInK3oZZVaMgnlrWnzhvNzklB77If10fI6e?=
 =?us-ascii?Q?Bng7uNU2mdVuLL/XBItOdmxjgoq1tH9VbzWjKroT647ioD9vufVbckfA8QgU?=
 =?us-ascii?Q?ZiDmRGaU8VJ6r2RE1LcePYRDhdy+F1mmX2Uc62mOJZRtNMz9gwAuFaGQNzEe?=
 =?us-ascii?Q?z9gRDZF0UK9B4I+OuMC/eIfesiRO0ZlyM52zYlDbkTMfjsNac3U/HuJE8IXj?=
 =?us-ascii?Q?zkPurPsU95LW5zLk80NBPHsicpw5bHs/kqmVczp0tE4Ty2RgHqgZgnJ6zdGK?=
 =?us-ascii?Q?+PVvc6YNKG+J4/+rdiiTeISh4fjVjnNtuMWefWtRNCdNkhHDoors737CBBoi?=
 =?us-ascii?Q?n64KcbonJJJq485g0yR/Wvl2ZUvz+RLK1T7WWuB+jqAG2DmVWXZyvjQ/Xnkq?=
 =?us-ascii?Q?7bxUthHBZzOUfL/J9xqTyRBI2OTlaqU+9MKAnWOBirmsdztjnIUi2Vicdt9O?=
 =?us-ascii?Q?zNUqv0Jyx/qlTefzhimhwFCpgp7xLaMwTgQ+UTsLBZJWR0Q+BHKtpFRyoH/6?=
 =?us-ascii?Q?UceqiURO4/Ih+/Jzr9vgphMWnmPF14J6GyZTQ2AnptN0Ill4DSmJVLoyUCws?=
 =?us-ascii?Q?TgFuhW576ksbe5Iy+PbVR5WNT+klzAu9v3d2tfsBAIkeLmMFEXkchJehVmaf?=
 =?us-ascii?Q?ri53PoWgzZN37VT6G/+hDOOG56ZHU3FVqwhfvj3fbO4fOkg4AGZN9Hg9sdOs?=
 =?us-ascii?Q?2X0bs2vUpD4wQpyKKhIHi/pZfRILKJNPlvZaABFi/SRrVl45jrElaZsrZOQZ?=
 =?us-ascii?Q?eBxQBjGURZlJrFYDMuvaAkhpf2jTIxWAVubrFb0fFf7mK6NLiPaX0Sd5IA/r?=
 =?us-ascii?Q?qs+63KvUC/BfWXerYvh3AQcYdYnHzlB364F/bFyIr3eSsA8DdENBCvJwyifk?=
 =?us-ascii?Q?V7k1aozjPTUb1Yke0vvnpUhXqgvrkly0WN+VEkhljhLPme8sRK4tvnb2KthY?=
 =?us-ascii?Q?GJGyPRPpKjpMg4wiIIumUWHNIrmAfOJuSGMobwgxSgYJfOs2LuIPwWdSGqie?=
 =?us-ascii?Q?vpC/TJff43C5g+TlOSSYdFcC2JczHfVGIgUzH330PAjHOgO5P7OfAshJZN2h?=
 =?us-ascii?Q?4WIb5izENM2ygiprzbZ8GteWa7fsq6tPeokH+HJArfpCHMBer1ZlpI+przo6?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690cbf36-19b2-4467-2dac-08dc34a5742e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:20.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlePfRoye8BCm5ZNtmuZKalWR+S3c+jQ9zbhNhgi5FmY4ENf79uOGxs2e9iSCbrZMMOhCgm64Ti7gN3zbnzz+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226

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


