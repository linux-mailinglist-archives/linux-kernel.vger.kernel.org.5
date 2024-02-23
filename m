Return-Path: <linux-kernel+bounces-79026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900C861C81
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38B4286155
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A314532B;
	Fri, 23 Feb 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gclZmedw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D678146E94;
	Fri, 23 Feb 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716462; cv=fail; b=f2o3Ffxq0J0jFBDjToP+EFm5pp0o1tF4ibr2b+B5bDNyG06AatQBvqqCozYdNgIHZIp2MvaZSSy/rBCE/lgvNSiwP2PpAVViDjXmCsaLgi0rif/riRBapLSi4An2FLbURZHk2h4lA83OzkWiy73Yw3NzNhTez8nGKnUxy+8BTHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716462; c=relaxed/simple;
	bh=zEalXwMXF988KW6AK0KPkvwHHZgauo3I3dbY018ghw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODdNTWkk492g8yT40UyGt6cdSXcpRxfCDI506E0JHxsNomRHXLVUICOplo9AqP65cxsiQBC8NRD37R5fcDjTENil83L8eUPQBanivldN94iUnjxxJWaBbjx46Pps3zt8ZlXE1BlB1YiV32SLYafxvFr6yCOKlrhg7bvNNaaI/8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gclZmedw; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZDQ4RI2b2kBHspAFs0+L7CQKCbCDAYnSuePri500ELo4Yr2e4wm09NbS9coJuAT8dy0kPuCHRRTPyW3nDHU8nosE/bU/5xqNNHqWkwRaim+QCIt65dg3vwByoDZVi25EEiKn2CIdkgyONuOSC3PTajCg7x+Ac1muAiEwWo2rxXDUOlwKaRqo1VcTd9pUHpNxqpPvBx16DZN15JGF5nWxYYgpXR9k0DVR9LQ5Sfb2nf0jPddYJxTYayqiPuDA2DFrWrghEmrQE4yrOdlWFyD0/XITbZKbEKLgxsmRlHQC/LGeEZZVShLWC217W+yz1KaQRosz/PBVGGUbpISj1bcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGLWjcx/NU3aS4NX9pHAeBP/j3MDW8Nr3/+jL/WsanE=;
 b=bgPGPLbwvW26YVnElGLBEHm6TG5TI9cXSe3l55LVTU2m1Wel6y1N0xkGw8RDeHhC9pD8ZVPRMXQiI+TgKpzDo3uF6M1UuK9cSc9AnaECAH1OmUbanBwfcaMmi4SswaryjBC1cy8djcallrX3vBG+4BBaIYHLO7IebGCUk8LvaRKyb9pGcSHnqloisIc/FZnAtE6cMu3Xn/10WkZRXh5Yu3/j+e6ZVH94Qua8Q0jYN9yM2ttk0OPnXdSGjRpJ0atvcPQkr46gCIgVpQ7Svm/AxDK2cV3PwJg1rrevdvORNtwJvvuWeLrAIY9y+l+AkBcETdPMNXUOp5fbu/sBlDEKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGLWjcx/NU3aS4NX9pHAeBP/j3MDW8Nr3/+jL/WsanE=;
 b=gclZmedwVI1vgJAiDm4H1W5RdTt9/t85xAFR7dSbyLbOiXcJ0lnuvUVbpZrqioFH63E7g/NWI2V1mDrnbYmhDIt968IUVh5Lr2Z+yt8U81D9H7gUmG+85Kj5goK+EniJBLYmJrmVaZNGQ09Ut7QDnIvJ1L9uVn2g+J4ASyI0WPTrJuYfa5mweXtnywsnw9ThkNgdXqriGAg22X662vv/ErK2ThbLMVp70cfqXKaaCeuNJjHaNAUJlQEzvDOh6LkoEMEjKFBcpmk/SSz4ruG/dZHTjmw4kUGi44Tkcqz2zHhXSqYBMYb6IhUwial/zaO6A2AD2hK0uXZf8luEDA1eyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 19:27:21 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:21 +0000
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
Subject: [PATCH RFC net-next v1 4/6] net/mlx5e: Implement ethtool hardware timestamping statistics
Date: Fri, 23 Feb 2024 11:24:48 -0800
Message-ID: <20240223192658.45893-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fcb873-fedd-43cc-ec32-08dc34a574d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iG76255/AvNJvrf49aRRbHrP4IXJwGqZpA4TE5nAPZzGg/vOU5UoU6kfs7YUw3mRBZCAiM42ODK8U95O8lAlWDu8MN8X26atoUErYV5emHgz/SjWpdqMzK0gUIqThwaedUkcriU1v6M/PAx7N7dC8pWqTNtMIL5QowmgU8phd3EJxFCrHoh3x8jyPAi8qYrTRzAXJ+3lwyMntkgjWLYrIGX6fbvfUzBkp75Jt+1VcD9p50saY2Edz80CmNFerfaPFoFii0LHtOA5QZIeCe71n121bqyGUSuDSWhzyMPS9kzOH6owKShQGneMrqeQkYd/afWuwL+e+6EfqGtikPVE9i5r1D9XdMDU0RPyur9fad3mTYsBArQuk/5HpNoWYiVy1+ooiDhDY7nJkNTLZaivOSHNnN9Dp4EZ44dnpnpmOw25U9KVwYSIRENcwC+nmgLRZHNiTUGrvmFi6BX/WoSh4djQNCPhMmzWMwwsJ9fNT6fuZuP5CCthzfB97YEVhPnlSiSLG5EZxJIWHDo3y8tgBo1h5wpNsWJQIOZfd1JEhKBclNF5kvesXgoy0QOPMjQaAgmLECC7JYyMju2aRs1LSm2uZIEZF9UZTVmb1EhVRKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31xSnhBdjgpB8+qsLJcHXZ40pZnHSJ2Sv9Pe1vPERiUu4k+fp27hEXqS0FwT?=
 =?us-ascii?Q?qvfVGO9JeRWR7fCKrjKIj1uHnzdVKGKYXv+uqNBiQ8+I18dzLW3ebWx7PyUO?=
 =?us-ascii?Q?C6JsJ5qKXZSqhlVGd9FKylQcyuLot8Bqp421IlT3H6ExkGJRhdCxRLGx+u1v?=
 =?us-ascii?Q?7RJZsq7ikNhXx2Npc8rtdCx7PyrhS7gJpiE2RW7Y2YVgdtwJiNW16tDAM7q3?=
 =?us-ascii?Q?hHgq/pLQd9pvHSlhqiOafcXoDguVn3fJwpjJFWrBL32Eu5wM6qKkCvQ4pLCP?=
 =?us-ascii?Q?MvTRehgN9+294BvGySpx6B8Pk9wJnyTCS4u2mqi6vZeGhgB2/qNxJYSEN15Z?=
 =?us-ascii?Q?u26sI+SLErwNzZytbtx2LeDP+vszzP6CnlnvwMZBK60F/RuhNb8xE9evKM69?=
 =?us-ascii?Q?Vho/XeBDZUdL0TR6pG/hIJeZepGbt3B6SbYZcgzWBEcem0ksYl2rLL6iy/MI?=
 =?us-ascii?Q?1gQuLlMhpNTUvUMzrE42hgd1HSxnmMyw/TPQ75mSnYGHd32IZXBxTf2ybV86?=
 =?us-ascii?Q?vG9X1f/UeRV3GEgoQxA23MG2x242LV17G8meK1humSpALL32YOrUhQL80mGn?=
 =?us-ascii?Q?hbjMIIRKUkocnkTc5/B/+9+OFZ/+o/PfgaubqhNzFH1GvIgO6odAQ00grOxv?=
 =?us-ascii?Q?uz9m4b+KkTC+Tq2EQI2hwVnO9svRQlp0bancvqWzUAG8pGlov+a5OmirW5t0?=
 =?us-ascii?Q?YDOxxbrE9nQaqZh36cUhEAOKr1nndV9ODDGkRRPJzU2WFkchkGsCPGXF4ZsA?=
 =?us-ascii?Q?DKa1tkoxwXh5i+shnB7p23HQcXfpkRvGWr+E9A6sO8S4q2WYDPQgAXwf+Qp7?=
 =?us-ascii?Q?SAfelR1fVzg/dWk83qfid+epbmPwu4eV7EAnHp0uze4wz+MHlDFqgpol0UuH?=
 =?us-ascii?Q?fvKXbq6nUlOezmOkxbhrY2uhXoYMItlc9GzPOneiCqnxxN7XCGi8iLSrY3EX?=
 =?us-ascii?Q?MHkBPDP0coS0OUWUthtIGL7EoSni+USvvLeIJLaY2eHyP1t2ts2gviHM0sBW?=
 =?us-ascii?Q?G+cvXIXq1TmtmtHq/FVnR9G8usgWeUTKkinM7goTbiJd6zjdiqeguUyOpj2G?=
 =?us-ascii?Q?ZHYHETb3hU3B6/mznryl7z9WD1EtWttQoVcnMOXW2+oGaJkEXBXKh4gX+zkI?=
 =?us-ascii?Q?i9ItQEr0hK145V+H/8/6L8W3mrYkN7/rD4vWbAoszGI+r80NY7wgLC3NRvtC?=
 =?us-ascii?Q?O2yiT5oV7us4FKUJvski3M3OyTMqaX/o0MNsfZcGe6zqYsF1TShYKJDCilEz?=
 =?us-ascii?Q?ehZDryiMaV0Y1yIH39QNln7FcphQ7hRSPVhekIFNSM93inTDTt3/05arQqpZ?=
 =?us-ascii?Q?kLSIqA+T1sE8Ip/L1WMv9zjLfH8+po8rYDSdRy9XhaLp3B13/mWPAypI34ti?=
 =?us-ascii?Q?Gc9Tl2lJqOXL9ENs0j0jL/lOOAWKamvjNuDaSlsh8f/qlEmSklh+fBHEo5sI?=
 =?us-ascii?Q?KxRP6hGND4JJlCVjrECX4DZ9ozWFlJdFBjzZmGw+zD1BU/4G2K8T2G6M3+xw?=
 =?us-ascii?Q?FpOEMrpUBqSYArBX0Qyaq+kX/vuL8f2u5BFeZvsLhw0O2aGLay7J8U5QDmq+?=
 =?us-ascii?Q?QcZAFDnXksZ2O5kfXTp9f7YwTN4cpjLbabY+ZnzDoVwsQVutDs8sJvT+eqfH?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fcb873-fedd-43cc-ec32-08dc34a574d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:21.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSgxeBfujNAzSnpmzD4q+Zbn5hEELeTosjR1v/Av9tD7azuLW8OHSiVm9f8WPQuoTIGpXF7LF7wCqA8GjwCWDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

Feed driver statistics counters related to hardware timestamping to
standardized ethtool hardware timestamping statistics group.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  9 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 68 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  2 +
 3 files changed, 79 insertions(+)

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
index bc31196d348a..836198445726 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1155,6 +1155,74 @@ void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 	*ranges = mlx5e_rmon_ranges;
 }
 
+void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
+			struct ethtool_ts_stats *ts_stats)
+{
+	enum ethtool_ts_stats_layer layer;
+	struct mlx5e_ptp *ptp;
+	bool tx_ptp_opened;
+	int i, j;
+
+	mutex_lock(&priv->state_lock);
+
+	tx_ptp_opened = priv->tx_ptp_opened;
+
+	/* NOTE: this needs to be changed whenever ethtool timestamping
+	 * layer selection is implemented.
+	 */
+	if (ts_stats->layer == ETHTOOL_TS_STATS_LAYER_ACTIVE)
+		layer = tx_ptp_opened ? ETHTOOL_TS_STATS_LAYER_PHY :
+					ETHTOOL_TS_STATS_LAYER_DMA;
+	else
+		layer = ts_stats->layer;
+
+	switch (layer) {
+	case ETHTOOL_TS_STATS_LAYER_PHY:
+		if (!tx_ptp_opened)
+			return;
+
+		ptp = priv->channels.ptp;
+
+		ts_stats->pkts = 0;
+		ts_stats->err = 0;
+		ts_stats->late = 0;
+		ts_stats->lost = 0;
+
+		/* Aggregate stats across all TCs */
+		for (i = 0; i < ptp->num_tc; i++) {
+			struct mlx5e_ptp_cq_stats *stats = ptp->ptpsq[i].cq_stats;
+
+			ts_stats->pkts += stats->cqe;
+			ts_stats->err += stats->abort + stats->err_cqe;
+			ts_stats->late += stats->late_cqe;
+			ts_stats->lost += stats->lost_cqe;
+		}
+		break;
+	case ETHTOOL_TS_STATS_LAYER_DMA:
+		/* DMA layer will always successfully timestamp packets. Other
+		 * counters do not make sense for this layer.
+		 */
+		ts_stats->pkts = 0;
+
+		/* Aggregate stats across all SQs */
+		mutex_lock(&priv->state_lock);
+		for (j = 0; j < priv->channels.num; j++) {
+			struct mlx5e_channel *c = priv->channels.c[j];
+
+			for (i = 0; i < c->num_tc; i++) {
+				struct mlx5e_sq_stats *stats = c->sq[i].stats;
+
+				ts_stats->pkts += stats->timestamps;
+			}
+		}
+		break;
+	default:
+		break;
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


