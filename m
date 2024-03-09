Return-Path: <linux-kernel+bounces-97815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E546876FDF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894B228203F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221BA3FB8C;
	Sat,  9 Mar 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mlsi86uw"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54B3839D;
	Sat,  9 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973908; cv=fail; b=nUIJUgm0Az48f80+Z1+NvGoTlxSa3SWMSOUQG8Bv7SPR7S7oMp/3bQtPDgyv96KcNIzGWlO1uOzUVRdOEEpF+mhglAl/Ro+lLwHjWjCnMp4ThrA0mdN1MQJQcHNm+XMWXlgbevDOKLJSPG9VqwehAzSyprfUz2YH4xt1+bO83w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973908; c=relaxed/simple;
	bh=h1BqVMbyqCstV3fz1rbJlr2tJLOfEoJS7bPuFTsMyOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXOXrsc+YNIAHl8QPoFoQfDCvV51xk4tyKMXD8qqopl4GKbVKPduZjnzpbanmu7J+219U6YjK1ATami3A8kxVDZxeGytjkzFIgbJGYaoqlvnJQHPXh8Px5EZrwAcwlwtRJPBH+6kw6zQyefBP1xa0PS65SFma2OH/LTUAi6FnR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mlsi86uw; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V28BDd7kXFbyNKpkg8X/w7xLHohqtu6OaR2ordJsXqSF/oDhjnVdAr7svs5jhd29GRrEKlSgCP3WkuUpKkeaHy6YP3TiJTWzVfYnFYALQCIXpcJbGDA126Bm3B6/JdMxjlYA9pN+2tWZ6CwUN/ejZsh29kc+Zo4fGJmj9Q57a3d0reFCvX8DfEzAlPDHtYphNwDjLfSIkCEOHX6tTyAiq03tC5yVEY2n74zsfSr9U2DbAonMGkdS4ndZs14bOZ7Opo6jqu59B+JrKxvBbycnX8LxeBqwzRnG7Z6/OndnyJ+7TwJ6YVEv2kSJy4WMLqQn/AbLm8sg3s+8JBpGqfcEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Z0RuwzlbvHvuvBzKaYz9Jq06PE5Uj1SUo9cOuL+Cs=;
 b=kcOhFyQsaKexxX5fTfL1/lDheA3u8RB8h3Zx+upbrxPFgsuM9/2LnqUYHcLFuKMzCbWeeiPwIwq0ezVeE32FIPTye2hstCq5OsDDIuBPvzbTgWekdah+pjQjaCsyF5VjxJxi/FiwDmYaLZHZoli63Uw4LFTzDPWqLsHiOrImctk2kiIZxb7XxuS37OKs9tP8ki2yIdNllFSeiKL9MZt3GDW40OfDcNmlQACqzYhwUMl2VHgYjfw02m2NZhh861QyFXh9xfBgAGvi5ObpqEaT3p7rxzo7jTNgJUJb/PA7KiTlO3lZZ/NWz36ZJibc9cZlF5/GP99GM+PFwAbyDqf7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Z0RuwzlbvHvuvBzKaYz9Jq06PE5Uj1SUo9cOuL+Cs=;
 b=mlsi86uwLlF0X3XR+WCPhsHa+Bfnu+ZQfPpavPc6EPUURHKQoP/iTHj/LXqsOl7ybcqqZOx29w1XoMKHAVbOeU319BXPni6J+WKwI8H5w/2oxFMq18QzWYX2V/EzHbMXY5uM1RN3Deboj9bsjab9hGH2xor6EMOHrsXyrLyZHQfOJzPx8kVxw+m6ZmSkfUqBsZde8+qlihwNh5XYS7OQf0XQf21LjXG28zsiYG2TwzZF8LcmsnE9Lhw0ZSCsb2mFwgaTwCaU1RPkJ6P7tVBzr302ADar+Kte3OxjztBHU0CMjPaHNgITGi9599km0ZuGEumGH7OqujKIsssKv/o5KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:45:00 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:45:00 +0000
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
Subject: [PATCH RFC v2 6/6] tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
Date: Sat,  9 Mar 2024 00:44:40 -0800
Message-ID: <20240309084440.299358-7-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1e0d06-fee7-4277-af08-08dc40153492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NxN2PdfMq9od5FJCJhVxoOaLFcDDbtWy5kpXa7d125TicTKjF0XScbg8nepKrqHdHddKDhU2uZVjg5C7p+jVKmT2LlojmwimaCJTWFrpoR4ymghzijJMAs8ZUT+qdyHcfgTiJUeX6hcD6SUnJ4fVyknMzBvozbyew01/CbmZf9Rhu2THwifVqSTtdurp5VNNbU2LPSxrJ6Xv7npCcl3p1BIWglWOQHU99tscNMRk5Teg8Gtr5fkrOzugC456oDWW0RPJsurCr2L9+N4M7vtUOE4qXQpfy/Ul6x4KbSDQoN9Z7sjMkEWs+u42GDbWhNE4L40jHLxDhzwh4cybkVG9Tb3+d5UqRLQzvh11SeFwBft8qPKOWuVJCDPILbSaRMf53JvVjuqb9LRSfP/qF5qmise6mILWUcwwHpoR+eD97ohgCnVw5KYzFiVWJWOihNEE/oErOAERBwhbXesr4ka0ZHeg4EAQP9zhQhIGYXyZ4QA/uS2kYKTek/VaAHT4q3bOOBMZTQ78B0k8J4RZUy1+LKdWOHcr8a+Hlb01YDYAvTKv5IB4irilx4AZpXzORvcR3agNOWnun9v7ZO/8bnyv7gQ0fOurgFrq8AUBXnnv00fwgK7C12gWKKidwz4ZBu0QpiSX4Wep/cI7A/dDdYKlW8mdFn9cE0vH741Xtl3GDrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrCkdH7ZYp3RftRDmMScrYzm/9PV194NabIwHI5ZZ9gvePcKcfxsZjqnlg3p?=
 =?us-ascii?Q?QJiUzzWR0pTkEDgWc/y5Sms8nUUVGoLStLm57oz7Sx6DCGw0dK3lZxgdyPaK?=
 =?us-ascii?Q?S9zqEUykbVFpmdB94cdGTMJwfBKX68wzLytJUsyb+uA/QeyW8tS3N0/30VbA?=
 =?us-ascii?Q?tF2ulPo96laoBBOnNi6CPeTN5AXv1HAJT1fra6FtOZkCXOMcRiYZpbZl+v2q?=
 =?us-ascii?Q?UeVRNvKV3KhB+2JejkKrDuFMBLAxjXrrw4ilkeD1QPz8eabBULqqu0dmmaSU?=
 =?us-ascii?Q?xj0u5hKTBNu99jiGQYVSSeMMaCi5pGJ2D8gbjsdykmKOZ/Xy4XDtRItJr3He?=
 =?us-ascii?Q?trh5LVKj2c4rshkK+GBIqDzjKsKXg5oEQ4SVNxEIS7aJg1gWh57V5GAFKRQY?=
 =?us-ascii?Q?6E8zze5p7dvFKEohs0U7oZBWxhSgn4SNHTfG/f7LfJQx6ERnpozaX9gF9TLM?=
 =?us-ascii?Q?gjVT4nMiUVpAKI4zpM74t2GsC1l6FuBARXB8n4YJVFa5AQLWjWYBZdSvf/MZ?=
 =?us-ascii?Q?z8zcWBvFNl1GIBr77bVlfTLVTVSw3megqM2bcZmC7bvOO34eRJXCTs86ZCiw?=
 =?us-ascii?Q?NQgL38a18CQ80gHzfIt1fmQrc4Y6tC47au1XIOeGhZOJwOuCEfljutC3kw4E?=
 =?us-ascii?Q?yxu7cQW1EnbQzLJtZWCJgq9lCMbaEMzDUAs/aJOhdhz39HqRKAg7zWzLfpfG?=
 =?us-ascii?Q?B9ic0KMXXygiGlQUM1jH+FerhSJj5sPIXyIAwrd6KbHiqUeR1ZfhUwFdAPd1?=
 =?us-ascii?Q?P8KLDNEa5C0P264KfOPnyF2mnRgu1F4VGQ7hERQUIadS8nCrdM1bgnvx4W/1?=
 =?us-ascii?Q?CJzaXSn8W/qJ2sQ3xbrrMdQMOj+3XpD4Khac+qedV4pTSC3eh/iNGR9fA75k?=
 =?us-ascii?Q?f+mDJPOqNcZ9XuJnE5jVN0T0zwFXhsODXCwb+RCZ/nKyBltT8HUGS1qtvexs?=
 =?us-ascii?Q?FTkqXCeF3QBhLuMxfRowR0gApyofK3GXZ6+5rzXnliWrHOHbvX1rx0MqGpnY?=
 =?us-ascii?Q?a7J84/MMc87R1snlfBi7uZMwxxwFKbtIxJsfUJskLmBYptVofbIbK8nqZwmr?=
 =?us-ascii?Q?u8il9Dz0RCtBAq2Ffnk48xXUGj0T66efTDeuh1zdq8dmFnoJ1OCK/nGTR7Is?=
 =?us-ascii?Q?f5wd1sRtv+H57I/IN20j1OiL7phSZ3oqv0IJYxzdEp2jqsKUpT0JxCaxvKTz?=
 =?us-ascii?Q?3KRenPz9AXxrK8e1U+i0C76PgJbxseAlrK0JfzozpXKDV426yoUuNFRXbaKl?=
 =?us-ascii?Q?huY3jpvWwcEYRJSR4RPP3UrNXbo7XfvbvTlSTXE6jYOpCatupK8qpm6YKZoO?=
 =?us-ascii?Q?mS+eFf0KaTntwgDWJdnqxWNCMW1NTouItS/bxTWQUGW+lgD2H3cddOrrh7Ip?=
 =?us-ascii?Q?VhZnbtcp4seGSyzbokkVwrpgoR9L3+M3Hsum0M+YzxW60lBejhImw7/yI/Op?=
 =?us-ascii?Q?xbV4ToqVYYdFvErwtaWRENbbx7JcUwVilZ5d03VLGqwXZeC3zLAfqiT5yy3K?=
 =?us-ascii?Q?Nbryj+5gpZsqRrIYFlZg1uaO/jEx82r1W65qF2LSyTx9mYm5vo2wcs6KLJEH?=
 =?us-ascii?Q?H1b+2JiMPpMFrxfWnjtWRU3DVl8emnjD2Q/44hVGXUvf1n5Cg3K9Y/ix+Tlg?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e0d06-fee7-4277-af08-08dc40153492
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:45:00.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqeZ3+5DtsBhpcidu0G8W6dn8Q358NCstGKGMU/N+exNs3t+Ox1BHNqZqAUih96PkmQ2i5n5yIs3LnxJ4v6wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Print the nested stats attribute containing timestamping statistics when
the --show-time-stamping flag is used.

  [root@binary-eater-vm-01 linux-ethtool-ts]# ./tools/net/ynl/ethtool.py --show-time-stamping mlx5_1
  Time stamping parameters for mlx5_1:
  Capabilities:
    hardware-transmit
    hardware-receive
    hardware-raw-clock
  PTP Hardware Clock: 0
  Hardware Transmit Timestamp Modes:
    off
    on
  Hardware Receive Filter Modes:
    none
    all
  Statistics:
    tx-pkts: 8
    tx-lost: 0
    tx-err: 0

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 tools/net/ynl/ethtool.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 44ba3ba58ed9..193399e7fbd1 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -324,7 +324,13 @@ def main():
         return
 
     if args.show_time_stamping:
-        tsinfo = dumpit(ynl, args, 'tsinfo-get')
+        req = {
+          'header': {
+            'flags': 1 << 2,
+          },
+        }
+
+        tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
 
         print(f'Time stamping parameters for {args.device}:')
 
@@ -338,6 +344,9 @@ def main():
 
         print('Hardware Receive Filter Modes:')
         [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+
+        print('Statistics:')
+        [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
         return
 
     print(f'Settings for {args.device}:')
-- 
2.42.0


