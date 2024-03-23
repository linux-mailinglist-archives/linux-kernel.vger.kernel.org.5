Return-Path: <linux-kernel+bounces-112238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9864088774A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E0B21633
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757B8F7A;
	Sat, 23 Mar 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g8o5R0RT"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91734C6B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711176973; cv=none; b=LAUQroTx4h4vNfqh/T1Ps+LrRbzOdaZprTeW7gb/E9H+mY3ejUa65hp73XoeMWeO2brt1e65YJiNbm/Hr9pVL814hRQDXVGHg3ZijJL8lS5uaJwzrZ/mqu8KxRHufvInZQRwHoMzwANIcF9q/iJT0BcKYBggd3JILgtB8el4RyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711176973; c=relaxed/simple;
	bh=Mg83579z+YfI26BJr+EMVKgNqskLLWbJSibN01Sq6KA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOTfDJA6uFQmX/P5Hdrb0ECJ4SIy/0lGylV7/riMy1B66EipDOpwp3bspy4r04mxolZg4dsMjJm7sqQ3Pa6J/TGUHT67osFQ/4LlWoT7rjn6frGYnL46CLkk+nlmpcCIhoUf/m844wuEnEwxuc1flOExZhzLZfAJ4ZUPyP80cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g8o5R0RT; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/pTXn
	hJNO0rvGZyVon+/V5qCy/Cr3WxVq6gLtqlZkAo=; b=g8o5R0RT/kDPU0GvBLxnE
	K+hkDbeFydeoc5mb8f/JKws/yKxMu8eSpokVA6aln5vunMz2oLAUgPogv8/JvSC8
	m1GOnFQfmxgKWkjlGUlyR4bn5ojWgflgHw+Lt0cEJO2TdJpklxkKRn+8TDRmdI5v
	XqRxzEPME6paQdZz8XPC1g=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3H036fP5lMHXdBA--.31160S2;
	Sat, 23 Mar 2024 14:55:55 +0800 (CST)
From: LuMingYin <lumingyindetect@163.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	LuMingYin <lumingyindetect@163.com>
Subject: [PATCH] tools:Fix a memory leak bug related to the cmd
Date: Sat, 23 Mar 2024 14:55:50 +0800
Message-Id: <20240323065550.603005-1-lumingyindetect@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H036fP5lMHXdBA--.31160S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3GF48uF43GrWxZr4rAFb_yoWfKwb_tF
	yIgr97GrnYqF4ktas2yrW8Xr1xKFs5Xr1kAw4Sqr13u3W3J3ZxWF97ur9Iyrs3trWSyFy3
	uFyrXw1fArnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREuc_JUUUUU==
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/xtbBoAuq92WXwXfQ3QAAs-

In the function 'disas_funcs' defined in the file /linux/tools/objtool/check.c, a pointer variable named 'cmd' is declared (line 4583 of the file). This pointer variable allocates a block of dynamic memory using the 'malloc' function at line 4615. However, after using the memory area pointed to by 'cmd' (line 4619), it is not deallocated, resulting in a memory leak bug. This commit fixes the bug.

Signed-off-by: LuMingYin <lumingyindetect@163.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index eb7e12ebc1d0..486a2a6374f5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4617,6 +4617,7 @@ static int disas_funcs(const char *funcs)
 	/* real snprintf() */
 	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
 	ret = system(cmd);
+	free(cmd);
 	if (ret) {
 		WARN("disassembly failed: %d", ret);
 		return -1;
-- 
2.25.1


