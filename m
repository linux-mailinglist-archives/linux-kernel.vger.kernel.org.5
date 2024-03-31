Return-Path: <linux-kernel+bounces-125935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F62892E61
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C056B21618
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420936FB2;
	Sun, 31 Mar 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="evi5XKC2"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680E611B
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711854306; cv=none; b=XC6jv7vteRZwCwf2SUWKdqV7Lpzv7dQdrnunih8ChX3uy8GfluruD7ESKa18HbOhT+nfJrc3u3R8j9VR01EjCoosyCvLubuDhpGZ+pqpvFh8iPPffOYyeTgKuxQiMftllOBxB/Kko08k8/srusLLjMFWhwuNfYa1wWkWwRMKGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711854306; c=relaxed/simple;
	bh=fwLFyQuSH1gL8p6WaXgbRYKSM1p4Sx+SaEHfEfPX4XI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6vvdGMFi8bbw75kx1vexXCpwgfOdS2F1bWYVZSQ5AqANvqOY/b0JYSJAsjhAuZ9SrlsCFm7M64jTZ226KsIe0z9M4e7Pza1aGFybFmkHzlNis4caMf7f0rX5u/n9I2J1v3ngdbGagcg/u/wCKH1+uzNsnhuu1FgI30ZIz4R/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=evi5XKC2; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42V2ErUA022442;
	Sat, 30 Mar 2024 19:19:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=6dTBj4eAePEk7EZjLkudl8wd/noflYo3XXpEzzrtWEQ=; b=
	evi5XKC23wD3nJcSTkMWrx+SEmKoxdC2+aHFehlWCsfxi7BG+pEc3+q9cw/brZDR
	l5t5ys3LgGnS7AjW4EBPojNbp6WbR2zztVQm+nOUzi9D3DtmM+AoC2XXYoW45aYN
	SD1fWkXiJGi5csyth6AzoWWR0R8SjIOUXouqUSY9TCy54RplOT2noUEPfAsQhl66
	JxYYGoCdFS9GsHAfx3j5vhtWdTT16k345tlgQN1aQ2EeFDRQAASJ9Bodm8feRzlB
	4igfZd1Ewyz0blMOSyQfhMM0B6+IAHGxpkCw9Eb5fb75wC9mBLrvDk9ThWWb6yBK
	Dg2oJqVM6YUvJ/ilz2zXow==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10gm3s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 30 Mar 2024 19:19:49 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 19:19:41 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 30 Mar 2024 19:19:39 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH 2/4] mm/slub: add slub_get_cpu_partial() helper
Date: Sun, 31 Mar 2024 10:19:24 +0800
Message-ID: <20240331021926.2732572-3-xiongwei.song@windriver.com>
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
X-Proofpoint-ORIG-GUID: OyBtIUl3wnHYanDd12DLcgj5PDGeGo_z
X-Proofpoint-GUID: OyBtIUl3wnHYanDd12DLcgj5PDGeGo_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310017

From: Xiongwei Song <xiongwei.song@windriver.com>

Add slub_get_cpu_partial() and dummy function to help improve
get_partial_node(). It can prevent compile error when accessing
cpu_partial_slabs with CONFIG_SLUB_CPU_PARTIAL disabled.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 059922044a4f..590cc953895d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -604,11 +604,21 @@ static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
 	s->cpu_partial_slabs = nr_slabs;
 }
+
+static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
+{
+	return s->cpu_partial_slabs;
+}
 #else
 static inline void
 slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
 }
+
+static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
+{
+	return 0;
+}
 #endif /* CONFIG_SLUB_CPU_PARTIAL */
 
 /*
-- 
2.27.0


