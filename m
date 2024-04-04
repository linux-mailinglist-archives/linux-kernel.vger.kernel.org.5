Return-Path: <linux-kernel+bounces-130960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDABA898124
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A355A1F237EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552147A7A;
	Thu,  4 Apr 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="LQWk9X28"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A991AAC4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210402; cv=none; b=EPrJqPOHC230mTCfDNG3W+i0vq6kaQntlwfzwKzXOfzB9nFTqL9q4EASehM+5h6GXAzVFRX8FKWIxlagIq5o3R2kzjKhdN4HusW6HwXpoqkyz0oq8JE+kzdXxsj9o8FtG0hzR8IFCOwLv45k9ULgszT1j9simTh2DqiEemNBYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210402; c=relaxed/simple;
	bh=I3q6yVYBdZj07ZAoBMkaBCIOYYEJTB/PxNQpx5q2RLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vF3ytxRAM9zqjG36kLiwP4876PBSjG9ZIUJE0Q1Pjcgk7Jny+Tl14ZAv7+E69PvOePJNnqiNHutEj3pGf6LKUEIsa4wKyynEOPDj07tjpjqUnDTzNmz1oDzJ+FwJuP+ll6O1FTbC/GjYm4yaTGljzFM0mYFcvNy+Gnd5KjdIZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=LQWk9X28; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4345pebv024549;
	Wed, 3 Apr 2024 22:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=JzMC+
	xaaHDfEUWStF3GoQ8L4qd0hy51lD7Gp6f+vDlc=; b=LQWk9X28x0k3fiAy2nYr+
	vNc5xoU0GLH1rD3rtnutOQdqmpBrWVogfXLv6w499gfC/hZ4bxn1LN6Cww01n2NA
	8wmj0mRBs/0Mzjrv/zSVJuN9wLhGixDzQNfEw1g88San7qI5x9bFhmF43NnGs22i
	+5GlOQLI4+JmIt+F2dyRTcW3oB5cQYRNsc1kUX5lTaLkvirqG2BrOZYIKtFkqnXH
	qkYuWHCFvqhU3XGvNjsnrwdqXrxKs9w2vuWeqP8FDiBDjC/eKuMgCxWFKXVUJsoe
	a5Xo8CoUeTk2qN6HsueRi8bf75BK+ydT5Llds2LtvsV17PsHr0eqvrDmsRMirnND
	A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x9en989nd-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Apr 2024 22:58:36 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 3 Apr 2024 22:58:36 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 3 Apr 2024 22:58:33 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH v2 0/3] SLUB: improve filling cpu partial a bit in get_partial_node()
Date: Thu, 4 Apr 2024 13:58:23 +0800
Message-ID: <20240404055826.1469415-1-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: egbsAAJQbBIeDtFjvDwn_eOLTJY5t8Fe
X-Proofpoint-ORIG-GUID: egbsAAJQbBIeDtFjvDwn_eOLTJY5t8Fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=788 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040037

From: Xiongwei Song <xiongwei.song@windriver.com>

This series is to remove the unnecessary check for filling cpu partial
and improve the readability.

Introduce slub_get_cpu_partial() and dummy function to remove #ifdef of
CONFIG_SLUB_CPU_PARTIAL. Please check patch 2 and patch 3.

Also add the comparison in patch 3 for when breaking from filling cpu
partial loop with ">" or ">=". For more details, please check the
patch 3 inside.

No functionality changed.

Changes in v2:
 - Refine the commit message(from Vlastimil Babka's comments).
 - Refine the check conditions of filling cpu partial(as Vlastimil Babka
   suggested).
 - drop patch 4 of v1.

v1:
 - https://lore.kernel.org/lkml/20240331021926.2732572-4-xiongwei.song@windriver.com/T/

Before v1:
 - Actually, the series is the improvement of patch below:
   https://lore.kernel.org/lkml/934f65c6-4d97-6c4d-b123-4937ede24a99@google.com/T/

Regards,
Xiongwei

Xiongwei Song (3):
  mm/slub: remove the check of !kmem_cache_has_cpu_partial()
  mm/slub: add slub_get_cpu_partial() helper
  mm/slub: simplify get_partial_node()

 mm/slub.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.34.1


