Return-Path: <linux-kernel+bounces-50218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43878475EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77A1B24546
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D414A4EE;
	Fri,  2 Feb 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="Fs4qqqnl"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DD5FEE6;
	Fri,  2 Feb 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893907; cv=none; b=qpIkfHBkyyeFZeRWpten5AFapGx4W8EN3RIv1VGZ2kP3Rfe8ECizy/x0ALMMdqezMcNRgC38CwLLDzGw0Dq7FVYwKw4+anZsGf8c1ObQWCtj0L9Lu32XwJNEyVBFzkQe0huOqYv/4363fCwFX8bD5DLZPcmZpISDVPC5VgV1jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893907; c=relaxed/simple;
	bh=p/cssrwWO4JA+lysWQPVqrAGJ0msE/E/7wO3Tnhk2l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwCqmD0ElhEf3RBmG0iWsin2bArCHxQBkv30wy0CPNB+RytFE2Hmp5RbtiuSl18Di3L1jly+iA7KOOufh+fR6S8TH3XU19m9CyWs8PTAwMEehCndAsDPH+LyRgl8sxs4LbiyhMA/xh7IKKXWP3Rd75Y30BYwG+m6JYV0uK+6aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=Fs4qqqnl; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 530A1DAE38;
	Fri,  2 Feb 2024 18:05:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1706893504; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6xv0ghtBWKci3ltFD1w38GyDNGgkmxE+GwKbqBNa0b4=;
	b=Fs4qqqnlwdzstMLeQMich9y4y19YmkMxpUMCLUV3S4+yi/GsqqSRfuNvsdyvJxi/TA0yGX
	63LxpEl8JTRHqLYqvJ5KBD0LfgLUYfBr2Rb1Oe/9OLjAW4msbxdEMS7j0a3d5M3f8GfvUO
	s8XcLGoJW3V5iexXOyhh91tsg9jUC/6Jc9LHVAHU8vM7jR3c9iUi6gF6uZBkLeZaxZAR54
	Wq0ZyEJa5YxhoGlC0dvisjmNLzMtJdmbrZIyDqKoFyaCozbKXx3eLwVvYWnQ2XKLEf+uUw
	x4zieMty50pirlKTav4T27EQ8PzttNMmBdpp2wXX+ffs/eFwP+o+Irj1Wzm/Eg==
From: Daniel Wagner <wagi@monom.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	stable-rt@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] Revert "crypto: scompress - serialize RT percpu scratch buffer access with a local lock"
Date: Fri,  2 Feb 2024 18:04:57 +0100
Message-ID: <20240202170457.29516-2-wagi@monom.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202170457.29516-1-wagi@monom.org>
References: <20240202170457.29516-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit 0cb152421350004d4dcf3a4523d88c002d0a7973.

The stable backport f8f261f9ade2 ("crypto: scompress - Use per-CPU
struct instead multiple variables") replaces this downstream workaround.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 crypto/scompress.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index c2f0077e0801..968bbcf65c94 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -24,7 +24,6 @@
 #include <linux/cryptouser.h>
 #include <net/netlink.h>
 #include <linux/scatterlist.h>
-#include <linux/locallock.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/acompress.h>
 #include <crypto/internal/scompress.h>
@@ -35,7 +34,6 @@ static void * __percpu *scomp_src_scratches;
 static void * __percpu *scomp_dst_scratches;
 static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
-static DEFINE_LOCAL_IRQ_LOCK(scomp_scratches_lock);
 
 #ifdef CONFIG_NET
 static int crypto_scomp_report(struct sk_buff *skb, struct crypto_alg *alg)
@@ -148,7 +146,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	const int cpu = local_lock_cpu(scomp_scratches_lock);
+	const int cpu = get_cpu();
 	u8 *scratch_src = *per_cpu_ptr(scomp_src_scratches, cpu);
 	u8 *scratch_dst = *per_cpu_ptr(scomp_dst_scratches, cpu);
 	int ret;
@@ -183,7 +181,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 					 1);
 	}
 out:
-	local_unlock_cpu(scomp_scratches_lock);
+	put_cpu();
 	return ret;
 }
 
-- 
2.43.0


