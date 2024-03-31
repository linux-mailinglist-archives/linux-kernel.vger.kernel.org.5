Return-Path: <linux-kernel+bounces-125936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E27892E62
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BFB1F21859
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03E8828;
	Sun, 31 Mar 2024 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fdSAbWLB"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826D613C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711854308; cv=none; b=SIYoug9PQruq94kkK0uJW9SKrsQvW373/9o+ZnW/WOTVfjXpIPL7FxfQxG75lVkbYhwjLuMXKWnDSY/Wb3djhxpgcvBrYjBZWdPkuK4rfn7R+iT+RAPEkMC6G17+uiYwYdpfHIiZp8om3Oxp2uOP30zBI7T+H1xuWNMWWxdcJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711854308; c=relaxed/simple;
	bh=9asL1uGTADUAnVvJmQ3LOM4Kjgl5Ou5eedmWn7dJca8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBdyTPR2sXkuCgTWIvF68JdOovv3GP3Z0wi9B10psykjnMrxoAiOlX05KCSE9AC71XEIqn/ctU9MLgCew8w54UnzE4pW4w56Mw9N+Dub7pFSqPoEv9sPCt8ts79nwDfoDMoAGJJb2jBJjeGMo1CZUnLCrBEqxrZ7Vu0czYljvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fdSAbWLB; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42V2ErUC022442;
	Sat, 30 Mar 2024 19:19:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=V/altOOb2D0h8LSKAVzpQh2XXjBbKxhhn3XS09HYYOI=; b=
	fdSAbWLBSS+chg9YVlYO/ndpwwt3aYThZnj5yegqrOhb0gx5vXUDkxIWMe9WbAzs
	hhWOsPLzs6BoptriCZSyWplzaJChIBv+c8+LeO/DqbHtBhLgzrJXaAfuYW/MDDzB
	dyf2zdyqosSdUGnfZjOpomBbPwlxotD0hRY5XAWsSZIlwSHDBPAErQdkl+i5umrX
	csDOzLjyAGGZbv1l7ZtzpsBr+BREaKPTDbrdqCnhxEGH5SZvtTnqPOkLepo+clNF
	jUj5r7nFhVD55nZaUzuz2qgEKEzRy6Re48QsagQxAKustc8RNHkKa4YAj/uoFyc3
	/bkgFPzFGEWVV5XVq/XFKQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10gm3s-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 30 Mar 2024 19:19:50 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 19:19:48 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 30 Mar 2024 19:19:45 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH 4/4] mm/slub: don't read slab->cpu_partial_slabs directly
Date: Sun, 31 Mar 2024 10:19:26 +0800
Message-ID: <20240331021926.2732572-5-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331021926.2732572-1-xiongwei.song@windriver.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B21bMmEqcagipPqRJ5Q2eJLVqbbmONO5
X-Proofpoint-GUID: B21bMmEqcagipPqRJ5Q2eJLVqbbmONO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=920 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310017

From: Xiongwei Song <xiongwei.song@windriver.com>

We can use slub_get_cpu_partial() to read cpu_partial_slabs.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index ec91c7435d4e..47ea06d6feae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2966,7 +2966,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 	oldslab = this_cpu_read(s->cpu_slab->partial);
 
 	if (oldslab) {
-		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
+		if (drain && oldslab->slabs >= slub_get_cpu_partial(s)) {
 			/*
 			 * Partial array is full. Move the existing set to the
 			 * per node partial list. Postpone the actual unfreezing
-- 
2.27.0


