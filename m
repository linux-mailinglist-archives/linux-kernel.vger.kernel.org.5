Return-Path: <linux-kernel+bounces-16182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A95823A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49661C2437D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A846B4;
	Thu,  4 Jan 2024 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IB8ZWww2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2F4417
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K4FGLqD3uBdoWg9s/jHgykLgM1NMmD65870GHPhgAJQ=; b=IB8ZWww266mfUb+riNCgbPaAe2
	c2ojz9fx28CDtTRTKM5M/refK4xHzIMeSdWUZDmKdf0lKY9DtYwGhIATflFHpBg5XqSEJ1AxQfMdo
	WTUtWe18nvqT6tyy9dkYag0vNlDyiogiXrjv1r8N/p2O/EuQd7SQM7oj536xtCSqAlgpNX8tM1u+W
	jYFaWlKz5EAnDEnbdaviEswjnb9WOt7TLaV+hU7MKu5BIf+Jt/q7gdvrlLIA89pvtczzKhuJgPOAq
	FGlLDFW25xpsdPERlOiZfq8PY0ZzPMTCYlh8esK9wMkYGlyeeu+7frzByuIIwV/JsE1GcSH8nmsRX
	YsgKjZQw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLCbM-00Ca9g-1g;
	Thu, 04 Jan 2024 01:32:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] x86/entry: don't use kernel-doc for IDTENTRY functions
Date: Wed,  3 Jan 2024 17:32:51 -0800
Message-ID: <20240104013251.14440-1-rdunlap@infradead.org>
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
This brings the common.c usage in line with the more than 50 other
uses of DEFINE_IDTENTRY*() in the kernel.

This prevents one warning:

arch/x86/entry/common.c:211: warning: expecting prototype for int80_emulation(). Prototype was for DEFINE_IDTENTRY_RAW() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 arch/x86/entry/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/entry/common.c b/arch/x86/entry/common.c
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -188,7 +188,7 @@ static __always_inline bool int80_is_ext
 	return apic_read(APIC_ISR + offs) & bit;
 }
 
-/**
+/*
  * int80_emulation - 32-bit legacy syscall entry
  *
  * This entry point can be used by 32-bit and 64-bit programs to perform

