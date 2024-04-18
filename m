Return-Path: <linux-kernel+bounces-149440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911D8A912A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944D9281D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347B4EB32;
	Thu, 18 Apr 2024 02:22:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C71E48B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406949; cv=none; b=HrfWA31Fqh0V6IFFPYrTjF+BsxWadk03btbnd7ItUV1uVLFkhXQv9sGn5qcK/OrpyLJa4tNKQcpcmhYdCLLWIV9MvOEVOAUEbuVHSa2iHbUVYYMsClDe3Aci64FemlfzHZcaTPD6KPUAxvGaXd8YmdBjlDYCU4E7qLIm5pRmSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406949; c=relaxed/simple;
	bh=zzCPQyIdeQnudS1XCHRDf/rB1lKso65za+t7hBJNm3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TFzgQ6B53ICbexJr7rmrPcJlelmpGJkNWnWzxbGA1P2QLkYYzOaP+TH3xMkuQSP1WSoyaZ7EbV9pJhVtVQttzhcemrEy6v/hl0+nbD5iot1FALlubEQZH2ozyiKHvhGvU4SGzM4igpWSNeybbA9UXJBBdJYXo0Zrn9CboLwoN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKhNL2FtRzYdl3;
	Thu, 18 Apr 2024 10:21:22 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id E641618006B;
	Thu, 18 Apr 2024 10:22:23 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:22:23 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <david@redhat.com>, <vbabka@suse.cz>, <willy@infradead.org>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mm/hugetlb: a few fixup patches for hugetlb
Date: Thu, 18 Apr 2024 10:19:58 +0800
Message-ID: <20240418022000.3524229-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

This series contains fixup patches to fix the issues I observed when
I did memory failure tests.
Thanks!

Miaohe Lin (2):
  mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
    dissolve_free_hugetlb_folio()
  mm/hugetlb: fix unable to handle page fault for address
    dead000000000108

 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.33.0


