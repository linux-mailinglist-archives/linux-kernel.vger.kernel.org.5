Return-Path: <linux-kernel+bounces-28417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31282FE47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B7F28C988
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08112125B1;
	Wed, 17 Jan 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gj+eFygw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC579CC;
	Wed, 17 Jan 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453811; cv=none; b=Z9LPnZwLxNyx2vIaAYfz7yA1UAdg3fdn0BroVP5Lk19H0l/tpP4k5r2ZYfabgj4sgDwZw+68Ykwx1jUMfvhkcnpK/TatEXjZLkhdCtcBC6RQd0NZ+HsIAuRkr0TYYwDiAOkrQIWscFWAdD0PqBQhwyA+2jGWLnhrPj5aaFJ+9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453811; c=relaxed/simple;
	bh=AyE3iZ0YIgSHRY471OTeVM9lvSe3brGHPKOEZ8HuzDQ=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=UwxdH2ak/PQ0W3NaKDGj+aGSAwAUGwqx1u+vlWjOakdJLSeBS2DwWDBTRqDNjTqsMpAtsXWOJkF+6XdB7RcdWEjqUQ1DHkiPeAoRyNgj2gZ0cU45RWmfo3p1N0DV+s9LRkMFA0DgEZsG7yzt/EOg0YF8UwOTdMJnm2EfPgCLo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gj+eFygw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NgQzwLw26rL6c+tJaDaxoF79yF00tNswbdO97Qj1Pt4=; b=gj+eFygwxAJfFS8oVWkEF4mV4+
	POxdvSkYyFjG/UQCXwN+mA1qDum/9TFHBgg/o0vKyPfIY+0IXK48UYijCRN0CaOH3LlWaUmQb+Cle
	jDf7IoM0dkcbO5WqVgP2LB+uvSie83SP0M4jCR/i0SCCGDwQXnSlVvy6BZ8A0bGv1FMPVlfulbBAD
	D9XAw+KzZ3pIr/I0k/MvEOijLUAJk8cHWuvKFtoIbo1JsJYG/qrdF0w96J0D1MGF/flXTIzpuCEAO
	4wZW4inv0x8t+K9bQHhlRz2lkOiqDgnmQg1TKWtIa5U9zsS2FQHq00Ju94dfoZNh6M9lgsrpMrpBO
	HDo2JWGg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRU-00E6zu-2g;
	Wed, 17 Jan 2024 01:10:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 11/13] ARM: OMAP2+: fix a kernel-doc warning
Date: Tue, 16 Jan 2024 17:09:59 -0800
Message-ID: <20240117011004.22669-12-rdunlap@infradead.org>
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

Use the correct function name in a kernel-doc comment to prevent a
warning:

powerdomain.c:1171: warning: expecting prototype for pwrdm_save_context(). Prototype was for pwrdm_restore_context() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/powerdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1162,7 +1162,7 @@ static int pwrdm_save_context(struct pow
 }
 
 /**
- * pwrdm_save_context - restore powerdomain registers
+ * pwrdm_restore_context - restore powerdomain registers
  *
  * Restore powerdomain control registers after a suspend or resume
  * event.

