Return-Path: <linux-kernel+bounces-28413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B427082FE41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEF81F27710
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482A101DE;
	Wed, 17 Jan 2024 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9SUaRqh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E615CC;
	Wed, 17 Jan 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453810; cv=none; b=XQ3HNXPaMw91M8ahb1m8uDMnXWyo/uQzH33bLOpXkYtOGDGwztnwbdvLt/hI25VirUbbn6Idm97GxYPSghNEnvoRhfs8MsznXrNNOgiMcI1Xzlrdy83dW14aCWvkUxMSimdWVkeUu4i4cJeUj8WsZTEQVuVzvXOpoXOw0bCcmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453810; c=relaxed/simple;
	bh=RO/Vlr9xwSjT6tqMGGLx8pIF3PiU93RnbeniABzIT60=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=QNw7E/qclDc+qB02X3euUK5YSzRgRdrkBCHds9eQvkAhAwJQaN/96dOdyC8tFD+qRr4VR69+J/331AzYcavGet64ao5hbMlgGbTuj6/MPIL6PLiFw8Nx2iOMiZk0EbUPvCDbrqmlXJOjDZVhWzULDkqfwsA5MBXai2fdK+bhCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b9SUaRqh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mP7AFe9fYHUcfkMXVMCBmHBXRj17q4ZjJgE4XRNARXk=; b=b9SUaRqhAvufEAhmS3H9EOr2N3
	cz7L2R5Zrk0hUJsFd6TJgMJsmbOr5U1s+E2v1MFNAS3c1V8lHq7TiiKFub4LOWJ0KoEsStDcuP5uZ
	xQCuQ4RiKx75qRMXM6YQuZf9ssRbelogASCKZ4tQYHSttbNwdMhp1RKhh3ZW6ztzms3g21yPjsLck
	X/U0CHhV7prBFGvEVifsCpt54canTFyBbjVrv1btTNQBpjLLLJ7wLl/1/aVVaIGmjAgW3twCAc762
	z04EAAFG190phwDDTg0TV7cxqrrz2sviVpzzRZFmg6ngTz6sQkz2MKL0KBkzHrbTyjdXuLjLmUzJL
	UCvMblvA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRT-00E6zu-16;
	Wed, 17 Jan 2024 01:10:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <paul@pwsan.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 06/13] ARM: OMAP2+: hwmod: remove misuse of kernel-doc
Date: Tue, 16 Jan 2024 17:09:54 -0800
Message-ID: <20240117011004.22669-7-rdunlap@infradead.org>
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

kernel-doc does not support documenting data definitions, so change
the "/**" comments to common "/*" comments to avoid kernel-doc
warnings:

omap_hwmod_common_data.c:37: error: Cannot parse struct or union!
omap_hwmod_common_data.c:51: error: Cannot parse struct or union!
omap_hwmod_common_data.c:60: error: Cannot parse struct or union!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/omap_hwmod_common_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
@@ -20,7 +20,7 @@
 
 #include "omap_hwmod_common_data.h"
 
-/**
+/*
  * struct omap_hwmod_sysc_type1 - TYPE1 sysconfig scheme.
  *
  * To be used by hwmod structure to specify the sysconfig offsets
@@ -36,7 +36,7 @@ struct sysc_regbits omap_hwmod_sysc_type
 	.autoidle_shift	= SYSC_TYPE1_AUTOIDLE_SHIFT,
 };
 
-/**
+/*
  * struct omap_hwmod_sysc_type2 - TYPE2 sysconfig scheme.
  *
  * To be used by hwmod structure to specify the sysconfig offsets if the
@@ -50,7 +50,7 @@ struct sysc_regbits omap_hwmod_sysc_type
 	.dmadisable_shift = SYSC_TYPE2_DMADISABLE_SHIFT,
 };
 
-/**
+/*
  * struct omap_hwmod_sysc_type3 - TYPE3 sysconfig scheme.
  * Used by some IPs on AM33xx
  */

