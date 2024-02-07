Return-Path: <linux-kernel+bounces-56209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A948F84C75F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6443228493B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6720DCC;
	Wed,  7 Feb 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sysgo.com header.i=@sysgo.com header.b="CskoReOt"
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770A20DC4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.174.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298269; cv=none; b=P3K0li82zbntwmuR0E7xf0h5dCGVQdxZiu/FE0PW5qfAxBxjSnM+TvbhZqZ2IQaVPvihpSU5n7RVhwrLB0n2GvfEB7xOhSeoH0HgIiRwsyqCHs4Y/Fzzo5YEGA1w3z3DSRW7vnkMpTljLiZIbvFzs7nVky6uUrgFLClTYDc9rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298269; c=relaxed/simple;
	bh=UQCs7jF0QDQSQP4Z2zUkGNTRIkBTrs+zMEEISjMVJiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbcGA27vMChXiiCxDz1mJsEdqM0CXevjqiZIc8BmxcJTI+8+Xdxdmh1b1qEZ3MHjNvkVHXbIJJWwyUr8RXcU/D6227rq4FevAW3RPXTPJ8PFuNs1rPWuimmo0SjHaw9JXrTIIheblylkQhK/Yf3ioAW/0km51/pfb9T5zXpbUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysgo.com; spf=pass smtp.mailfrom=sysgo.com; dkim=pass (2048-bit key) header.d=sysgo.com header.i=@sysgo.com header.b=CskoReOt; arc=none smtp.client-ip=159.69.174.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysgo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysgo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sysgo.com;
	s=k1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
	From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=KR8loywrqe549dMcInpZZOzBTyI3NtTgoQfmDmuVi9I=; b=C
	skoReOtyGYZ/FpsY+JQS4sSZ2rN2xFwmOajdkGm6fMN+/W4Clv+d2oM5d7JYj5AsTMIMOPewKFMOd
	IU1rCukrBiqVBwgHkTl0poeprDw8i9sBI7m8e+nleBhh8qb3KFVUmiIa5lRmVMgUcu7Xwf+25gutb
	uBecXo58W5ZPmIhW5NcStxxnv0P9/39/3fZwq4iqYUVwjbg7WmozkCbOVwi/loctMHVC/5e3lBrm4
	OnWStqSKonITFjCzgFFppYKHQFtMXw6H40+bzT3E2MIh4bxQB7beiq3pOONgvgbDiW6DNqVFE9T/C
	mcAESjSM3cRgJjHs8O558cyJ6/qd0nA2g==;
Received: from lantia.sysgo.com ([172.20.1.5]:47800)
	by mail.sysgo.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <david.engraf@sysgo.com>)
	id 1rXeDp-0002N2-2b;
	Wed, 07 Feb 2024 10:28:01 +0100
From: David Engraf <david.engraf@sysgo.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: david.engraf@sysgo.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E
Date: Wed,  7 Feb 2024 10:27:58 +0100
Message-Id: <20240207092758.1058893-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e320a76db4b0 ("powerpc/cputable: Split cpu_specs[] out of cputable.h")
moved the cpu_specs to separate header files. Previously PPC_FEATURE_BOOKE
was enabled by CONFIG_PPC_BOOK3E_64. The definition in cpu_specs_e500mc.h
for PPC64 no longer enables PPC_FEATURE_BOOKE.

This breaks user space reading the ELF hwcaps and expect PPC_FEATURE_BOOKE.
Debugging an application with gdb is no longer working on e5500/e6500
because the 64-bit detection relies on PPC_FEATURE_BOOKE for Book-E.

Fixes: e320a76db4b0 ("powerpc/cputable: Split cpu_specs[] out of cputable.h")
Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 arch/powerpc/kernel/cpu_specs_e500mc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_specs_e500mc.h b/arch/powerpc/kernel/cpu_specs_e500mc.h
index ceb06b109f831..2ae8e9a7b461c 100644
--- a/arch/powerpc/kernel/cpu_specs_e500mc.h
+++ b/arch/powerpc/kernel/cpu_specs_e500mc.h
@@ -8,7 +8,8 @@
 
 #ifdef CONFIG_PPC64
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
-				 PPC_FEATURE_HAS_FPU | PPC_FEATURE_64)
+				 PPC_FEATURE_HAS_FPU | PPC_FEATURE_64 | \
+				 PPC_FEATURE_BOOKE)
 #else
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
-- 
2.40.1


