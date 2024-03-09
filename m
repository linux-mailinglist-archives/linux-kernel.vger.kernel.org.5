Return-Path: <linux-kernel+bounces-97813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5DE876FD9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED361C20D0B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5C3BBCA;
	Sat,  9 Mar 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOFnVzCt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C8383A4;
	Sat,  9 Mar 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973906; cv=fail; b=DM3HDN71wkY5fZv3HhAlE/kSSXAlLtspty8BEE945gMm3BtfpMSVxlYIla2RphJ3mKPqEu1t1SPaOOGOAHgcBXyE+rrCBDV2Mk42vH8Fqo6YnJ50xDzLcGZokcaYtDPl8Cqtj19Qo73kq7+B0JsaX5zxDvNI4X8VQ3DBYqpF5jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973906; c=relaxed/simple;
	bh=iFNnJ0bKa83se8+RVz1QiXLm1qvQhKh9LkXMUQJyB4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIPdhYlATizI+gRRApZDwhW+dqkv3uL9vuHICBPXtU6ouEQs/AzsCKuk44VdBxwIF2PAJzEf79ZecxAfBsH4ozAKPRDK6WaLCrXAx6I8h1NYpIa9xlG5cQW/pDkh/uzNlU+aPDZq7HdiynpoSMuFjmb9Q6NVPTNR2mR3XgKdGS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOFnVzCt; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKuytNgDQ6QyBVwdND3uUGyC+w3ibr4310FMorxW6x0rdlBwI91gk2FyBW1te8wSJymjp/ODcFSHXrbQBQKhb8EPOHlVYIVdPKQWUUc9UbqNXUDwFN7mindZKUxkWIE9nziOiibvxaG7pxm6In3mIZN/tDJAL+Ev21HEhcH9CWr7EIjtHelX3CDqxk667/IQUDNbk7m7oO6Ci1EpCCZOa7pEeufBFoWoGlWY/AmK0L5qINzaQOQybyc/Iwd6HtYhEPIkw0U+8MiCntfQquK4X6t3dnxH+VWRaehyXjSv1gFipAiSDO8wV6JMuPmUQrOnGlth1yjDO1jXy8rQL8xZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzktG3mbT3nH0+Ki/CyAOzoqSEJtEFXbQImRnJ3RQ5w=;
 b=jLUEq0HQlIyX0wOm9ETq8z5PK+oT42unABO1/q3vQsp6HCKjSUY/zq8gKZ0o86OeMHFxrxhZbRbO5eD3S65M1pmwKjMfgOAVpSymmJ6EIeakCjOalC/odSGYIu7wWN5LuV1qaQdOX7HVcQQ5g0wrOdOccBVQlT/JTCBPye78sKzpszwADvPraXllM3QKpPoKgsdQHBCcjFQi4Wunub3Jb3ChzU85QaQAvEG2jY8RwUIyJ3rnC2m45nV88CLHeFYERVae2epMIXRJ1OtB78Ee/GX5pwFuVYALQAMejDNBx0QjoC/3Nn5k48xYo5GFka5V6kOWcrexPIMcPGutzbnNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzktG3mbT3nH0+Ki/CyAOzoqSEJtEFXbQImRnJ3RQ5w=;
 b=oOFnVzCtE89iXQIF1Bv6hR3Q0NNCqwYh2iK7XMZ0knf1VAoMRFe6x3YnIMeSUVCpMItka4x8a7P5mzEUx/Bqx96fnl2fWkJgQicEWHMI3FAcdQyZZTdj4hWtkh7dmmpJSL9NCO1Pfqu1OxwPy4pZFvoueE+B+VLMgIGIGS7n7gsynChybmpE+pywkMTXaVYxDsYRC6hdcufjmaLv77xxh91VJ8YZ5DvSqe3Pw/dRUt+saZrKWpQQ9xgHpFN2HJz5+fB5HF8XPLqS1pv4bVk9Zlvu6X+Km1IZQSvr+YIpQHW1tMMrNYbZBtBQbaj3kc2g5VNeO07KIX9zrFRl5GiaRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:44:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:44:58 +0000
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
Subject: [PATCH RFC v2 4/6] net/mlx5e: Implement ethtool hardware timestamping statistics
Date: Sat,  9 Mar 2024 00:44:38 -0800
Message-ID: <20240309084440.299358-5-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2091ae-6028-4ba2-4d11-08dc4015337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d53DZIugALo7qXvsZYlAyC9cMXy0d/PXCp5KVxoEYD713CZD50DlWqHXqxl0jKy08y8tmJupQC5aRdGtiY3tx6NOkjFnBbR1IugXmPPEVH0LntxoRp0wAsDU9q1Td7LbVM4ElfRbwziFWOQXHEg3t2q3hmxz8YfGT34mD36KnA6uVxUN+jJsT7zPUHquuBqUEIkEXkgsJJlXOP4OiirD4FxQ960iMLx5fqUxTQF6AaJWb4e1NFZQ0es/Fk1PLqDh+UxaS/LCVKeAnZlPcNkiwHCXml/eC0GO+wbRqLZe+fMeuF26Yd7r8mSiA/iQhr8qtvObhX28uzbaaUV78nYTh4+xlxxGWYuknImkmGVI3Viek3A5wODtoj7E9t7YwGgxo+sgmkEuOSGP1cZrJ58ZHVHX7oBD9nOmeOiAOFqsYEjRyrFmeZBRMHPb9pBmhXl+GBZragYYTLor/S7ZMPaUa/mIaD1Frz8jlu1B1nhWTDadc3nR4wgaLdiH5IDvqpRE3/5KU8eOyY9xOJmP5fUs+hCdEkJkbW4ABbsajmFILocSDFcxoNIJJjGeoGaZwgs5mlBI+mYLvOrx/+Pqpu3W9LZkFVR5PiAu5q8uAeqcfUsnQqUCpXWBF5tFRyGemllXlkZ+UHsA8sC3AZBP0qjeMKGLn25MnoCR9/bFE15zAYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvU+fYRKk+b7SEyxxLW/DMkpfIuwwLu9DlD560J6jnu8lbeBlA7t9jB4S9iW?=
 =?us-ascii?Q?P/ipWBNouiGj3xCXf4ldECxcriFg03KzlXhzCoPLqex9jGX8lF2BwYS5UCp/?=
 =?us-ascii?Q?iD/kX9qrdGaeJmWQM0heMFrkcrGZFkK+ocaHvUwKRXJlJ0ytL59vjjgW0LKa?=
 =?us-ascii?Q?nuTrFyzfplvORfmWJLRixj/PjNovXQEt5KvhZq0m55K6AGL4bxDX9H9/Gk2l?=
 =?us-ascii?Q?KJVDSdzCjT1D+xmDi7LkRUnIvNjxg4lpz7sY1ZEePPWCknL1nmQxxN1bi1Nu?=
 =?us-ascii?Q?pamY4L4gTCwBF/bRlWuxhki7/pqWvsc7CdppBk1xdU7uYWiucW6tigtQavIi?=
 =?us-ascii?Q?Dql9mPG82oOtB/+8KZf7LDsux4ohNVuev4jCkf9xuW/euxB4QEh++/FSM7Jj?=
 =?us-ascii?Q?sZsW6LlIDCd3k5IOmPmC9L4gYa0MejoogPabPa3DDad7Upsnp9io26DNmFla?=
 =?us-ascii?Q?iQ+mY3puZpRSwcknSGErJ1iq2xuEBAaAgp/8yxv3bWRS0KhTQnOOCfPfAQPs?=
 =?us-ascii?Q?vJcEoJwm5S/SxzU7j/xHaFmsOOYzmm0p/6XeTIAOT+eXLQYncOKMHiUiG3ti?=
 =?us-ascii?Q?GZX6be2eFUp52OiIalQ3oEemmP7W/tHZcpHWLxsmGFFw3WJt/yIxaYuP2Ejl?=
 =?us-ascii?Q?8baukb807rKhb30vkH4q+ZHHPeUFPOlUt6XMvQOnsK1tgxrlW0ckkXfd2YqO?=
 =?us-ascii?Q?SnrtrHEkocrTtr7GongMAEntp4R5pcS1Il9i4yyW7YQt/u0oVy7Ah4r0hgzO?=
 =?us-ascii?Q?UOxOSpTz/Pq/CayYPD7CrmrsbFdDOP7UOOeVKAE/hl+U4Ytzs+QEAQSewigL?=
 =?us-ascii?Q?u9F1d3QS9H4/xHpoz2A0fFTBq/+LkOfy6BAYa9scGJ18mGFwHtyR9qrhAcYo?=
 =?us-ascii?Q?pzhOFUb7bviNa37yVnzMOygZfJapa7qFJU0bay7u27OukCPVoQI6ojzgqdmu?=
 =?us-ascii?Q?WMNAzn4sWoUcarAMLF/FIHvoCIQvnW4DVKWYTdjRYRKs9gUL9GUrHRmjN7bX?=
 =?us-ascii?Q?2cqtmINYV5ij8RnZl0SkEdw3kwQ5DWrI5QRIscGJtH++ycxzx70VcK4ncaUr?=
 =?us-ascii?Q?JHu6xQe/93pGs+Kp5c3WT4SP5OCn1gOafDegMj/fPcOGuB4u9WjYizBAjKZw?=
 =?us-ascii?Q?2y3NlZ1vWJ6nL4JY0YaaJZ2p08oY41uvitLloXjReP89ZYijIpKF2bkFA0Jr?=
 =?us-ascii?Q?hAgJqcytKKVjkBiNi0/3shhwe0B+Lkh2dZnZl/+vnMswS7T3A2D7FGl8Qshz?=
 =?us-ascii?Q?8LsxdyOx8Jpk+jM4CP3f/497V0Kds1awqOwOKtx/liCn+DW4swVz6dfOUzqZ?=
 =?us-ascii?Q?Sw+Qix2A4zmNVHksVemYxZyOcoedCPRWhXj95CT2OxopQR/3hsuDlIkysgyP?=
 =?us-ascii?Q?IDqpDN1uqD9RoeBqKlRN2p9C25Q7mEjkjTpppaF7kWS2n3/SkqpenSfkKt1L?=
 =?us-ascii?Q?gcvwKcMrn/JH3HDnAfkUCKN8RHMHD5X/rgi/DBklFegdYbdYmSZ1kDB2GYp/?=
 =?us-ascii?Q?psnMPmdsi6C8T5aeiXtf/sEnqVTIEyyYWciY1FmZ56Y6mBbHTjpSK9kMxwth?=
 =?us-ascii?Q?L4lEW9Lk2piHwbDoFggcwel31uGP9Llj13vUQqEGBoAytp7vG5TU7CpH/0EW?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2091ae-6028-4ba2-4d11-08dc4015337f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:58.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDoug1AGUUta6YJ5HBhSGhj6ju1xrsxVIboRQRuU7i/9HdZi4UVCu3qPp528Q3ll+eTGajU/rl+K9TZiYxyTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Feed driver statistics counters related to hardware timestamping to
standardized ethtool hardware timestamping statistics group.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
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
index bc31196d348a..465c1423528f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1155,6 +1155,51 @@ void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
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


