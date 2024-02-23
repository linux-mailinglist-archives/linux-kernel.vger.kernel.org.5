Return-Path: <linux-kernel+bounces-79028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F29861C87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275981F24A78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E7146E81;
	Fri, 23 Feb 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZaKutPU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4201493A4;
	Fri, 23 Feb 2024 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716491; cv=fail; b=Hh0NzxW5F5z8tPKCEN851o4dBv4gfo+3pNjcAvY8vVHloOI45k6ClKnYWZ5WWT04c9Kojko8nx3JPurFAzhtZKqxrNhl4IFmgFntAs7dNFFEnAEhDEmozgKHnZQuzXhM4RBLrr3kNauJI9CPCIBMmpuBSspUncrqONNhZdkNkio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716491; c=relaxed/simple;
	bh=FdKtC2xeLuvnFo1OAMsfhSvhgOj1atR0mwxgyBqVKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLzCWwEWETcOx20JHNEzvXbXj4S9sSk4Igxe7uE83zbLhvXJXWzbBDty3NaqvQfBHJdrVaaJ9DFbeCWrNmsocjEeyUEqOHpHNtOhZg/ZlhCw/WyN4KNjlu8Cr2di5BVcCfBUMHiasxmh3v/7jN81h0d/Bh834nNO/tmk0/ejx94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZaKutPU; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azo2ZUTbiHabM2YVpAxIfEBmIp/KXQhABcvCrqcOW2RGptfzYClvrwqbjAeYKJWLG46S8te4teIT2MZ0gMlRYgKYTvB0ftJl43zxERMxt+EMXJCLgyaNnIhP1EG3kYQVi6HZyQhWTfub685MI3e8rqgMETeGGWcH0Tk+0wbIBsCEqm01xZg7DVSM+mCPZOKFMMNVwpYAjcrbuE199TWrRBBZqa7Lb1XJqBbeDZ3kTolfaak5G4ytqMMXoGVfaSkBzBIWOKh8xuYMtrYWLYergI17M/rVr4xbXRxM3hrJWbe+2pE9aXgdSCAPEV0Td+2fHxeC8KCAfu7LDwaqZsizug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H19rLmz575sVJWqGExnyBhaIQJlHq4JmgjnCV36zkNE=;
 b=ijNu/HtLjnvkhEgjt9QjDJNkSj/LBQ7gQvQboK9Mlf2XkA7EzpED6w/QcWDUR3P3dGOsIuWLgKI4olEIIl1gxKyOIuNkdMWUve+eHMrmDodt06kuod+QDqxjcH14lYem52syiyIdAIuNkdBi7WzPT7V/VXtZAoC3yckqy10t82amdp6JE2GYxgoQHiTN+Iu3jftn4Yxt/BmnRqvyg5f1aYoOfV/CyR000xIWcJ1wwJ72/a7wwhV4x/3X8KthxtRu2ZthdNXCdHSXT6S1fZTfFJIPy9IuBbdcNTyXi587OeQreBSl4UpenygGWatPRCyMl/ych1HK7C0rKRPhV5gUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19rLmz575sVJWqGExnyBhaIQJlHq4JmgjnCV36zkNE=;
 b=cZaKutPUFgYs66V8Rb8B+zqzuR+O9JTrLnpq4H85Z8cNGhoT8yco2FjJW6fd9pFb72HZfeWtl6QYuMhcvjzrUAYauOsvrzSP0rxk/wGrgEiC+7C3yj3UqQWsmygzrooZT5F+tJ//GrUNwnzYDL+jnPi18RO82IzAMsuH0pU9YiL28GeorwLB+3DOHQfgXLec/foJTsTdXLWY9FINIL7K9rpleJdTeP25nZqbiTq4cyonXkERkJQLEjL4iMiuWZknoXS3c19rul7Z7PKYgD/s3aDjMdtThKOhbGZui1zK/I4L0soNvCYglzSYVM6k+TYeAK0uv2eqMIxU/IX1qMQvfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 19:27:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:24 +0000
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
Subject: [PATCH RFC net-next v1 6/6] tools: ynl: ethtool.py: Add ts ethtool statistics group
Date: Fri, 23 Feb 2024 11:24:50 -0800
Message-ID: <20240223192658.45893-7-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cec468d-018d-46d7-5999-08dc34a5764f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TIDLJKvqEXeAPuyPbHYEtO38CASajNdQaVGpYIJ38H6MokuoTcmkBZfx8tE988dxRsnl/2A0wq7odyLDNjcWLIs7gfOJoXDTHOy4LK8yMveW/K/uuWMMnxqDUv1F7RRMd7DNNcaG9rQWzcckEUYlxNUQK3k4SAgYvw+ZGe+c+87OichhPknH23dM4ij67VamYrf2cugIdpmZ/RkvQAjMT2SpPCqlbRqmtEUQ40JR9Bd4TPotnZSxHb7UNpFpOTHtuNGER0Y0eE2ZLvDq94EaLBu2lrp4KZ06bnx/y/WAejMsVFXNryQAactlRdkijZg8n5gO1EWSAWzQ/5qWE5105FjWZ0OeG87IMUmLsbaSDAmTOvS3Ytk7rRY07B9n2PTocZkSBHGy+MyiSTxgQg+w8NumPXt0UyXEg/MTH/ogPiktkPEPAVpL+6UypxePPdORy77nK2puBwZhbOdHwk7Ic2tfOdkaTsaI5j3/le+H6ZDDPPUjtdPG39RsMkeo6f8WIHXo500SjaSBNE5dL/pDQXIDvRxRDUfEbMymdlCNwwhnlxR5JwI5Way6mONqmcN6WlmsWm3rV9gXDmdqBrVm9YH60LbaERRv7FfEUlgGxuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C4oPmNDvhgM1PMC8iy+jjVRmt2lcUyGIorx3stcvgk5VVq1YhRya7xiMws7L?=
 =?us-ascii?Q?Cq4EqNPpsdxy2Rr46Afa/puJy/nGI44uc+BzspulWZBFJW74IC35HBHhJiWq?=
 =?us-ascii?Q?G5kuX95EVrIA+1vdutBLvXt9WPcc6ZbsrJpJOpzpkXpQDnj/SIQHor2Y10Tt?=
 =?us-ascii?Q?DEG9TR7DJehF8lYNOsl5qoo1NGVmb/MwFTlqN8fPq0o8404lDq4LAj5Q1r+N?=
 =?us-ascii?Q?kUm1G00sG0JCrrLSTJdQdolnzmS4ttXgWPpiLpUlszheHkGF9HH70Ceg/lXc?=
 =?us-ascii?Q?aI9z460ZMrXqqdUjCBxmYkQE27QNFbNAGs5HS/D5wvy9j4mSHaIdgVgCKRBU?=
 =?us-ascii?Q?Ev9yL1H+zSux0P+stvc8F5KmNZ60kpFXgxlBXmljh7Qn2l1JShAAOudX7qzw?=
 =?us-ascii?Q?UeelFcbvyGyGKFGWp2JJ61MglXxyyK7Rbu5W8RwNaoOK5LO9vy+QG7Psuw7i?=
 =?us-ascii?Q?Mr8IqoRhS/it0XYWRwhLJVX+c1PUM19VW0Y+Td7qHmzIuqpKSUBtzyEkxE/T?=
 =?us-ascii?Q?VaeJ8zaINmZS/AEWyrSUH0O4XxuKhTi8ydYpLXuKlb+jfvn2tEjPILCb/i6o?=
 =?us-ascii?Q?7s4yXXkTMx1sz11f38SjIGVh+iqpta+LBDID1LuG2pJQpE64tg+onx+dfm8y?=
 =?us-ascii?Q?A4/TonEAANXQVU5FUUfYLZse6CGYlJZel+ZvhvFbRj81ALgYFrGIL1OjqrKV?=
 =?us-ascii?Q?gAkk2JLTBHTPpCTf7oP6rtxSpg7YtJq7Nr1R5cRPeaRoNuXQ2L+GhXqA3vTQ?=
 =?us-ascii?Q?sN37sQSSdQPQHD0NstFH9YymnaXVkwsYqrxknffjDJY953IC4MG3YYfgmi27?=
 =?us-ascii?Q?q39BxU8tclSI73eRQvofIHZtugSUOZouCDDxpj+RBMG5wdAa+p3Zzz70yerZ?=
 =?us-ascii?Q?A/cnpJlsuV/FVrREKsOjVYsB0Dseu0pMyND0uOZBu8z/KnCzVqRkkThkDN4Q?=
 =?us-ascii?Q?yUiLTZ6YZ9QUCTDLv45jrBFg+rhKQGOnJOVlXgIbXwpLW2SCL28Hh8ebhukT?=
 =?us-ascii?Q?t1K7fgaqNwBp/qfjyLbjRcpNF/yP2Gk6vHvGbl2Jf62cUh1iqgNTyrtJc0Ms?=
 =?us-ascii?Q?dCfkMqYUy4h0dkuHJ/U2LvI6e4ahNyMt+3hloUDaYRn08nBVIm4oCZXvs2Cd?=
 =?us-ascii?Q?VLlyJQUWEgBXtQhgmUZOriVkmLtz9EfzU0/2KOylKX+OmXRURr7ADNI/ci6P?=
 =?us-ascii?Q?Z4OH5CEZKj65mcfdgyt7Tay6UjYE8yHI9BF1n2Eq872kKNjsQwfBrEOitGbh?=
 =?us-ascii?Q?1+n13Lj72ZxH0u2t+y7C7ap8y4twxt0eULh1Lgv06kPWhy6ImobMyfEQyCBT?=
 =?us-ascii?Q?OIMIyGoj1yqDzrjCNWeFpRuNT4+8ecv37OsXUCANByTorixKK9W/rT1D5Fam?=
 =?us-ascii?Q?atSYOhAvzBcbLsYQdSShGTJ/HpHGkfZFT/4+HKNdfJfdbAZgCj8OgZJHSm5x?=
 =?us-ascii?Q?owe3MmEgHUUKuxU8iDl8ZJFSi41JFXGY89wQrxNPDmvvBKRG5KT4DaopojsT?=
 =?us-ascii?Q?cTv+64bIHuMC7qEQJl6JqiM3KQEyXOW3G6aY1EyZLdEPiDBzzY6WtS95usx4?=
 =?us-ascii?Q?Y4NZwX9JcrIiKOngc9s/F9gSfFlxJ7/oSwbzxxNI8syDv4tL1tqNYZ4PP0TL?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec468d-018d-46d7-5999-08dc34a5764f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:24.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/HQcqMp5rvL3ZoHl9KZnDX/ooZxiK0FHN/cUk2AYoNnyqSOedoto1BpL72x3DUkHhKIaKsbHkxOS8qpk9Wt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

Add placeholder for hardware timestamping statistics group for testing
stats-get ethtool netlink family operation.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 tools/net/ynl/ethtool.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 44ba3ba58ed9..d3bf3690d3a5 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -314,6 +314,7 @@ def main():
                   { 'name': 'eth-mac', 'value': True },
                   #{ 'name': 'eth-ctrl', 'value': True },
                   #{ 'name': 'rmon', 'value': True },
+                  #{ 'name': 'ts', 'value': True },
                 #],
             },
           },
-- 
2.42.0


