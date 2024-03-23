Return-Path: <linux-kernel+bounces-112245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399A88775F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE32283364
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ABC9454;
	Sat, 23 Mar 2024 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lPPfPCCf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B123FE4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177650; cv=none; b=p2X7q13X7ewjpgEeUPOBFSDTQOmOLo7fcm2qDBStONnPp1bIxf24thjwELzNgDSjLtk7dHSDqAlm9sUOGhHm5d7yrJGeBGNe0MHaq768QZoICzXykEb3HX2t6/OSFIpYS/qCCrBycIirIAGbgbRKxB+OKzASVV+fgdD5Shm8B2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177650; c=relaxed/simple;
	bh=Vyzf/AZilWjnwBiifCxTTrnOxXQPtHnQmzXMKaVQ5SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1vj3bRLSfU9dfPnvLAdfzLTOTnGko74+2IDndw9Rknd26QStLvLLmPOEEDAIZt0dPtybfN+jDZFt1rs2rfJo4gPtqtcSff69O4oEdy/ROIG2Kw61P/N3OArh7beDOhk3qh6P2uYjVnrLmgCBR+JSKGVdSKSToLF7vGo+sh0vzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lPPfPCCf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d0y5m
	BBVvcsmNkmoRldur1L3xG4+xesheCa7IqGmu6s=; b=lPPfPCCfYor1mXps6Ef66
	uc6xlG51SFFrQ0iAVpmjbv/zRKvI9QibwGiWBJsVFAf8QsqzZ8D/xoz0WyU61xI4
	Dcy750FbGANa9nJ+ytmVTDxEWowCpjt/AB44gCLGuOju7zzCvzd3FyotI85Lq4s4
	NIZ+Y64wG1MOGg5gHapqQY=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDXv1GPf_5l03flAw--.59121S2;
	Sat, 23 Mar 2024 15:06:56 +0800 (CST)
From: LuMingYin <lumingyindetect@163.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	jpoimboe@kernel.org,
	LuMingYin <lumingyindetect@163.com>
Subject: [PATCH] tools:Fix a memory leak related to new_alt_group
Date: Sat, 23 Mar 2024 15:06:53 +0800
Message-Id: <20240323070653.611102-1-lumingyindetect@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv1GPf_5l03flAw--.59121S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryrZFW3Jr18uFWrGF4DArb_yoWkurX_AF
	yIqrn7ArZYqF4ktFWjvrWrX3yfKa1rJF15tF1rXr1SvFyrJF13WF97Wr9xCa1rtrWSyF47
	Crn7Ar129wnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUmFCUUUUUU==
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/1tbiTxSq92XAlCxApgAAs9

In the function 'handle_group_alt' defined in the file /linux/tools/objtool/check.c, a pointer variable named 'new_alt_group' is declared (line 1748 of the file). At line 1791 of the file, the 'malloc' function is used to allocate a block of dynamic memory for this pointer. When the if statement at line 1792 returns false, it indicates successful allocation of dynamic memory. However, when the if statement at line 1806 returns false, the program returns at line 1808. During this process, the dynamic memory area pointed to by 'new_alt_group' is neither used nor deallocated, leading to a memory leak bug. This commit fixes this issue.

Signed-off-by: LuMingYin <lumingyindetect@163.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index eb7e12ebc1d0..f5d8aa79e0cc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1805,6 +1805,7 @@ static int handle_group_alt(struct objtool_file *file,
 		nop = malloc(sizeof(*nop));
 		if (!nop) {
 			WARN("malloc failed");
+			free(new_alt_group);
 			return -1;
 		}
 		memset(nop, 0, sizeof(*nop));
-- 
2.25.1


