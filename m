Return-Path: <linux-kernel+bounces-28416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B439082FE45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664341F27B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E9125B0;
	Wed, 17 Jan 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qyE3IUnN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8703881F;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453811; cv=none; b=S4vv+dnZEtziUTxTCK+0bvqngYvL29LScwaWRVPdyaSBwk1Zonry5vbpm28+0eSHsfg9DJ8ywuzm889PKpBLdmImdEFMUbw5BDTWYOBW3Y+BuG+u3wRXIPEzmt8fMkEeqyeHeexpt/teuPnmWx1FJBYD+x1vgQl7fiunuUZ3yBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453811; c=relaxed/simple;
	bh=pVMRQNIGeDoYkpfl9T3yFunV82OMlyMJoPN+08Vl4W8=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Zkm3onX51+pjAGk0mjn6e8ftaOv2NxqRkF6RY3FzncS0JiAokkjb+r/eoI7KvsVJNQGBZyGoiKx+VPabS4BEfGljUM7FGggVDqJy/SiDFp8DcNMJJiugIQa89DpQvDsMqVc7LdAEZx1ib0rIrwZ+d5SBsw8I2adt059JNYwUWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qyE3IUnN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ClK/v0rLso9Z/3FXbTXuYzr4YDDul4TOjSdON3U06CE=; b=qyE3IUnNbpQg8QAafCaeH3WBy1
	9fovh5jIgam0eMRhJ5/Hr5kJc7EgFDjXzY2o6yhAxzMpyKRtPQvFshWXZlGe+seDy/Tm9Q8NnMjTF
	qbsYo4T5FFxNW7w4axUhZAZx0T6+duHkxkJHnb8ODMsflkj9gXE6PDx17kr/twLNz6n8d/V9J2nIX
	uVyJOEHLarqkMtR85tzKBRAEdx8Li0kPxDTzaF+E3xc/BJA9M5/ZcCL76NpzgUDLNjULdbvsXRKsL
	6PgENL3b9sYthOEFr+fqaFb4pgJhK3Z5G/71OPsbAaJ39eS+SAmLFtoMCBklt1f5KDCvBUCAk2vPk
	K3Dos1jw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRV-00E6zu-0M;
	Wed, 17 Jan 2024 01:10:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 12/13] ARM: OMAP2+: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:10:00 -0800
Message-ID: <20240117011004.22669-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in a comment.
Use the correct function parameter name in a comment.
These changes prevent the following kernel-doc warnings:

omap-secure.c:61: warning: expecting prototype for omap_sec_dispatcher(). Prototype was for omap_secure_dispatcher() instead
omap-secure.c:191: warning: Excess function parameter 'clr_bits' description in 'rx51_secure_update_aux_cr'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/omap-secure.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -47,7 +47,7 @@ static void __init omap_optee_init_check
 }
 
 /**
- * omap_sec_dispatcher: Routine to dispatch low power secure
+ * omap_secure_dispatcher - Routine to dispatch low power secure
  * service routines
  * @idx: The HAL API index
  * @flag: The flag indicating criticality of operation
@@ -183,7 +183,7 @@ static u32 rx51_secure_dispatcher(u32 id
 /**
  * rx51_secure_update_aux_cr: Routine to modify the contents of Auxiliary Control Register
  *  @set_bits: bits to set in ACR
- *  @clr_bits: bits to clear in ACR
+ *  @clear_bits: bits to clear in ACR
  *
  * Return the non-zero error value on failure.
 */

