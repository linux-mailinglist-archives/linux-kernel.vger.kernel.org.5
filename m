Return-Path: <linux-kernel+bounces-28411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166382FE38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B653287380
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C98BF6;
	Wed, 17 Jan 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jjZQJqeL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644215B7;
	Wed, 17 Jan 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453809; cv=none; b=o/cu+/W+TfH4KXICxirfEi2o4k6pEotywDA8xkNxRrn4FbcikYu+AOLslPx2jypmQpduEE8tCjYC3swy4KlfuLNh98wbzMPJ3OEIg+KkFB9o5mYUbXKofQHcakkl37gBgOtmUOoE5lX8dYZgq33ix6/7jiVMMpp3Arboie+kWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453809; c=relaxed/simple;
	bh=TpY9YZBMiKLnHcXHU3L0fU+AEI3fIwR1kbbzoZ8IsGk=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=VOVj+rR4YAOw7KweUNVYLFIuE5vavvlPKbVsmrvgUcnZymGdfSTCgrP9AiQU1QVRHwWYE+vQMAtNi8DuVzoFvIkl8Zcvh6hBCNP7LG2YpNp1u2nslmfraaGPg7RHY8E67QYShRU2EfjRb0gDvFk3xDFk/HDHwcFSjuOV8TC+ARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jjZQJqeL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YqDqQhI9Tad8JS90rKrmaa82AwzcW8UAGZbm+qX2YYg=; b=jjZQJqeLLU5KIm7iuhwNWUMoFZ
	nakExqXN44Zy8V8KZ8rsEiJ6HgVaahmmM2bjzZhjKSXYi+meoqiKvkeoiwOeqsvlsc3iXMxrV/k8+
	qlfW0Sstf4IJZrSvTDBReP7XHpZ019qDtiSo9nledLSWCbXN0KO8xOdLzPmo/8thrdjYG3DRJuxj0
	Hg1DBQVMSUKnXARbDIotMuKMv0N4vhFQZrVLK2O2xVw+KRLtK94bRa9WVeXqgxOTDGPxAy7H8MydE
	Mm2p+xDg4MW1VvsBDXKaGzrWS5YaaE9b/jN2vxnTW6uavKPuV219wQJI3F+ImL9b9yw9b+iNm4DVK
	xlDHonrQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuRT-00E6zu-05;
	Wed, 17 Jan 2024 01:10:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	patches@armlinux.org.uk
Subject: [PATCH 05/13] ARM: OMAP2+: CMINST: use matching function name in kernel-doc
Date: Tue, 16 Jan 2024 17:09:53 -0800
Message-ID: <20240117011004.22669-6-rdunlap@infradead.org>
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

Prevent a kernel-doc warning by using the correct function name in
a kernel-doc comment:

cminst44xx.c:249: warning: expecting prototype for omap4_cminst_clkdm_force_sleep(). Prototype was for omap4_cminst_clkdm_force_wakeup() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 0dd3ee31125508cd67f7e717

 arch/arm/mach-omap2/cminst44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -237,7 +237,7 @@ static void omap4_cminst_clkdm_disable_h
 }
 
 /**
- * omap4_cminst_clkdm_force_sleep - try to take a clockdomain out of idle
+ * omap4_cminst_clkdm_force_wakeup - try to take a clockdomain out of idle
  * @part: PRCM partition ID that the clockdomain registers exist in
  * @inst: CM instance register offset (*_INST macro)
  * @cdoffs: Clockdomain register offset (*_CDOFFS macro)

