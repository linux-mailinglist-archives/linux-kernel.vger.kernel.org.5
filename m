Return-Path: <linux-kernel+bounces-130630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F5897ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294FAB20DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE75156F4F;
	Wed,  3 Apr 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eL+MxXMW"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B026156F27;
	Wed,  3 Apr 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179792; cv=fail; b=WxhLHZyHOsKC1CSS0XFQ7WtwczufEl+IAUFlPXtztzFqsETBoslFf8fxQVzU4FwVwEDMYDFxKpZsj2GMiGo+0u8WiOs87CkbN2CHcLPi5KR91xBUaNgUqmCIgMUUUkgrsnK/DOcZinwf4HA/1b8WlTUs+Z7H3wMbsoYsxTSTut4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179792; c=relaxed/simple;
	bh=NlhCiYtdLwkmc+hC/Q7dhKKn+EFCgunwTcHkbnFAQc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ob2zLmUjZtNDrVRHxDe+OgTpcmSG+4bzORUem4yGsNlVtwrUbzIGH4bYfZgCSIzBzkO8ElP8Evi9OkISUVLC9LelM0fZ4cq6xu2iP382J2n6lMFufEnIiGxUnfmnsXyxosU+MrJwV6f91LJTPSYA6PK9ZNFrK11CrKRAuLh9NbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eL+MxXMW; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQdvANgZqpbe/7HUF4oaFSIAN9hG8c3WiL+w5qog4gsjlA8R2RG/aEYfJeVwYwOzGLVXGwrB0zvH1NhfOxoFO9Mb61uadz41md6zuzGDPCEx3y5nultdoFUXhZ7a/wynGUcZiiCyScc4oeoD2X/wIJFtn+wpSEO0la2m3EuGrEhnb0f8uan9UAoyNT1ex9JyyV7GqXOjSQR1wegMbirYjdBN6MEji5CiycQ0Xdhb4vQhHogRG307D26nAZ0GtuIgbw8pFcJcDsXSxFDcyX2LpYNq741Yx4MNGIkoLXzB4TOep1RENvmjcoKcskeGkGHOfFIX9kkuChUiBYS5Pu/lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJynZq47AZ51ddW8veWZuitCK5J0k25xaq8Bltpe0GE=;
 b=TEk1nZHyyMRF4aQfuXciP3NLr4RCjXdaDRFglhkesyFHoKS47pzux7UISJXdWzGsSuMlUn3sHSATyTxm2Iwp/T8isTl42UiJ5xA+tEQQfmJHuU5HvEGoRcFyGAM31PqTfD65kwrThGp9Moq+Wvoah8Njt3cbJszlGmyz/GK63B5kltlAMI97gm0DnbnAC7q5L7kXdPaZZDQnXT93J1rihgc3cXtc9UPl94DOIC6or5Eaw2eSHg3zD2HN6Guth/ccOzb0CY+KnZE4lkzDegcEUODgQkShq4ZWmPakkaKUnPfYmHdu0AJ3/MCp4jozA5KkIrqgSPBV/cYQTmmHftyU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJynZq47AZ51ddW8veWZuitCK5J0k25xaq8Bltpe0GE=;
 b=eL+MxXMWNn2QOa3+7hHoImWQgKeVHRlbCEDWgxsSGCF9Iw5dxJDcq4m20A6djypQCi84sOkpDysd1c50dekyTdPrq9OYaiK5td+5wbC+aeCwUmhnv0Am1utwfdml4FyhbRPoPHnfYMN9AH5s2Q195f+pq/YSh6qwDi8+pZI2q61f4e3BixSqZCIr8AI4Ov/v/i4+gNdtTbHllAo/NsVi36gWQQww+IFezkvrqOwd2sn8hxaF7zhKQ2TldFYqEbTYmnKRAHsvZQKTp1o/R6A8SnPH7JBFa7AhoJX2H7j3q+Akdl1bokysu+FOxmjunpJTtVqh85bs2ewvvJEIWg97Og==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:46 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:46 +0000
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
Subject: [PATCH net-next v2 4/6] net/mlx5e: Implement ethtool hardware timestamping statistics
Date: Wed,  3 Apr 2024 14:28:42 -0700
Message-ID: <20240403212931.128541-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	8SdxizOxrBAv5BwrUfjprjwslkw4ax/wXZ/+Tn5Yd0TNxFRHWi0ayccl4tlORafpASxeTBlw7REpyDApdWW5ZwJ/LaUEkNLGwcZ1mnvYxYVgyB9i8O2tNgZJH2IG5+QFvU/Nr6YMmiEWi/UK4w26tAbhenYPpCcgYMk9vY/M4L85QlcY+rFVWHKCMkQv1wmZ26UNbYTqugDQMvrM2ENe/aNhPf7XWueji6i5AC66ceU7DBvl3gYHs5k3ZtZK0CYq0epqcJRFHcwOoNDBqm65w0DfK80b9VAoyGyVKGml9/hITbOdwmWTbFsKDhLxWPv4vNRjsa8VGfW3I0K0+SP/3x4emuHzs9fjcja/6RGLL7veJuxfQaqKXN4h0WgfzSeuZzda8RM6h9GkXfdwNxvD18lpUN2RI7hrBTXFh2naLIKWj5l0tkY7xZkhWtmbDbWr7v0c+Lm7GZRrq2dxsKRrwC9+omRXwqDNbVtCKfML249nnXz3GmREkOgZCESsP/Gli/iS8xEuvm+/K9mom4s5qKRUGepyJxCx3KU0Hj4AddUg4UjmPzkfVZnGtIA66zcaXi7S/en0SWEyVsZhdxOSwXgDG0bz/Huiyfj09HrKamscd6PXqjOrVwFtZpH2SPHRNlsKpfO6OZWctXSGEyutKJkWD/uYOmAS0fWB4g2kUDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqxHZQb1hhvrHUQhbab3qVFeob2JbiJVTirbyyW23AkVO1xfxyV7mbo4gWpy?=
 =?us-ascii?Q?eeFkg1De/GCmv43SdpH/P+SgoZCeJ/04fH3uOntN60m3GD20KbK2aflDOV56?=
 =?us-ascii?Q?CoZv4L3BLwYHqqtG6A1pUwKOm7j1efNut+cih2dEAQgl883UGgHj4Gj+Z095?=
 =?us-ascii?Q?HRyDT2RMgLX03trlO/IlmCyiafnJxgoRjmHugNueL37GV1SLBJQ+hZ4ZL4NY?=
 =?us-ascii?Q?ndhVWmj8skFkCSFT87K9IE17QB+3cIw8jFq7VpItsY+/WvkLfHHbbrIVDbnp?=
 =?us-ascii?Q?VOnSE4eB6AsiyW5FkXaAldeRWsJtincxJ/vdyhEnWtFVeHn4n4UrYs2YgqES?=
 =?us-ascii?Q?w7t5sFmV0IRxg56YFCfWQ5b97sFEGFdWD52pzg5bifWrUUAekUgnHEFuu1KT?=
 =?us-ascii?Q?pYSgCM4+3/xO2WyoD79XwsTH0F/rqvdKMbLcpKuptRxamaq+fANFi5Za6+G7?=
 =?us-ascii?Q?3DdgVZvFVAuF6B1QadJp+88QLuk68UQ+DpQlXoErXG3fllweu1b8KFpzLPj7?=
 =?us-ascii?Q?85xZe/ndIafcD2fVrBAN51HzHqUgFFRhg5A/KyOiGLtL0Dtdf5F9Fhg32xiN?=
 =?us-ascii?Q?Hp0BPNbj7PgIe6kugrljrdlCjcbCVvaQWi5b7T6NM0rUp6JWfnEu6gsWxpM8?=
 =?us-ascii?Q?hna6Is523xzg4hs9dUG/+oELpHQQYFGctj+WhbtgUJqX3fcw6WJuYn7e/47k?=
 =?us-ascii?Q?tEL7lOgyxAQYP5OKj9mETlbVm44btyaIVdvAS55uX9VuDgeT2YSWn9zulbc9?=
 =?us-ascii?Q?uP0t+ZMz77NEi3uPZE8bhgHFF21Pe9nfLtfBSdCiSviXHT1YXg17tvOXLk9O?=
 =?us-ascii?Q?ANpBzVSdH6gJCfKPHzb1CC1SdoWJ5tFq7jiMm3nbeE+wScn2/ncTihVn9mT4?=
 =?us-ascii?Q?kw7/phxiA0qxlqBZnTcInUX1nHhNE7a17MowKWU5z1yWAj5p6xVqOohlzCfh?=
 =?us-ascii?Q?+qN/aEHtoHIW29fiJU4Q9PmFZEJU5tyh9aP2gnJlaM8TeEsrayAa4HDnvp0B?=
 =?us-ascii?Q?fMd5iuCk415UfmIh8fWZ0+0FwvXBKdD0CyRy2XedH4X8b/Cc8XC8bick5Xo3?=
 =?us-ascii?Q?XCIq3DM0QZeyW7mz1JNGfn/LYC6cRHbXo5uuQkJM8tdL7QklSOsR46Op5pZ+?=
 =?us-ascii?Q?tsun02IiV8oNK/ZyR75SHLrK+MiNYlJQIMDAEVIYpavs+Zg/5KowmnHsBlaY?=
 =?us-ascii?Q?hsfsq4gnTHNXTDLOXdlm+y/z4kElVhoVWHYQWSYtz0UGv8sneXWISwMDMC7G?=
 =?us-ascii?Q?hzTOCXAiQkQ3FWjHtZK4tNzDYa9+NB9ch55Jj01pnaMsat1xUUaS63KL3Kco?=
 =?us-ascii?Q?NKitgQNcMbxQVUk/5DIIqe6Kgs1ECAEqZU1Skb+1g0cCUTbqN1HcH4K7SgWG?=
 =?us-ascii?Q?VSg1WrJqdoDKtOIa2h4CLg/u6Nt8cB7X+j0ZY6oof8MkVbWq7SYvoFKSVz9n?=
 =?us-ascii?Q?2E9QHq4rXLYFkiATLB/6kN1bwyx2G5STqNTEpKof4Nghbw24SPWwl50lPNO0?=
 =?us-ascii?Q?SxxI99v9m+cVvIeC7jUFD0dWxup6jRnsuPIoRGMqb1R25Hix7OiudWd7TN9Q?=
 =?us-ascii?Q?c8JEHYMTUs0nK6+NmA2UDfj+1nBJokj5AO6ipBvbqWyRptJw5KRyFaLNSlPm?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d219ca2-f8fa-4c81-8d1e-08dc54252b5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:39.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL6ZYRZbofNB6XCkwqLvbVWAHK1FEg3tQFn8h8RUbyywIU0MYpMa0lOOcgVK93YlwKhetU/xGPPadISw7keTcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

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


