Return-Path: <linux-kernel+bounces-128678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3475895E10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FDF1C2207A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577515E5CB;
	Tue,  2 Apr 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYlU7N2Z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBE15E1F3;
	Tue,  2 Apr 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091180; cv=fail; b=KXa5GrS4ywT3t3kj3ZgDZRJuLCofFX25iFw0D/ngNdVni4PBW7syM6jzH8YpBCjgJ+aDB6V0G5VxWrWa5nATnDXeJPeHTnSFcCTMADCGD1CsuLSvdJBfLPlw3w8X3y1p0GBSd/EZWDcjakEZiR39e2O0SR5xb5CXe8NO6tqGAgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091180; c=relaxed/simple;
	bh=1Iq1rPE5Vws/F9owFdesCR0VVEd8lfjFoG6/fp2+b+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoMCXXCA8aOpZNKzbuwNcTTrRvV2dFOOKJQehOxNaWFhCr+xlWJC8HN2bxvyk9q8ByrnEKgyjEyPHA3N/4ILreKlRiKw4uTJTgZXX4VBuNftzbdqCbGyVj5UWbTkkqC/GqHtqazfBzmWuhufu1hDGjJbwWd+i4yBGYMdsMFc2nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYlU7N2Z; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS9Pfu2uNq04wjgVW17yQ9kD9SwINjaRIdzk0lEVy01Gn623ovo3zYtOmehMgNY84iISQyjRojQAIKMfigPNwi+r5CHt3zgd/Ef9a35z8hZCXBjY7D4CZHc2Vxy8WZHfoweeb/uaaBTTChV0bM4/Rfjoy+qCn1a0MA3TT07Fvr6R/vINUlWGa5n6Jk7WlIdhjRQ4trrfyrtV/p6KokH9YHKfNZ8iUVQ45jvQudCpbQTN4COMGS06fLnycItEzob2kRc0PwcqTzGdz1wdUuOVGgDVxMnMZAAAUNatmehrpLHvisIYGBXxWErVtSKNHTbIG76FVUbXt9XYHQga+cjsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jA2vxHsGi7a/yAU0vv9kA467PAZ1r09oWr5tHTIlCI=;
 b=EU+yqXaH2qICV/eB5FDpeLHqQynTmNTQuAyBKEAw47wzhqp50cCOayIHAbgWp4tNnHa1NymShofuJTvfm6P8fEDlcsGI1g8oGVgnV9nJaKq27WTG53r6FdkGKATyV5W0QRBKIfGN9+FlPm8JoqzG/9k/Isw7lu8FFA75vqwmasgUj44EEqFW1TaeVaAmyw1jvi2wFU6Rk/OxQsJ9AEnWOFuD24pLvQfqKn8rTUU3CkBv3JjSf8OPvxVKKei1T2Rw2/67t8X20q1P6xNnyVl02W6rGLBjejyJO1OXY3lkS/O6jC6iYidEDpULY8YZAWYsVTRK6HyHiTPeDxIXq0Kf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jA2vxHsGi7a/yAU0vv9kA467PAZ1r09oWr5tHTIlCI=;
 b=sYlU7N2Z7yWGEVZ4FVP/w4ILYDcKF/LqUElks8Mx1O+VGcuglarTHpaeDzPLN9r82K3Hpu60Y4YdVpCYm/CoC7MJOLsGPM2bpb9xfiF/3ZQ/050L5sM+9gUjMW3+VlU+SMYetbOyURZFd8X4s/LRBndMP/nchJ+cMaha+UnWDEQtqOTAlZLRlBWf+sqDufi6jx7QFD+H4VYZXqV4TJYvW7edk4ruZfI5OkcPnnkmFg7ppS4HsC8H8+w15xOSkjc38HT1fQCb3+F24xT76LTX7WhxD5OFVTQNNpH60LJwolErjm9vM82P1o3Aq/LyeryETujrPG0789Ox8Awo3Jf54A==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:28 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:28 +0000
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH net-next v1 2/6] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
Date: Tue,  2 Apr 2024 13:52:02 -0700
Message-ID: <20240402205223.137565-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	nAbstr8VkE5Cz0oPtEPoAY7+zgUSba2+wlrBU39ZwQ+nsjuev4HKSWuLYiLdd0I2en/i8BwSkf2WKyQRhTYuMclN/HhenLMJ4FfO8ppAUDVkf+meSgVStpAN2KVCBOvXqXOsfR76DKTxAANHMhpSQUhX0zc2Vx5Qkbex8nuPn+bGRuq2xYLLMxfVX9+6DjQuwUh23lV/bJuO2JGxa/3EQUiCz/1NKSOmaxTGntV/ohddYYf5YtcDPmV/csJqI5VHbgIEtyStbUcCDcvLfHm0+HreQNiCv7H+y8WWLzLwoTf6mC2MjRvjphtpF7rAtmwFAayy90qlnkA3ggwUM8QXk2grbAptQ//elcoR57xUMV7oQua5ndCFQyhUqjzfleNw7baMwGFEKBAG/tWo6u+1DfZ0NC3bEKqAIMo4sNiZ9HUiM2M1O83nop45eF1YN2Tr4mdC6FmcxN6AK3UJSvw/9MNA/Owe+F+e5mu2+Ms33ww2qcapYbfGXXAR4pnRx9dmPG5tdEcfzK+x7HOUhaAH4+0CfDWNQa/kkBwfd6k6QlIbMOoykYqQU2BIQ3+ByPXj1EpFf0onJzW6lLF8OnXdUxl3zv6jnlUIAhzAs5G/96DwERHE3LqjHPeTTz6T4KKEHrtWRhTmJTJ4IDvvet+atr8CKpgQ+XuzXTQuPi4d52s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?52Og4Y2fJO8/iYKLDy1G94aNWkEM6u/qPTtOPtnLq+4hgpP8ypDb9trVHbvP?=
 =?us-ascii?Q?qpDqPN+megCkmQ/SphN8PpKJkmozkb2d8xcNxfF9F9yAFlWVIZvX3X4/YoHr?=
 =?us-ascii?Q?bwqmVh2M2RQdb6EVNsvdmx70SJsiGBQUzA8VanLDWYzp+0MpFw9cYNf6QGA/?=
 =?us-ascii?Q?sWlAFm0LpFhsq6dZA0bdrWZEKumJ2XukdCRCVQ/NNLHUzV2rM/QU7oFmQKpo?=
 =?us-ascii?Q?zgITE9x9s1Ato58qTho5jNf9CbJA/lSzn5pnfzBa1VCvnJwxEuSrCfnoC7ym?=
 =?us-ascii?Q?8rTVdLtUGJFSvdwCpzhskwEsRdY14vDoiegJQ512du9EMcW/5Jr6fqgWzRfb?=
 =?us-ascii?Q?pIsXqkrGZ5Qb0ztU3d5lKnmiPTxXYZGaFicqqedeob9/owwEUOj7N8THcpfh?=
 =?us-ascii?Q?3tiaP3aSqhwQh28V01HkRxKtfuv/SMSc4Wgs3OozcNx8yGdYGa5ywHOL5OAv?=
 =?us-ascii?Q?mDTDxrFEcKZjKqsOGTAENLDBmGfgLIrKkPuOQaBsqm5GKzTVddTfIJFQQR9w?=
 =?us-ascii?Q?XO65gmMHL+B+AlizGjniMiQIT2uaLjEY2Jzu7qKk24wiQK6MJ+eFJxEZ0+p9?=
 =?us-ascii?Q?CMXI1mHUzLD4QyLcdG6CnHnE3QhCVlp3CpJ/tqIWXzriYJAfKIPX0ZZFb6cc?=
 =?us-ascii?Q?oUToBjh7JTlxmJGXkmWHLLBRPjrpA9UymBNZ/9/bqTfN1er5yGbOqm4JwNJk?=
 =?us-ascii?Q?2Fq1GkbTIVe4G56MdljrJPBEEjZcNj6hL/gpLRwH/r0cgAP/7x8u/YTY9Q+b?=
 =?us-ascii?Q?aLDTy/+YT8ieu9W0FhE9YWpOJrxW2KS07hMIHUU8eZIO6dg3JRlkSS8AJ/R+?=
 =?us-ascii?Q?1I6LLNoXmQrzEn2OkPVQsz1Ys6U91EqFcxb7+PBYwNpCAXPZ3LAPdoPVVhya?=
 =?us-ascii?Q?2Zxxe8uOVZoU+o3UAPbPNuyFiKLtk8wMxkyP5+tHP+Oq71w0tvMQj2Dleb0+?=
 =?us-ascii?Q?QuHuSgwkc2ARl2jHc70/mIfuXktwZKDF5BAdDx0L17wgPGa0PMi3I9/NZPK7?=
 =?us-ascii?Q?+IEKgdcg5uv7V80oo9pnuzMCON4GeA3RFrmXU8JwP/u1I8QC1jDX/fu3Fbqh?=
 =?us-ascii?Q?7NU/sxpz1F+Sds6vtNavMcPFmWMwxvdzAecBWu2ZW1RKZQnebTtu/wsoWk3o?=
 =?us-ascii?Q?CXIpp5fgQvoXOuiaHop2W1Zbj/2u2oIUMNrkukt5AppZH9tl7MPHnpqatJ5A?=
 =?us-ascii?Q?uAxG5I8Ek8nwzaWJwo4Pfvr0Ym2m4DqzylHC0kJIWz6aj+P6aIgS02xSLKH0?=
 =?us-ascii?Q?Uc7/1Y5sal0nHAdcfIqEsWzTcACNbLFIW2U54++Jn+PEnmPhtEfl2HIhf468?=
 =?us-ascii?Q?qHffqq2ZW1B96dOqWB5xswDyvLgMpDh63qJlFP0TfAuQHbqCzcVYPFm4rAxm?=
 =?us-ascii?Q?2161gA4vm7eri/Nzh4P1BPNhLysbwqL0ZcvomC4U+DG1z33SAbriorByIHOt?=
 =?us-ascii?Q?medGgg/6JdAkoi+NxWMfAWoodlkv6jaXlhQIEaXMsJZK3odTpJz3+kDbOG+6?=
 =?us-ascii?Q?kO6xUZIlDA4ZKj4WGfh2rktY2u8zT7tGRimhIcf7utf6rt5Coym2Ue2h6gP4?=
 =?us-ascii?Q?XIY856hwnxqhe/IPV4P2KAjlUh4b8wkUuCe9tHeo+9lP+802nbbFGlcQZOM0?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6763e5c0-086e-4fa7-bce7-08dc5356cec3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:28.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T0HnPK4kQbm7oxz+9LSO88TOJyjcvQS/UUE0j5yfZh4KcMwRRtVwlK5PezR0gqjv+M6Oud0FkIwB6RLIQjl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

Track the number of times a CQE was expected to not be delivered on PTP Tx
port timestamping CQ. A CQE is expected to not be delivered if a certain
amount of time passes since the corresponding CQE containing the DMA
timestamp information has arrived. Increment the late_cqe counter when such
a CQE does manage to be delivered to the CQ.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst      | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h          | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index f69ee1ebee01..5464cd9e2694 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -702,6 +702,12 @@ the software port.
        the device typically ensures not posting the CQE.
      - Error
 
+   * - `ptp_cq[i]_lost_cqe`
+     - Number of times a CQE is expected to not be delivered on the PTP
+       timestamping CQE by the device due to a time delta elapsing. If such a
+       CQE is somehow delivered, `ptp_cq[i]_late_cqe` is incremented.
+     - Error
+
 .. [#ring_global] The corresponding ring and global counters do not share the
                   same name (i.e. do not follow the common naming scheme).
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index d0af7271da34..afd654583b6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -169,6 +169,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		WARN_ON_ONCE(!pos->inuse);
 		pos->inuse = false;
 		list_del(&pos->entry);
+		ptpsq->cq_stats->lost_cqe++;
 	}
 	spin_unlock_bh(&cqe_list->tracker_list_lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index f3d0898bdbc6..64a435f914ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2175,6 +2175,7 @@ static const struct counter_desc ptp_cq_stats_desc[] = {
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort_abs_diff_ns) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, late_cqe) },
+	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, lost_cqe) },
 };
 
 static const struct counter_desc ptp_rq_stats_desc[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 12b3607afecd..03f6265d3ed5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -461,6 +461,7 @@ struct mlx5e_ptp_cq_stats {
 	u64 abort;
 	u64 abort_abs_diff_ns;
 	u64 late_cqe;
+	u64 lost_cqe;
 };
 
 struct mlx5e_rep_stats {
-- 
2.42.0


