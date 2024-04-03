Return-Path: <linux-kernel+bounces-130631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BBA897AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534F7288BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE92BB02;
	Wed,  3 Apr 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+BpDJ1w"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC26156F28;
	Wed,  3 Apr 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179794; cv=fail; b=hjt8U83e2MxuHkRBtTXE8aMp1XBczHwZFE6nHuzr5JzIJWdJ/r4oXDsCJI5w8UB9Dlzb6MqxXol8j1eqbirBWhJJbJFvmUUcMqPuWHniMqA6UAAkbRyk8R8VRQOtzzCh8iiNW43XaTQBub0BJ2rPeS/kBIOV+z8bFkmD1T3E8iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179794; c=relaxed/simple;
	bh=WcARV9EEmygFik7TxeEZLEIAzAFkt5zRbts9fcuh/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKDz9lLeFKintKyFYEsnD0URVs0AWQnaCVmOqu19wVvSIldaxuMMWiN3cpmryXotTYvJu0iMI3FH4Fldw8nzCYNnZFoXOSnS232Sgtl/OkFF8DdTfddugfPIh33EiUMPNloDaPbnbHE5jMsyVK87eAC1s6VHrcbPi0aJzppKwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+BpDJ1w; arc=fail smtp.client-ip=40.107.94.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn54yxOLrZg+918IEeqGM6nKhFImeeBnoG7kvDUZLYt6qguIdN2rMPEUT4lS5ZA158GsSbjBFiqfve+PYDhrbJQeANTLzk4dH3KgWYWJpfPBGUQrSCrckcWlfQVTAPWdRgMve44lSIzhlQ35pbQN6qC7aKdKB2m3KeCmHdY+DooARlcAiwTxy3G3D/y89Mse68++3CCIufsyfhdJuBq1J/3pN+rMdjRt23wM3IMhj5GcNPxX1kZTnqO1H477QT5U5oSMYlwo5t+r7YJYBHHCuDpzMhhmoHKRMH6KvChbmWcWl4XyWTxssI/C8HP6UaJzZKWluq01u4Lci5iDnRsUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzu2h7owJYfaBza9LYpvZJNzfQg78YM7Kwm33ootnEo=;
 b=T8JgjBCBOCIRpuGgjCmZHyGac7BPHfWw2L7ozNxUc/dLeqoQ5wmShmUipH2PSgjuYTDZHt4vUfOtWSul/gsbayFJ8St+XSCmEdGTrPIlnY6LGJd2tf2SwVH7jVQc4HsQQ571nFhIpLIx2vToMApPenOIzG5MQXoDChhc5e08DTFCEclYhvyQTYbDE1ukWeKIz2abfeIxuqEvgCGZhxDJUl2Y+R10GDgsyJshjLsMGZHCDpV2KSjM69P3QNrOx+G6HrytoxDii2GEwPWog515TNL2qkGsfwoAG+dRhF3iMsEsFhGSH1sfonkIRXtlFHlxXe0tslKWPuJupuuERSBAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzu2h7owJYfaBza9LYpvZJNzfQg78YM7Kwm33ootnEo=;
 b=S+BpDJ1wPBJbbgfW2bjc0+pAS+fcB5tkxQ/wxZCNnioicFKVuytGieTBBKi4fF1LDn0Z4KLDrHeG6yDNxzgVGJ6c5xx0nO++TAeMYcLBQyJrGl1YyfdDZvlAANKO7FKRApjnyIz/IESpUBZPoSP5JOoNspRnlTQL0cX6xjW/8wFJEiQYuRrr3rXDZp9Xm166qq0Wby7Uzs/pO7AqHAEC8++/zE0CyYYZ14H4FOJHcFR7txQcdFROhVfMegBeTTpb6UxN21mk2FOp6b/CR71ZJGrrs0lRsLCVIG/9dcMmIYHYDIC4kzv+D4QxlaKD4U74BjnWfLTxZbgDmFtA9FmAPA==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:48 +0000
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
Subject: [PATCH net-next v2 6/6] tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
Date: Wed,  3 Apr 2024 14:28:45 -0700
Message-ID: <20240403212931.128541-8-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZUMytboxh5Fwq1TJtTh1BVuMIzbrPGtxpRHwwHmnJ/1aFxQ3L12mhpv3Uo8UIMgbj6IFu/BtcOs3yUiokPIc/Fwuk82twNJqmbCG3HjRUQT4lLZEHVY7kfhujTCtovkjH7xQ9tToOSpOHlofvm560/bTHglvB4p5TTfDqj3h24G/YbHvyODkDpxAe4EGqQnD2k1K9K/Nw8u12BpfN41QZcpc+ok04vCFzvsPrCS+MmzPY46ncrpu1DJFJs4OhM35JlwHUI7nEWFXl9HeyVGrfwfOOnDQYIVLfuF+MKDtfUMdXIaAFCVsjzCSweGAPpF6VCnhHD0b12B1wnt5pfRLYXp6lN6alsLpIkR9+vTK+zhk2KTuETCJLeCW9RA9H9BePvX26c9XXS5EzTNzPFk/+EzWOb0EjqhzUQfE6rtcECBW24i6q/7sztkHfbspXb2zACAxiWCzkAJKVmAk0AJSG8wWt+dqrwZlSTjyrRgez/3UUKrQpWBnKengy5G/b9dp8vKxQgJrwHhIYoQ5LzDxmRerhqgkdp5Hnak7Nn7abrppgAb0NgqutxNJXOauZPqbSa0yfNIyKDhKT0/wd4YQiyr1dhrD4r2mw2Cz+oMpPXpjgEtIl4ZVQaDCI+VW3oAeB0syKM8F/0WkVhi5mWTilc/qMIVz7Dqpl6UKfSS7RT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/KSOzFYycLncG0Adi2zrSZPJINXEQaLp3lRqMcIVGaOxlOiQ/OZqGkNsx5I?=
 =?us-ascii?Q?D22kjIYkuvvCXJl6kccNNG7PnTs6sAqPAy/4xa67ab+DS/8VR6jb+SN454Sd?=
 =?us-ascii?Q?v7AyDt4XoLZCOb8gdMlQwF+MgKftmbjSWCNRyRYXrmGWDkmHPZ14oCW19ZeA?=
 =?us-ascii?Q?lUOp/ZSToXjksfI2JLouNwQK5hiOH3AvmvtRE8XrOFDmOitFU6KZNzI+oWGZ?=
 =?us-ascii?Q?9ktOizRTqGsmDArImiAqOYSismr29sI+qW9QtYdH53+vp/nGNz3EzANZTCor?=
 =?us-ascii?Q?nvgll98XueyrRwNfxc22Vujfj1A4/Bo06FTJ1r3K3vQig90umr45eCeZbIfk?=
 =?us-ascii?Q?RKG544CT8phE6+xxh+yktxATBzi/dHLYB/rpBznxMCKBuYGPs+j5GXLN3T7L?=
 =?us-ascii?Q?l1u0xH6iPuAf/OaPr6Qe+DfK3arfXel0rcEfUHYZ+fxthFXr68+j/2z6KUNG?=
 =?us-ascii?Q?VwmQRjHdLuljVQumToTcf0J2O7dnQPMti918mrs8lfYuIuZA0XANNmG7u1ay?=
 =?us-ascii?Q?yFHTDMsV0hBWSfgfqXmkniE8D/9KkRt+34eZn7uSFqlBit9itWQZSG29eTg3?=
 =?us-ascii?Q?fdJ3eC7SdMS+LpdpqcK2Hj0POvOn/EBT7J6aBfpr65XM2y7JPMpmdxB7uGv1?=
 =?us-ascii?Q?N/tO+u/X9GKxf+AZ221KWIRdQjJX1mH2OrR9HX/yEzVQ4jqYGzrov832/Kgt?=
 =?us-ascii?Q?6wwnsQ7Vdjdq6YRp8V0LzDXyWxHno5fO7K9GOixZYdbSWrZiUSokgu5ow8CE?=
 =?us-ascii?Q?vSUOv+lO1NTiUUfv+WWptOIS82jMwYRoPNWNJhV6v+TgXJy4zpf+ln/LJ0Sg?=
 =?us-ascii?Q?14mqbzyscq2woxoqewAPNlWoifba8IeG1oe39zwfmc7CodVPxiR27emGWEDL?=
 =?us-ascii?Q?EJZND3mdUfwq1JGsZeliG8hgLKlM7pSvSN8LPgZjFivdsM4gu0cCXzRv28+4?=
 =?us-ascii?Q?oH2UyrH8Ec5v8/BOB+2AP3xu/rYvpU1n2A+H1NIdgYhEagYwPP2pOYFd2IOs?=
 =?us-ascii?Q?wDZ9RAeEVDwEEjfghfhmoc5Ho7GTei0QgCsH5CsQY9X4PGL6jTF13uaQSEjL?=
 =?us-ascii?Q?v+39SzO7DSXxL+VjR8/OrXhkRHeU+t1haUwT/elq6pubO+cc1NDIilYQAZ4Y?=
 =?us-ascii?Q?s4Ov0xmH6F072QqbMh4LohYHzCLd0grIdr2TOFQ9ZivACaKBhnBx9+qJUUzH?=
 =?us-ascii?Q?gPMr5qgWEeJxiQZ69D0feH6px18R8i0xJUtO9DQzvQXWgAu/LarS4NywXNG6?=
 =?us-ascii?Q?/EXnW66I9OCVgiBpY49CXrYhvko/MOJzA6yxfWKG/Xh5qzH0tnXM36qZPngy?=
 =?us-ascii?Q?f9MpHi1wVsCJF6gFLVpbgwSlpFAvdYCvP6b1QhmfDYDTcJUH9hJc4wYECuLV?=
 =?us-ascii?Q?qNrhbjKwqNQXdHJ102Oo4umxbkqF4zDdBK+jVpOVkJLD4/ujsPuQJhoNkEem?=
 =?us-ascii?Q?Cu82YWQOxoMQ70t8VA3l6AhRTgMJifcbm7ipoyYJD0eduqOQ4SmT9oAU0HXP?=
 =?us-ascii?Q?BEZF+gnMOg6nwNVqAN7BAEwBYZMvb9S2MZZqb+RAIAZ2u27/A6GIw6aTAv6N?=
 =?us-ascii?Q?8lQ8xl//9dfC6mc8X9TVbRfmp75JNoB79XlZf6X3SLUHaZ8ZfYyIaoxp1lFF?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d2db69-b335-43ad-24f2-08dc54252cb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:42.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7O9mPw6b469gSPb702W4fmrpDNbnbIM1UR7SxlWow0R5REyufwYc+aSYrMLpoyTDyc5cOJdJL+ivFXTJeiMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

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


