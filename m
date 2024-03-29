Return-Path: <linux-kernel+bounces-125334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0B89243A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AEF284EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3F1386DF;
	Fri, 29 Mar 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z+BLPzDK"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11022011.outbound.protection.outlook.com [52.101.51.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467413341C;
	Fri, 29 Mar 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740524; cv=fail; b=my2PZkvLubNQjRvU0Q1koW01OOVUjR1lSrVuAXxEi7AnCi3+ucMO5u5F9W3dLY87lXf4X5LTnRM7OW3d8WCYIkjqF63gGmEA58tBnGmuI5R4wZoIRmlvr3Smy40sXzym7v/GaenLvAqC5OS83k63/mN587igVF4OVjNAe9b8IY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740524; c=relaxed/simple;
	bh=cIBz7W5o1CZDJeRt7wrn3QOaRx8Id1dxgRxxQWMfawk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EoenZ7Xw4/JUq3ySBWFSPrjmXFA6mpIGSZZylTL6HWThv3yEB6b67LpZ8IWK6zC4pTY3TFMl0RGQCoEKOUww+X1YR4lB1hWJFtE41QsGMGyCdtvCraRjH5cwg69ddXT/09+fPCv7gWX0tIjjATx2PXy5BzD0H+L69ICBJBF+nUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Z+BLPzDK; arc=fail smtp.client-ip=52.101.51.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMAuzSh7ZiLzrQhY+/hhE291TbF8/boIaHyEEPwRrw7Kdtqt8aTbFhWDocUPR8S3q/GkmdPcFPvTC89jpoYMlb35G9sblmYYD1+shJIftglceCjFMF+gXNi07kEUs82SjFJXhvvvzKJ6zb0GdhjK5lz7c5BFhN59jAOqbz16gKL3ZZ4G3Lc4zIZG7Pa0Qro97wtHpbM9+0XkAvjkWf3J8It11lzh58zKuulAp0S/mK7n0+KtSu9z+CA1s6g3rLrRDbTpL7T9HIRy+ax8mW2k8zlkI8GGhXaWhIIoeWL3ZkSP8rGqbRzyLG2dyQ4+IAWPXrdImCbL/MTv8goHcgcZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfgHic0BwJD+Xl5p9SUjRrjUsJ52eadoeUtUppsGN4s=;
 b=b9x2Q9aFJzeopff2IF13N5fBO3zDUSD4oOK61RFWcxihkhi7oZBoRN6IddyVbao3OCChpABb8xHNejD+JUBGm6V8/rKorJDzoxRsOAJ+f0S1EwRPY9q0awdG5dAQTxEodQl1IZ+Lyg0aO6avxNzxSn52AdX+OWItMVF2t9/Rw8uzMGPDKme03tEh0ShCnoyuoCXOup0QH0zodNgF4BuQlMElnarAYM7OcNd2IoXdFttNrIB3+sVldCITuVfVTK+RxbU4KF3japhEJ2OBjq1oz8Kn4YF8lr95TG4kM9ZR1eQNXByHj3gsYPM0tQdEYvcT6+fW+XuG6SqgefA7fg9+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfgHic0BwJD+Xl5p9SUjRrjUsJ52eadoeUtUppsGN4s=;
 b=Z+BLPzDKRN76BaLh50pHJeWlQAw6fbWXWggSsgccc3wvG4aavFQ/UGD8vp1SqdWzGSd4T+FWEnsNJhL6tBHu4mKIwR984hl5FNr/KePUm2gQFLqDh0s7leFd395cNaFgWI3oLMjOY21pVoAVatazyAENQhUrgfPZEMkr5sLd4co=
Received: from SA3PR21MB3915.namprd21.prod.outlook.com (2603:10b6:806:300::22)
 by SN7PR21MB3937.namprd21.prod.outlook.com (2603:10b6:806:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.17; Fri, 29 Mar
 2024 19:28:39 +0000
Received: from SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::7ecb:6139:8f1:fb7c]) by SA3PR21MB3915.namprd21.prod.outlook.com
 ([fe80::7ecb:6139:8f1:fb7c%7]) with mapi id 15.20.7452.015; Fri, 29 Mar 2024
 19:28:39 +0000
From: Dexuan Cui <decui@microsoft.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	zhangpeng362@huawei.com,
	iommu@lists.linux.dev,
	mhklinux@outlook.com
Cc: linux-kernel@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] swiotlb: Do not set total_used to 0 in swiotlb_create_debugfs_files()
Date: Fri, 29 Mar 2024 12:28:09 -0700
Message-Id: <20240329192809.17318-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:930:10::26) To SA3PR21MB3915.namprd21.prod.outlook.com
 (2603:10b6:806:300::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR21MB3915:EE_|SN7PR21MB3937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0Ruw7LmJYx7VHhQJ8eX65wvdVu720279FH7kG0/dN+qEmeSMczQqTQRblFcqjeflC1Yz7tecFeZf9p0PjsdfzipAh7OwfM2vwzoHu0xy3O5IUUUkAHYjU4NJrG2Sry53/DaME7v4W5Hl7BdrlkN676mUp2a98WOiOgIKop4rot2elZ8UJLZQkaDmGDzpq1mM9IO5WZmyfxFA6GiNoRmA8LTuChNtmD1OFZh1lZgvkJ0xs99RazlOBKaQKsqXDqMbh4kMRMQY5XjaogoLEnM2Psn8xyhqt7EEb5PVGmXSSW62pRQw91Vizr4vlLvCiovXHo+CIQ1l3SlkEzUQ+AI+j4N5dR1I69F7MSadcFcp6wbv5chIWIHNNcBGl0ct7JVk+xsDklWlrX6rlrRTkioSPhShnz2oo5sQQSyWOEwf7bKv2xXjaQls2XEOppbzZkkwESEgqcaar/CiveAFh6Jj5/O62OZw9W29Irz4ntVmU56XthAz33a/On1+EUJsjlKlkX+76v/aJ5ei66DtyQWjGaYTwOovvN2jyr4KGVQDN+Y/xjSom16qGDhmayE+FjkDBcjhFWP3W0kqLClq6GhgOYBKMRBd4GIFRVkZyekN0PY6z10m8javhLOhuu8lWhIs/1Ju9+mhjQrNsaNG0qjttdn6lbZ3BWcQIUjHjnwzME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3915.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ATrlUO8UR5PCb22221JBNknSHNiLoUqlR0oH3JoYwCoEpft3tT0/2VNMLi59?=
 =?us-ascii?Q?J0ca89Ipg12MkbJ+fxOsq+6Cb0uj/X3RQodJNo/Bvq09cU/mjgJxQ4JbUJY1?=
 =?us-ascii?Q?vugKIZZVIG2R8CULrOfEpGBnhamGimaQAZOylSKszYG5fhKig63XBMc88ShS?=
 =?us-ascii?Q?Q8GriY9nXYNxZy8DFiaL8brCtiD2bpMCnq4E/afYr1kYQ4EMW1Ie11mgdio2?=
 =?us-ascii?Q?ZDADZhIVs90nQF70njmnvnulihyTUhXe29MujbVO+mxpscIo23+N7RHqULqW?=
 =?us-ascii?Q?BjJ5IViNYcDE1Iu8Kd4HvWMO5HCCrCRE5zNH0SuXGGlIz3wlbmyBRteeT+Vm?=
 =?us-ascii?Q?263hrv6oB6bBHDDyXTIdy7fipAwcGEnRN1W5dflZOqGazOSireG5UPOIrVlS?=
 =?us-ascii?Q?lO/oVTRJ8guMNa6l7lOBCaVB+nUzaNzFT4a2T7KGmQnnTizQkZcuzF7g+AQm?=
 =?us-ascii?Q?QUb+LPw2gHKt/OjkEAnNqBcF7G0CReMVphoro/UGoep98ATTKNP28gHdhypr?=
 =?us-ascii?Q?XINsJCYT+diPy4xAz+PJ9NsI+3D4oUzKf34BkzU+RjZyJ4VWGltC2cfpniZN?=
 =?us-ascii?Q?10CQ/zlBNl6xYRpuD5pe+GsPgxt4UmeAq1PAF9uyHBNu+ApzZqLl7VikxG2O?=
 =?us-ascii?Q?Y4IHFH09WH/fo0C4o0CZp71fWT5kI889n/rGb5tL8rOpTjmUqZE+4d5KEI91?=
 =?us-ascii?Q?jNyVTR3q3NUg36H3pjwsoQOYuqgRxLue2nhZ5JVuYWbh3WgWg6zbgZl32P61?=
 =?us-ascii?Q?Y+0oKeOj+nIoj90Rln9OCQx/PguqYoA+RrHUkb3MGLCqnhgikTATtGdPrV2F?=
 =?us-ascii?Q?hV3B2Ozp0BZrEq0C3YDos/fDjHa5+Lz895XSQCRn6nSGktC3E/+u3TgiISiM?=
 =?us-ascii?Q?60sTpehNF99/7hW3ioFWx8u5/Ea/I17piEv7IaNnxxPwxM3Ac7f9t/CyY7SB?=
 =?us-ascii?Q?WXd3Tyhri/PEoux3G39uBPWzNy+80aN6vhQ8nJdlbQ6uAIWejJmwhHygCMM9?=
 =?us-ascii?Q?nOquv3c1lbCNz4UqLtaBal8eff0qfUePM2uk4/dIPpQOFw8Qe4D1LxgvQvBT?=
 =?us-ascii?Q?Ms5NabCP8wTqQx6T9f966eTAdT6z7dXM9Fxiu+IIG+TedDcJXbyTIYo9t1FV?=
 =?us-ascii?Q?8QQVdvPRUPZ/ersV/TAMIP3iTiSMhUivnpw9hpW09RKDICT+R3oynpO68gM2?=
 =?us-ascii?Q?tkm8SvkbhPqdhIYKGP9Dk6SSzrPtDxYsxlxTekfF1zZd/mqvA6pTzAFiKeyl?=
 =?us-ascii?Q?wVFoNWbjX710r5GEwecJMuZFugxvuq3JQfYz3iXBMdmJ1VSu12njtfO6M549?=
 =?us-ascii?Q?Tz44d8SqlpP5j3R8CkeQuLIIllZtw4VkaK4nL/s/kVYEfo8y0RETDRJjS3vx?=
 =?us-ascii?Q?4khil76iqO7vrYBEtzHVxdj2KaMwTLXdfiDxUdMOueXRL7NPpCGEXJAlRWEY?=
 =?us-ascii?Q?9AxBTd7OdaeWSQhpHsC4qp6t/fj5hDPjpanmRERuxFjGQxXwET57htvMx6Sf?=
 =?us-ascii?Q?9PB/E6K3q6dOQYO3X3Z8uCtVVZPh1TeOZfEGiabbeMRPRL8WIgTBC5KgPisP?=
 =?us-ascii?Q?MXEuHZYtP603lxJ4D78vWZSMrokGLl834rQU2qRLo36im6OJbRzQOp6MjlUW?=
 =?us-ascii?Q?/unJbmcWI30/VrXB1oC59OtWoEYeLZSk2W5CaN9WxwYb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaa8205-6460-4a4f-757b-08dc50266fa5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3915.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 19:28:39.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wse6Y018XX2Ym6yLlTAF5y+pqVyvbbtaN/0g9T1GVIIA6jP9DRKuJtiAuN0qYBaN4EMJ8RrlRSRAZ1/yWmuMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3937

Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
which is actually a negative number if we use "%ld" to print the number.

When swiotlb_create_default_debugfs() is running from late_initcall,
mem->total_used may already be non-zero, because the storage driver
may have already started to perform I/O operations: if the storage
driver is built-in, its probe() callback is called before late_initcall.

swiotlb_create_debugfs_files() should not blindly set mem->total_used
and mem->used_hiwater to 0; actually it doesn't have to initialize the
fields at all, because the fields, as part of the global struct
io_tlb_default_mem, have been implicitly initialized to zero.

Also don't explicitly set mem->transient_nslabs to 0.

Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water marks in debugfs")
Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient pool usage")
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 kernel/dma/swiotlb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..4a9f02c13da6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1647,9 +1647,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_hiwater, io_tlb_hiwater_get,
 static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 					 const char *dirname)
 {
-	atomic_long_set(&mem->total_used, 0);
-	atomic_long_set(&mem->used_hiwater, 0);
-
 	mem->debugfs = debugfs_create_dir(dirname, io_tlb_default_mem.debugfs);
 	if (!mem->nslabs)
 		return;
@@ -1660,7 +1657,6 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
 			&fops_io_tlb_hiwater);
 #ifdef CONFIG_SWIOTLB_DYNAMIC
-	atomic_long_set(&mem->transient_nslabs, 0);
 	debugfs_create_file("io_tlb_transient_nslabs", 0400, mem->debugfs,
 			    mem, &fops_io_tlb_transient_used);
 #endif
-- 
2.34.1


