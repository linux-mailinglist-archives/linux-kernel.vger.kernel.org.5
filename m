Return-Path: <linux-kernel+bounces-28409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A182FE35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EAC1F26826
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A779CD;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxFPPkkr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D73138C;
	Wed, 17 Jan 2024 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453808; cv=none; b=CU5xx+D3Ce4MbFohUlvIbkyXWfFxAM49X4E9OeOJUJTAZhpUq19E/STBvOYjSaffbiPbZsZ7tNCsHsI4BHxn9+uiW9cUofgFrn3XC2YqN7gQM4laBZfMm0hWZeXQd29NKeZ9ebJijC6rCNEl2egjiOkYcWNFMBCQiGLbAFrfuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453808; c=relaxed/simple;
	bh=E5a8W/JASgFproKCFJ7dwxpj2fi+/oDl2SPrdRL+xng=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=UL/EsnrHOnWEgvc19wqFh9hBgWyZJb/zyr8ghvnXrRX+8LSOMzmoqQTCpKOS0ovYJJrWZg0ihoBxQxXzJ9kT3LGdjFzKznUVcrWNKao0iFsj/E7+NeSayIWivSa+EphDJvhcDIiymB6zMcMi1xU2KjMk4GbagvyuzC5R3jwElaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rxFPPkkr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d6sYWXOYku8urx0FvA1UhyCkVYzn1pxHKk2cTNothWk=; b=rxFPPkkrHBZQYce8trpTyuZmRR
	gCU3ou2FNvI3CXyDn6/kEwLINTVlTok/HXZYFIIVILS+ldB5jpbW38nTYEdFAvHZuXtPkYy0fFluL
	Igp5fFw0qRNWE8jytnQD3jrbIKzocxvg0hE9X6OE2T5moYdinQ2sow6JYcFiQ8nc8KFCbbomrslxR
	zcGmkU5VsFUul6lst7oBJegDCLUyEl1E5ORNsQnwc4haStyIu4dzFdvGSKOT0h1KzLgHt4jwGUNji
	WFa+0HQcCoI0EpxbDL+qe4t8vcpw61Th5DTv0P/8P/3AKLNU2fNjO3z2Hpvtnj9WgxmDFZg8ZEZJ+
	yeBi1oZw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRS-00E6zu-0g;
	Wed, 17 Jan 2024 01:10:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <paul@pwsan.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 02/13] ARM: OMAP2+: clockdomain: fix kernel-doc warnings
Date: Tue, 16 Jan 2024 17:09:50 -0800
Message-ID: <20240117011004.22669-3-rdunlap@infradead.org>
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

Use the correct function name in a kernel-doc comment to prevent
a kernel-doc warning.
Use the correct function parameter name to prevent a kernel-doc
warning.

clockdomain.c:1003: warning: expecting prototype for clkdm_deny_idle(). Prototype was for clkdm_deny_idle_nolock() instead
clockdomain.c:1125: warning: Excess function parameter 'clk' description in 'clkdm_clk_enable'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -990,7 +990,7 @@ void clkdm_allow_idle(struct clockdomain
 }
 
 /**
- * clkdm_deny_idle - disable hwsup idle transitions for clkdm
+ * clkdm_deny_idle_nolock - disable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
  *
  * Prevent the hardware from automatically switching the clockdomain
@@ -1110,7 +1110,7 @@ void clkdm_del_autodeps(struct clockdoma
 /**
  * clkdm_clk_enable - add an enabled downstream clock to this clkdm
  * @clkdm: struct clockdomain *
- * @clk: struct clk * of the enabled downstream clock
+ * @unused: struct clk * of the enabled downstream clock
  *
  * Increment the usecount of the clockdomain @clkdm and ensure that it
  * is awake before @clk is enabled.  Intended to be called by

