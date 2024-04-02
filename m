Return-Path: <linux-kernel+bounces-128681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F7895E17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF09B26844
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3115ECC8;
	Tue,  2 Apr 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l0mGLfZj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC415E5C0;
	Tue,  2 Apr 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091182; cv=fail; b=ZC6/GlEr+Xg4eFL2ocsCM+EljAPvz4/RvhPmiJx9c41BONFgrFfdEacUlVlx2mkBfpbP+49Gcha60T4fzz79XgXM5vtzAy//V5oXUpzbz2eBslVUbnyFNo6bljwbWLwSMAvQ0Z7bDBEYatCUfRE4TH4SZQI4VuyN+VlQagnydYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091182; c=relaxed/simple;
	bh=NlhCiYtdLwkmc+hC/Q7dhKKn+EFCgunwTcHkbnFAQc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpJ4GVyplOPiAPofecdIKGuzNWEnLbV8hPMX/DYp1kUXrcB0b0Db9tjp7vnCDwt+kz+Cn0WKxHhmxWHwKFkYdjGrL0UV6H4Ika5B1B13auH0Sg8oz97xCVTSAc0APZgp8sAAnG3JXDj0DauxQkGiH0gkT0IW7YSmiJaZBsdUymo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l0mGLfZj; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY0l/bLozFGba7FGr/LMIA94xOpoS6FLkZXOM7Rv436ZaLM6rhoDfXtB0VsWnz4uDft6qpJVqqyNUUDWg7xHl9VkECPDTfbm28HBtYytQ/3RxPiFb7AtyrMDA/s2Y2bViPI/qYruIuosa7J95U4dfTfa1OFshRvEVdkEmwHkyq4qWqN9aHU+YqRjpBzITOb8cr9AcIgM7JmUoaylHXIPB8d1u1lUx26ce1HGHnBz7fZNbzvn07SitP3BJRHNYZ1ms2gkDXx1rT/QFTZgmrNYGZqxPAbhDlqvHv549aLQkpbzrj9dPvOkf8xj+Lj82jurDuIvaEssaLVokQ2kWfFm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJynZq47AZ51ddW8veWZuitCK5J0k25xaq8Bltpe0GE=;
 b=QCYNgkaw6BoyJ25WwRn0ej4OA4UoWndC1GTHdAQefz2bUcCRgauwU2iTtxJkfswZeV26Om3gHIz5ey1xjDqv47LsnbVn0hqa5kLVH0hnEQ+uJIzF9ZiUydgwqgBzxTHQkXPdtOTtVuGsGHySyH0lVGPQlTsM9GSjSvgBnvKWCd20mJ7Xtp37ihOc+7/GzOURdT6dofTnOtD3/9MLQdtBZo4MoqTZJ4N3kkOvmzoXnTC8iG88ssX3fZ8L8UFcriCXMRBdyrfGiS6qCtLozM/qS+mfZrNrOwW9V2wQY2pjXFBCaKUqnMGUBhHkqWJsuHhZ/JS3cWy6bwYspPf0K+xUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJynZq47AZ51ddW8veWZuitCK5J0k25xaq8Bltpe0GE=;
 b=l0mGLfZjD1cXI/b+lsH1a9Dc691nLAltl1BKpsaOC1Ks5I+Dnq8VsZxkVWyCQiChdW229dFDWGYmKiH9rjg5awJN9G3mQZIQeeJdWf2aV4ZPnqEzqt9Bp01gTL5zLVYymVgEx5bva8mpZIpGmTpPRksTpUi97oTmYmL4TVFmXyT3qj1Wn0iUFUXvO50KniJtziyIjmMlCuY/yCcfwT3PU0w53dUHd0A3ySPOYZU7hM4brqRjOiDYzfG3/AE7t2Zd2+YQPEBP4lIOLg+L3e4S5k6wRy0meReKT/79n6tBcf87p1Z0CCOi1+E8aMw1glrez8+DrQ+EzLuEmInkr6M/dw==
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
Subject: [PATCH net-next v1 4/6] net/mlx5e: Implement ethtool hardware timestamping statistics
Date: Tue,  2 Apr 2024 13:52:04 -0700
Message-ID: <20240402205223.137565-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	69iUCWndM65znCEqWz0kbZEnNSf7I43clZsP4liOF6aN7H5RQSUz8xtRGVjp1U9KRcM9s0O7SU0t7LbHdWnHxVKOLgu8YF6zHcKtC1z2zdy3b/XXbbUHHFVPkj9L6P4Q1DFWiTtArRkyDl5oHWStnOqz5VPQxc9E2rWV8bsKE+dZUrd+tkC26MzrUmyDy0cRjpxLzFGDCq3VCh9SqMKcFY17SKlmJg9/g/tG2fWwYNCdHAMSU2wn2B6ULZ9ss0V/0uTW9Tc1PRxfFNrwXygLd8//dOYHVvRB4zLSj+gjLl6IZtt2WpAY6sF3H/v48oDiCD7ow+io8rU9jy/FBeB7IzxM5hsmy1o1sg+og1FH2wJnvvNKVyhBYHzC6EC0by9GzFtq2DulQ0u5ws6fJ5BIuodiAvqqmvzqCGuOCdjBGPAG8VQwMMlel7jaJUaM1zqt9bWrr8yIW1P1Iph5c3Rr84O84F5UY6wG7Uw5iSx5IPatD64Q6f1FBX7g5uogr36Q5wpw+9ygsRc7x1DcwsklPLb3/HJr5XE1khrFhM2gOfCLL/ZbPCUYbEbWenNfTVhivbRrqjzd38GP75HwROENxhs9B52ovcHJzUF1NR5AvBcYkv+RDnD8eP59q2suSFgbnVgaHGxrbvMzDeWAN2JaSm6UQE34Nx0FVJwmlMUUxY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBKeA+OqUdHb0mcQEm9nTlpg5BWDUwJYmLEbKYIw7bZuWimfpLTdn4nXBO5G?=
 =?us-ascii?Q?gFhqiFb5dSm05b4s0LaFWJBboY/HuLjMjHWTm1aOhldECLp0Zz4A+m01FlK8?=
 =?us-ascii?Q?KQoQ81Ek4KRCrqd2lrFtCbxPUN2okZGi5tZ60YFiZQPxl/5bxkBrsmaj3UFr?=
 =?us-ascii?Q?DY+YyaZIrMK6ly3zDLRMYPPqofsilzUReFlp0Y5Uadl32XFwU8z+n+jIuzx/?=
 =?us-ascii?Q?/iyYjwNPhxCwUXr68jyTXzs9OK+Pr8juhmvND5JIALabnakWS1Flf4upjltz?=
 =?us-ascii?Q?ruzHV/Td85uhN19NMCVBBh7QlYDdCcvG3lx925MhBdzHa7qVYmzLUkoljVfJ?=
 =?us-ascii?Q?7ZiQlGyJU7xOvhZOjaTJWc6ud2riI63oQdN79aUoXXBETdh1ViSThvGZEOVs?=
 =?us-ascii?Q?n+q94K6huDEtZQ30NWna1+Z5vAU9wT5LhVwBtQu4heW3xKiHfUtxguro6V6w?=
 =?us-ascii?Q?ZWMg5TcZjUIknaB615WrUlIqz2aa+cbYM1AjbnZ+Rxi3nMLN5t61EEiXwaP1?=
 =?us-ascii?Q?IDpOJW1N5Zr4S8EwjqiHITlji8MW8/UlSQNtFKZC/GhTVkNXpyZbi/De74Ip?=
 =?us-ascii?Q?HoxsSuzB7p4V0izmSCiJ0P5bN2Yduy54Ow7vRWyK86XHoPKylu/udOR3/z4G?=
 =?us-ascii?Q?BJxcsWT+wb1lkENCTnfIGczKUlV1mWUIcQd5riilmSNg1ize62VoQdash0HB?=
 =?us-ascii?Q?8vai4UPY3mH7Ur4L9Ni14CjvYwKbtc2dvq1M1O39xUgs6DMBkv38FDnLx3ua?=
 =?us-ascii?Q?1CU3g0lMC8Y4cNQjc9rrc9epEyV7BcvdKXhnLbqRwQ+RgAet6AvVV7Saoped?=
 =?us-ascii?Q?XuaoM9bYYnx1rN8VDu7hSZY7caJehdy6Vrf1B6YABFkrjRGe69zqAIoi+6RQ?=
 =?us-ascii?Q?qO8llFvYOdmXxPAOQqn8BRnE0uFmlnc7NrtwYdv2sXog5xdMSnh9kiV4+7KK?=
 =?us-ascii?Q?Tzh8VcL8EmY7Nx8D3cXyeGI1+9E0FmuS/yqxVYv0uDkDakNvfjkQrjJeATxm?=
 =?us-ascii?Q?JmneZh2IXHtpKRf7Wudu2AKGuh7OeKa0lX3mYGMZIVESNPCIZP1NvJoGUMxm?=
 =?us-ascii?Q?dDaqhySagsWRxiXxtjlqYD382U0mbdlfJ6yaIfiO0NclrYaiCeUYKJcMGJmH?=
 =?us-ascii?Q?x66CILAdCg/GhzI3MoevcWIiaPmzYuXtiWfbCzJwfIjW4RgNf0KuScjfH+tV?=
 =?us-ascii?Q?hjeLzX3Pos9w9GjU6UTzSDygNTNr6/pFbRMMlNYGthYyqEiqcHJFXP5MBFKI?=
 =?us-ascii?Q?oHYjc6t8ZZr51X+rYcgkQ5Mfbs/EjGxJPWEImKAPIiBD2v5G2FnkcB1A51Ee?=
 =?us-ascii?Q?NJ660Nqqi3Uv/ypzVNKQSyCJ6CtCGD6EKjIlezf/uIS6gWwE5UdiNja/L6sm?=
 =?us-ascii?Q?LHQRXGj3u5/ARnXlA9i0RquOS0lFl1OtQT0FFgRx4NF8thxHAdHq1BoBeSuk?=
 =?us-ascii?Q?Xc+7U+1eyL/N+rtMPaoVUdHxOE2ijRfW1bqYyzKDf8/K70HU2/2rUh095xlG?=
 =?us-ascii?Q?w2YZabMc0T+/k57qA2UnLh90reFsoHqFGGoNsT7h0p7xL8E/dFxC3maR7jOP?=
 =?us-ascii?Q?8Nxpr59IlPJKfrN5nwskm0wSzZHUkAbPJ82yn2DPFv35a5raPunXqvh5mdcP?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d00c8d-c309-4fa5-1de1-08dc5356cf84
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:29.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+QBEox+JE6loSZtzZjW66c0Y0/wgQtAdc7YwXhM/M5N8levHtzAj4+szb+Zwpkuh+ienLwDgZNyug4q58TBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

Feed driver statistics counters related to hardware timestamping to
standardized ethtool hardware timestamping statistics group.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  9 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 45 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  2 +
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..d3b77054c30a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2381,6 +2381,14 @@ static void mlx5e_get_rmon_stats(struct net_device *netdev,
 	mlx5e_stats_rmon_get(priv, rmon_stats, ranges);
 }
 
+static void mlx5e_get_ts_stats(struct net_device *netdev,
+			       struct ethtool_ts_stats *ts_stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+
+	mlx5e_stats_ts_get(priv, ts_stats);
+}
+
 const struct ethtool_ops mlx5e_ethtool_ops = {
 	.cap_rss_ctx_supported	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -2430,5 +2438,6 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.get_eth_mac_stats = mlx5e_get_eth_mac_stats,
 	.get_eth_ctrl_stats = mlx5e_get_eth_ctrl_stats,
 	.get_rmon_stats    = mlx5e_get_rmon_stats,
+	.get_ts_stats      = mlx5e_get_ts_stats,
 	.get_link_ext_stats = mlx5e_get_link_ext_stats
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a06c6c80e36f..d8cf1fe99fb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1172,6 +1172,51 @@ void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 	*ranges = mlx5e_rmon_ranges;
 }
 
+void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
+			struct ethtool_ts_stats *ts_stats)
+{
+	int i, j;
+
+	mutex_lock(&priv->state_lock);
+
+	if (priv->tx_ptp_opened) {
+		struct mlx5e_ptp *ptp = priv->channels.ptp;
+
+		ts_stats->pkts = 0;
+		ts_stats->err = 0;
+		ts_stats->lost = 0;
+
+		/* Aggregate stats across all TCs */
+		for (i = 0; i < ptp->num_tc; i++) {
+			struct mlx5e_ptp_cq_stats *stats =
+				ptp->ptpsq[i].cq_stats;
+
+			ts_stats->pkts += stats->cqe;
+			ts_stats->err += stats->abort + stats->err_cqe +
+				stats->late_cqe;
+			ts_stats->lost += stats->lost_cqe;
+		}
+	} else {
+		/* DMA layer will always successfully timestamp packets. Other
+		 * counters do not make sense for this layer.
+		 */
+		ts_stats->pkts = 0;
+
+		/* Aggregate stats across all SQs */
+		for (j = 0; j < priv->channels.num; j++) {
+			struct mlx5e_channel *c = priv->channels.c[j];
+
+			for (i = 0; i < c->num_tc; i++) {
+				struct mlx5e_sq_stats *stats = c->sq[i].stats;
+
+				ts_stats->pkts += stats->timestamps;
+			}
+		}
+	}
+
+	mutex_unlock(&priv->state_lock);
+}
+
 #define PPORT_PHY_STATISTICAL_OFF(c) \
 	MLX5_BYTE_OFF(ppcnt_reg, \
 		      counter_set.phys_layer_statistical_cntrs.c##_high)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 3c634c5fd420..7b3e6cf1229a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -126,6 +126,8 @@ void mlx5e_stats_eth_ctrl_get(struct mlx5e_priv *priv,
 void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 			  struct ethtool_rmon_stats *rmon,
 			  const struct ethtool_rmon_hist_range **ranges);
+void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
+			struct ethtool_ts_stats *ts_stats);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
 
-- 
2.42.0


