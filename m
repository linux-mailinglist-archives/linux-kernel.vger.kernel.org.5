Return-Path: <linux-kernel+bounces-130633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B75897AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D53828A4E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC9157A7A;
	Wed,  3 Apr 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RW7mPEVs"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B6156881;
	Wed,  3 Apr 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179797; cv=fail; b=MaQLiYFAOEDmEGKr+2sxuYlMLUhLgQ61R5fRQny50DnRXoVEIp6Bo+JSCebq18U1WA5T3iw9gvPoBlFYCqARHYOyIzJQGuR0pqDynt5YjE6xWLt/I5tVCk6aID9y0Dof4YoJz9ZIVgZlmToBc5B5Mf8+ZKnAlQZDkzaNY0uRJ/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179797; c=relaxed/simple;
	bh=dN7L214BHKIN2vsw9rUU5smGx6bsG0dlxyQaFVdsgpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VN2/UxiFFkofqbDKZvZ5sTw8mYiGb3m0GFsrTEE8PmHRPMtSAfmMw8pJYKTlIaCy/INmYKh2Eh/KMn4udVSVEz0Htu92TUO7kx8buwlSYOyH+wsy7yT5JlN4tpjzfO72Uf+N57TwyUOXTOVbtp5txFVglXFfMxHyWF8vb5xfqO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RW7mPEVs; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWyvJTLt8r/WeaH2dd3p6mMBQR+IBv6ypUjaYFoRH4TQbDuW3bwPjezz9Ct2EhlJ9c8ihd4pUEpOUaX6vCmD7DNAvmBVtNX7hkNnYtc67DLyqwORJ4KYmf++TaHDAbfVOzKeXiSuQAFPk/K/3ieKDLnwu7Au3u7H8Dpw6XlIGIIDneRnunwwdNDY3rpthVCH//uqEvWYr/Lmfm7iQCOQF1uurSAuvFgpDdUImU3EtgzpHQVt2QUJfIbM/es9gGpWKqgDQqi76xbDt6Jys9+hUGL3zQSHZeOMrSF1GbvZfn0Uab1i2MBPJS77sGRTj1+KEekIZZEYu0W0lPGJpomTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbQRyhr40BMu2hpzbzg904a3AKx8411K4Ou5gTxN+aU=;
 b=WdUT5y1rX7KbFe2sK6MC5hdDZVmLH9VuIKfm69bKnS+2QdllslGlJkNK8RjIWlbYJslMDdFIz68A5NLLZVgIgMa1TAX+uCV86+/pw5H4ulnI/gJexogzPEYit2taov7sTeTVH4Q7s5SkbtWRWqGKe5esRHTSvr8/705h4xth0nnGYqj0pCsF2PR0v8FDntRWPuAvht80kSlprSjajrg3O1zLZTOtOwP+1xPdDXrlK4cDJfDhwbqkKUJfgRmUCF0B9pjih0s1+vG+89vfBnksYolaZXmkbAgfwoKogpwvp60H6AYQQyeHY3BcmySJl62UojBDLzujRiRj4J4oLIl6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbQRyhr40BMu2hpzbzg904a3AKx8411K4Ou5gTxN+aU=;
 b=RW7mPEVs3G+6Z3Sdtj1anqOx5E4A0QiG2382f5mpSuW9lR+5xPAXVSetLBIcBUBfjqAz3U4NtAWr1+d0joMCmNfxqWa6p43gYDAQ3g5ZM+3lJASKCmELL6Zo3GrskBopwTnqv36SH8xrcxyVfST02BGrnOulXhfSxiFVXWEZS3NnjpBom11OZUqhM+7rl5baeH8N1jIUYuvOBH8huN4h3nOhhVJ0RsvPlLpAoGbgL06QW38A3vwKZvI3LjJLdANcGQ0N23Vv+/NMumAl4fJSpNVRGy4pOVNZb2IipujDA4VUF8x4zVNsf2BDwv3h6s8+DEwIFodff51wr4rIOeceZg==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:47 +0000
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
Subject: [PATCH RFC v2 5/6] tools: ynl: ethtool.py: Make tool invokable from any CWD
Date: Wed,  3 Apr 2024 14:28:44 -0700
Message-ID: <20240403212931.128541-7-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	zdT7vgOP9tXO2s2SE3Do6CMut4nSBVO0X4QtyHZIUFBfoeMZ0LS0yQYRYrADn1LtaoVjnFqX9R7hEJpsfdBez2Y/bKO9rygnFEVqJu4bQFcxGRFUMIU2/8cCEqv7atvJIlVZdi1P4l34D+98/vNX5KGOeoVcei7lcYz54p3QS16s0DPYqmDKunZSsVMlweP4tF5Nuo0hc42if0T8uByd5/aQmsFKDPSLC9Qx1ljMWekXBzcpNPiNFdXssxeJNCgIDeW7tzjt2JLwrCwyHkikm1CmedKFNuWR+CRz+0rODHXsvBdJnawLfACfmXhHToAB6vZnBxl66KHGah5MzMyO0ZHBSfUptSR0aOX9eohIO19wZl46v7tOT208GLjQcN6SH4cOMDR3/eCm3btneIK4YeFLYynCRT/1ZNGrA+NS6oGxsNCxYoeXd4/C5A3lqdiJOKR9wK6Rf5Fd/Tt+KsAbchvqT41gUuppyd/kXIq4Db6tTn/r7mASS/qkv8h4fbtWKCAsSZLwc5rVyaqXzkgeTdiGt0O36D7U9TKg4DUG3OT1vtTu0IYycXPSmKixKTIjQWB2WhwZbokKWPjbh5NTS97r+vrUIJGbBTW4fUkXAwlFEJLrK5RMwpG9vPQZblBt5BAUBqWD4eKLP9rKvO0q93Uz5TMi8jmQW46OBzKS9GA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oOPUOGY9gdjdR6oYQnrWBveYAG6BqghQEqtOQsOUMWR9GPyaXjSp0QxK4BgG?=
 =?us-ascii?Q?0yQjdJ08KDbXL98Z/5rt9LIpNh8ra+U7IAwwtdroh/gh5s/DDI6k9DhGBlEK?=
 =?us-ascii?Q?r1v8T2RWE4UjsUczkzzLrU99tcDAqyqFCMI9w39KtYfWMwVd+42O9xPp0CuG?=
 =?us-ascii?Q?Ta4o0XpEIkKbRCvRN3rUiSOcb/uja2dvzqzn+UHFAcVLk1dPg/mPSEzQc6me?=
 =?us-ascii?Q?1jSn9y2EVvzqplNezLjZksx+HMAS0nsTCQzwMXu/ljfSiAweKTRHvXV/vaJw?=
 =?us-ascii?Q?3pgRg0kpmj6757UFts8xR8dLlIZ01yYemhuKIcNepj+zMJP0G7rGODkGSVGt?=
 =?us-ascii?Q?zYY4MXqLzAa4WUH80BcylMn7vbBO0tEsabV61G5YP5myn6SJ7qOxnn4LNJqb?=
 =?us-ascii?Q?v+cU8Cvf9rkHd1vAeVUbDpuEEl27PmHIwmXpXgnkB1aYYXvCzqAj7N2XYbEE?=
 =?us-ascii?Q?gxeNpeNjo7ivX8Fn7KBT75wT2rADkcovsVJqyJZk0nHyCcI86pMK8OSumMYR?=
 =?us-ascii?Q?hY8pZU7GcT7y1Sku1qawl3mD754IiJf4D9cWKI8NZOB2+HY7/OoxVy2vP8hf?=
 =?us-ascii?Q?VOHJd4DmD8Q/mKBrhmk80sQiBUYO/BWgqGZtX6M4MxwQkXmzQ+sbQWKjOBab?=
 =?us-ascii?Q?tio8xRfqBHQ1U75HiNEBFknpn2Bas2xCrpVJzFbbLK01V4Do4HmeWTZnoG6r?=
 =?us-ascii?Q?pfgsf9ri/BNDloVgCzX3Vce6qMRi8YKo96IzGJpq63T8+rzHXh5TvSAjpATL?=
 =?us-ascii?Q?acZm6FTGM5EEr0Ci+pguWBOmJxoACMaGNvLh/4PZxj3Oaf9dVl1p8+NUZJvG?=
 =?us-ascii?Q?gZQ++RNu8JV3yxENgGq0F5agKd2pqlVsiE8LeNvpI6KYc227jTJrABmC+5RK?=
 =?us-ascii?Q?mUSDDq+cQc5VQeJgWfcIDRNPIpeNHdepZjXp6kJHotqqo3KB9iQIjA8Rs9Df?=
 =?us-ascii?Q?ZPoPhO8iQ3XrTW6anpB5IEpN8mBmUYEfpzpFNbXcaDjMXZoQZ4XFpgLkDpTT?=
 =?us-ascii?Q?zncoUuMIv8qo1p2Vbiy5ALMQWtbAMbDBd9Koy312Uz3cPlCXYNYxSYMzkvpj?=
 =?us-ascii?Q?r5fZHoYa2bK7p9AxlBz4E82AZUNQmbS7nKJfKR3D6H/TegWNBmIMy1w5HXNY?=
 =?us-ascii?Q?x+VjwfjcRGw/PgsW0ns7qXJqJDaz+aGtVtmYYGdHOM/zgXSkC/A4VZ2A9AIn?=
 =?us-ascii?Q?KAs8UFyklhGm7f4ZAtDs2RFQnEK/QjZRw/NszNbSMo8nehS9tFWUueiD3DX8?=
 =?us-ascii?Q?B3vwiz4v/erMq7c+R0jNaxKXRbCC7Sy6wrNIMPF55T7j6BltALnb+9zZ3HXR?=
 =?us-ascii?Q?bYPCKaKUZgVaOEMcfJKf6o8lUvNAljtAWz9lYPuhyesDqQNnatZRcUMyWm5O?=
 =?us-ascii?Q?KjiV+LmHt0zYffi7JPiNCQ/HqAGA+wgwds7JN1kHjn/yA52dsT6Drjj8afqd?=
 =?us-ascii?Q?wq6GyZVbo2HHciS5O5EK9oEOqFJAucR/fzvfx4rw5n+689vEqLOsaq4gLh0t?=
 =?us-ascii?Q?USQWN1j73EIgGNvb4VW53wVg0aldpSa5a7JKIaZzmwc2e1DFMajvOHqX7+1g?=
 =?us-ascii?Q?TBWStXPzKlP3eTjSrJpmpYwA+gBTqqzEx/MYRjLW/DF4q6OlK6XlP05JNVq+?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57adfbfa-580c-4eb0-bc32-08dc54252c5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:41.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNwf5Ou27LYaxP4Ev/zAFKc/7/+0U84Xp9n46mnIeP7vwww8rmS8uvcr7TK0M7lf7/kahrIOtUTpBMfKtNGhwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

ethtool.py depends on yml files in a specific location of the linux kernel
tree. Using relative lookup for those files means that ethtool.py would
need to be run under tools/net/ynl/. Lookup needed yml files without
depending on the current working directory that ethtool.py is invoked from.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 tools/net/ynl/ethtool.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 6c9f7e31250c..44ba3ba58ed9 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -6,6 +6,7 @@ import json
 import pprint
 import sys
 import re
+import os
 
 from lib import YnlFamily
 
@@ -152,8 +153,11 @@ def main():
     global args
     args = parser.parse_args()
 
-    spec = '../../../Documentation/netlink/specs/ethtool.yaml'
-    schema = '../../../Documentation/netlink/genetlink-legacy.yaml'
+    script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
+    spec = os.path.join(script_abs_dir,
+                        '../../../Documentation/netlink/specs/ethtool.yaml')
+    schema = os.path.join(script_abs_dir,
+                          '../../../Documentation/netlink/genetlink-legacy.yaml')
 
     ynl = YnlFamily(spec, schema)
 
-- 
2.42.0


