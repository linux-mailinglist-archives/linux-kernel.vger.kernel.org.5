Return-Path: <linux-kernel+bounces-82565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF8868668
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0A81C27CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BAB12B79;
	Tue, 27 Feb 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Xr7oqbB7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416DF510
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998642; cv=fail; b=cZ6LAFNPoQpoU1izItjt1KomYpCLdXrnsWKd2jiNRiPkgC1OqbBzKffOX6fW/eSH9W/AFwxtXrLoKToeVSY9hYxjhXx8jkQj/lrflfZhd9uhMR5G3jhWczrdOIUcrVBjstfuoDpv5TOmGcIdzYUNbVbGwb1HwFvJdxf/lYs3O40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998642; c=relaxed/simple;
	bh=oM7ylc0Bx50iFijoQ7TrnttsyZXngrl9Gl7CO+VOvr4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OgSkNO+gzlOWRsJJrDBb3Ygrths9pn4UPhc7I9lUSSLivEL2C3/AV+05AHPKtMaYFFIUJUFd5VjTlXxcoPO/pmZ0vXadxcjAJU0j4KKnfvPHXPjfM22GeecdHFISvfTy2YN2EXhoh1D+ixpvFFQNO01jBSdpXiMKc47fKHlU5kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Xr7oqbB7; arc=fail smtp.client-ip=40.107.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdhYZLmpSCYhtqYClDeq43q4mXvAm0OPzz6dDH5c+d83M4CB1ognzk8G4xzGshrhcKmEyTQaXQHM6iQa65wyA+1maQ1WOWz5otBC9+yXgjqcEAXjow8rRu3K94NnV3C3Nv2F/1fAA27NCCE9Jv09/sW44SDj9OcUdmSvJk2rD92w92DkrDiuYfVAYBYPxgiA0c2X3oTmL7Dd5HrYG0lvloR9E44ezipGSXUVLqNtMmRzke9omOTlqzMDUimAoK+XIKRPdt6TCgQVir8YSCklSermRLzAQ7P34n9B416zIyDL1jMFZ2YcV5+Y8hYRwIYOuL2+gR7Uf5UGQDuqJlDqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOXhH41sDCPGU8rsQnZo6JUy8TlCmibgdP33jv8D7Po=;
 b=nKqdTBODiinGY7Rw2aajY+61fO7UH5Wv69DPMHeK+SLhebD5nPIPWboyb99kSVT2BwCvKFsQxAIZO6w3/cRgJFvV6ZqK58dQm336xVyoE45tsS/g4EmVS4UWfcKkUq9+lnNH+CLi3NuZ/dpLEmwR3cKexCnXL7XiCeWP2n5J/ODwTZsB9NgjalYAm8teus9uBNiCYgN+ugaQ7yk6PNA+cIYxqEUUoFd7abZop4w4ba6+JwmKVaIJOWvcTLzbLO0n4tFzpmMN1zEKQ5U0wS5n1LYem7qbmlficT97pWdFitm+F0srL0UhbUhNjl9mNeWIvn6LCO2yQiFzW3UjRLUESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOXhH41sDCPGU8rsQnZo6JUy8TlCmibgdP33jv8D7Po=;
 b=Xr7oqbB7/QbIZyyU5mpsOzMOp8gp7zYLOGFLliukESgKqlwB1Vi+kXYs8p+WO5ifu6bmzcYKkKhKtrTqpsCGmpgHiWzeBKV/BNVlPI4a+tx7BevlhmSWVAQn/OcGfEh3dyEUPso4kwLcleU1ZPWABDJQb/F9Bekj6iWtW5vCd9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MN0PR01MB7588.prod.exchangelabs.com (2603:10b6:208:373::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Tue, 27 Feb 2024 01:50:37 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7316.018; Tue, 27 Feb 2024 01:50:37 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: patches@amperecomputing.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	k-hagio-ab@nec.com,
	lijiang@redhat.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP is enabled
Date: Tue, 27 Feb 2024 09:49:52 +0800
Message-Id: <20240227014952.3184-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MN0PR01MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d91e85-0640-4be2-2790-08dc37367e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TAcZRR17FnLY31bxv7L1P4Vx1Q+0ZPcEklejjaKLy5Wew1lvWxEtQg2ZGE/QC3GqiYefpdtMbRA4zXp0VNeC+1DTZwyBZUWtMX7aI79NeV9AWy8cmctVEgAulVm8Blg0d4c/7Wav+Nhs9+nuQrsbhWjyaoe0Y5QLWOgX0BKsrIeTcqx6spAiHc/LYgKHq7E8xMbiIDwn7X2peBC5ljbI5IHz5+blzaHj98vDMhtBr1OSIqYoOC9ahvZhO1A3oL8ywK5TE7cm01w6ZSReHW2uK6IeQyQirVG+oYUF0W4frnwzKJQKwsrDRmzqokPoKhcMGSwdj2BeW+KfaymGZ9KNe+L1KN4zETWlXrnVZBhIRp7ltaWF39zcErlOSdcSh5a67llSFxr26ark4j5L0UuWNRsauC/2FavOjJTL7o+Q+4rjHIYb0clF6uGCPLkgoth43Y5PWcPxms4g/DIzXas0UxehibblyitK5rruZhGFtD4ajfZ+XRItjihAXENTkBAgF3qcMtLLnMxAshuA06wQKOiTmHq5CGpLeAnVLYTHtItyaunuht6bPUNcnAJp3HmYOA6jFCr++MAwpwPmyu4r+GwPoYT3A4jh5GSHqPKt3+FrfjHkPFzd5eINGL+gsTY9iL4Wb+am4vl5Ww9rm7RieL2OJoQh2wn7DOovouGvtfDgE8pz272GJRm3m6+whT3dBDBhfRnZgjzMe1v5qMVeSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2deD7xSrhOV+DICCfiBTIxRW+irfIr29zFPwnG68mxTxEJ69j+qBqhGcb1Tm?=
 =?us-ascii?Q?YDugVgpFyT104CB2eE5OVYw+ap+rclGKv+zUvsjeb7tZpnpqscvNqODQdzeH?=
 =?us-ascii?Q?DRrlf5OtzD0ovn72+QkpYPy/yrdEjvHxGi6qWAAu9o/njsy2F2s7AzrvzyC1?=
 =?us-ascii?Q?jcUuulFaereeHhiZ7vu+oljjF8bedMgvIrmtMvszxJC+t/xwS+UcS4x2bKRC?=
 =?us-ascii?Q?m2HIkgX4/6wplkGIOEgvmFHS0BqhBNNP1J+rpuoRdLVpZIIw8t4x/9CLs48X?=
 =?us-ascii?Q?4FauQLdEzXgdiGrAwRnfEjeqwc6rVzH+Ed63rqu+VJuGW6vJisT0MTSSAPJe?=
 =?us-ascii?Q?+Rm3MSL8cdGZ9MpBLG/H8IHdGh0t96cDjsBhniJx45YBExm3ZqzUuN6+57FJ?=
 =?us-ascii?Q?wLWI5xTg6y+ODuumy4ut7/UmKjfLzqz/TaTUUIEeSGQfsJGHW/rdYCXayMQG?=
 =?us-ascii?Q?qJ46mxtCdEmP2c+dzBUzdhybGQotFwsDvlg0SwJJsOcnm/9HGFTwxbrs1sBx?=
 =?us-ascii?Q?l0bSg5WhjEjSFdnBnxoVRP+D7K0VteTnGPPAbKfmT0O/SXqNJqWaH2FTuS2H?=
 =?us-ascii?Q?RXQUHopPHzMZHPw/QT2R+iRyDCjL8sippsnlhHjgiq2H9+pKMjes+Z/MjU7g?=
 =?us-ascii?Q?l/Jnc4HGtX5Ca/IPbA9pyNfUb9hwGMnUfedT5GJKBfOrGHmlXTQRwqT9yCY5?=
 =?us-ascii?Q?3e/fF51EJ34iptEWN7Opw7/uMGIj990QZQCpUyeTDZSa/kXAKlj0qm8tFQpb?=
 =?us-ascii?Q?IOFg3cGZczEZLsUaVCq3e+5yTGYmpXYm4sWX3iBSNO59qZ6H8WxXVTK+izmb?=
 =?us-ascii?Q?vbhLTUiQ9oOtOXUQRllKl6aQQKNd1fv/3YsqC9f5K1SyvQCsGHIGd/xxeN8P?=
 =?us-ascii?Q?XNkofkI49NpZsvZpBBH+sa26oorYQ1dUewA1gzDMdDHviyp1AbJx/l/BRO/E?=
 =?us-ascii?Q?bMJ+Cx7QKu6JTQPjWvYHI7xvw06JyuKSfJrTx0XINVvWSjcDMQ7OVT+y3Zrq?=
 =?us-ascii?Q?blWY+H6QC5DLRPgl8OBX9U2KdlV9+uyu+POs9qICpHseS4Xxby/rO8Q2Ztt/?=
 =?us-ascii?Q?F1lBD25wAecBtOVi4UvIQPJndR32X6WQk46Gl15t+AiCNFwDQmQIXsRU4KCL?=
 =?us-ascii?Q?1nOid2ycXMomd6sNqQxRRm2QvahtI1n073IxVjIEbizRFp1b2HJ4aW773zCq?=
 =?us-ascii?Q?VY6OfgcK4wmLFg2F998gfKpTiN+KpRCuSyfH0P+oHAXZ0qVQUyyglpjvsgD4?=
 =?us-ascii?Q?XRQNw/h+DPUxlYfi7YCoLTGeSXTA594fwkgxjZEze8TcpdMYtOhHXsKFIvZ0?=
 =?us-ascii?Q?2Dk3NB5faNWTidx3uMxxkfmwmTQImW7G/qyT/SgNLuD/Dg4db1I1JHjVHx5m?=
 =?us-ascii?Q?rRHd8D0xBSyaIVQ4230rDT7qtfJ33GqUfWvxnb53WyhhZrsJVff2Sk/GXIA9?=
 =?us-ascii?Q?ZY5XbuYlSi9qrw8KNq/bIGEszuS4AbRh0Zk+MIQLWRR7kklHQZea+y0KaM8N?=
 =?us-ascii?Q?8Ddixb1jYONRoKSKHNhyrsKPHgWbVULND+V8sxjY/UEUqs6bS8/sz5L6yVis?=
 =?us-ascii?Q?7hTYZ2oRZKnVvHuSmQ24qT1+9gWuUh6k/4+EMlekRfpbfwAx5YGPNEdOgGkG?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d91e85-0640-4be2-2790-08dc37367e67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:50:37.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUCEemQZYMEVrwrzl58iG/pqKAcq6gueuwTiNbCdBwfFqpJIbGtJC+rO5sxcWkoIgexybl9zJwc5sRkCF0mHVrC3FcSrLqOkeFJD/ds9LkX0uqUskW4LzJqo/sLyAghs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7588

In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
and kernel will not use the "classic sparse" to do the
__pfn_to_page/page_to_pfn.

So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
This makes the user applications (crash, etc) get faster
pfn_to_page/page_to_pfn operations too.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1 --> v2:
	   rebased to linux-next tree.
Resend   : https://lkml.org/lkml/2024/2/26/98
The v1   : https://lkml.org/lkml/2023/11/26/342	
		
---
 kernel/vmcore_info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8f77e238a54f..f95516cd45bb 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -152,6 +152,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(mem_map);
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
+#endif
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL_ARRAY(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
-- 
2.40.1


