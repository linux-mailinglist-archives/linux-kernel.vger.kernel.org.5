Return-Path: <linux-kernel+bounces-65935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00338553FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364D72841F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499A13EFE0;
	Wed, 14 Feb 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xhcLvxaz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZw0Tm+8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B8213DB90
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942583; cv=none; b=TPcW7CAR8LEfacGROruOKYRaBIMRqR0NqQKtwoHAYlYRpnEFAHrq16Z3gQKeMGI/ruLDLB5j6y6z+T9o9VlF+MsqMwvHZq+UXsoo3JmX4hUcoLa5usTU9R8kfhOe5bgzN69DfVsSCQON8XcxxsKNb+DpXNAgfDptxxz8m25gpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942583; c=relaxed/simple;
	bh=9NdmQygr38FbiHDYmFLfzBnl/u63Eh+Q9S9G8cq7kRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ux5yETlhzK2LAmDS5TUylTlbCENHFu6FQyK6TzfBOf1dE/27FoWWKHOyriP+Nf/0bAK7Y2aUbGEvWNH/f3MsD7s412e/QoX0J1zT51K63GvjnLZsdBduoUk1buemPwFBoP/H4+VAUoves+hSyvk6ngcSbSFLgGe0silgSbB3+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xhcLvxaz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZw0Tm+8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707942580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84DJubKwwkVblZgKUQAX4uwehqMLPuVWy1ICL4A8hAk=;
	b=xhcLvxazzaE1dROiMH/ERLqgOue+3QcLQ1B/e8IPOZp7F6B6kUnv4pwTRTv5rX0UEDDFxp
	KR79lXhvzKJ+n196FIEjJRqjbKG8WD/58ZOYhcThlC2HOj720Knb8lOSb9zkkBNDP7N9R5
	6d3sBCowopQz85eLbEFpTnr0hyBMlBARsiLCOm+B1cnPO1wgi5nsQLT+RFKEyPIJkF+Vpc
	lKopqC+1B93t/DSSjjIuzpWUrTL9YD1gklVKLe6PE8a0sUXLRmG/G8nVdFUCdLiqmNjHzP
	lso4SNOkaVZh9118ITP4bxkydmCxXqe0PltdFEzdAfxBbiqN0dsBx4QyD6EemA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707942580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84DJubKwwkVblZgKUQAX4uwehqMLPuVWy1ICL4A8hAk=;
	b=FZw0Tm+8z8lxOrjR3P8S2W4ZOylyjyf2dSnTeLm+iTNcCJZ662bY21EkBLXNCusfN2RVbT
	CNlniJOjX1SigEAQ==
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>, Dimitri
 Sivanich <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kan Liang
 <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, Andy
 Shevchenko <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Wang Wendy
 <wendy.wang@intel.com>
Subject: [patch V6a 01/19] x86/cpu: Provide cpuid_read() et al.
In-Reply-To: <20240212153624.516965279@linutronix.de>
References: <20240212153109.330805450@linutronix.de>
 <20240212153624.516965279@linutronix.de>
Date: Wed, 14 Feb 2024 21:29:39 +0100
Message-ID: <878r3mg570.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Provide a few helper functions to read CPUID leafs or individual registers
into a data structure without requiring unions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V6a: Use CPUID_E*X instead of hardcoded numbers - Borislav
---
 arch/x86/include/asm/cpuid.h |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
---

--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -127,6 +127,42 @@ static inline unsigned int cpuid_edx(uns
 	return edx;
 }
 
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
+{
+	regs[CPUID_EAX] = leaf;
+	regs[CPUID_ECX] = subleaf;
+	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg = regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	BUILD_BUG_ON(sizeof(*(reg)) != 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {

