Return-Path: <linux-kernel+bounces-143433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527498A38FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AF71F22AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC67152534;
	Fri, 12 Apr 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R8f/G2ap"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E11487E4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712965314; cv=none; b=h+CWmEGcow5YqcigMzNFXZ0Daes/n0JjnmZwytVm2rbyMzIwXuhppKCI035xBuv8kcLDj2B5x8viXsow9Ux0J4W2xOLHQGKnPHP306Mfh8FNkla+DbeTemnuKRVJZPoSvNjX+R96K0jBQ5hK3TkXo67OzjkFgUbGxEjhEMgs20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712965314; c=relaxed/simple;
	bh=6pQVUvS7PDMEdreKmLs1VF23tmvgXoTGy50ip8xGNZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMWPo5okWyVAaghgpLJT9Vqk8sptS9lWOcy1MmcJCqjONOXv2L+RCwHpfKVN9sCuVuiV0rL+kDlBXWu1YVKsrKv/iKt/ZAROIU4N16cJl7zc+S3+eVWzNUG6XcKiO3/aaxtcuNBPQT2Q1o2Yx9rIDVqu2spK3koKlU7e5Guk3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=R8f/G2ap; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43CNewXO1106754
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 12 Apr 2024 16:41:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43CNewXO1106754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1712965263;
	bh=d1s8ofOUvwo6/1leLihcfYYM2FoneKCZzHrcTwSNRVA=;
	h=From:To:Cc:Subject:Date:From;
	b=R8f/G2apzaY/vaFRGDNS4fehkUaZbMS5zXl+w+L/Crw3CM/a7ECFHj4ZkPKNmgW8h
	 V2cMeVypDkyGFFa9WXMp7M+JTj93xo5STF7nGng6saOXrlmVPIhwG7TaO86ReUSmeE
	 akpgr9DjtGC+GuZwPicvMt0Cdbwyu0gvf1LtmNNalT/hDVIZ409HrQVCj36qkBKKl9
	 GwXUhbJTydHQzRRnfdNz7YPrObhJ6i66L3teB4X9eQgiWUEfyyObDLJVLAvdLzFs5x
	 puGeD7otxVyRRRY/qU0n9g6xXgtu184EZahYZjyn3ifGx3N4ZoGO0pH90v6SWeAco/
	 MricPwiMcp0vA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Date: Fri, 12 Apr 2024 16:40:58 -0700
Message-ID: <20240412234058.1106744-1-xin@zytor.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 55617fb991df added a bunch of tests to the int $0x80 path, however
they are unnecessary and event wrong in fact under FRED.

First FRED distinguishes external interrupts from software interrupts,
thus int80_emulation() should NEVER be called for handling an external
interrupt, and then int80_is_external() should be skipped under FRED.

Second, the FRED kernel entry handler NEVER dispatches INTx, which is
of event type EVENT_TYPE_SWINT, so the user mode checking in
do_int80_emulation() is redundant, and should be skipped.

It might be even better to strip down do_int80_emulation() to a lean
fred_int80_emulation(), not to mention int80_emulation() does a
CLEAR_BRANCH_HISTORY.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/entry/common.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..aed745fc8333 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -174,6 +174,18 @@ static __always_inline bool int80_is_external(void)
 	const unsigned int offs = (0x80 / 32) * 0x10;
 	const u32 bit = BIT(0x80 % 32);
 
+	/*
+	 * FRED distinguishes external interrupts from software interrupts
+	 * with different event types, EVENT_TYPE_EXTINT v.s. EVENT_TYPE_SWINT,
+	 * thus we should NEVER get here when FRED is enabled, and then the
+	 * following APIC ISR check makes no sense.
+	 *
+	 * Furthermore, the external interrupt vector 0x80 is available as
+	 * a hardware interrupt under FRED.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return false;
+
 	/* The local APIC on XENPV guests is fake */
 	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		return false;
@@ -211,8 +223,14 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 {
 	int nr;
 
-	/* Kernel does not use INT $0x80! */
-	if (unlikely(!user_mode(regs))) {
+	/*
+	 * Kernel does not use INT $0x80!
+	 *
+	 * The FRED kernel entry handler NEVER dispatches INTx (panic or
+	 * oops otherwise), so it is redundant to check user mode here.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    unlikely(!user_mode(regs))) {
 		irqentry_enter(regs);
 		instrumentation_begin();
 		panic("Unexpected external interrupt 0x80\n");

base-commit: 86d1b22a75cffa50160e4621da00311e6f6f48de
-- 
2.44.0


