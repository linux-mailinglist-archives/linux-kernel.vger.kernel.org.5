Return-Path: <linux-kernel+bounces-105675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510787E273
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78C8282447
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64CA1EB21;
	Mon, 18 Mar 2024 03:17:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696F1E865;
	Mon, 18 Mar 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731839; cv=none; b=FQ/yt/e6KIAzlVqXhPLS9uWLROcMP6Lrl8LZxCMdaamkr6QS46wEF7twN4kbCT7sD46+v2Q8oAq4PMfivGwfD6rhuV+xpzKdOkN8tLEh5PtvFLXQphZglbpUGXkNY95OvmXhXnMIE5x2R00QU5iyQCaLuNYPu+o1OnBbldV/KKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731839; c=relaxed/simple;
	bh=JxHyzKSpcWogjOmX5TD6nVEEdmlE6Nwx0hjXyPziLnA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gA/bvqtaEEnMhuBvDViu5twKfG3RdyJkuUwIS0dgUTG32lUgTW4Nfg+JZkGv6Xz7JiKGy+O/ALAR9vJaInXQ5OvmumS5Wt0+aNcd/B+QzddGDswsZ9KSjT+FA3u+7BScjyoaG+j62F9WDSKoPy7ccdlW/5avR77Je4/ttJUoG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tyg4j3Pg9z1FMmK;
	Mon, 18 Mar 2024 11:16:53 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BB781A016C;
	Mon, 18 Mar 2024 11:17:14 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 11:17:12 +0800
From: zhangmingyi <zhangmingyi5@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<liuxin350@huawei.com>, Mingyi Zhang <zhangmingyi5@huawei.com>
Subject: [PATCH] libbpf: Fix NULL pointer dereference in find_extern_btf_id
Date: Mon, 18 Mar 2024 11:16:25 +0800
Message-ID: <20240318031625.193590-1-zhangmingyi5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)

From: Mingyi Zhang <zhangmingyi5@huawei.com>

During our fuzz testing, we encountered the following error:

Program received signal SIGSEGV, Segmentation fault.
0x00000000005915bb in __interceptor_strcmp.part.0 ()
(gdb) bt
    #0  0x00000000005915bb in __interceptor_strcmp.part.0 ()
    #1  0x000000000087dc65 in __wrap_strcmp ()
    #2  0x0000000000951ded in find_extern_btf_id () at libbpf.c:3508
    #3  0x000000000094d7a1 in bpf_object.collect_externs () at libbpf.c:3712
    #4  0x000000000092be3b in bpf_object_open () at libbpf.c:7433
    #5  0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
    #6  0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
    #7  0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
    #8  0x000000000087ad92 in tracing::span::Span::in_scope ()
    #9  0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
    #10 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
    #11 0x00000000005f2601 in main ()
(gdb)

tname = btf__name_by_offset(btf, t->name_off);
if (strcmp(tname, ext_name))
        continue;

tname is passed directly into strcmp without a null pointer check.
When t(btf_type)->name_off >= btf->hdr->str_len, tname is NULL. normally,
that's not likely to happen.
Considering that the bpf_object__open_mem interface is a direct API
provided to users, which reads directly from memory. There may be an
input similar to this fuzzing, leading to a Segmentation fault.

Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 604368cfbf02..c65d2f2abea4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3944,7 +3944,7 @@ static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
 			continue;
 
 		tname = btf__name_by_offset(btf, t->name_off);
-		if (strcmp(tname, ext_name))
+		if (tname && strcmp(tname, ext_name))
 			continue;
 
 		if (btf_is_var(t) &&
-- 
2.33.0


