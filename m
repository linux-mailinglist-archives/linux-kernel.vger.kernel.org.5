Return-Path: <linux-kernel+bounces-97809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37404876FCD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B11C20A9A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3453D374EA;
	Sat,  9 Mar 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rji8nKR4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6D17740;
	Sat,  9 Mar 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973900; cv=fail; b=faxEwSlm8irKqDm1JvtAEMlW/8cN0Y+C5ZmwpLG6k0iBWqJ/hCuqD93OmhIIPMMuy4KTHYCAgVAbfOt8jWbnhqPSXc9enASJvjDwyoaL94Mt6mz5kvRcvUIbzsROBAVrtmtbcoOFiAO2GSLFMC/5lBaNuESGamPIDv10iUWWq/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973900; c=relaxed/simple;
	bh=TPt+B0/9pZqrrfQnP/8OiPy9bBtG8GnehFvvf4Ad6oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRlIkIer1qCi3Y+zWEjJhN7DuVB7mcQu+ddOezoUSdr6azv+wGfvP9vgDlNMLmiqUd1qgBwmMXYlb25qGJYmoGNORSYB5yY/gAjr4d/GLLpDxd9SNT0N8JsXtWBVVnnrg/cmpWgu4sYiw65t2B+aiHY/6S6eIfhv7k6ogBXJggs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rji8nKR4; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm5IVXDKRR+TxLN0d1KZkv/v1oUpVIF/NuttwblfTeSuIuozGFVk0M/J+u8XgA9ItHb3+BxJ9/D6NIFZtZcZuhYi63zZKWWuX7lfJwnKGXVe6TabhUgmF1rUF1GYwMRH3MVf/5DKmOgRah0o6HasEyvuE3OcWCL6HZ8qMZMo/ouYJKcGkkPuXhj35MxL4mED7SAlLOrOUXjwX/CEtdVW5ma3rjXYi+V4Qhq775LwX7031xm0YF8lk6dRQjG9PhXFG2Xb+HjA0MFMBV3DZ1dxW7rRRMN6v8nUTHwIZ4Pj9WDu+jeDfBJHXyQZvTNt/ix8cwLTOzVXm1ZY6sYXXFNa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geAr/maxny82tC+qVidF32JFjV9pzOFLZ+gCzu+J2d0=;
 b=YaHr8LVjxSxb5wsMTGwJ5VoulQaKD1vSkbtAAjgmHvXH778xv6SCpGWcTU3x2wbO+V1KdpgDp7il/h+mjEiugOuv48OLfB9lH2LMU3TvjTWtwKqGYQ8J6/XFm3JpMoBFNgf6bgMn4BkXAZ+GSSF8hs7QkXlCuHTlfO2mRywjiMN2NmDxUREcTURqHVFAJw5shR1DC/pL2zC5LJHE8oZ1DX9urIYwqe34MIZa3tWRj+RbCokyBJT97okelu6W2yIkwKJsnGhgNKWvkYqLzMOqTFWNRI5iy0CUvOazQMCrCZstV2lKwQrqi9akApDsxPl2vf4gDIEpNBORhjPisQrqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geAr/maxny82tC+qVidF32JFjV9pzOFLZ+gCzu+J2d0=;
 b=Rji8nKR4Wt3zHr7hAJrIYoA6y/a+rxtCl1mit547/ba4J2/G1Yb3n61db8a0dai5GgR2+8qdS/Mx8HgiYyxeSTo240Bg5nvSiVykpoxK3f4c7hhFmqYixXznmmNPLd2ZM2vuqBLRrgIlTKz32tTpa/ZovAHmQt07164znmZYyT68zaWBm67radVwhZg9R5YaPpAUBgzgT/cVnMc5PgINcsmasyWqQrzxKPhD/H12DDZzL/VRYx0BtwYF13Rr0j3XLGcltgUxfBc9o7F/f6fTyD3Cm0CTN6rJdvMzbTuFkB/X5xpwWnVnJtmxssb5otavWKuLioAyiUWvQyUNcgrD4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:44:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:44:55 +0000
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
Subject: [PATCH RFC v2 0/6] ethtool HW timestamping statistics
Date: Sat,  9 Mar 2024 00:44:34 -0800
Message-ID: <20240309084440.299358-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: e24bdb7c-35ec-4429-48eb-08dc40153169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hn7aTpVeYQ1CjEmjahO8G8n4ZAghi3MD8Sx+BNVNnZ5RdS5OHjS/Zu/Sm8LTIl+maLCaWTU/g2uWWm/71MLIEazcv7SjcoUjEEyYy3JaDSdI7RExcY3oAZ+2QlH4/aT2NedIuNetKqlM24gIBLj4yXb/JT6irRYkFkuhJcaSUjGjUHm+exyo3H7XsKnrSqC2doalUwcCTD6LRpkiLEBSRPnw4o9F4AgCPngA5yvG96j2HJNhcYbDui2B+JjB1SgdtsPtF9noif5ZQGiSPpHe+T9zvjleMoVem4PNYbEseD7poHUe7BrS5nhptbs0q5IQE32jg85c9+cVyze7Op7YL4MMbfUKnK/GDc8MrQMepCu9L3IuJqcREdbj/lEryrlhnnV/oVLg2P9wEEs+bn2WZcpffNfajSA4GPs00lsaWKJ/DRMoU2HeC022P6UmFSasTbmpqTCu2XdqmYXEoEblVoTjPrMqB1bXRUDGBWHJc6BsYBSOsxLnBr9utobFlEW/C0fL0vDznmvfVmEeWzW1MQdc+vhkmxr/c36wfVZ+arYZTBJGZfnTmS+T8fhiDNiDrpHVYdW+Nvq16lndVyVSL8MkC3MjMfk01Hiy5S+HaDT3LSCj+CM0J0ZfZD0v5I+ZDReMiaeO2wWmdE7C71KlhQYENZVhSXMtLQadI6c5piA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mffrItPcp85PXCwlNr7sQLhcUp9IH185gmQcaHmjXmkDcnRURm2DzkPe/f5e?=
 =?us-ascii?Q?meMxVyeBGI6otzEqW7mZPVx6dqu+pSbi1dfWiAqQ8KpjKrhctURccvojH5vp?=
 =?us-ascii?Q?chJ6+fsxAC4hg6q3YZdKNV81r6kl0ahEmqZRzsH82MyYSd2y42mK5ciicnPN?=
 =?us-ascii?Q?Q6RUsI9TcEwB4p1NRPfAZdyPnDiylFhnWKUmzrBJ4qHv++aPN0qWsjgyWmG/?=
 =?us-ascii?Q?evl0Mr0coCrHn+I45c0P+px1hsnjveN1it8nCKV0vFs969I0/jJedGY7yvHN?=
 =?us-ascii?Q?/wN4s0GPFjuIUQVoijlRWhOqrkLvgc3MfEB0xuWC0xCresL2jlfJxihaJPjT?=
 =?us-ascii?Q?2Msflaerkvjltx33fCMMRS1V4R8FKyQAkc62uNrAH6WQhrZv8c/atuaJZE/b?=
 =?us-ascii?Q?FH1JQKi26Wv+zeVuQhR6yiEo/u2aXvYSRSPXTs6XXhIe5RZ6jr8yUWR+5ylV?=
 =?us-ascii?Q?cjYbb1ARQMgYiGXWOuBaUMVuZKwfMJLXYu34HYRr24Pxxl9D4FoqsEfPeUyo?=
 =?us-ascii?Q?hbRd17PWF4rC7l/2SsddCTJagcc1WYUiLH4oXYXUfaRkT8Py9FF0Z0iERolF?=
 =?us-ascii?Q?Wx9rFq99vZs3x/UOMJOSgjfVJP9q1Yp1YhrFEmKSgFz6VNNAQYERv5M+IPjv?=
 =?us-ascii?Q?7UMWnQNQtfdZnx/Ghowil0P57Pe2lOCauuwasGTgcK133LwLeE/pVgrbpyow?=
 =?us-ascii?Q?MTXnwm84As1nTIpc5LGgN8suadcBjfjwrQ83ztMasg0x2rx7HmWM/VTSzHtR?=
 =?us-ascii?Q?gGsAj/Aao3SUqkT1T8FFfOUVWAbQBPIdHGOeNHC6OYp0+aX247NwbpaJRzFr?=
 =?us-ascii?Q?nhQvZmEqYjzVjCFvv00QooApWYeqvahDfpHxYsB0ZOCy4MBqOdh85wAhL+v7?=
 =?us-ascii?Q?UHxUr9PTtd6jET8H0jL9QsZkxLwOuBnff1DBjtTKCIRHJpDUwH7+nB9CZkj1?=
 =?us-ascii?Q?HmTvhKGOFs7FhMQUlWuhKwzM135HyR4OpXSdtEIFs4dLOwE9F62tqw1ZAwsl?=
 =?us-ascii?Q?0Vrtr2HMptKrDynAKf84aMVcq5j/DVih4hE5SfMzVfSrkpU2k72szTKqb2g6?=
 =?us-ascii?Q?nhwlUNhEtzrCrwukwOLQ6vBexO/uQESziXfbWtD1MS5iYYDhv3lImTVIX+an?=
 =?us-ascii?Q?1ghSAq56Z4YbBmvzfs0aiWPl2a/DdqIaoViRts2Ucahy3B+UBXU5Mskn633y?=
 =?us-ascii?Q?H43Xq69rgvk1niF5zDXKGMv+Dc6Se5U/6U+BHT5ty9O0V5E4tHHqRbFbktBR?=
 =?us-ascii?Q?5c0xCx0HbZEFL3YywW9hqcNMEkafjNzqCvj5pNTiJCotG3OCPogmtU25nzM9?=
 =?us-ascii?Q?Gp4VCMVd3Tyk1aXM2i3qRlrzZwVn3H5ZHG3TOt8OksYo7dgk316d9MVxBOuI?=
 =?us-ascii?Q?45K1hc4baQZRQBgL32bxMXk02QMQQGelhZwSrUkWk17l6oAn2hTI+fWP8szi?=
 =?us-ascii?Q?gb/vkT69mdWtPueOtdRBfIvHyT3y5e7Z+0CYFTlOn6f/YPxSyfz3z0/wsPy5?=
 =?us-ascii?Q?Tm89bJTnmlF7yAdqML+IgW+SmNFcec/lp6lMMRRfdh2GwTIACCfv5NZ3UWup?=
 =?us-ascii?Q?+QfYGSTqT6GjB5ia646upBvAgWAC6lUZCM5P9ff27CxIjynjHnPPw4tMKIWd?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24bdb7c-35ec-4429-48eb-08dc40153169
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:54.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdwjO38AS8KbGpMhD21pEoNvgA+QIvWeXrvHrvm4cmT94tL/AMjhtp1cp9iRaoNGrGRSdgkhbY8F8rhAOrL8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

The goal of this patch series is to introduce a common set of ethtool statistics
for hardware timestamping that a driver implementer can hook into. The
statistics counters added are based on what I believe are common
patterns/behaviors found across various hardware timestamping implementations
seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
this patch series. Other vendors are more than welcome to chim in on this
series.

Changes since v1:
        - Dropped the late statistics counter since that was not general enough
        - Dropped the layer selection attribute for timestamping statistics
        - Take Jakub's suggestion and converted to ETHTOOL_FLAG_STATS
        - Provided a working interface to query these new statistics from
          tools/net/ynl/ethtool.py

Link: https://lore.kernel.org/netdev/20240223192658.45893-1-rrameshbabu@nvidia.com/
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
Rahul Rameshbabu (6):
  ethtool: add interface to read Tx hardware timestamping statistics
  net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port
    timestamping CQ
  net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
  net/mlx5e: Implement ethtool hardware timestamping statistics
  tools: ynl: ethtool.py: Make tool invokable from any CWD
  tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get
    operation

 Documentation/netlink/specs/ethtool.yaml      | 20 +++++++
 .../ethernet/mellanox/mlx5/counters.rst       | 11 ++++
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  9 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 48 +++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  6 ++-
 include/linux/ethtool.h                       | 21 ++++++++
 include/uapi/linux/ethtool_netlink.h          | 15 ++++++
 net/ethtool/tsinfo.c                          | 52 ++++++++++++++++++-
 tools/net/ynl/ethtool.py                      | 19 +++++--
 11 files changed, 200 insertions(+), 6 deletions(-)

-- 
2.42.0


