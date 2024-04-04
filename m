Return-Path: <linux-kernel+bounces-130961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE689898125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A06B24E47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E7481A3;
	Thu,  4 Apr 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="e/O+MMKQ"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABC40BE6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210402; cv=none; b=H3gD3Wzq0pKp6PNOAf8+S3cGN5gSjgjuJTeZbZ4X+TnFkB77PfbDzurGAgVlIXuZ9FbHbhA/9Gg/hHONZs2CObn+yatwRjZm/IOna8ZBZV2jxN8cwuy8wXp3jeO6I7ot/J2aL0FFXOZKE+YbB/kTbIjbi0p60n8XK0qUvsBQS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210402; c=relaxed/simple;
	bh=z9cHZ/qfKgBMB6NKxBmf35xFA5LdAxKDMWY91reJmhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGoHr7NWwCfpgs3aOxs3vCtKVxvdqB20F11qFJXv1DrrxFC3u2L3BbnRP1czGUfHlaIcp+/uk5zqIBF0qm2wqv95zYgS2V8QDs6vqiVlHP1HGPWZTtMScEU/dsCdThpBXGRz8gw1F/dIpNEx7ulZBEAXzmyWfIgG+s/kVL2UCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=e/O+MMKQ; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4345pec2024549;
	Wed, 3 Apr 2024 22:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=avXvV/YgaEweVfIX+OYFhfHn6ohAwRQj390NbocEzvk=; b=
	e/O+MMKQ4iBkNhp30A38D+LdknJ4gBqYNPz8sDUWqB6Rt7Ukq5HH3fmmTXaeqOSW
	OQB+sARQ+ugqCvyKn17GpHsqlkSB269TWH0w8LqUddYYZUPMDZGrD3EwcRpe0zHG
	c0td1NXEPL/Tl2na7+mxm6qLC3a6tWz0INVuIzJHralP2JkvQvbpMnJBmGFaIGiA
	zG6mArk8PZpPMQOSMGcg/lpSvcENYbwOBr+hPFiQTTgQ7R+yxmsB9oWhB0+rLRru
	FXmHScMmWf50Bvk2IG/6ogQcxccQdW8jH1U+1QI+Rg5crZQzXxail6DXDj4Qop9x
	7rU8L2+vFNNKcfCBp4pJVA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x9en989ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Apr 2024 22:58:43 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 3 Apr 2024 22:58:43 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 3 Apr 2024 22:58:40 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH v2 2/3] mm/slub: add slub_get_cpu_partial() helper
Date: Thu, 4 Apr 2024 13:58:25 +0800
Message-ID: <20240404055826.1469415-3-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240404055826.1469415-1-xiongwei.song@windriver.com>
References: <20240404055826.1469415-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pGdg9kS9SmD2FeZs-34uq8T6B03R4GKO
X-Proofpoint-ORIG-GUID: pGdg9kS9SmD2FeZs-34uq8T6B03R4GKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=929 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040037

From: Xiongwei Song <xiongwei.song@windriver.com>

Add slub_get_cpu_partial() and dummy function to help improve
get_partial_node(). It can help remove #ifdef of CONFIG_SLUB_CPU_PARTIAL
and improve filling cpu partial logic.

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
2.34.1


