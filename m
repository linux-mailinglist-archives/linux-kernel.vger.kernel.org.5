Return-Path: <linux-kernel+bounces-130625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D385897AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFFB226FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28E15687B;
	Wed,  3 Apr 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9YHswHz"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1787156671;
	Wed,  3 Apr 2024 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179781; cv=fail; b=ivkZsAWbsu9f3QaC6ytH3wN64mfRXJa1Q3F40/YrADU7CzvEHuvQ0U3+vJaVyZsuwv5WHdWPAWdLuywNRQ+o0JvG+cST96YypIU7mIgRYSTMJ/Jx6Pz5uL6l3YfVYHqLIJmwKgLgWomZokI6oGp1nkXu378v2oivY/mLIMV5RW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179781; c=relaxed/simple;
	bh=450nthN8ky/dXi9TRRcYJihD44hp1kYAOarNTxbr8oI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i2xJe7728wUtwUzT98JwvreGpxJH5Ag4ODCq/Cer768q/Q9i+y+3gaZtQsJSc+QovE/SpWRXvkpl+ce4zPuPGVDFMcm+BvaVmR4dTE3fFFj2RKv0hOcSZY98/BFT1hfDapSoLCm7Bl/9rSZb7E66RbtYUG8/8bo23pl6HFGylAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9YHswHz; arc=fail smtp.client-ip=40.107.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbPWOK6Ql1q7L5jHyM3osPtZHNxs1B4/H6GINVQKr5bp5BrmmgGsl+O3STOiuS9CMszrUGnpihu7tW0qKg0jPn8B7spqjbb1TbKNgdvIGoBwiay/TofRBREgCwxxAknoVzbaP/lwfgRIltP/6kKgX/FS+vFN3Tr7Lzh7JXWrlNOlEpqZl930fsR0tg0dT7JMdwwLVkP1fN8ViLYfD73Oz9igBpaA4slDSFUYTCmt46FejZRJoYMM13mAuqp+89koL/G2g42ntLSSdb/T/CpbGAXlq9O8X8KV9CeA4pYDYYm0VSWoCg/SMOk2OmAnrWUGeA5cyuyQD7giebXf91eRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzVfSh8ImznuwNaYw7KVOgVp1DXbNoCUeH1YxAUL62U=;
 b=AkQYIkvlRU8+vFKW6xDkmoXnvkYCCIjCQOoh2FXpDiHUVu2NEiM9I/SihrIXh+9xTD67+omtBPQwomFoXQFz6Ot0ZYImnhHl+l9sNMpmm39pXHdjmEZVnhUQ0CgNrTN7fwrZsybtg98+i7rr63MvC0kL30Di/dePvVkvaHYMKhbIX/vbucOAGwjW/83Kar9WdVGj4L7x3/tORdjMJhING0A6tEsaojw7/gyMBk0xO8ZydTnr5pXwMI9R8HqS+umYmzh6i6hzGjl2qh2WWza46/Qm2qNeWrxeFkblbvH1mU0qybnQT1Q5xVo91Rrk2IGZdGu971buguykniE6wBKVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzVfSh8ImznuwNaYw7KVOgVp1DXbNoCUeH1YxAUL62U=;
 b=f9YHswHzUD0wk8x7EIXfmqSoUXeamWlVzrMWTmkphpklpcrvebMsuzXZcgaepEmWJTl4WHZvPdCFG+W/NmQztsZEuyQ2/VGljXBNoY1JgT+JXvRfL9qL+2PMg4BSfY4IdvWIlmY3AobbMVl75ia+Oup1nUncR4T8ItpXVqMBzedZG+ZGCeAHrcXSXTkqVx3hlw8rd1bEFr612nMCv9wd15NAy4xXcsVyCMLgObLTYshwKSYoHcGlkLkVM2aGCGM2yJQeyMWGj4zmfjSfmOr0YB6axuPxPxOXfBrdyqgQ2xT308V+/H/KKe5fgHmQVvHiSTpaYuyS9/eMmCse0MH5jg==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:36 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:36 +0000
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
Subject: [PATCH net-next v2 0/6] ethtool HW timestamping statistics
Date: Wed,  3 Apr 2024 14:28:38 -0700
Message-ID: <20240403212931.128541-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	mTdxg98ptDThMfqvCBD58AObc8wtPnOOdSAplE9rDz3xisX09UKvTIjyH2fY9sgk52K/NvuqYtRLp3OI4XmrbnatvqxkXW9Mcrf4bEtJKrO2+44NrnQX+5olHwb8M9K6vuiD9sVrwnsUHlbLy1RcbkVC96PtXlhFkn/UxFdZc3jCArOus3crTYIQSCnOpzOsNeqQfS7fimplhzyEn/f8Z8D2eTF36Ci97sC76JZ5KkBhRB5rFHVp5lKfr0ptc5l/aEI2/dgpT1n6uqJ/ZXjFG1uwNg7yBsjYKcYwXkaAk4FhRdx/0aJEoodPuFTatdzMoKhqYiyoQpuLwrJhoz6kj4HDJixJIDAKrgtS4mbTCFN1cf4DHSJ8WTyjdOrp+UVqgq/NyBOBtAVXEh70/8u71Y00Ma8W1oIXS5NAZ4w5WC6iyoB4PeXSVDy2gbbJqd7iK31rwILaRkEk+Qy2XVoXurdk2UmQC2nNQ/4FBuD7rVAV3jlmF4pLtSQ3fTm9pvhdzqI9ktkYDYsI1X+y1zAalvZPjplDYhcCvTlOpHhZ2km13tL+Y5dTdyL77oLkqq6nGoyYVoiGkwSW+tXEaQr9Tq3b5bKAK/XENcaPjlcsZCl0YQBeMDFtwf3J6YZDrcOEbJHwnImI6C5l1x/CUUeBk2SzTICZQpwZGpVNsEl7As0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQFWmKpKUx410ZKjHiVU8PeyZgXdA+4R5qi0ocDURjY6SvQKmxaQjwyuAuqV?=
 =?us-ascii?Q?k6PhVzGjLE1BRTImg78TraodohUBUDV+8nFRTEL5tVl66cLSvlHoYT0mFGTL?=
 =?us-ascii?Q?oVwSjtxwfAtrvVFbPGj+jJ4ycUAnMPZUJOpQBbiW0oQlVxLW2PhnzKPTuDai?=
 =?us-ascii?Q?6p55eqrqWTITSJI9xl7yxqHbevuYArWj3aBFlQ66QxgXREHayrEBacW0/UDx?=
 =?us-ascii?Q?wyzNzgEzgAPhzuqcvBRkWypbpd4P11tWa1AItOhhnpFTHwoe6qnQxIGPjslT?=
 =?us-ascii?Q?ki/E0NyIMe83A4grToaAli3EHyps0EGsII39ocv7A0asACBB2ehr3+TjS7C8?=
 =?us-ascii?Q?UZvP9wUZ0kOG6+ut0PzWf2wYxqdxOs5r64bEI4IXb5P8lm3AdlluwNLJApy1?=
 =?us-ascii?Q?aX6qpBG3A+Q6dc9E2tMO9bRtiFp08L0gc1O0KbwW+NyoxNPEdzneVwioPd0l?=
 =?us-ascii?Q?U4Tw99YYsziE918VIY+oOWBDaGt/ZtHwFXh+aJcIxsSt7r4va24YxH795Hnn?=
 =?us-ascii?Q?8yXX3MgPCCyJgw4PJwyNypTfFJ9AsXce1vP6J29rTYoyZe6sbgSkKqNuIq6h?=
 =?us-ascii?Q?1FuIn5lPzqqJBxHYkG6rVnxQJ3GbIf8y/Yg3qCuTO47+2Vd+ZwAEgGlaDlOx?=
 =?us-ascii?Q?uvJ7oPquX8zQyHa5Gm9b1W5cN+Un3WcrG4BNbO1UjEOcZkjnergLbP1yuA2L?=
 =?us-ascii?Q?5tPziD0hjkUczkeSpoqAXiU+M80sXUan4MR0kFZPfs96QODq0zS8oudheu/t?=
 =?us-ascii?Q?dXPt5ZUV52LBz4tGkKAc1wqssXDInrZr9WCzoWwvdnge0lHYMe7Jd4DY0OWy?=
 =?us-ascii?Q?jxjlMNNg1+t6WRsdccKdyvtMF1Ykz+i//M33UVEWVijg8+TFhHO81w8a3S6n?=
 =?us-ascii?Q?AAkXgGg/vkl2KjXiE2u+4IhD9R4aV9iAeDJ70vYSAvMdCyy+/jU+4zQBhCZj?=
 =?us-ascii?Q?/uOAJLbzynm9IMQAorYxFY0+2+SXcSzAAoDYryfiQyhMDyzEttpwJWDv2F5N?=
 =?us-ascii?Q?eXa1YYK/FczsYDH+nnCLCCknm3zZS1ifXIY1dJQPHy2kyEBgV9qIgzptSa83?=
 =?us-ascii?Q?TGayxs/YcHRNQGV1Ll/icihOwu89q4ZMs/6DRaFzbg94LjG5OVJFSdsX7qrI?=
 =?us-ascii?Q?a+Sa44tIbjVCeNJSomRDu4DirNJvgamjEH4KesslnTCGDtedIYzzFV+7VskG?=
 =?us-ascii?Q?RlnCSfquTm1LIv0mQjHF9wlkBxZZCgtS0ebMXEdbcoh0ZyCgrod6anOswQtH?=
 =?us-ascii?Q?6G880sxhv6oYocsr1xT4fwP8pmk5xvmNYOeVCxRMxBIadFxcMU15c/HOoPR4?=
 =?us-ascii?Q?fbQP6Xpgfq87nqOBoJ9EuuUOOGgxaIYc5MW/jNWPkHtuxegav5o0rSjWbdBM?=
 =?us-ascii?Q?qKD2QZxKhiTJ0c92f7jkov3hDeTK+6F6FzZRO5vZVUWqkLmOTLFqPZPOAnyH?=
 =?us-ascii?Q?JDic7rpRBQbC29oYS40a0IZI5a+koMK1ObSK+5BXWW/jTUIpSgTVre5RcCy6?=
 =?us-ascii?Q?/lCkLtonUcg2n7ibk+K6KvscSxCSlKqayIChvxd2zJ/u28EWm/lJrQhhjeV8?=
 =?us-ascii?Q?qKk8joM97KdD3TcItxjZ5+Dd6pA3RCVUfxidJBwdjekYOP+HBrOj+5sdtTjk?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af72f7f4-ada1-43f1-4066-08dc5425297a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:36.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heY9jp2VxZOpj5cpn0NlAI7g1liJ4qyCjk5kUb7x+ent3xnVIIT4pXHiv/q46sTby1pq0DuFtY6lMOO4pMRQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

The goal of this patch series is to introduce a common set of ethtool statistics
for hardware timestamping that a driver implementer can hook into. The
statistics counters added are based on what I believe are common
patterns/behaviors found across various hardware timestamping implementations
seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
this patch series. Other vendors are more than welcome to chime in on this
series.

Changes since RFC v1:
        - Dropped the late statistics counter since that was not general enough
        - Dropped the layer selection attribute for timestamping statistics
        - Take Jakub's suggestion and converted to ETHTOOL_FLAG_STATS
        - Provided a working interface to query these new statistics from
          tools/net/ynl/ethtool.py

Changes since RFC v2:
        - Applied suggestion by Jakub for implementing an enumeration for
          ethtool header flags

Changes since v1:
        - Fixed scripts/kernel-doc warning in include/linux/ethtool.h

Link: https://lore.kernel.org/netdev/20240402205223.137565-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/netdev/20240309084440.299358-1-rrameshbabu@nvidia.com/
Link: https://lore.kernel.org/netdev/20240223192658.45893-1-rrameshbabu@nvidia.com/
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
Rahul Rameshbabu (6):
  ethtool: add interface to read Tx hardware timestamping statistics
  net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port
    timestamping CQ
  net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
  net/mlx5e: Implement ethtool hardware timestamping statistics
  netlink: specs: ethtool: add header-flags enumeration
  tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get
    operation

 Documentation/netlink/specs/ethtool.yaml      | 22 ++++++++
 .../ethernet/mellanox/mlx5/counters.rst       | 11 ++++
 Documentation/networking/ethtool-netlink.rst  |  9 ++++
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  9 ++++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 48 +++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  6 ++-
 include/linux/ethtool.h                       | 27 +++++++++-
 include/uapi/linux/ethtool_netlink.h          | 25 ++++++---
 net/ethtool/tsinfo.c                          | 52 ++++++++++++++++++-
 tools/net/ynl/ethtool.py                      | 11 +++-
 12 files changed, 214 insertions(+), 11 deletions(-)

-- 
2.42.0


