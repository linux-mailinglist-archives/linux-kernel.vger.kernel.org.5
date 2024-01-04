Return-Path: <linux-kernel+bounces-16183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74A823A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4073F1C24AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6B5226;
	Thu,  4 Jan 2024 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="koU84Q3Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14A5231
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PgI2mYoVs1GnN78ppMjwck2xWkBQIPMMPhE0a8pJ7wA=; b=koU84Q3YIvUJcpw/rxnhcCMBK4
	WXKI/NLF30JQ/CHc09fVpQDVmmIBYZIuOG0dVdrIjaCRJJV48ZSMzr1n6fTDcQn3K1ei7Fn23anFa
	R11I2a260BCXWRvZ2MZI1e/7ny8mlvhWBjI4ppWa0QnIWb+g0/0GF1nGUwAebWy/CVmj8DjnjhykT
	MYwVUv0w9F2iU5APR5fmq4avQM8/IClElkpYjSNfNyAVg/6MIavsqjpKYLbTkdgbbHU4pgPkQRGlq
	UFjrc6zLHvegIZLgPZF7v1j+65oYbGlQR86NHcf9aUHGBQpVRj7ljKSuhYT5diGZXCA6Y42Us/kGb
	0Cb3E7pA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLCbW-00CaCB-1H;
	Thu, 04 Jan 2024 01:33:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] x86/apic: don't use kernel-doc for IDTENTRY functions
Date: Wed,  3 Jan 2024 17:33:01 -0800
Message-ID: <20240104013301.14458-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc doesn't handle DEFINE_IDTENTRY*() variants
so it prints a warning when processing them.

In order to reduce/remove kernel-doc warnings from the kernel, don't
use kernel-doc notation for DEFINE_IDTENTRY*() function comments.
This brings the apic.c usage in line with the more than 50 other
uses of DEFINE_IDTENTRY*() in the kernel.

This prevents one warning:

arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 arch/x86/kernel/apic/apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2157,7 +2157,7 @@ out:
 	trace_spurious_apic_exit(vector);
 }
 
-/**
+/*
  * spurious_interrupt - Catch all for interrupts raised on unused vectors
  * @regs:	Pointer to pt_regs on stack
  * @vector:	The vector number

