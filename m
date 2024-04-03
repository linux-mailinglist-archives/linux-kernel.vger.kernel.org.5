Return-Path: <linux-kernel+bounces-130632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EAF897AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A643CB275DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D2157A48;
	Wed,  3 Apr 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUxuJd75"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2117.outbound.protection.outlook.com [40.107.96.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771F156F3B;
	Wed,  3 Apr 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179795; cv=fail; b=n/JmH84EuWZyfbJ4h2WDXcPUBr13L1K0qyv09wEJjs/6myrq2jCHPnOYkaD928Rx1yGFm3oC3eDP5T+9NNb7m5WKzGrqL17GdHSVXg3aS2rnEOzxrB22W9BubOi9LyCLFMeUEfPH+NUR1l+HzHtWmalNT0yfF+7Q7z7JvUYzXdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179795; c=relaxed/simple;
	bh=i37RrI0Yfd+qpbhqvBQb0KwqxFEgy6CsR2rSzcv5NG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dg9go6ZxFgO7TrLm3IpmPBhzcnRVRE1pR1VzIy6j+8cvBhrOQ1z2PsfLEzCFSJ6XHJHjyMjkOclIhxEN6swcC6BGlxXwHwNuaEnqo6Fjl31XqtmdgF6c1DZli++UCHBKNcYHKzaYhahdQYjZy6Jv9n5Uh4xPRgdmonmaab8yiEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUxuJd75; arc=fail smtp.client-ip=40.107.96.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMvj8Q7dB6vTqSENFLy/+8BOcws4YzQjywnA7hDSPPWWVfTTVNlNKzHymaRaxgSeRCEvRZnWEUIqt1BMuV833OdSfQKEpCExjD7B8nL45dSdflLemhJIV+3PSZejO8zkL6whbZmLXhYzkT7mx3FC+0SIBCnRPCKvBghfFeGBPvJZnWtILm0b0Dm8IGsgD2cZ6ZsGeMWVeWBlx9JH1tt238UGmoP/JqEC+wtzMa03wbp/F9uapaZh5TsRKiaBwhyDgnWLJ6wy7R4VFf7dg09gE7AZOg0pBYyFjAPSPCTWweGPvD6850/3oWDQ2q7J8IzKG6s4iKiUJt7ehvLX8GoF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bZiNK+KNKQ4yMz90KgKJ+Sq/gR08XGQsI5wDFJnBIQ=;
 b=lXWf5PmbLr5VEmZT6WX+pBeWNQlet0Rv9NRE3eATAfnZ/85NSjpOzVBS1bwNIEdmuh/gw3/AiBuMdlUOtkK3iOLHOTPSeavmBULEXpbMv2edJKOgWe5dEWt61KIbCA8E89z0Qt2v5VKfphJQYgbISiY199kx+O4O0VFeKQbHCP4T5amz+FPUA5Upq7GF3DJbj3NWb3v8wcyrE/3/BNl9OGgYKnuJUItWA9jFxkGF1xEYjx11Gh1vG31gbPplZWD6MDsamhiCCrBOkxO/TuQ2Aa45J+WrpQ5wmRo6PQ4HM73FwN/VcXwRV0c+ReOERko4adcIUrC1YjjfsXzE4UYR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bZiNK+KNKQ4yMz90KgKJ+Sq/gR08XGQsI5wDFJnBIQ=;
 b=eUxuJd75JVRz/vQ9kiV4CEgJnE3l7Dgi1VISWa7DRmBN/HwbUbY7iuCvhSyAkb5cyWpdeCw5aS77Zk4W5aXX0sIymekzSTu0iy262VsVfOm/pd0uwYmT980uY8Go6ndnKVREGsJKiOu6mcf+7H8z3QJP9EI+hqyEn4uPsmx2XHwS5syYYjrwLU7JcBVJegUaORErms7rMVJa73Yxavk8LJb8uZfwoPjLMXMhgmKsv4g1Zf0d9a0MU/Knpw8EvofehjFXaKvgoU23B1dYQbHH3ZMjZFDWffl/rGtgoi2q2C9IZ92bDgg+Bf45Ip25vePDJ/gnugKTLj8P1jiI0HngvQ==
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
Subject: [PATCH net-next v2 5/6] netlink: specs: ethtool: add header-flags enumeration
Date: Wed,  3 Apr 2024 14:28:43 -0700
Message-ID: <20240403212931.128541-6-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	SpHkT7t/3Kiepobv35DCP2jusXLI8OxNwWCX61XZb2cMGky1CZgchXmJgl7uVVCdM2Q67BrwR/as3lSTuI0DpphdTNzZlrTey2vPEcKec4fiPiTk1HnR3Fw7POHQSeZL+JNXUm6Gb3aVQxFNa5YpOzwu/hhTCrY6UbhVFduP8x8lsnPRjpPYNL6nz6QrIA3l7F9p37JE5U7hPYF8VSRZ21DHT/bAefDEM3hTPY9DPzXvimp4txT9D4SdmEyPexrSaE3oLw7QsWwW+iGitgNH0vQe+lXQ/OUgqDkweodo46Qn4T0I//gGJDbksTO6Dgd27FSS3BhugBVbjNmDQIEK05moHlgJguNkK6ILX7dSneTvJRhLf6ukO6PST65lwOHMGFuBUcpQHb/d0bPb6QC2judDn4QfaMI/qoSZTwBep1YHaQadR67rTVsnUmGeXUhimpNY4gmSVbuMNsMpwCTZPolVAhThpfChS9KkGtdW9Rf6+g0zzhJtYdTc5kDyaOu3DvGxcWsrAH0AeXnQzPiSJgDoJtDKwF16+IdDRJk/nFEWIAPXYQgtMPGdnNtsLVoqO+K1d0xmEtQPauoKTutQZ+polyopKDJI7kcnJOsCt0agoyOIwR2AJfl2BtJuXkTz1YQqzBtLHojp51yt8tR2eAs5+4GgygNPszxONWGV+tA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55bsp0A+DZFUp3tNdN/6EWsq/W9VYAbkbYpUo73GjacqgJA36rYf/GKnV0KW?=
 =?us-ascii?Q?0aEiT41fEwx896q5SU/daCgTOScJA4LksT3viRnULNeb9IHtQ8Ml2XtjvEf3?=
 =?us-ascii?Q?xFLUYSY+KHhcGMQHQQZFF9bk7C8Z6BYG4RaTnn+xLx6ZUU8iYzSp0cf4GFzb?=
 =?us-ascii?Q?2PeOHlrnhPIRzGq8g0MdSQukrpL6SIbGStMUZRIRikshtZgekGAibiKTzDUl?=
 =?us-ascii?Q?TjCDi7QX8clRRVp4pK6ZjE2+bwxZ0XrRfdlpBO7wX7z/9h6WxDCVciCRBNZ/?=
 =?us-ascii?Q?+V4zb783WCkgq1+6qz1JFczPxr2DniJLNeq0UVRQwaoCLxU4APCTXMxmZVCk?=
 =?us-ascii?Q?NYYTPqUSsEE9lRSmYZF7z400dwrldoND8yMDr/cAwGa5DpAt3pof5WC5jLoL?=
 =?us-ascii?Q?aH/801MKAx4MQGUoiPgtHjfGKX2DQWS6NDvq8D6bFndwE70YzDUWEdkHVNUv?=
 =?us-ascii?Q?Ir9VhNvI7vD3aHNT8N+Cdnv1pPJkmN8gimUtIrLWQcMsb56Valxq/YGcJG2r?=
 =?us-ascii?Q?82umXIHrOCkogfwBXwg8klDq7XwnT91dcxxRf6GMVqbAkcNQJlXJAZNMmfQH?=
 =?us-ascii?Q?yncB/MMEQI4VTQNrffGbJoIJEYnILBQ7DEaQmirJTjtB7IwNgH5cshY4sp7C?=
 =?us-ascii?Q?px8NnQ0z/dRx0SjZSPoddJqpYVhdGX0gSSmjQL/tn78qfV38ldjdItfAfaEN?=
 =?us-ascii?Q?L/HTl84AcawNnmDE9zqA8jjo9qb1y59gp25gMeclLfEz3c/NVKSuGX5MMPX9?=
 =?us-ascii?Q?+caS7ttz0pzUlxvqcVhVvnHCdApwNbyGwPn6ovAhXrn94ibvT76mvVspd0bD?=
 =?us-ascii?Q?uY+AwYp4akS63czMepvQMcsHXGZwK0EODcVyRr52kk3Je5rbdQOv0QAP3x0n?=
 =?us-ascii?Q?TzVKZf7mCZMpBDAaLWFJo2OzvUE0i+KIDTNag1cHJQ1nTeZUSqqH0/In97oN?=
 =?us-ascii?Q?Eg53Co9/xKeGF7wO59LacbTFiP2wU3tDrD24Eqxg/5Sg4WWb5r+WhPFs88Q/?=
 =?us-ascii?Q?J/H8nzpaOT3OjUZ94Pqpp4f9XlPDlxWo3GjgWjYRofHIh0SfUlf2qICUGU96?=
 =?us-ascii?Q?ra8oOJ5rDGy2mX9AM7nvln31WLtUdV+5IlRZRmpz1JZ+kgqYXD2BvhQghhNy?=
 =?us-ascii?Q?vrImSPJ0X9aTp3tFzgYEW9Ei1w9Sfg2gpbvIOrqM+LsRcHxRH84aWM+t6/6e?=
 =?us-ascii?Q?vfDQcChKDM74DxRKy0xSgArRkM70+2qgS1XJWKoMmjDN/IeIpd/9rIar91+L?=
 =?us-ascii?Q?p42pH3wkIVBY5ya6q5fGYP7CKeb1Nu446xIB75evNzwunIhkEnfnOng04M0y?=
 =?us-ascii?Q?kIG/QqoruwudRmJfLTE9WLCdf2DmqHQgAXwbkSmzF6IqLBH699ALuhGG5B7a?=
 =?us-ascii?Q?ZbOUP8mCaY71sHacC7VPqRBxbGL0PeOOuzLCsPvB2TFmxUBF2FmFmTJKER+r?=
 =?us-ascii?Q?pZYx20+uLRbGM6NHSECzyKlj22jSE8LpZ4HQQ1gRBKexO21AUj8WRF+NF1Oy?=
 =?us-ascii?Q?FJPNcV+SLlPI5mE4Li46HiJomjgsOvx02AhYowrclwgtMpZhqsJT5yFKPwqC?=
 =?us-ascii?Q?jZBJ77k87GHVyDIkvmS4qxF55s/xn0kg+srtPfuhIWy6yYGgSd4tzDoVtz9Z?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d617e90a-83f2-4fdc-1c0e-08dc54252bcd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:40.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /B23eES0EGZeFyALx96uvqV4moIFu8e3j5WPalOTPRzyBob1k5xPaCraS34f5cDFoE2QFVj26qxHC2bWTMAQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

Enable specifying header flags using enumerated entries in the spec file
rather than raw flag values.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 Documentation/netlink/specs/ethtool.yaml |  5 +++++
 include/uapi/linux/ethtool_netlink.h     | 11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index f5aa1e7f3383..bae3bb013787 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,10 @@ definitions:
     name: stringset
     type: enum
     entries: []
+  -
+    name: header-flags
+    type: flags
+    entries: [ compact-bitset, omit-reply, stats ]
 
 attribute-sets:
   -
@@ -30,6 +34,7 @@ attribute-sets:
       -
         name: flags
         type: u32
+        enum: header-flags
 
   -
     name: bitset-bit
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 8dfd714c2308..34a4a64262b2 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -117,12 +117,11 @@ enum {
 
 /* request header */
 
-/* use compact bitsets in reply */
-#define ETHTOOL_FLAG_COMPACT_BITSETS	(1 << 0)
-/* provide optional reply for SET or ACT requests */
-#define ETHTOOL_FLAG_OMIT_REPLY	(1 << 1)
-/* request statistics, if supported by the driver */
-#define ETHTOOL_FLAG_STATS		(1 << 2)
+enum ethtool_header_flags {
+	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
+	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
+	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
+};
 
 #define ETHTOOL_FLAG_ALL (ETHTOOL_FLAG_COMPACT_BITSETS | \
 			  ETHTOOL_FLAG_OMIT_REPLY | \
-- 
2.42.0


