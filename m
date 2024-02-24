Return-Path: <linux-kernel+bounces-79672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB3862556
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A63EB215D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645446558;
	Sat, 24 Feb 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CRdI5z4w"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611E45BEB
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782638; cv=none; b=TgCUXiYyba9i2Q9YQMpqWQenxpOfrsR1/FsY6FMdtyVSRV2A6mTvqbgYi9zEwTtrkEH/yPk10akh5w60YkaTSdvVZ/b0apfAvB2/Xh2zD64o33tzoDDpqeKirVgUkofrYtUsSboloZYWMv9CqlkuigXkmPEWw0frcFEs52lFRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782638; c=relaxed/simple;
	bh=LaJxDtd32yynnLkWyQqfW3yMF4S2UUgWOtITIbNfcIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CnedQ2uMbLGzOLEXNS6zZEPEYclTfB07dOS7UD51Am5eciLosuivC7ICsXGSoAYDDtvxUYKKJRs6jeWXJsMGgwjMsaImA/xyVkqyo50aIkseaRvYoO4M2+r/JqVtbQ/juFWU8fBbZg3RmAHCXE9IU10qBmImAFTrsMLqYWNdzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CRdI5z4w; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5S+cDXwG3tqZp5u5Q5yT544TdSeExm5GQVXBPA8TbL0=;
	b=CRdI5z4wyXGaRXW7B3YU+K3XEoJ+6PB9g8P4TCsBqqE9DHlSK09b7OaDnJbbcfXPiQfVJE
	7DHvuicpaYaMZ6MAVqhkryBNnF+Z5Y8o8RReW/EkxEwvrT1IBwX4wwV0X3UoFcG0S8UQ24
	7k1LgZm6iwWx5sygwgxx2toH+/CBzYM=
From: chengming.zhou@linux.dev
To: brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] openpromfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:28 +0000
Message-Id: <20240224135028.829910-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/openpromfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index c4b65a6d41cc..4a0779e3ef79 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -446,7 +446,7 @@ static int __init init_openprom_fs(void)
 					    sizeof(struct op_inode_info),
 					    0,
 					    (SLAB_RECLAIM_ACCOUNT |
-					     SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+					     SLAB_ACCOUNT),
 					    op_inode_init_once);
 	if (!op_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1


