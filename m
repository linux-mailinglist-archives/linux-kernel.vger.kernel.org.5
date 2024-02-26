Return-Path: <linux-kernel+bounces-80392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B08667B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82A81F21C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E717742;
	Mon, 26 Feb 2024 02:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bM/EhROD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941415AC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913120; cv=fail; b=QMVeXQp1N33v/LMcnlWI4jakRUfzt2jUjWUZYx9j7JfoY6p9fn11s+fzE58tcsFrioazUcjbf43cRf8bOUJhuuK0gE1JDa0PYDz6edinQ+H8AbriRvNhRdi0o0HPFnpZiiDdj0ifDfwgvaqI2zGZxYpJYt6AwSI1p7ILFIqCihI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913120; c=relaxed/simple;
	bh=UALAJ1oxBjjHr947/Phf/k+TYM+IUo4jihfVYyA2Y9M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YZAz1QFfCExG5kdH7z+LvayyCf1RhNjIDl3WvwXxNC4S2zyTv4YgQsz+XoRVGsxGJoUH5EF3heYJxNfblcj+qgbQrEcB2NOxX5UBfXYb4gLI2SgcjpMESjRyAAmw8+elOPEx83U7tpqpIXJjv9sBGijaWJsDhiCqV2SpCirirDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bM/EhROD; arc=fail smtp.client-ip=40.107.237.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+hfdkd5UTkvadPYU/qsfErXDAQW/XJ6s2iUACokA4potpZEqbDjsH3M4yGLR2HnvWRrxtowPv+CLU8cn5FsLFzrM43+rJmL+1XAjZlIxIZ71InNbxlKFDTuTXzw6lZo/oi1At+Yqg0qaJ1Lh/y3kf6zc5XiBPQZBxRvqpQEWda4iUUZny+6bPGylTHHr/1x4spJX0T4IBIlqSieoWTeDeRI1q89XlunuPbb5K64g/YWshrPMFziUAZ2QmXsiV45BP3pmkzLV62yKmUJj4bSuOVcPAaU2AUJRzISukQJuC2PXlsYjBDEtk46lt8Lo6dK7Z3Py2UYjm+vT6+IKc8E6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79HmkstDpPZXR9cKLFS06QcAmOKtmIb7fOxyDSLHeOg=;
 b=akW6SPQqaWN0TIYtPxEBJ5QVVeZKFrq3+0fg06xnX+vPUrmA5d7Jji2k9gRYtr3XgdaYPkUS33YLGb2c07/j+fFXlqDHLFy/EZyglTI3Z12mCBfmuEZk5v4QhoT32q3F74KXgM6qAfr8uN1OFwgToYQLMA1sKQzI0uyEY5dg32Cnz+flkuxK4IK8wv6XFRVRMeAPQ71GRE4XyX8n/pKTTc+60lYAmmRN5MY0J7C78NdKFo84uHUEtBosa7A/wEx2G/vCKSZ2KgU6nQM3Ru0TciN8BFcPZILuuYZqZuEgxfSk8/mP5HxNGTdvjKhk8ysK0Y8QMeQ1GsI4cp6UZ2pA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79HmkstDpPZXR9cKLFS06QcAmOKtmIb7fOxyDSLHeOg=;
 b=bM/EhRODTkJ9U3d9UVHIE+aJNeKYL8vOTxR7mlbohfXaLnQxIzgQ5BAO17yWl5AXT1gpdpbNc69Oku820GG3QFy/NaHL0V3MnQtR1YgjmbonhWoQNbek1LSSvLrMZ31tBNFUUO+xLsEIzhnaqv+jMSPBRzQ8NR5djbY+fCAh02s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DM4PR01MB7690.prod.exchangelabs.com (2603:10b6:8:65::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Mon, 26 Feb 2024 02:05:13 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7316.018; Mon, 26 Feb 2024 02:05:13 +0000
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
Subject: [PATCH RESEND] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP is enabled
Date: Mon, 26 Feb 2024 10:04:33 +0800
Message-Id: <20240226020433.3353-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::16) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DM4PR01MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0c53c1-c2ae-4d8c-ad2f-08dc366f5e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cl+DBi9TU5o0+rYsDowHhEVluBZPGmPKU4WBm9zT174HELkbIcYp5YSeMk/KZINQ5c5JLDXsC4kSlVHpqoqfMXNkSmfh/ATtj6Xe92TngOjH+L+9HiWsNKW0+6tS267v0lYeYGXwS5VpRArfHm5AdaNvMPJpsehxB3fv01790kM1jJbRMoh/fwn90PirHDDU1bEIM7UprgIUdPVYykBjE4Hwsfj4kBAWbDhfb7ogbKd56pzIaA7bO53uZCXUDbbd1SeCSajhknV2YNp3+sfnOFrjVpSWm99myObTO/pO4lf/WKv3eL4E242P0l0wK0sgT3Ej/oNDSGj+ber982OxFFVODsxQZiiLiAznMeY++M4ZkULZMm3yXEOo5v1lHzSjmZc227UMCvrzikOwPO4BgTNpOEkYAHcE+OlGHoajV136jsda/dDfhNETY4hgK5S/O9V/8zM0ALhXpTQewScXq40hLlkK4n8+EZHfSnQXlgR29dzTr/3vhLSUbyl5rZMvcvB/brY7+EStwhQsEZbXe73DarSqxa6Ba98ctvDUsMgHpVx/8HPQ9pV1tMQwR5YlsfwyYnE8VGp3W4E79Ajf5kOtAui+Kq0HA/VZ133d28z2m4aPyZM/GKsHikbrsBc2iI9/rvZmTzaI9JNvMdFwlFHI0ezCBdXrEv8xhoAQ9tSPJoEZssg804YaRrE/3JFVPnUNiGdsLZUAt7iNFjeYGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30sCXqoQzN+KsXdD+OOdo3WNkhQXNc2SjzOVxq9ub1ETjaa9DBzrDW0+LYqu?=
 =?us-ascii?Q?H1tdRiv2Vl1rpnsodlI7/K8DVT7FwVcVPZpunRT0K0VSYQL7d80teXeg3jU6?=
 =?us-ascii?Q?ARMAaiXJsZ2/TAlxUZXm1mKLpxoD9z4fTdlPa8JN0SJ23NiWvxHB6d2qBcdx?=
 =?us-ascii?Q?MTclw96cmRQM7gXpqHr6Xg/J1I66kA/VQV/dg01IwOOtjQSM42Vee5SQKvaY?=
 =?us-ascii?Q?/mIjZywEiRh5tI0JTB1hfBgr8ZEaTG/8G82J3C4NxkK/Mgv5Fo+KOyp6nk/8?=
 =?us-ascii?Q?m71/Vex6+0BR6T2kyoPt6IbYnOjZQKV3tcIfjkIWaekJMKfSGlUFyPRbOn9a?=
 =?us-ascii?Q?vwF0PdPKfvySdtrqmmmBuV9j41wlaYpms0jjzAJycSq7xMR798Xykrh6+pB9?=
 =?us-ascii?Q?vcjcb3/J23THUPiw06KHBF7N6NFYX1EIzvuTJWGFDuhI6XQVjyiEYzqMh7DC?=
 =?us-ascii?Q?4w64l6ljZljbFbXNluQ2WdUfSJB8k+aHcWK8IrqYl6gnIOgaDOszqD1mwNvZ?=
 =?us-ascii?Q?+WUQe6cmsvDU3bug9gILKsu/NEhIc7Yj2LtJ4CIa3ZzoHFwat1SVko2B0nzo?=
 =?us-ascii?Q?AE72bMzUsXD2Rnm3BNR9+Xqd0T8YmWuBczqLWfyY8H4tmuv5Ou5aE9B617R4?=
 =?us-ascii?Q?nR5U6jTprhHr3JiFI7hlS4nCm8v55FYJLGSRwjQveQPziARA9KAwsRnOIj43?=
 =?us-ascii?Q?zLemz0uzayAgzKRhBxYiWzcaBJL1cx0Nqb7gP4fcBfiENHg9nlSn+S4rDRix?=
 =?us-ascii?Q?sbNB60M3klKpPRRRBmnviN6BQXnFATXK5r4/3caYtm5O7uspF69empdq7PIB?=
 =?us-ascii?Q?y288nOYGU7VYZ6UKrJsyu/lBTBCwcaR7IwSUXdGm5dZkBzrhlRgkiOswnFCu?=
 =?us-ascii?Q?DQjz1+JTSd0XSathmXUCkLF9DdDuZWRghYzcog0WBCJpnwAET6VeWIk1wE4Z?=
 =?us-ascii?Q?/gRvkjVXnzEV13W8gL9QYb2Cj+UwYNqdLwBeFyn0Edbvv/HTlVCoPZDrH6pq?=
 =?us-ascii?Q?GaUbAP+qyTdvgwR61qcI0VtVGDhscg3yVc4cf4X4RMEOAwmcdfq0VdPngve5?=
 =?us-ascii?Q?TgCSDxLUCO6lvgqEsXrlwNWkB4Wq7dxXlhlckSiVz94+B42KlYI0UdTuYdtj?=
 =?us-ascii?Q?ssQNTmEVaSFGJ13osmQHfCvKWgsSOnpJ8Y9gE+1e6wU69OueKRh8fUo3NdNI?=
 =?us-ascii?Q?8226LzmAD/OKcCR7AYxr+tJ/LifrPUUO98863o1iavSZn9kKZ7Ykf8GZhpTw?=
 =?us-ascii?Q?/Q5ti3b+N7z42fDyMjdqixNmz/yQ6kSxdWtHxObQiF8anUTS4Vo+r5lqEjZY?=
 =?us-ascii?Q?JoTeetTxKTYWMqmUMNFqKaytMVUu8Jvsk47/pB6jzNwXLVrTwJDmVBKRlDfN?=
 =?us-ascii?Q?Ca1NM8UL5JxWECe0ZNRglWJAaOhdKXX1JmgDdioK4XvA7Pot3UAuN5LP1LFM?=
 =?us-ascii?Q?8r13h32ToerNAfKYLhPnd1iIQfCHvuYmc7MF6PPPNz+XTFJ5h5RPG7yhkDy1?=
 =?us-ascii?Q?phx80Q4lyccedKaOWI2eUqJ2a/qwqXvIi+kdWpWwp3oQXnRXyM9zi/39NhJw?=
 =?us-ascii?Q?tbAGgPbigLgMmfaEKZEL+fhKG/jkflzK6ZbuiWA4TimGmc89IjQwUhZ0giUb?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0c53c1-c2ae-4d8c-ad2f-08dc366f5e36
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 02:05:13.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k35nU3l1qX4igWgrHGLBJE/1t6L4hFEzGNKSqzKcBeXfK4YxFFYlDLE5l/glzJMd5IH1ZdeZyjZLVjQSzMsj1r08zAi7yfPEUwsEGlUiRNgSZEHMP8YB+jOGt3U7q/nu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7690

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
The old patch: https://lkml.org/lkml/2023/11/26/342
---
 kernel/crash_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d48315667752..d665ddc66fec 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -744,6 +744,9 @@ static int __init crash_save_vmcoreinfo_init(void)
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


