Return-Path: <linux-kernel+bounces-128677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF4895E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2633B1C221D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A815E20A;
	Tue,  2 Apr 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h1AFYWMz"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062F15E1EA;
	Tue,  2 Apr 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091175; cv=fail; b=hENzImX4YuzVqlM8OQLSMGg9QY0zIbUM2G9b0Jb1UN8icolR6eV3oZ/PdS+6AN6iFUJ5zHldsE1J0C2y/2Um6LEdWZvDdQh2pFFdg6NcmzLKNei2H80+/tkTJcHWzXbBMmnLDWzSvwaEVaFQYQ51wfJHRUYKWU/D7Rdzw33Bdus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091175; c=relaxed/simple;
	bh=te53pUWiMTvwgjQk1Pif6eAJDkvgLYazkDyznj0GtGA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A6cCOQFCYH/aEN1NepIccBIARMpKzK24mSE3ErVHuTVMYBF5YRnSrFAZs/tkv7o0yQA5bKLBnbIygDmRUl+JU6bnjvSRnY4ii2QPEorHCUcy0zufAxNG6QAh0KvguOmnT5aO0JiT9SnNuShKTMhR8dIhlU9ot58S3qNWZjYbrLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h1AFYWMz; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8VgzTQt08mhVEGrbQcZFHIwgbdq3BRXofRA2uUwCL6g/lUA1hBHT57NXff9FRVYvfklzmZFpUK4/oHeQ2yaJ0cqNz7+gxZLY+CIPCdofjUbfXQitMWvVE2axLbjCNmatdYhRZ7ARID5ADcPH/A9DpHLROGDmb042/jKIRZOlJ8SZY5EyR1mbh5nnwQh5iIZDZCFQx6phNU9tY+if1TlXyQpsgy3B0aVFghWwMmZGvhjSpYO4w0mSS3XxbokeJRXxTwanacLRuYLrARA789l97/VAIO4Azcd1pyrqcCknZ3NE/1J0rzt8BZqj9Orzbbfazw9LJ1NM77WxUWiHtCANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aojyshXktIhBLzR6Q/R/KKR09nDQ82BUPUJcuZwXTDQ=;
 b=fixV3REYrRGneey7DBuNaWoq2giSpqSLrCW1fS0BK5ocRSIOa9iZxCmT6e8R9SNFJe3wrPFyahxEGEGMIZaywkYEuFcvnmpoUIDNdE/5Te0+uoZXwtCZTN5daAJGWPM/jShAOPaa0YAICovfmSyCouXcL4VxZCekXI87wudZcmYsheRPQLoqTdfqisuoP96Xc3IphtV4OrsGSDg1tiBU0BLMTla635FjVWfZKlGF1qXQJe5KAxv3zqMMlz51ef3ygEFv7sozIK5zIKUjesfPC2JPYTDPs307TqOK8vyfOXdOMPysgrpZwcEMOLYVrRER8yjTYpg0rkChHytqclZUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aojyshXktIhBLzR6Q/R/KKR09nDQ82BUPUJcuZwXTDQ=;
 b=h1AFYWMz58e6xcrS7eNsKGaYRI8qQYiS2HE7EmQV8KxiKnz6Zf5cE3WwcEtDHO681w2Vc4Th62zEPuvHmaDuK3KCjd3yUpLN2q7noNi/QyRdWdXxgA0l3rQ8vgt4EBnYVQqjSBKNGcn7nI92JLJoSm0ZTe9PO9l3CJBrOKJr096rM2iXUD0pd0ObIGdBsWIqa78wwymyEl8l7Na9K2zsuAaWlJliV9XaycBx5M2z9do6N8l0ENNCUPm2JvtSKfm3XzYM21DWpD4x54KIKiWRsY2WwOSeYoeSMo+Qcw4YD/5riwYJyCqN/0CxWpL03QsBEFucDAnubQXhQ8CEIxFNhQ==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:27 +0000
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
Subject: [PATCH net-next v1 0/6] ethtool HW timestamping statistics
Date: Tue,  2 Apr 2024 13:52:00 -0700
Message-ID: <20240402205223.137565-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	KvhEAU0IOq8w1Ic5lu3rybRgMryKwBj3C2DVcHPZoSCZnnuU7DL1X8R1QwXcGnazcb8m5GV/KXSJeAjdIxAixX5ayFTja95GaIzXJ+PbOvZP7J+0tsQeN06N/yD18WpaVBVrqK/08aQ5Mr2+ImhMbjYqWuSzXZ7IAZ5nKKH02yTBz3Vr/g4hJq6zDh4FyDg4wKDRm868ASCgjujj/0yvMnMeOyX16YUtu5q2EcswXXf1VqAg/feMoG4xu+KJWCdmYzJn2I2kFbCFGLv64/vMLMbWahCv4+sQ11XSg7sW84AgoUecZzE8jGoR0ikR1rxlNPDVVvZwrmsWtotTlFWVTXzXXjNLjaiH8T22wa7Vx3HkV5Zk8E3DX8bm1tFnq2ogjG80ZWNo0xT51rERSJov3WH7lyrfbs3GI8WynokIq+PmVqfuHl0yGei9uLwWkpC4HT3BPiVvw3wF/G9D/ak+0vXbiXfvcGZSweoeWiAXny0SnWGUSCOrAinlm/nRua5pVGreH4Xx+PhREtokxz9RcjIqpGQd2hn0dFirsOPGYZqgyVWMANUF0cWGk6uOvDHlrYlOuB+32Pw2O6df/CrwxszUQTS/iE+BgajoNVvW4GjwI/UAgViWaMdTr34DeyqjJQOwyC0vdpj8gWbG5MFsLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/gZrLMrWQKXhh5RffWATGWrJhoTZ6ffzkFbBTQ04YhLntxm+2lhluVD5Fy0?=
 =?us-ascii?Q?8VYj9pXEuAlwfooB9XL8FYmDYP4gkpXE+MMLPICqrj8uXVwZfZxh6KwzhDVp?=
 =?us-ascii?Q?+eGfdTp4WfcbUNLTJmNMpUltl9Y2mM4P3BmRsPbuLVTwHs/65fGIRNRkA21G?=
 =?us-ascii?Q?3EK6gGL4Nz2hf24mGdCpvda2eEPJ5tOJakFT0/W/IJRExwKrp9huM0iRGAET?=
 =?us-ascii?Q?bKFTC162qs2EmyfZim4kdQyhmkvuFYV8cZG0UoAZeexyAAs9Zl4KuLCsqFp/?=
 =?us-ascii?Q?0ZR1wwXmZ3EUwYuJ3TblkF7PgWFtnSV6lDmhKqXI9qnN/I5iWzZgrxvhk7Q1?=
 =?us-ascii?Q?zunxfXumF4ZLxL6jYTKlFZB+LMEsU7iMZDUmz4T1zm7JT7MFHfLGsytIpueb?=
 =?us-ascii?Q?YreUU/23CZvKSznBILwmu7aRdkIzAsIgcsJJr/ybbt9yR4ZtaUPhIdwcJnEx?=
 =?us-ascii?Q?n48I0LzxMr3VFBXkozAKywnDHGuDsNpXxSUbJ9/mY//YHoOIEiQ5sOrsT1CW?=
 =?us-ascii?Q?eFy3Utv9XdPceMFcM4zh+OJeJr75nTvXJRqgXrKcP+pwRn0MgqUheRDeAjof?=
 =?us-ascii?Q?p4uy7Ub2PaYlrtAT1TYXQNQSFrTQMyMTNMngmPCwrhUAC7MjmIU2vL/aKiMo?=
 =?us-ascii?Q?VZKjbXhT6wnKtiLNpOwSSnu0ySJu1o6ArFdufTWpr0ePVPZf2D/+0iAqux7T?=
 =?us-ascii?Q?L2whOjc9TzewZN7c4Flfw69aCS64VrsE8iH/xnqXXXjloyFa2OP28d/xci24?=
 =?us-ascii?Q?cH5BD2VVrlcRpLEba+1o82pVba8ALHpuYkMRSUKQaFxcQza1ymgvaLGIuW9U?=
 =?us-ascii?Q?rCVufmO1kdh53DQGzu57+WNT0fZn2mpON4kZUIDFgFhCslHoq9Ug3m8zTFgz?=
 =?us-ascii?Q?v3y74L4kCAwNxxAUhSZP7JQxl460YVaa7djF1TLxBwHGhflEAuV0pkE/h/RE?=
 =?us-ascii?Q?Af9jcwFwERFGiRjS+xkmtQ+9mR60s7aAbUDb0T59V7KSMYWF0Ulo51j8ewWP?=
 =?us-ascii?Q?7n5oxxz038iEazwF+/33IOQ9Fj+F29nTvIYf3RYb6c6+tEuj0EZ43LRVxv8k?=
 =?us-ascii?Q?Wp7Sznvg+LRrBjeYn8W+qIKG8n6QWGZrDL5i7ypXEVV3ksObxMTecKz28H1u?=
 =?us-ascii?Q?40ow5yhNPgSTL34cuOmmireiVxAJpAC6VUfgglxDsNBCeBDpyBvFItoU7JAa?=
 =?us-ascii?Q?jVeJwijPajbtmIoQdR0m3aLulkEcGwCj0lJR1oJ0DlbyvV6VhNqHpwFStRqC?=
 =?us-ascii?Q?y3vp+GA83sE4lMuikBP6gvnA6EEAihHQr5jyJ67OPENHLyizDYQtlWKYVRCB?=
 =?us-ascii?Q?d0ZI2tJfnNogx+2/CYRsnSxeBVy8+vvZVtgFO9QFwNJQOuSDYu8pgFvDPAbO?=
 =?us-ascii?Q?a2v4+M4TbJp1hOh3UAlPcI9GRFfnmmlXOfn8pJnt/4ZTWsUoZXGevSqssdtW?=
 =?us-ascii?Q?u9LADyT2jYY9kvmphtCguiweqqwlpO12p1RGIh+91ZVoqyeTk37T267YKzYY?=
 =?us-ascii?Q?77XPvrIsogkCPeznn+aELeUBq76q1Mvh1SKYzW55Qmss7YbT0N7HmrnPeQ6T?=
 =?us-ascii?Q?XtlLV6q0PiVWp5E1MUE667WVgA0fpzurIA0yxZZjzpv8tTW8DP/5t+PtOclh?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fcb85e-dd37-45bd-9da8-08dc5356ce00
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:26.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au55vSoE1bddlkEuB+DfgVOcVA23lXNQEVgZQbCtBfioD8hrzm0HI5VmVaEL+fThx3gcTgFG7h4vcapAQmXcqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

The goal of this patch series is to introduce a common set of ethtool statistics
for hardware timestamping that a driver implementer can hook into. The
statistics counters added are based on what I believe are common
patterns/behaviors found across various hardware timestamping implementations
seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
this patch series. Other vendors are more than welcome to chim in on this
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
 include/linux/ethtool.h                       | 28 +++++++++-
 include/uapi/linux/ethtool_netlink.h          | 25 ++++++---
 net/ethtool/tsinfo.c                          | 52 ++++++++++++++++++-
 tools/net/ynl/ethtool.py                      | 11 +++-
 12 files changed, 215 insertions(+), 11 deletions(-)

-- 
2.42.0


