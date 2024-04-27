Return-Path: <linux-kernel+bounces-160936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388B58B44C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4F41F2258C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCDF4206C;
	Sat, 27 Apr 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QTYC1/4+"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF1044C66;
	Sat, 27 Apr 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202661; cv=none; b=GhDaDqVU1CTGq013RjbZLbyZ+bnGv5gGxBDVnVIu3ckoeII/GsLcjhc6v/RtARvDfeKbxC2PN+ebUezyY755dxrRIk8OQiMXLjvLxbRdBWL0HbVoQ/VwVosp2dKYRhdvFz4/owAmbIpik3tYberIo95Z3CGk+s9xaUd7rHLV62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202661; c=relaxed/simple;
	bh=kVpt3QCfeLtXIelAdzKX2iKyg7vRXdCkERS8lVfaMMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Znp7bzUyWqiPi1hvL7eOQ5jkeXZSXA7KtPzI0npT+sdYDQW9UvCZePriBOjCkJsRnsOgeb7vqqOT0/mSO9lzFrqSi3h35gFDZcyyTr2IOxYr7gbSXR7voy4OJrw3Iswmx7zHki44Gvn5+bKJjtRH0Nzoo55iAeu0jqWcqQkNFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QTYC1/4+; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=idpVf
	whektHky8Wqw0Sjx7L9bi6195lOk5IVtrio3Ic=; b=QTYC1/4+/z+87vx6EwoRY
	gybFcCijs1mUEnSOI6kHW/mwMrlXhX4jMu6196BiHtIvYoQ5ThTlR1lHSRhGmWwh
	5RJy1OAIKthHwAsw6lE5YtcKvNgq9ZTLKirA0xamUiRMDIx5c1OspDYMEvaN7Vd3
	jakqtpa8J/apTCmwI98guI=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDX_7sEqCxm42oFBg--.44942S2;
	Sat, 27 Apr 2024 15:23:49 +0800 (CST)
From: lumingyindetect@126.com
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	LuMingYin <lumingyindetect@126.com>
Subject: [PATCH v3] tracing/probes: Fix memory leak in traceprobe_parse_probe_arg_body()
Date: Sat, 27 Apr 2024 08:23:47 +0100
Message-Id: <20240427072347.1421053-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_7sEqCxm42oFBg--.44942S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1DGF47KF48WryDCF45KFg_yoWDArcEya
	ykG3WkJr4UCrsrurWfJrs2qrWqkF1rWrykuw12qFZ8J34UJr13W3Z8C3ZYqrZ5WFyqqF97
	JwnxWr1kuF1rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU01SoJUUUUU==
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbi6B-N9mVLbEsaYgABs8

From: LuMingYin <lumingyindetect@126.com>

If traceprobe_parse_probe_arg_body() failed to allocate 'parg->fmt',
it jumps to the label 'out' instead of 'fail' by mistake.In the result,
the buffer 'tmp' is not freed in this case and leaks its memory.

Thus jump to the label 'fail' in that error case.

Fixes: 032330abd08b ("tracing/probes: Cleanup probe argument parser")
Signed-off-by: LuMingYin <lumingyindetect@126.com>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c09fa6fc636e..81c319b92038 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1466,7 +1466,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		parg->fmt = kmalloc(len, GFP_KERNEL);
 		if (!parg->fmt) {
 			ret = -ENOMEM;
-			goto out;
+			goto fail;
 		}
 		snprintf(parg->fmt, len, "%s[%d]", parg->type->fmttype,
 			 parg->count);
-- 
2.25.1


