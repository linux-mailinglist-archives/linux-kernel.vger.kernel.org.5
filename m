Return-Path: <linux-kernel+bounces-130628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B822F897AB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFCDB23CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E3156C45;
	Wed,  3 Apr 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hPe7HvQx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92F15688F;
	Wed,  3 Apr 2024 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179785; cv=fail; b=QYvuM4we5ERhC6hVPKsHNsywnvEmESUR7LINbFJwpkBKv7Jl5LuQzp3c7vV3lnWVwGSXBmds1xih5kAsg2me1TNJhMCFQztC0vQNwJNkSrodwIgt+0USh/3fn7GjoQxZayHVQAO2cFigbmwJET1YP8778N5DKVtDGC2z7Jcx4/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179785; c=relaxed/simple;
	bh=1Iq1rPE5Vws/F9owFdesCR0VVEd8lfjFoG6/fp2+b+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTIPTsmdVSTnsG597tIdc+XnPbcA4jm6wOJumFmwdgzVqanBQtMHil5tx5OOTvmOt1C3es1bNv7R1UE02pS9JsPhgM/JPFWEZWfttCqEXXpVE+T32mly2pHX9aFpvBJLNqx8nQnt/poFCVfbVq1rfEqzGCy/krMazdDtsgfv22c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hPe7HvQx; arc=fail smtp.client-ip=40.107.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7WG4dcqYl9/k556jB2a5iYeECVwpp0kwTu+jnrJLvYmkHAFrublgtsAIPP5/u/soN5GHMk5khyix0yCa7VL3Jop58Ng9gg835rGvjnBXOU/QKjE+6FcXSFA27NdXHwWcxlvJ3msBOMNEiNKWMAwsgdveYS3mbca66uK16t3UnYvgmYxbgKj0VvgHrI0iKFfQSoesAa8RbzGtxPTVlXl9itP9BuzmfLGq8TDaRxz2dQfZlcxsiu8MQmP4a3O/CC0j6BFFsZXAEdu5Vl1q4pv9OkChfkMPYdOEOIeC0rvnGy/XVpF8K2v1E4rJl+FhZjkruGmJb8D/KjGqTKmWieImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jA2vxHsGi7a/yAU0vv9kA467PAZ1r09oWr5tHTIlCI=;
 b=XwnQgAY4w+9lzBwUJ7bRHxThQCtjomAZO7nUywrurg8iVcI/R4j+xPGXWy95PLviBrvEk2itFJHLFIz3XC+/anO+7lpL+F0MbZqSj/ZPxDVTUUsaD7xueuresVNcZmc4PSy1R0jOsZlnM2HMGCSVU0uJMimQEuZ18joYcb5DNnpj2Wc2n7Bn8Su+JHbMsIs1FE/uhvvDuUAgZ9tklSSe7yRuZMhy59PIeKxRF5OnUUa1N9Xi6xPaOV4Aq0koCuBcMnNrZDiP3tTrkCXY2sDBYRcAM6gsJidwPODXwk1WlwWCmRRxMSlZma0fIv+pXEDwkuTjJ1DaD4FeUdHu1uUmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jA2vxHsGi7a/yAU0vv9kA467PAZ1r09oWr5tHTIlCI=;
 b=hPe7HvQxTMUlELCTqf+8nuAG35nB5p8JxzvDSk3YwQm+1G2ZfcS26HIU5wZhKZFqV3CS/VRn4/toaVZOdv/utd4T3R8nq9NR+n60oh83G2Y/xwtBSbG8CH9cIzTTzhbK+Q8JkeQueCRpTG/sC2mgWeAn+/jL8hEKPAgXTMZ5JEt1LqgY94vmkj3CdZMHfxwZub+cGymNrPouWAMohSgElyQ+BUdCa0hGv0eD8sSOsAHOyVrpZ7/4ohMAGVp9FoUp0q4p/Z6JxAhVIXBgJbKVTg6sIjaZR+Nb+Jzz+JrS0ye0HZfLzCNxQVA2aYUraC0tQ7O+ue+07IcfHB/OG8K9Uw==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:38 +0000
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
Subject: [PATCH net-next v2 2/6] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
Date: Wed,  3 Apr 2024 14:28:40 -0700
Message-ID: <20240403212931.128541-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	hN8Gr2JJgL197hTwDQnF7keCnlG2CYAF9ONaQZjxI6vba00Zf8jXIN6G/i6q9oDlcLkp0tPV/9obPDlJKvNJgd/g0iWPeQt4EHU/8FtbEckLKhA/Ad6y+FJgaYJk2pbHl4dO7wm7qV6JQvaXSlQ0kbr9N44a1G5kZBUFGdjzdjtynFs/MInNU6zJ9HMtbQnZPbdRs1gnJUl+lmE7mmNNj9V+EM+o3PfyTLBreULhBou1GolN0WhHhJNODxSBtwc3Bnd5vTqA4Ne440xxve1Y0kPJPExDS7ZkNqGSqS7rBX6rac9DXHuOYxAIJQaypECecE+BT7sI7DcnqW8j4Ge3Ts/T0ltiOvmbVMux3MlSv3fA0Bq9Rh9dUCRXA1MwtB+1D9n7rAS7MpqmNGladWBnTP8ojH0qqXaF23GBdnKIk2BZU/tEy3k08M4aGzGJhKB2agjrID0vHLXWOkACsNID4sTGsN+ujQteSEIoZFgob5p3Rl/7T5LjXHp4TpS9JDX/9nLaB7DSCM1/KW/QbqDO89D+HeaqnfqItU2EYaIrO+okG6mqFjEEwI/xau99nHmmSgPNhhgCTt5XMnKulIlo90B9DIwGll3c2aEsjwDcH0jii7PxfA5GKM6wPZPCJljv3GUCIynZJPBOBUxSp24TAU7zRadbskfptsbWZVGtS2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TE+0R01o7AdeVMwnF3A012eTcvLMXK3OZud7PYu+SoatFCZgU9yd/RpE7vaP?=
 =?us-ascii?Q?L4TNHT5V4xZNK47o3H1HluOiRnn7aZT71xIzBHJ+i7T8bFu9sGPmuHHEtVo0?=
 =?us-ascii?Q?p/Kh4HPIaqNM4+gOiH1BTpmPHSzDjHsh9BBzI3AEqNxAJbxQ6J4fdYxtMxyI?=
 =?us-ascii?Q?YQl2ib+xTnwcFblUFVHLHqqJ2jv5QhSS4qrQiWwuNT03LR7Llyx5d6ysAMY8?=
 =?us-ascii?Q?h4orX6SPrpnj3mMlxEwDdseoe5oOUQscuntV449knj3+NIX/j+3RBVSgsmdz?=
 =?us-ascii?Q?tF83bTZWxrPSSXGu68TV339YKt+M+MhaRZ0S6N59xWLMhKvvgP6tr8e7K5Vh?=
 =?us-ascii?Q?KHk4ixFdT/Qk1i1Oub4FehiVCJRKfkt08SbvCBKTssiWBIZPHubzOtZ+FrtE?=
 =?us-ascii?Q?LGyyeJplOPxy33/WoiFSEYcFGD5x9PXPgA/xfr3GAoHKE50WHRWt6fpEbbQU?=
 =?us-ascii?Q?V1zTVhGT3yrhrJMda/vWWEJ4GCIC01dOmWYfNcT9cFvxS8M/cLOUVwQE0KV5?=
 =?us-ascii?Q?lvbvVGAd/NSzK4TMEjzmdaRVz8cp9p54xazS0ShYWvNHCLBPVkcL0qGjsgHW?=
 =?us-ascii?Q?n5nwk4SS6B3fqRwfc+3PaCsL4ITzk0kzsX7JfygRDZH3/OKF+684OS3Sxu50?=
 =?us-ascii?Q?LuQtiVGdaHO5FqZjCFfcuWR4aYfSw0uv7AoWAkvTaGvSN48YvfagEv96OK0h?=
 =?us-ascii?Q?MQmPtIz+JJxYYBov4eT6mZMpmEGrFeLI9ZwJG13DX3EWaK3BplIbNvrMyKH2?=
 =?us-ascii?Q?35e3btyDwqrr+rtsknA25SZB9FGHvwSb0JnVn+WfWauxjWSlCh5gLaIbkESD?=
 =?us-ascii?Q?FSNBOIsbGgP//5C6eQ5AE8pZOhVwyy/12E94kg/MLt2PJzuI9wQiVB3+imqH?=
 =?us-ascii?Q?98IqpxSUQE6RZeSxpDi5EmRMOpKW0kFTIWYnNbwRsGBWicVEDWwcUeS9Rfy1?=
 =?us-ascii?Q?b/BSF0dbD2JAC5P46yRfdtsHy92IdGCIlKri13LfAnOT6sZQLNl8WLxGHf1m?=
 =?us-ascii?Q?8lPGws68JhE3TJF6ocVtVPhgj0LbP+R2YMMoBgTdxAQCr4U+YbSd1+SQ/Sby?=
 =?us-ascii?Q?k0U95mK8E9hKFfg+WFEcYkLWLMwOU8hNhxUFdkWg2rpou93S/BcqkNJJU1es?=
 =?us-ascii?Q?hFgUBjGWplNfeK6U03B8P2YX3vyCxmhGp3zqjPmtlCjp0o3jJdA63Xg2s3JQ?=
 =?us-ascii?Q?M2aOZ9yLwv38c8tiWbG5uAi5N+/jr7tJYLgMmTjNi0P82hxuLxxb1CWO3yy/?=
 =?us-ascii?Q?7YKgqwA/XKL2E++QyW3Q8H0yW89UZnbpfbYBJAeT4I5iCheioNebsTSeoqRv?=
 =?us-ascii?Q?rNWQc2fW6ZMB2WtVIGc+wtHn/c8+tdyodaudBRFhxl8Pb2gvxfLd7z8zMZQv?=
 =?us-ascii?Q?2NiSc5x0MjcC8WnhLXbuLtLTLg7udq4Gb2AWzQjb6LSRB7hptkTxfO6f1ije?=
 =?us-ascii?Q?OJyXliBN/IXtqdoykigOpNbIdsNIcrDmhEGntNSpL41fNCc5AVm1yKk1H9Sc?=
 =?us-ascii?Q?RdV/kcgMr9xQMvahqWqlVGVyTn0RxgRGTMGpIZmTp3OWXN984SB2fz8328UJ?=
 =?us-ascii?Q?zu0hB29kEA5NkbupEM3nAJjBMOcqoU7fHN0GxR83KXnDq0nOlopMym6EqmTc?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfa297a-7b89-4396-2114-08dc54252a55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:38.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXZTUUnFGMH2Vc2BqVQmqax2GbLsBhJXn9TZmna5dSyqR+Se6wcJBUGNlXKj9t3p9+RlveZdaLgN5m8xL4Uo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

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


