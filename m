Return-Path: <linux-kernel+bounces-24003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BC82B522
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3E2286CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9C5577F;
	Thu, 11 Jan 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="njpr5ebp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TVLeoSM6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762539F;
	Thu, 11 Jan 2024 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BI0pEx015492;
	Thu, 11 Jan 2024 19:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=L7OOCpTqUrsgINsrHoYRgEKhdwl58ZvICOwiKS3486A=;
 b=njpr5ebpL5PkM4Bjd8GkQAbaKFAOjmb/hgbWnZXFPL4Z8r5J6BTzDx8xRSHuC3xK1bEX
 gSfZtf8ERbdYsgBlsQ2DPmiM5uLGNnjK1/0i2+9zAM5vLj0GzPHup8HZ0GL5cj5yVZzk
 xQ2aduCYDAGps7ZOCZs3B4BCy13HfkPlAODS+OgyGeKGVP+pLRx0oGJLwwbnKucWdcC3
 MaTn4ybH/HOXGgHqrIyC+5sMPlglmQfhIjHCWfOPRnEW/cHWUxG+4GUWA0410dtl4BNE
 WPpuw+WqEzrf87j3F0rmeP2rcgNe4YtUgKJrCbeH7yZ+WPl+LpYp7XGYmkKsb/te6Tds +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjmnerb95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:18:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BIVob2030295;
	Thu, 11 Jan 2024 19:18:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutqmsp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLERjxgwPdnyUQ4sH7/pP5YRMzcEgNA6/i4D4m6I39XYDB6r1dMviZV8eKJ2zZ7/NSaucqNl/6xnrctKm2JJDVJR74d6rGqeBZXInyn7aeAoZdgwNgozGUuWhS03IrJx1wecq6wwOKT7xpNV3ZMUUeQGJ8vWC3GzNpInHqm9lY6NzDyHsTaj/b8FIOh6A7qHXSLM4SNDiDnr1tBTD2O6Fkj4P1IQRKNZ/XCX8nRipaTwS+yyypWBvMdIQFglZ6eDntAge+EmiZIdkRSc+tdIR+5Qy7euB2TiD0RPf9rqchpWS7o+lqnpFwYXCi4vrerRl1tlKRobWV2k/IgYH5cr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7OOCpTqUrsgINsrHoYRgEKhdwl58ZvICOwiKS3486A=;
 b=YVo08NoDYvv7cS+fjyvyUAqXhtsNFxojpSYB0bI6UP3DT1dna89//d3DjVLaUOvj1L2KOCBEGkdUv5XtedwnHpvgW+jvHPMJz55d9bDia5E54OBUzRzEKqfCNaPppHWt+zicyXtoSuJQM5dtqp0JsTlJkAeuDES0kD4IeKaAhrE4Uc3AxsUqEYq518Vol2BYD03CfQPHXb3cL3X9E9WjYZoY2F+WyikQauy6/xjKrzmop9eNWY+QLninT7+HShdXOo0ih2TWCsKEaAybpDg4V+VppmMVX5QgAW06FRQIQWK+UGrYFQsXlrSMVGzw6Gunt1uAQUc99V25I15WLIjBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7OOCpTqUrsgINsrHoYRgEKhdwl58ZvICOwiKS3486A=;
 b=TVLeoSM6ZbK2Uxpc38Bwx5DDlREzNsE+X7qHCGMIIjet5HnijF7J8W2cZDlmY4UO3/GNCnaf1fM8RhF5DHn6U2/IAINoeafcJNJK8OSlurMkVK9RFn+CO8/hkJRU3XdtG7m+a7U/A4gjV0H+/FoJj39ipmufTn/EpmJb8PsdIIk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 19:18:14 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::78b9:5082:241a:d1fb%3]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 19:18:13 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com,
        muchun.song@linux.dev, jiaqiyan@google.com, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, shy828301@gmail.com,
        jthoughton@google.com, jane.chu@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, stable@vger.kernel.org
Subject: [PATCH] fix hugetlbfs hwpoison handling
Date: Thu, 11 Jan 2024 11:16:55 -0800
Message-ID: <20240111191655.295530-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9e5565-3bee-4642-ddc1-08dc12da031d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kGme4RSNlUQu3ejR6mMxP4Xf4o990fxrrBIAdmkuoR6qwl4MHmp20KWeecGZ9FFgVWReXeuuESx1+MM/JVfi/D60g7TyLUp0ze2xsurAeyVYOdEN9sJGtoHp05QbPeemDz76DxrmNzV2klv9PHxpKThZVUPQKJoWRKp9eo3X5bj2rDIAaJsGmARXtv1oyaJiQAghVT77+IcAk+8ewWzRl6nXplWbkB+oL9473wslN+OR2Lob7dfJjLj1K3plswEWn+LCXInY8hJTDz0rS4tz4wWGk0WnQjB2d17Fvmib8/wG06Af0hXziJL/o+KIg/wn1oRDlRlNKFbvfaAasKcwuDMwlTvekjmYXi7zZzJg7NfdqGoYH6NCRfaH0fi/oDQDb6oIM/es1liivD66vZLR/ydCWYrS+joG+4FFTt+fFlkDS3MwyawGj956GXhVX61qMisOLhXK8EhEQ9f3S8qtNGBGWCgAGEpa/7zW9yzKVAleuDuF8ZbYTQzkri4YeEYHWSdNSyMSIHR9OJTCtxCT1piApyJyrbrPcL9rjMdcbaY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(83380400001)(86362001)(2616005)(6506007)(6666004)(966005)(478600001)(1076003)(6486002)(6512007)(4326008)(38100700002)(36756003)(44832011)(66556008)(66476007)(66946007)(8936002)(8676002)(316002)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+IXPlCVewnUpa6wEL3gD7k6fuhoW5ba95562zcl4VxIrqV83qseVoZwXfi2+?=
 =?us-ascii?Q?Ssz+NlWDLd4s+t5jbt+zBEwJmZJb5S2egwhaeaa+b7A1lhojvMgt5Tze7hch?=
 =?us-ascii?Q?DTM2dJOAweGKsaAl4tdnmxzZzG6E1CraEfAGADRAv39Oiq8901/nWJ9c1AIO?=
 =?us-ascii?Q?S+FIhHgYcA882tn1BpxCHGL7UVFHsuKsfXdfF5hyNmLFGoXqsArVDt2f4+jz?=
 =?us-ascii?Q?NMnGIPE/HHpKP0it07YcP1KEEHPOMO07X4oVo5uaBDxvWHhEvmN2xL79hCOX?=
 =?us-ascii?Q?iamzkj3ecO36gT7yP6hRSw7mh4mYjLAYsTVFHBrkTLH0w+McEnv1fXZDj6WP?=
 =?us-ascii?Q?+vpvXaWu9cD7ZRFVjg+goJsKy2/8iWMviRY0Ieau0uvXwTUovcV3knD63iQP?=
 =?us-ascii?Q?OQFrUj6eZaV7NJfXkyodPaovVBf0xg5c1eJzbnqIKbu4GTxNcImO9i6x5ElA?=
 =?us-ascii?Q?Q+3uwYLNDfHQulOiReedVvU6GZ6tVqk17c4EfaTMcsND9eQVhfNkya396Pcn?=
 =?us-ascii?Q?89zoeeqXDe5CehbuL2zQtfHq87+yLsGJwqtHQq1uwgWdF4r3b30C6W1FUTyu?=
 =?us-ascii?Q?SUzztC4QjKj7LmONFen5E8vON7Z8py1kxOWV/M249ZwXRfccUg0xzAyKayAf?=
 =?us-ascii?Q?K3TuC/5KbkcLU20crcr9/oW5ybx02Jhqa/8b2BS/V/Wqn5BA2adGtW/jIp40?=
 =?us-ascii?Q?xpu+3Ei52BrcGys38Ftf7FBsuaCRs0AYxKMoFIbiP/f2LwqCsJmOFeQClQ14?=
 =?us-ascii?Q?hc5w7wqbYJkNDE7Ql0dNogJqN9sXn7JBieha7pztmLI0CTCwiadCqcBrFUB0?=
 =?us-ascii?Q?EjkrPVKQZOtJGzz5LhkcCkK8Uu/uRtNlnQNXBVwrRjlr6sK81+3yEKmfGWQy?=
 =?us-ascii?Q?eE8XKCTcgERtoyDnfhtQ6dK0rBN+/7h3Aap2HEOoekx1KyNUkq8Jim7jILGi?=
 =?us-ascii?Q?owsvBWv4KLGf0EeJrKgs8407psHXyGyIToC+zTWogYxnHNxeI/WjNXhrBCz/?=
 =?us-ascii?Q?htyWcDcBIbIPXFFITnhQpfCIVOhXJC1VCg1P3PXtBFQFUnjFftRaP9UA/T81?=
 =?us-ascii?Q?Ibv6BPp/pMTmh3jkuz0oaOsOu/+fLSMGPglTS1ZZUdL4t636s1cHvhstQflr?=
 =?us-ascii?Q?BG+R4nzXotBitQvWCMGqtukx4y7tJiTao6XsXK2r6ZRqa8jeqXbptzfTW544?=
 =?us-ascii?Q?Ww73Mv3iDmcIsfEwzsevze1jxbAWevsWnwWvved4Ei8EcMSnmwadNOLvEORM?=
 =?us-ascii?Q?SvSxm/gOWFK+awBgY8HIMZHsdj4h52/9KgQISnwvowskighRMmkTMIxyZ2HA?=
 =?us-ascii?Q?hZ1rVGoYiObSEur9DBYcsTfeUoCJ3h+NxUR0M6zXh1+fGrFT/czLSoAI49nj?=
 =?us-ascii?Q?2uY+PNKE7iIwZNQyOg6H0WcSx2J5EPkgOKqVG9uqDh9uC3fEyDb4bKvliC4v?=
 =?us-ascii?Q?/l+A70FLIw3AVzvcXqhOlrXwP4emRkQJ9ddXg0MxBHqjQJL+F0n1oLwE+sUO?=
 =?us-ascii?Q?UyqK/2LbAH7BZGLjuOTDqiSpr74Vgw2BZp3pBcdCuB6IB3f5zDJ4FbybwsPE?=
 =?us-ascii?Q?0X5fxTbqKBmFxNA1gFc5ANrME4PpqMQL6BA2z8SlXerp9cBe3caU/oIvCzbK?=
 =?us-ascii?Q?0jfHHtOOQE/HjH9jZrPzlFo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FueayVvyLcs3MrfxW6OsxIgQILW1t35qSxKyJA2mOpUZhI999sIssuhrX6oAKKGp7p/tqFstMEkU83Z3vNsYsAGeu8OQDvnaZz+i8cf6xZbp3o/MrySA66vXxA06WGoPLIrDt9+rFADX3U5qhMVK26Dae35Pgvjb5TAD+rNrgs9qlyuzJAOdcOwQnOmS0dq2rxF8EK/t4FzyWO5JTM0P5XFRxA7MbFy0+N0jJNi4JvTbz/R0kjKPD6BOrLvcz/VClnrfjvT75CZxvKn3Q/p42zx7A7O3nMaI6hf+jBNH/oi7JKgBOG7P4vbBFIJOvcMnAh4XeZ9Bogp7AVtZCEzxnZsmdOJfexMrXzHcoarLOiTvSZB45ncoqsw9HlwYTIYqA/IfZswVlp2w2lpTPaWjroq+RDXUDUxmaipNH4fHmQRPRqP6PnWFL/3kdD/5NDARHsAFM9S71hwM/+UCo178edZ+ietdjrLtc5PE+RpuSgiZNRYtW32ovYITja4VKVdGLybdISF6PmAEMNkrfEzgyIVptVIh4OylxTuxh9Ihxz71R/sWjfNu1DdD/aev15Ge2GySV4dZa/vpLKeYEhiHvT8gjhBrl42Pkxt9ecQy1Xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9e5565-3bee-4642-ddc1-08dc12da031d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:17:54.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npAPbt4LlcxYhTxMM3XJmrZDylRzi1wz92xHdO8iRkZfr1c8irpD38easQfgSqjiWGVPq3dUPeU6dAXrTXhfBtEKlwlrQqhR38j5nDlnMeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_11,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110151
X-Proofpoint-GUID: KB6mb_EAjapkjNzdx06z8o26PF3bXqkg
X-Proofpoint-ORIG-GUID: KB6mb_EAjapkjNzdx06z8o26PF3bXqkg

has_extra_refcount() makes the assumption that a ref count of 1 means
the page is not referenced by other users. Commit a08c7193e4f1
(mm/filemap: remove hugetlb special casing in filemap.c) modifies
__filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
(including hugtetlb) where nr is the number of pages in the folio. We
should check if the page is not referenced by other users by checking
the page count against the number of pages rather than 1.

In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the wrong
flag as, in the hugetlb case, memory-failure code calls
folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is the
correct function to test for that flag.

After these fixes, the hugetlb hwpoison read selftest passes all cases.

Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
Closes: https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
Cc: <stable@vger.kernel.org> # 6.7+
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 mm/memory-failure.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 36132c9125f9..3a248e4f7e93 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		} else {
 			folio_unlock(folio);
 
-			if (!folio_test_has_hwpoisoned(folio))
+			if (!folio_test_hwpoison(folio))
 				want = nr;
 			else {
 				/*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d8c853b35dbb..87f6bf7d8bc1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -973,7 +973,7 @@ struct page_state {
 static bool has_extra_refcount(struct page_state *ps, struct page *p,
 			       bool extra_pins)
 {
-	int count = page_count(p) - 1;
+	int count = page_count(p) - folio_nr_pages(page_folio(p));
 
 	if (extra_pins)
 		count -= 1;
-- 
2.31.1


