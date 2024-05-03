Return-Path: <linux-kernel+bounces-167130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDF8BA4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A349B22678
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BCD29E;
	Fri,  3 May 2024 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWcgzLCo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597D2F41
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698585; cv=none; b=d/pbHk5fRIZFZcmdx+//7GIokvXYFHesXu6dtP4v3mnY7KTggBPxuR/k+1LUvHM/S6KDnZy5XqEhCRjg7zd0mInsNMfdzTVtToJed/K93XnhrbJ1FO/Nu1l8e2pVtizgPTXILABW1ebQ/2Ke0tpbEFCId/h18QkHBG9WoGNnHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698585; c=relaxed/simple;
	bh=iFTpX5SCz0cGBxWlRc+gGDKI6re5O4JvIvLA7Z/r8l0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YPfpx4UGpn4mjFPzxByEkj0CbR2uMsKF3Lzfz6oRd8aOcQXOdWN/Dq3pY7bNxxtnM3bBexiNTPx/oIzonjIjGjtZd8IaVxCXwKJqqHwB0DEVa8yluCQsiBP1cKxBqjo0U/umiPZE+e9dVm3CcH1KWpp7cr1IymLCs5QXYYZ1tVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWcgzLCo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442MYgZj012962;
	Fri, 3 May 2024 01:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=SOvRaCHY7bt9fC7qYTTsBnsQzRZD7sei+4AUOOD1e8k=;
 b=SWcgzLCoKoprCz5eH0JHybg0yOvc1q1lNvjMNrhZGP4OapN23OsbPzYIPwGq9sqEzfDg
 SDnWFSQSEW6K3eQqSi1dkyThwx+HWVrfMixxiE2JSxro/OQb7lurm9bmqW9QA3e7noTW
 x6CMwHfbRt2/8zxdHVix3A9L0Dvxrt2EuoLaBvAkkEk2QMlxR0t5EVuzTFjhO0tqCKEB
 EoO9zHmGzY3iOa+++Lse/06ojVLNLKojfHS3J1lae/iUjvlycOQeTvcji38rNiSat495
 QK0qsNB9/Tf+6WYEa3h0YcrFuJc/81zqb6laSpSextqXLNcuicCAAwO5voL96FCvyDKI wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvyaeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 01:09:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4430KuIh006237;
	Fri, 3 May 2024 01:09:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbp7xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Fri, 03 May 2024 01:09:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44319NBo035083;
	Fri, 3 May 2024 01:09:24 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbp7xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Fri, 03 May 2024 01:09:23 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, willy@infradead.org,
        prakash.sangappa@oracle.com
Subject: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
Date: Thu,  2 May 2024 18:21:09 -0700
Message-Id: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_15,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030006
X-Proofpoint-GUID: XZp9uBYBIBI46k7qNuUGbkZdyVssn5-1
X-Proofpoint-ORIG-GUID: XZp9uBYBIBI46k7qNuUGbkZdyVssn5-1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch proposes to fix hugetlbfs mmap behavior so that the 
file size does not get updated in the mmap call. 

The current behavior is that hugetlbfs file size will get extended by a 
PROT_WRITE mmap(2) call if mmap size is greater then file size. This is
not normal filesystem behavior.

There seem to have been very little discussion about this. There was a
patch discussion[1] a while back, implying hugetlbfs file size needs
extending because of the hugetlb page reservations. Looks like this was
not merged.

It appears there is no correlation between file size and hugetlb page
reservations. Take the case of PROT_READ mmap, where the file size is
not extended even though hugetlb pages are reserved. 

On the other hand ftruncate(2) to increase a file size does not reserve
hugetlb pages. Also, mmap with MAP_NORESERVE flag extends the file size 
even though hugetlb pages are not reserved. 

Hugetlb pages get reserved(if MAP_NORESERVE is not specified) when the
hugeltbfs file is mmapped, and it only covers the file's offset,length 
range specified in the mmap call.

Issue:

Some applications would prefer to manage hugetlb page allocations explicity
with use of fallocate(2). The hugetlbfs file would be PROT_WRITE mapped with
MAP_NORESERVE flag, which is accessed only after allocating necessary pages
using fallocate(2) and release the pages by truncating the file size. Any stray
access beyond file size is expected to generate a signal. This does not 
work properly due to current behavior which extends file size in mmap call.

To address this issue, hugetlbfs behavior needs to be fixed to not extend
file size in mmap(2) call. 

However changing current hugetlbfs behavior could potentially break some 
applications. Therefore this patch proposes a mount option to hugetlbfs
to choose the mmap behavior of not extending file size.
Use of a mount option was suggested by Matthew Wilcox, 

This patch adds a 'nommapfilesz' mount option to hugetlbfs mount option. The
mount option name can be changed if there is a better name suggested.

Submitting this patch as a RFC to get feedback on the approach and if there
is any reason that requires file size to be extended by mmap in hugetlbfs case.

[1] https://lore.kernel.org/lkml/200603081828.k28ISgg10244@unix-os.sc.intel.com/


Prakash Sangappa (1):
  hugetlbfs: Add mount option to choose normal mmap behavior

 fs/hugetlbfs/inode.c    | 19 ++++++++++++++++++-
 include/linux/hugetlb.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4


