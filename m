Return-Path: <linux-kernel+bounces-115270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C4889C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C071F2EE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B979156874;
	Mon, 25 Mar 2024 02:26:29 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FD3120A1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329072; cv=none; b=YdHJrWoBwFPf/poBOragzSS0d0IlYu+8bKk1JJQfsCdvSG9noC6Vxg68ST+V3xFGJJfnberkMFcSy5fB51zgLLz7mJ+4vzwoMlEZ7Fj1NyJuxprIxNn/iwpDWXr/5K7yTmyfgNSiZNyTx2vgWy0UOru8GbGlw4L6ih/WhgHb3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329072; c=relaxed/simple;
	bh=/5iKxA+XBBw3FL3r9wcqsRKmwLwgzwO/tXhiuDn/qlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otdXCFry4JNOUOD+DA2eR5SS7JRDD5DkDJ2W2eU9ARJafQOE+NlSLTrUL7WlCIfQ36wtRj+QIt1Sc76b3ZTtBHfOiRupPyqBxR0ZltaLhyrImVhpTB6d9d7MCUmRXwkwReNwC86QznvNDjc9o46+jbCH+B/ChFiek1S7KKkGvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V2vxJ612jz1vxXc;
	Mon, 25 Mar 2024 09:10:12 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B979180062;
	Mon, 25 Mar 2024 09:11:01 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 09:11:00 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <ast@kernel.org>, <dxu@dxuuu.xyz>, <andrii@kernel.org>,
	<cuigaosheng1@huawei.com>, <ndesaulniers@google.com>, <vmalik@redhat.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] tools headers: Make linux/btf_ids.h self-contained
Date: Mon, 25 Mar 2024 09:10:59 +0800
Message-ID: <20240325011059.1001518-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Add the missing #include <linux/types.h>.

Fix the following compile error:
  In file included from main.c:73:
  tools/include/linux/btf_ids.h:7:9: error: unknown type name ‘u32’
    7 |         u32 cnt;
      |         ^~~
  tools/include/linux/btf_ids.h:8:9: error: unknown type name ‘u32’
    8 |         u32 ids[];
      |         ^~~

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 tools/include/linux/btf_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72535f00572f..7969607efe0d 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h>
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
-- 
2.25.1


