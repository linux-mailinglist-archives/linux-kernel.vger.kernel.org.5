Return-Path: <linux-kernel+bounces-79022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6073F861C75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4762285FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8D1448E6;
	Fri, 23 Feb 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P2fTBvfS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1A143C78;
	Fri, 23 Feb 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716443; cv=fail; b=cKjMuVA10PX2H200GiAZZZUCqPJ1rvHLsD9qW9kNgIvBTJfTIxpXIVmpJP4ugeCThdRnQbTxj0ZLEo9Vbvb3opDDEVKOCNxjzeQE1CgmKGu6d6aFnThKEBvS8UQhXd45BHB91vJwbC9vngJN/vfsKlVv+c7zZW4pWSXdQovOoB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716443; c=relaxed/simple;
	bh=7fd+Kgu4uLN39161xBgBH39m6WuN6GvXrp5Ez1zQIlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLS8a0xbhw+67ywG6/z3x2SZjzrZkLJElkdzPguQohBk1pgi0478tii3eK3WHRUX/zjZIMgUasxapDG9Zj5tP+vljPP28qOrQce9D/d2Q6Y9AZusbDVrJqln7pKygVd53uGWcjq+KtU3ABVCarknSDy4QI/UiyIKrxWdZnuBk8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P2fTBvfS; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuGlzlpdFJdJ093Mp91JrGylEp1+lY/1d+5aV0HPsQCipXnh3eB546oZKQjOEqdnoAMZjZOxOcDPJlgxyWjcWDe+6LGXp7f835YVMGuOt8a/QxAZ5PmUnguhceJuynX/SQlAq/dihiACsoiuZRvuW47Z2+4jD1N3QckzOblR7rTP+dgwQ7W2dKr3psSFn2QEuQdTpifypcipFzJREhCpdKCYDcHkTN0OCX47bUnt9emnNHgTl0/ptAPx2Dz9+hIAsQWl1PDaYHUALCLMfazmjUi5wlonMu6iM6rw2tgyfgrBdFTKzGRZdYITA+atEKNyCgZFITMUwLfZDRo0wt1QxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOufzfcYPeiRdHi9Ovu02DHwY43No8jQr1B4aPT+z20=;
 b=aIaZ0Mxy50zmh31H6IAYmv60mIU49LZGVeJ7DIQ88T8/IUh9bHFWK6LSia6SWlSwMTjqJgHNJP4I89WuR9Y14f5K5RFPEmhE0c9ztbz4RsVYM9EvQr9+cVf18yXgzTQsh3H32mFKg+8AJtAwc9UJpT1k10Lb00E4zPJiZ++UxSVyG2n6YsPyfoBtjNDzer+4s/qtRR+WLjEn5qIflh/fQv/fVqXz84SEAJflpqawHrEoQFhVA3U30cpjvbRcwmAM4G5cfxRzbMv9LsORz1iA2oMmKigM7Cmpe/ue04aMfKpcjFQUNNHVIM4YCspSxt3kRDYbwf1kXa/gGTqIkX7rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOufzfcYPeiRdHi9Ovu02DHwY43No8jQr1B4aPT+z20=;
 b=P2fTBvfSidJcruuXz4vvQZxYZIzeg90hkGBAg3FN6KKx9eWPRhdBS2xUv9tx1ZneQNJU3QJ0l75cup/6FMnWVALNcdAJ+3A9LJy4YGaXJHMPp80+aAIfL/YimOgdRECBrQNHqB9WVB+oRACHv2C2zjEqKjSj1uZMefCHyJWJJF4VHBRnvmocZD9Ki6HA/gU5GvSVMB430ZkbflmCyL7dnwRj7ipNbEDM5f/ZCLTvJtBFrHHPjbW+goxYPsWCQlmmXGLsZucekvlgc/E7BssPv30g4ZAROwrbfUG1rW+qJCEdjWkqGbJdXxERuCI05SAy9Tbb4aHwFMGm4Hc5aY5XaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 19:27:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:18 +0000
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH RFC net-next v1 2/6] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
Date: Fri, 23 Feb 2024 11:24:46 -0800
Message-ID: <20240223192658.45893-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 005d94bf-537b-48ab-7fbd-08dc34a57319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TPgfWhwFXbLzDe4d7hPmbT4PxG0p6SV7eT6Tp/EKtjp6HWb1QwyTowgDKFu0Q4+XhUSD8Qy+sT9Nrm80t88PBgO4d4niaRKMwxfziWnxcEe4XL9L684FeiLXhXk7gvyWxDdgPn/oqKfzKLx49Ru7vRYs+UZbYDzuY8bypLVHxI5RNCm4lQnabt6Bl/4SH/UJPYxeHuPaZLXCvd0aZv7k1DJsDh/M179chuNqooESkE6Gx0Vczwe4mEaahQ3NqA9gmcVh8t4D2iCX75AqfojvUALA+fFc2ZHS9VrwB+X+1Qca/P9ZzIUai3PfCkPJ60VyWRZhTH6fqcS+UW33PGH2vfJC6sZiBxStStOmc+JJO0hgT7RXykS9UYzCecBbtT8fyUmW5d0UYf6x698uCkISkMGiaVZVL+pCYKZVmNgp8Lt+gvpVvrBk5xJkBTvKp99FaAxkYQQzYSvjw8La9iAu3Cr+ICKJwg1IRNsix1j5QT22Q5hMYv2fAQUO9/3EKbX5jik2ucq07bD20Y61DbXn9mA3cp47SsIeMXmMVSYQT8OVvnltRIKxeGoUVAI4WM5EzTWptv5DnbTHbQEDrcmLZwgo9wUFj110UcwbWfwYPK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0ysmiqtDacUArw2aFFE+McfQ1OgVK5XM1tqebK4eIm3VEcZw/cVonuX+DX3?=
 =?us-ascii?Q?1alb+HYHL+/P9lyXdb1k0t7OJ0Fh1idDrs5TGBcYHtqmVa481STuIHsO22QX?=
 =?us-ascii?Q?15URWEs/5SKnmQRH/TUjaV2JuVqd1xN/5CukouCC//oau6dEKY3nCBAIZRWh?=
 =?us-ascii?Q?4Fujt4fE4L3GuxHgC57mRC6sIa6Ma9QzcyBZ1qniNUVxg/BxeEX7wPLX8A7R?=
 =?us-ascii?Q?IrzfAZfNrisHVvZFHuhYkWdANtKuEVuvwwRBVI96Yrn1PegLNa9TeXaReaEI?=
 =?us-ascii?Q?seRNm3f9de2GMzjbLcOdAX7wBeQexILNyic0b7m5EHdauIUtYxOIy7kA76wl?=
 =?us-ascii?Q?AO9QZUQFIUT7up74SJi3HX9AEGAkbhIO9BshQsHoz4Ehs6iMlT8G1NvQbZ77?=
 =?us-ascii?Q?E7FOUPIIVbGfJwf/EZ+OsIma7XeNfWvuQicE4HUzUFGtLnCEpx24k/pkV/O9?=
 =?us-ascii?Q?/p1dSWbyuK2xCGFLKO09Zxn0gfRcgKXRqzMLmwAMapx9733QjLTfNC55QNGW?=
 =?us-ascii?Q?dr/nSqIItEf8nL7z4mLNU3htyb9wU1LY0IyItgnWMI1wPMlJvihouw9cTPVJ?=
 =?us-ascii?Q?QEtjedHn9dvHahZvTwTRkDDTbYgYAgU5Pv8LjieDvViEmo2UqM+6GV0HMrj7?=
 =?us-ascii?Q?dAuE3x9Zst/dM/fw7E/RlONCmoxUw8psug3xnik0n3N/jVZm4VXFnVWdBspX?=
 =?us-ascii?Q?43uFLF4PRBGbmc+uVgRYvqpbUWGehtpFNIIhIivt1j4o+xvodreFRSoRVljY?=
 =?us-ascii?Q?rntx4rg7EC/05fov8NScchtQcEa1/N3/7ccA2hPwNSuOPaifDXq2wkfz/Vol?=
 =?us-ascii?Q?iwP961eeUYh9+IbIy8UBxIiCjP01tY4+irA8hinFqIfJr4KS60BJKE5gX1k0?=
 =?us-ascii?Q?mR0fqxfimo+Bwe/a4eeE3FRXUh+2mQ1L8aTnviu8m3yXbJ8EjzvzWz2bbHbC?=
 =?us-ascii?Q?7vmOqSAC3I7aSAwLMiEXFp2Y6FDPfoQasSXyixz0rLUG4YCHHqknHAvTKN+p?=
 =?us-ascii?Q?lvXEy6bY030RyQ8iUXfDATGGwS1H9N1Kummn/1wJ++LlKlaX8/f6UKUMrMGe?=
 =?us-ascii?Q?WJKHjYkxxJwhhhhVfEwofaSbB9PU5FG0+jfd79Cz5dOb6LwQDF3Lhu7u+kw7?=
 =?us-ascii?Q?qWCu0jXGt+OPrYXB968meMiXh7Osm3WwxUh05CU02O+DhasCHa+Y9z8mBQYl?=
 =?us-ascii?Q?ztSyUWm4BXrFYT2V5iIpcyh23mu7huUWnwnf669kbyrhYd9btCjgp5KzUPCe?=
 =?us-ascii?Q?888x4YnPH6Odg5BUcMdM2/abWjgtDhgCw56mvNVVORySWlK1J/CTbU1iezsY?=
 =?us-ascii?Q?aF6ARRj72Y3ImrIX2grFAzufzWt7Ba3CiUysPoT01lA8T1/lx/XEDUld223F?=
 =?us-ascii?Q?36GNF+A3wzN/pNHkcgibwgW34buDImnHjt+gYqiULqTSB2h2XEAhguoT+ZRI?=
 =?us-ascii?Q?RfDhv5owOvH8liNSNKxIfYc7I4ud+WyvEdus9xeVhm2W+4eO3nG0yWc/+I8Z?=
 =?us-ascii?Q?vr4AnevQmGt6HGBnrHl7Q67Md2kqWS8xFman1dCXC7522cKtO4fR0SljjtLl?=
 =?us-ascii?Q?BjZuF6vuJnYGZgqjVXutt4F6+gGvDcc/7zgkeyFS94dOo/hRCs64LrhuFh0s?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d94bf-537b-48ab-7fbd-08dc34a57319
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:18.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5D8LlTMd6iFLaf9faTXN/hya2FAkKbZUQ4M/RpO8EcpXl7z6ZYBRyKhPmmDf/0zy6H4+u8NSNuu6vsUCN6Tfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226

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
index fd4ef6431142..1dd4bf7f7dbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -169,6 +169,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		WARN_ON_ONCE(!pos->inuse);
 		pos->inuse = false;
 		list_del(&pos->entry);
+		ptpsq->cq_stats->lost_cqe++;
 	}
 	spin_unlock(&cqe_list->tracker_list_lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 4b96ad657145..7e63d7c88894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2158,6 +2158,7 @@ static const struct counter_desc ptp_cq_stats_desc[] = {
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


