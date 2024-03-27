Return-Path: <linux-kernel+bounces-120589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A348488D9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACCEB23AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CCD36B0D;
	Wed, 27 Mar 2024 09:08:52 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF603611D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530531; cv=none; b=GPOr30RBkQMNLSmkLn5Sj+yrlCah8OOXMTiBlfkU0zWPVmUqqJQGWB528/5TSVs+2DS5B+KR38ZJ2x5Ga4dJGr0DtW2tye/+f5PrEzUcDBAfl/iXNCUw8yzXCMMyXK1n1/UhEN98NfRIV+hE2qfdAVscUpcLH1VK0RgauY7SYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530531; c=relaxed/simple;
	bh=/toiUyRRKpHhrNq1RW8Qw0KewFXk6dt7DT2RMe/GA2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECR/DUBm0ermn/fOUvDCyOt791bXeB5n+gGE/MGDlGCASRw0QiMYUKJ7vEBD3HtIttj1JqBGL0dyh7AxMmLlCXkRIEPTH1iVHQB4RYFhewur4Fsey811pPBuCVkSVlR36sR3ICQcLcEU2IIfWoniTjuulFKqHetGRIseBPj9rfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V4LQB0LQgz1xsqX;
	Wed, 27 Mar 2024 17:06:42 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 69422180062;
	Wed, 27 Mar 2024 17:08:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 17:08:41 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <peterx@redhat.com>, <david@redhat.com>,
	<axelrasmussen@google.com>, <surenb@google.com>, <lokeshgidra@google.com>,
	<Liam.Howlett@oracle.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
Subject: [PATCH] userfaultfd: early return in dup_userfaultfd()
Date: Wed, 27 Mar 2024 17:08:35 +0800
Message-ID: <20240327090835.3232629-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

When vma->vm_userfaultfd_ctx.ctx is NULL, vma->vm_flags should have
cleared __VM_UFFD_FLAGS. Therefore, there is no need to down_write or
clear the flag, which will affect fork performance. Fix this by
returning early if octx is NULL in dup_userfaultfd().

By applying this patch we can get a 1.3% performance improvement for
lmbench fork_prot. Results are as follows:
                   base      early return
Process fork+exit: 419.1106  413.4804

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/userfaultfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..3e6ddda6f159 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -657,7 +657,10 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 	struct userfaultfd_fork_ctx *fctx;
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
-	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+	if (!octx)
+		return 0;
+
+	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
 		vma_start_write(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
-- 
2.25.1


