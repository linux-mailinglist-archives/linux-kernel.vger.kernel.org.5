Return-Path: <linux-kernel+bounces-79023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1D861C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F121C23628
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0114601C;
	Fri, 23 Feb 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TRQwUfLL"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BE179A8;
	Fri, 23 Feb 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716445; cv=fail; b=YSVxlogg9PBBYfSLSpFKaK9jDILE4ij5HN0iFqmQLYQC0cj3Syfy6LI64tq6Gl4R03dwJl7GGJcZcjORzVP1pj2r3FGO+H0E96O/VqFffjku1B1llYlY3bmYXLUPQEOYvtRoypTDcfnXJPK1yDIdS2prnW08AwgrSi9oVyQFkw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716445; c=relaxed/simple;
	bh=8W589ri+hg4bSEhsGN1GWaMawF0HzHN+vcIADygJG4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FurAfAleOvM9AWQEsq7Oq0cUZaWYSdU+k2OkFyVCoUT+LN21363RqDsGa5vB7mPNivKsyiXR3IDtLtPCx69rM/0qdprzSiOmXqD9Wm/79rN0/pFs4qjw9X7OP64ENrlMO6wrl/TZuQdAilXFo251qYS+zk6LulhP8mfsbI72Jr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRQwUfLL; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+DfZq3AoLYhIpdgNMUABMOFpVZWemuUoizblm7iBWbX7pRhVW/Hslufo+uM9ju3nscEglDK/9yRUn5tLLTRnzjUwQnKga3RvVnFwbUkDOJRsg7PZ+iTt8etTSW1ibMW6SAUPEMVor7vTTQa+1bF+u1qAmP1D9u9dnV1YKynUV7S5cw/oVaF8QKYfOSJ49AAlJuU+YuBHOv1elo3G0B9sPg0nD2QatQBSUFQeGj63Nn2pLn4dYfZxFGdtmZDFLLsMAh76s1CS6iY/8COEbXTCgaQwNUj7bsGqpbSqhb9mpgym15YRCj4q4NYpC3imsrjFfyAOrJnCwkEPWQBI+ogAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mouP0gvIb4s+6MbwsNs5eNh76gKqMtlZGkqIh5E0dW4=;
 b=ArB9FQRg2QDf9CLo5j1g5dKjxhEqaEOicfM+ajHiCe6qDaXaC/aUGJGlTDIHOsk9W67onpmZLUhiWB9EDbLfK28spxMtb7uXt7lulVgN0Z87XzEIOGYuPHbVqJHS3o2OL4/8KdDpZrCcCfBZQgw1AdCmUXIZQpWvr192goercu3h0XpybMKST81N/3x96hHt+8Veyfrf/duxpt6+GfkIzuy0E5pIsLT/9amcuy0dmg6Qc3aR5WlUO/ZxMbrXpS2BhsJT+yFMn/fYPKrxIrRxv5CX/+t6iXIGXiKMM8kZXJUMVgGgeBgkBbPsH4ss0duFdfc+PjfvPfKldIO9uiYQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mouP0gvIb4s+6MbwsNs5eNh76gKqMtlZGkqIh5E0dW4=;
 b=TRQwUfLL1fxDWgI/P0y6M6XA/uCZwuhPnULkVD5DfxHYbIXOdMjc8sbWD5W0I7SAYeZrxXHMcMKD+GpKhGc8VZ3UoDrUk4orfikez5seRmBFgUNPjb0odkFeguIcHXua2HXSWE2RX9U999qmaxtkhGRsYhd19QcP1OuCrVwvv14NhW9dehDnEKRGuG8aBNnM47IQatrmBoAL8tpSJ6CQvH4FwHaHOEiQpewu+998UZa+6kx8P55HFwLg//6/aVx1XhlmebVIqZkQ0w0wg+W6gJDdOwudJ0G+lg4rgT7WJnF8AS153QIgFk0fKQq4C5A7IAjYRWybkyx1RyHwxVXCRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 19:27:16 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:16 +0000
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
Subject: [PATCH RFC net-next v1 0/6] ethtool HW timestamping statistics
Date: Fri, 23 Feb 2024 11:24:44 -0800
Message-ID: <20240223192658.45893-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 254eabe1-6fd9-474c-065e-08dc34a571e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ulbHuysk3E5TzVgqF9U8y0FxCzFQEawfWl3JiwEIGvhmr0FwrLbIlcka/I4Ae67wjoURnRBX5yRJih4KPRIDuuQFuH659oxFZg4H3ar7D3Sfj5ermBtyD5uBdrQyxwMoegw15PC32qLskvB7nA8hGz7l+nCMBMhyO2MEFtJ7OzVNXMIjrku0w9HU2eDzIBVbHJ5r7Tlqz1SLPY4107vx+XBQDeWuAsRb5C9J0m96XiIcTu+iuQ2gMRbdgx3JBfVpT4c/5GOTvmInQ6TDs4X3tbOxZbZ/CySmg7MfkeWIR4q6/LsWs/bWN9R7r7DBbMPJVW3RCUO3c7Ry/apThrHhIFFoBKLUd0wYDJ7qGXXRQby+4jr3JpdPseYbFBvv4jSP+2SnCuqXZcTsGrFgZ3Zapl29wHTYzibwv7hsHvZsRXBLqUbuyxyqVJr31xT28P1BxWJa0Itz/P8kFb3Pt1qvAlvs2eBBAd26/qBdfLBxT8QMJky5zPGiAf8VhY+huaq/H14a46/rBvPiX2ButahQ678NLF9L5DJqSjtdTrJhmM11A4Xxoccka0ZaeqjUBYJlQBZnQeIPbcMlleH2Ql4g52hJD1DSwLLaejtk/V3Fmw5gqCzYLG44jHmocvIkuVSC9D4pYbqhCeTuNEK3cofwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iN5tfHKmMuwsY2ShOo/4oDSyqbQ7vOefQFoy+YEOGv+zd4F5jpREyr6Ql40i?=
 =?us-ascii?Q?k37q5aQUpCuBs5HAgaONPktJUVieBnizSbYVqAXz27UUMsZkd7rSroWbLPxq?=
 =?us-ascii?Q?vQ2gPeq3w3x9avFHInXrhhNQM7fZAZWVHfal7s861Zofc8BagM0k1kyipVf4?=
 =?us-ascii?Q?H3ukmsOH0A5Im1jCFCMsi3ASFNfKOqbnE/r+rGDxv337nrCqklIIFqNZGu0n?=
 =?us-ascii?Q?PJWOPI6WG1rI5qdXL9K3/71bCct5kIPy87KAp+iMLE5p8pxNFX9hgsf2XkUQ?=
 =?us-ascii?Q?8sSoSIiT055IYkeJuu+SoFhsPWNpkHGHaOfI1c6sYciFikYc5QZo9iMNc9bK?=
 =?us-ascii?Q?IItge+7s51S4UYMAsyLxf+XSVa79BRZCvx2uve90xwQU3EHjJhj+wJHSJt+C?=
 =?us-ascii?Q?J2uRkq85By72M8sRSEhUUjU/ELM0TnTOVvTSPUv19/4XUERl7rOIHnsbupm+?=
 =?us-ascii?Q?ZKSX+y0V1ZOCdF1XSGAZ7Au/IyzSDHZPP+QCz/9ZGeAMzS8fl66xK+VwhVv9?=
 =?us-ascii?Q?UrGISNi8kYO/VJEoCb+dvv2AmZlYYM6ZS5a459fVZx5X+q2zy4FK22s2XLG8?=
 =?us-ascii?Q?vMJKmglUvv9OFbakLays/tgVUBro4WUTmlrD9CKhIZS5WSXwsWUwhnPGfYG8?=
 =?us-ascii?Q?NGYxNOsttsdQheFliBSoIsVnpjfyEh8vg46rYkeXl3lDYdCujzOTAOslZfl0?=
 =?us-ascii?Q?PPmsrDQmC8v+suKlWKQGEo5f9UgyK7cgCx4Q4QL9qV9/PCsU7iyMFIGYCgWp?=
 =?us-ascii?Q?2SaYntlwzOZoXqhi/hKmIHolkkEv0S1++dkYeA6yHs5xfFj3DZJbS43IbOMQ?=
 =?us-ascii?Q?OYyjqlzVRiD4+71FZ6LusP2rJ0AY9OXsqQc9dXIi0gVdhbU2SUIzxDbu3iRC?=
 =?us-ascii?Q?N1IgeNSo0/4TetWD0ycjl3CWN4C1O8e8QNGyOL/Hb7n1ousKJcTmy7DGfrjO?=
 =?us-ascii?Q?2UZHR7RHsv1qb0OZI7w+jciMFDDl2q4zRed7FY6LoMqEjo3S4rd2FXI5n3a5?=
 =?us-ascii?Q?7ynEjl4ahfpQRsCh576ot3IgcJJNF53I/aJ3O/GftojjZYpFI/hTSRMch8Qx?=
 =?us-ascii?Q?C7yws5HWJatCwssJVLWCS6JJfaYzMZC+69Ilenw+iHe/Sru7v1+V1EwmSkc0?=
 =?us-ascii?Q?8M/T49orge8gIvifhfP1Xoo4n7/4Zh8B0MtCxiTRKQ9DNZcYERfWoGPs9/lS?=
 =?us-ascii?Q?IN0smfz5kTb7R95pRGbaj4R6zVQT/XFwhRRv5dFOJRBoqiZWUgz6wzotEGZ1?=
 =?us-ascii?Q?zhjzsBvaCimBuMGusqp9BGf9pqLXdh4qG9LJCuoUv2qPdRr9kpaeN2rnSUjO?=
 =?us-ascii?Q?IT6T2vxNJZT0QGJgBh3UQXAK2J2SPlTnqxwA2pE1G55Oe4NJ7BEvl1TkIreW?=
 =?us-ascii?Q?8OQhw6c6HkNpT1DgRLmYtdGdJtoEb9rKWzDryiyIQ7Am3vDety9KqG0qGfmS?=
 =?us-ascii?Q?sf0GbTgvkXDrFKExWYYwxP5aPYFCQ19PBI7kXPLNiEWWgYx7xY7x/jY44w9L?=
 =?us-ascii?Q?D2loXdGcJKO3TXtO9eyEj1CyfXCdfNRWmmN4WLwcePcIV8X5LD+bqyk4HVCK?=
 =?us-ascii?Q?ewKwOJtRjXe6NbPdhAHibRkwyz95E2lyLjDAqo5YB4aj5QqdtsyEu6Yqb7WI?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254eabe1-6fd9-474c-065e-08dc34a571e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:16.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+oftdCWq11IlHkFIBPhNtiN+n/mfCcZPPZLS5aFBKMq6MEbk3Jjv4VqHgS5OYMu2E4smiKG6l23GODezTnJrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

The goal of this patch series is to introduce a common set of ethtool statistics
for hardware timestamping that a driver implementer can hook into. The
statistics counters added are based on what I believe are common
patterns/behaviors found across various hardware timestamping implementations
seen in the kernel tree today. The mlx5 family of devices is used as the PoC for
this patch series. Other vendors are more than welcome to chim in on this
series.

Statistics can be queried from either the DMA or PHY layers. I think this
concept of layer-based statistics selection and the general timestamping layer
selection work Kory Maincent is working on can be converged together [1].

[1] https://lore.kernel.org/netdev/20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com/

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
Rahul Rameshbabu (6):
  ethtool: add interface to read Tx hardware timestamping statistics
  net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port
    timestamping CQ
  net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
  net/mlx5e: Implement ethtool hardware timestamping statistics
  tools: ynl: ethtool.py: Make tool invokable from any CWD
  tools: ynl: ethtool.py: Add ts ethtool statistics group

 .../ethernet/mellanox/mlx5/counters.rst       | 11 +++
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  9 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 71 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  6 +-
 include/linux/ethtool.h                       | 28 ++++++++
 include/uapi/linux/ethtool.h                  | 20 ++++++
 include/uapi/linux/ethtool_netlink.h          | 17 +++++
 net/ethtool/netlink.h                         |  3 +-
 net/ethtool/stats.c                           | 53 ++++++++++++--
 net/ethtool/strset.c                          |  5 ++
 tools/net/ynl/ethtool.py                      |  9 ++-
 13 files changed, 227 insertions(+), 10 deletions(-)

-- 
2.42.0


