Return-Path: <linux-kernel+bounces-28419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B082FE48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC2E28CAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759E12B6C;
	Wed, 17 Jan 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHwc24/N"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FE522E;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453812; cv=none; b=FAJKB/CHo93fCp4zAvgnkf6e4IXleoTfFa1OTQ4ar8QXenHYUwyfgTA0irhIifWSN6Fj5AVl7U8G+ymA16t2+WXtHrCQ1m+uAZ0cQIA+7k1Pgl/v/uMxv0bRMejxn8kf8f8YvyU9/X4yGrwuLdTTkYTY2K2/fSn7dE9G74EDXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453812; c=relaxed/simple;
	bh=CSqPH5+UdLpUNxxzaocE3enGj5LEBrTl6eFIglSfw7s=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=YlbrPtzi5/b1neBmQUNLe0nIW9Hwx0HlM5i0MjncN9ntypiqJqF8ERmOdZs4qXYxJYP2DsNIxnqxQJ6w7K5Ergk6pdbppx6yyDQo3wUDhTeG6gzsMjRCd38YY2gRovtlupNxyBuJZhb5mgu+X0fMVGpJilB7tLsGQ69i4p7Phr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHwc24/N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZuLCJOP9Ph+ZIWn7AJcTrgpLCTTV7YzBdRszbkNK8Qk=; b=bHwc24/NIpoVG22MZ7F+PZ5q/S
	jeD4DKPA82VAaU6o9lylfychFfL5oJoIL1suzKbi8K1T/Qb9VfnVuf8vtdk4G5JZ60aOsojOH1HpQ
	FXu8BjZLQPVJIkmdFTety0SCkztgRv3ulobRogUvjCI4QShUGr3JdbUpGMKyMVxrwF9cCuunaN6vU
	vFKJoSmBZmIinxYaJa1MMMJc4r+gB2kMT+sbEmgHN68YJ6dQ6JIglfsFVM9dfR0BB4fThxpElFjhl
	C4zLlJQlhW4ezwwkAlYT3Pl904IGsLJU9N0KGt+Q2rNXEpnCudrVoMTBrN26A5nzictdPMz3IjcdG
	p7ItG3KA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRU-00E6zu-1r;
	Wed, 17 Jan 2024 01:10:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <paul@pwsan.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 10/13] ARM: OMAP2+: PRM: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:09:58 -0800
Message-ID: <20240117011004.22669-11-rdunlap@infradead.org>
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

Use the correct function name in a kernel-doc comment.
Add function parameter descriptions in 2 places.
These changes prevent the following warnings:

prm_common.c:384: warning: expecting prototype for prm_clear_context_lost_flags_old(). Prototype was for prm_clear_context_loss_flags_old() instead
prm_common.c:505: warning: Function parameter or struct member 'vp_id' not described in 'omap_prm_vp_check_txdone'
prm_common.c:522: warning: Function parameter or struct member 'vp_id' not described in 'omap_prm_vp_clear_txdone'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/prm_common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -370,7 +370,7 @@ bool prm_was_any_context_lost_old(u8 par
 }
 
 /**
- * prm_clear_context_lost_flags_old - clear context loss flags (old API)
+ * prm_clear_context_loss_flags_old - clear context loss flags (old API)
  * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
  * @inst: PRM instance offset (e.g., OMAP4430_PRM_MPU_INST)
  * @idx: CONTEXT register offset
@@ -497,6 +497,7 @@ int omap_prm_clear_mod_irqs(s16 module,
 
 /**
  * omap_prm_vp_check_txdone - check voltage processor TX done status
+ * @vp_id: unique VP instance ID
  *
  * Checks if voltage processor transmission has been completed.
  * Returns non-zero if a transmission has completed, 0 otherwise.
@@ -514,6 +515,7 @@ u32 omap_prm_vp_check_txdone(u8 vp_id)
 
 /**
  * omap_prm_vp_clear_txdone - clears voltage processor TX done status
+ * @vp_id: unique VP instance ID
  *
  * Clears the status bit for completed voltage processor transmission
  * returned by prm_vp_check_txdone.

