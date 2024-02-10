Return-Path: <linux-kernel+bounces-60511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C63D8505E2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648401C208C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3465A5D490;
	Sat, 10 Feb 2024 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="ujrJN76n"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349A259B;
	Sat, 10 Feb 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588294; cv=fail; b=KRiOu73nZF4SS6fBrjQcA3tihzUVeeKD2mhizQEgp3lhVYu9TAppt7LcND29fJSdDkI1QewrTJ5fVDFkikOfE0Q5p0CNTIzd8sa94USGuI/utlK+8AE9TjAz0ni95rvOOAAYr+1ZOEt/kh8+CRHe1ooaOkQE1tJb/JBVvwQrJwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588294; c=relaxed/simple;
	bh=txWABCYrxdCJ+204b+0wT5TZ+gKWxn3HolVMlaGWhnU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gmuhRycg52gTpRv8USWIBXh1py4hmOOoskQ9C+p2txQADA0crHjlFb77E1plc2IKwqIqApyCnKsJ93EVrTv1R2QB0dBU3Uz+IsKEzWWpef7XfYwYxf9/rM76iiCLuwztaXCr2Wdj8duRmfNBiNgsLJH/4HfW7RxtVF1QSudK1G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=ujrJN76n; arc=fail smtp.client-ip=40.107.243.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3qusijYTDKzbCzTBGRynVm1omT8tnVPltnUFf9/FWDuvJkQdB+lw2zbk7FLuGLZ88AGHLT+OB33Mw5IU/UOM675h12NYhNhhobcIleO2sHVbSVb/hSYayZqCox9z8ZsJeGFU7RFjI/85tlyNvd5G8GZDbgV13QpXeoHjC5je0FGX2Dudtn8SO6WvW8s3NyjlB6Dl7RmpzJpxYw/9QIVU42WkFCQq4cCiwQBwjPMW6QFU9dVAq4bBNpoHkqUOlvL24YAMd7/AXDgJAgdnb+ulUgCLjwO0DLblwTAsGDKJWsGl+0rDeyn8sXLT9YGlnieKl3R7tMRPB4kixcV+9ZClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd0tOkOiF3YhEnUFUGnck53/Rp2hL/+Up8uGYDlbZaA=;
 b=TY0CalLYGdS5qXpYjIoG7RPVJo5WOkmkRCKHpw2QNgqTpdPMd7scnwSS5IJ6Lr1TCG7OEJ7mb7LW9uLChvQIa4RqmzuDVKV9SB/JlZn6KnRbHsVVpYvKrBfLAikqi/RUVuPY8sygYKU2kRsIFUGSn6uNYLks5e3BUPVkLarTWx8JCFaDedao9+aXBLxMUIMJk1ilElKw+iILx+ZLgsoxkK+7blffRZ95DDgjoE4S8xeHLs1ibW7Ghxb9Teha1NMx6zeK6YdS0SLMOwinJqmuHRWliP3wDzamEC4qKuYTF3beJJJOXLkv9ahK+ry3pw7wNiskhanFLIujpkFBM0m+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd0tOkOiF3YhEnUFUGnck53/Rp2hL/+Up8uGYDlbZaA=;
 b=ujrJN76nyFEaD31N6LqDHQU5Zv90n8gzmwnTsH/9E1lSUcMLylO3BgrV93d7hCKVm2K8HgKI2ss7G+spwpzQwc8cycTaPqabAu0jOdiKagF1qbxvl6qWKz4BjFMYi346ZH7RlXtaW6kIbn/zes/vymFirPSbCRvbQZwLPebhtcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BL1PR03MB6102.namprd03.prod.outlook.com (2603:10b6:208:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sat, 10 Feb
 2024 18:04:48 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5%6]) with mapi id 15.20.7270.033; Sat, 10 Feb 2024
 18:04:47 +0000
From: Hsia-Jun Li <randy.li@synaptics.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com,
	nicolas.dufresne@collabora.com,
	alexious@zju.edu.cn,
	ayaka@soulik.info,
	linux-kernel@vger.kernel.org,
	"Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
Date: Sun, 11 Feb 2024 02:04:06 +0800
Message-ID: <20240210180414.49184-1-randy.li@synaptics.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BL1PR03MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b0772e-3f70-42eb-53bf-08dc2a62c4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EtXkrksErg8loALkG1vCOuzEH9kmYKOe5vGxK6FwjxS7XYnItRyRVgQKbdKPsKT34nc98tRCi9yunYJG6w5r9yGbisfkwq8NQtbaNiZiEkG9V1/hmTADrvSARez5hJvE0hZ/5n9RdHbgmwkRj6Lzl0I1OsfBLZWQdhClv5zcKDUART7csyJThSt1y6kIU4XBoOoovi7kt8Xwkm2jdxvEbljqiHmfTARu8FdQe4HD1h1vTVx+ju40qNGV4b6rALZnrwfcaSPgo7rs9fAR/Z2rKoG/5igyUHG4P7a1lCw1iKCL05Th0GEpkw+4R6dLnHAfQLQYY9mN0yeVJqfnlvmxA1HlMAMqS3O6LJySn1F4IKU2K+dfKfd36mBhtbS05UaN/XhoXAyabJYl7oa38eDPGZlpYOe9KQfeYPgn6BQG7VIiLFpPcZQactEoxNcWTmKmhMej1zbxLLYkobi66fGxtcs1DvYeZWhq393hwKQhzEaMoHCoB9Aw2Hgmm5llORsZVSx1QZyWWrSYmyvn39L0Ks4+IaDmKwfKvZnZw+AVoTm5YqgLpO5jgxb9eBCGD4BKuhANkYPeMRWoUdgoTp9NqW6fxbPtRqRtIzWwCHW6IjZr/6ebUfIEtUqSlSE98P6A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39850400004)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(4744005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(2616005)(1076003)(107886003)(26005)(38100700002)(36756003)(86362001)(38350700005)(6916009)(316002)(66946007)(66556008)(66476007)(6506007)(52116002)(6666004)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DzL/PCbwhmDYBGyrTSkwLX0R8Il1/9rnSRBDLK/9csjUup6P9dUA1hWBISRG?=
 =?us-ascii?Q?mcqWDWX2U25eeME3FD0uRJW+HgNa/2hEJEXSv6GIygN3cdK1YpwGMIqgeZAc?=
 =?us-ascii?Q?6+IJCb1/kQ+ETe8Fp94QfTlRkBWJZD8eNJ2tE2arh5HCLGU49ZlFV69QI7eY?=
 =?us-ascii?Q?GG6LJap4QLUIV50yXYNefAJkz7/r6xdReCKoQ7xV0G1twD6nMmvFl0OupFvS?=
 =?us-ascii?Q?0Zb87VwIkKcGlv+BRJAJCpVmf9NOmK1XcZDVc9rZqlD7hxEJ83YqRVTyQvcn?=
 =?us-ascii?Q?5WGLAffLzvaQ3QzFX9GbUoPVVPjIbhN+t4G2vf+6rcKMNQ7hSpN5OApNP8sy?=
 =?us-ascii?Q?9VT6rM6GQBpSqyP+dMOAFV8epXl63C+mAYCLunrLZOui6o/Z85ANKo1/z6v7?=
 =?us-ascii?Q?EFw1ft+YlaCzYODWQyFhVBJFwSWrxD/N5qDBL8Me/B1AgwxWqxgL10JPDwMM?=
 =?us-ascii?Q?GcHRcKUphj3UH8MEJHtwl441SRopg08132aC/KKyP5xd0IvrNFFmmQV3eNpo?=
 =?us-ascii?Q?Ffk+o2CvoKTf2exJswLuqRU1dDFY/eLfGFNbrTqOFQQc/RveMurMroD8C41N?=
 =?us-ascii?Q?HNlRlBq36jdDbVqVIXVKgQrDxfhg/XJjZqS1gS/IMUkdwmMsVvE9fPcB6If2?=
 =?us-ascii?Q?UNoRoNyi9idIDznQGoHKHTHodnCy8o5R7CTNHA3jxZj4tDWIE/rMYtW3xWvS?=
 =?us-ascii?Q?kIiELIDIYc9SNjVJyaEI/ZD1GC3Jk78xR01NwvizwXTZpR6oGBeR8nEMNlOq?=
 =?us-ascii?Q?3/dlXpTYmOocyxCMJsxZ/6wYusk8NNAhvloKa+Iure6wA0lJucjVKHOkGQDP?=
 =?us-ascii?Q?rlh140lADph5eRBdHk/HoiG22B4fEsT58H37nd8d92BhTGwq7nlE+CmTk9m0?=
 =?us-ascii?Q?79aNCDbnCIAX9W+/uhirb0Y5cL6FheoRMNSeJq4ykURvSdXUmr/tWqnQpxpE?=
 =?us-ascii?Q?I0u54Hns1ApUID+i3sPIuS4IqxhsCNNFr63fvflnTFk1WLLgNTqqr6MzPMXh?=
 =?us-ascii?Q?eFvuj2wy/wF4qeucMf+fcHSaSfN3L8NXOrQ9MtQAkHa5U2TYhMz/ImXmQCq4?=
 =?us-ascii?Q?6n1t2xiWlp87Ka+RT3HuO5V4TIAvaVz2psBbRbWzmFFjajncrHZtg3UhSbKq?=
 =?us-ascii?Q?2fK20QcFwShh2HjkNx4safsGIFnVHw9ibOmZGYIx3dwDcrcwMZxHiq7tlWUn?=
 =?us-ascii?Q?FyRaB5UUVK1Ny2XcAgsUbpmyEoPSElo7URn5E6FluHCwQxpIDn510IKiqEfM?=
 =?us-ascii?Q?jGclwMqoPW9j+HJ3FvhymOZ7k/N6hkQIUliv7TsYJYOVyQBZY3puhC0XWD2V?=
 =?us-ascii?Q?36YsoLHDL0DFqZWZ6ccwW3nC4Fm9UxqkIZke61t50GSlOg77K/unLJbQNZKE?=
 =?us-ascii?Q?LbLwaG0ppPZksRPpQh/s3+R2h3E0ATSuixBtPMSQP/yHbhzW9wNqVuV7Meuu?=
 =?us-ascii?Q?Vu/Bys5AREQlZdx0fwegsESMU9n/3kZ2wkJ0DD17hyaYWYnTeEKYk8O9Nk72?=
 =?us-ascii?Q?MWLdA6q5F4g41qshiYtBEErZ2fT3/Y6kmM5ROIowiJHqiO8raohjlnm4fPPZ?=
 =?us-ascii?Q?7JbMkkaNTF2WK4Ywqs0l6BkUPqyJYEJjM6YBGR9T?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b0772e-3f70-42eb-53bf-08dc2a62c4ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 18:04:47.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q59CzCR7p3ibx35/SYKVViqxgV5hwJ0AdgwS4jTTEVzgCNcKUPnOfPGU/2d6Kp6vv6RePVKONhsosPIXTW70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6102

From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>

The has_stopped property in struct v4l2_m2m_ctx is operated
without a lock protecction. Then the userspace calls to
v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
a critical section issue.

Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 75517134a5e9..f1de71031e02 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
 			       struct vb2_v4l2_buffer *vbuf)
 {
 	vbuf->flags |= V4L2_BUF_FLAG_LAST;
-	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
-
 	v4l2_m2m_mark_stopped(m2m_ctx);
+
+	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
 
-- 
2.17.1


