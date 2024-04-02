Return-Path: <linux-kernel+bounces-128683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C1895E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C29328BB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDEC15EFBA;
	Tue,  2 Apr 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jL23Jaut"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE515E802;
	Tue,  2 Apr 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091184; cv=fail; b=ISZFv2tUQKz5nR9go43/hQcYrRuK5JWA+nQA7BBNbnoWj4m3D62ffJgk90hqtDwNaiEEHnvx+kgwnK+tGoJgY4PdtqFLijH3B5SSoQXVlhjy2olmYKPrjD1Cw5b4iBgKJZhint5T3GB8vLO1GVvJUpXN1UMnB3SANKvJEIoGFKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091184; c=relaxed/simple;
	bh=WcARV9EEmygFik7TxeEZLEIAzAFkt5zRbts9fcuh/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEypD53XFBnUPJ4cnCmmafLkZKkFPB1yQpuccgvCoe+EFZ1Sm1jaCn5KuJSZ/7NcYRGCaEoZwY4GqLIoxycZ6vmXbxamMRMWYjvp/IomToKNofmCEwi6vf0e5UEdgo+1tVgY26QsEz+bHYQ3jVWe74nVn+3irI8911UWVBKHgQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jL23Jaut; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzLRO8tj8r1mTzqCckVB9Nahoyrk/TdxrvP/vZ5XP/OS4kUK8pnEhQUpRIFLQCzbdvsi2l1srm5nN6GXnCZgXVjROnbfvxq9Qycg5DKR54I1UaM3DHSa/kW8recDmoJ853qwvhCYRl5Dz4RYpQ7rPR210lHLD9U0tcZTwCg20UvlTOAIFHD+wpTGjO8wIllO16B1kKqi7eTiRMbLg2/Z6ZGCmLlGqKNbE14LmdPexknFeEdUdzIJZPWTIUGvIhmfjhuNDvAln6iEohCxrkOlcc2Kq9Kk+ez6Kt3RwWryAtRzxBRInoG5MdDT/dTVXAC2oqJJw7o+X9D1t+Daoj/vgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzu2h7owJYfaBza9LYpvZJNzfQg78YM7Kwm33ootnEo=;
 b=jIW9cji/1TPZ5iFMO+muWw0G6eV5BjXUmkEUQvr7NVP5F5bwm9Pm8bvWdDtT5t3I4XnI/ycXdlCiNbofA6xwg64eUnX22RWUAK1aR/4o2Vr4i29bV5PBSawnyjHHXMuAU4vetxqnx86latVVBSs2RvF9dVrl9Bh3A0wyjI89XrG0PH/+/0CQLyU5NnqzWfUk8Zjg+514lyz+wPmmCGbvGvD0OV9aNFWwA5kLymGHlnL4mRYGgGiLkZTzqJzgLHiRbJIOzq58AU6+6XnFpaPkCbUtX2J2UJ8E0slp6jiXcIASw+o7it3JwGRCCbszFYdHdefSnNc/r2czF5tZIK9bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzu2h7owJYfaBza9LYpvZJNzfQg78YM7Kwm33ootnEo=;
 b=jL23JautuNSCJYFNY7SXmf+lraaWU5mmN7GeIspmZe9/yoAxOqA120Lzbbpujmf0dSaC559EWp5wJI1xfLQ3HZIQSTo4p5QK61Dk96ydDemfRYyEslYbO3dNbJNLMgiyI2hM2731qNRFJj8hrNrdV25PNgmQzV9OCdkboCDoh5LaEPtk3gGAhBIlpr7SpFifMgOknhmz1goIe7WxBUtemqnqfYpMKAfyDE+3ivi2jIcfN7eCQfo1DuFTA5wJnq+S7+UZo+dtPzLUty630wA3UaDfQ/pS1zM6HXXdLn0BtdmeL2GCkXCnsYjz6ZETBXUBRnjt2KLT4/ScVsgpkgUqeg==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:31 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:31 +0000
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
Subject: [PATCH net-next v1 6/6] tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
Date: Tue,  2 Apr 2024 13:52:06 -0700
Message-ID: <20240402205223.137565-7-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:a03:117::24) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	aFZ102qLer7g+aZs04VCB8gtGekLpdfAQ4B0RIXkLtdkV3ouKCdy2Xby6vXusYRC6LO6WBg5C7JRkH/BnuHvVqqRvmY7j7Jiguf6WSDlxKF/VHqrGJ8H0sZQ6iaoFT9LPlec8ZGXpBb3U11U/VrypjraYUbFoeXZtk/Rr0KoKBGZExAZdNLKLG+VFOVewemGA2/T2uBZ5UojvRDUPC4xaCyOP9UB2jJE1t59s8m/Qw5c3Q+B/wYPkaD7CxcqaI/Q5aBTeVWNUomQMqrsmYRAAOJxaJo0HnPK/cNvWj51rXac5RR/t9gWAFLth590NH2xzWMNtfoj/Blt5PpcZlJeFybAK4ZJeiw8AaXKkloJyo3MCmTe0fvFZTioHOeXHPg6ADKHXTR7bhYs6UZsuB6b+a7UiK2rUNOlsRQv1/7wHcjC5fb4mP4ddpg4nsfz7ooj/dKZJnWGhA6fanVpuUbbeisRh1evY+vzJa40vgVB7H0Wf+k9ynEMM6NxDOuqNT6J+PsCEgq/IPIEKfmWTBdc0R0np1pW7SSAltcz6gSHScDW16sGLReUPqlD2Ei6k9ckTpWps3mdEy8YrD/6sB/l9gzJ6t18jvv4Pws2KeHPB8AuI4ZbLskISa5jmEXlYojLvFjWzFfGlNen+ecJrhAT/ioE2c2jxiuz2swFZ/1yxmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkXVXk3v8gLz8kEvj9CDwFmgjot0h/TpkG/YYL1F/0IMQwKVjZM5HEHvZWo8?=
 =?us-ascii?Q?h+BGj8fJ42qln2vtumJTqsxg2ZXtoHfW5lAl5OYnpB1eqlC7ZUR+pGXoUHBN?=
 =?us-ascii?Q?ff838Bg5wDcdTWcDsrI0m12irw38uCMigSUlqzudouvZBwUK6RsaQa2CKEuP?=
 =?us-ascii?Q?IH2P/WtZi3Tq707K0YiZinUJ9lLTrLBvwGL5X3tjQhIoRFcy+MuQ6JFg7vC7?=
 =?us-ascii?Q?qwF2kB70HxNulNK+dXr0/oqS/nbCS/4wIkTlvi2rvWwQTI+xYx/m3YjN0JZK?=
 =?us-ascii?Q?6H2wAJbLGftIyI+9cZbuv2vEjJMfn3xmytY//UDSRvEStahZu4ofez9kUML7?=
 =?us-ascii?Q?UozqJcLmyO2RDr44P+6YSQN491ZRL3t2TAQNMnay6yONaD7vtwIdYzVmpb2Z?=
 =?us-ascii?Q?Qr4FURHcpFnGDTCKqFTSv6QowkqVs1hcizV71ROkFxFQu8ovNkBpEkV5E0Fy?=
 =?us-ascii?Q?kgkxp5DtnQ1DM4ekFLkv9L0T3r/ps5Le4OvkGc00N/M42Bb0CypLZR87Zn9+?=
 =?us-ascii?Q?FpfqRCnoGANN4OeVHmWsiM+c8Eiik7h+hzLBpLCGUIhbcwEIIZ2vnC7Krp3G?=
 =?us-ascii?Q?la15QyqIeE5f7PxTQJ7VLXHxfp/DHgeo0wE3CE4zH+7uixH3raMElnExQMks?=
 =?us-ascii?Q?VzteJUDL8kwW7XetnzN1YCFsTlQeLCEzsBCiX8qZDX2EXH/pCQ9i87WlOlxn?=
 =?us-ascii?Q?w1GJd+SEhSNxoXO68rSb+r3WSqDrtkG6PicMTyEZEZKbweFqI1xYn2e26EL+?=
 =?us-ascii?Q?dB9SOyRuXUQ9Ms4BVr3p4PVx0yVRWYwUGc1zHBOSoHiPLAvo2GMOjNyHGQuW?=
 =?us-ascii?Q?7FP0DP3bqDVZ1CG03Xxwobl2WF5rPz+aEzM+jjWAbAzY4ru+Tryu3pkvEz27?=
 =?us-ascii?Q?fBn8ncTaY87koliAfSap3hDofQNOab5UqabyR+61FqaHtX5m3KrS29LUUSHJ?=
 =?us-ascii?Q?QxcOhHGuIrb581NKbN9qjWqgl1E2RVoGRAruzMWWY1hcA1S7PhgBix4K3oQE?=
 =?us-ascii?Q?pZAELc2G40WNI3i8X+5i4zD57TQ0fqiC0qE9o/CYYesZ1Dg+bQhm8BVlEX11?=
 =?us-ascii?Q?yMegv6EqHUe96TSNKkV+nCltowVaYFDe8JJDZFZcGbwfAXPKRYJr2WyxmUT4?=
 =?us-ascii?Q?mSmX4CexGQYJIl+FW04o6Q4RuMXr+urYQrUyjnnHV+azVCYUPDHFIKAnlbgl?=
 =?us-ascii?Q?ksPcFdc589kYlWHn8Rs8eNRjyiowVZKPUQUyHeM1aEAej1ZHWnXaiTLcHkhS?=
 =?us-ascii?Q?zDSLBSpr3gadDbhkViujVRdHgq55SD0PCUe9W74Tm8CJOK0wBtc2FItj9BKG?=
 =?us-ascii?Q?s42cvPZb2MN7q6o6t5aAyodlrU/8HjTVAVC2X/DvaI+F5K1ku7/E944iQI9v?=
 =?us-ascii?Q?X1xqO4mEVHU1ZMIasYfLZAHgElVlOsLiqRKEKONWS6bn/wfQccY+ElNrKbjg?=
 =?us-ascii?Q?QXzbl3JpBqvjyJbR2xbOapSSTa8eRUSgupL9/MoYiSXAqyGIl3LM5JeGmkt/?=
 =?us-ascii?Q?WFk5Cm5widTUdVnVIngTLhFdRm2+9yrBYw3ZBQw2x/huEfXhGissAVK5wSed?=
 =?us-ascii?Q?r/4VySUS/b1wiM1KzcaFqMUEK+zXX0LBpAhFn/ua7CbEKDggWCyRdLESk7wq?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e3427b-f110-45c1-3f08-08dc5356d0a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:31.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nfJil5YMKqEuBNA+dkQvY7PSL3y9atvV3P70fHfNZPqAKFFfeQ8v8TBgFC/HosvX8mWGI8N3mhXvSSGjHDz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

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
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 tools/net/ynl/ethtool.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 6c9f7e31250c..47264ae20036 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -320,7 +320,13 @@ def main():
         return
 
     if args.show_time_stamping:
-        tsinfo = dumpit(ynl, args, 'tsinfo-get')
+        req = {
+          'header': {
+            'flags': 'stats',
+          },
+        }
+
+        tsinfo = dumpit(ynl, args, 'tsinfo-get', req)
 
         print(f'Time stamping parameters for {args.device}:')
 
@@ -334,6 +340,9 @@ def main():
 
         print('Hardware Receive Filter Modes:')
         [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+
+        print('Statistics:')
+        [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
         return
 
     print(f'Settings for {args.device}:')
-- 
2.42.0


