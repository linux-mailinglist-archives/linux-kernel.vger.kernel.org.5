Return-Path: <linux-kernel+bounces-60643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F68507F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA601C23C62
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B017553;
	Sun, 11 Feb 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yYuc+ZPi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2417544
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707632704; cv=none; b=l+riljOk30sPTU14oVLhEWQKagzlSEqDIYFMa4ghN5AL4wPFF5ByhY611s65Taos6kbVlnYPD29m3+GvSyX12brEAra2T6cwy/JxdWm/98pkAYQOCEgAZz2nDLkm08tJQB3QdycmIEK4u7+pQoPO6O4qYS6UI6jHaMUtR7HbXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707632704; c=relaxed/simple;
	bh=L6YkMF8t7672mRyTLHrAyjD3vqBMXzFM3f86CB5kEaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvK8QVxAmLAZHbHq/KjK+RBIc9sdqEKw/Zg2XRp3GMDZuFCIW5YhvAsB6fOhRQGq8Bk7BhGCKu3daI01KNuoobtXcxOA11jIJeQIBjRnaO1pbmasr6/DWMOIrCr0nCHgdS2OjwO8zrd2GhrMiHItK7P8f3ERsXv9g/CX+6ggUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yYuc+ZPi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LQIskt9qiL2WIMWkwLZ9WrQJBwOSRATJWBP6F5QNiaA=; b=yYuc+ZPige1Dtgp4E2WoSIJqHC
	gJByBKw8TS6KGQ5eJC8zsQV7wi5p8DSEJbqB9kAp+hnqh3jjNYKc8LFkwNvb/Xyunx5nKXqKPjOSx
	sbJetz+k0XYd06HjNq2WHPKEdyqVQO0d86W6n46ZoJJLM9sgGLlaQmCWWCyL4fP8TzSGzLZD1SpQT
	hTbWcs7PQCru55NAannfD8uvVZMEQYyW5y+OqBQAVsjW7MVnF3+91g8VOx+IdhtQY23/h0SBKyayH
	gF8Oon0Xf0fz6f4FXOSvdnVZbr2qcjjenRT2SWnagHfHCHX6BmwDIgyX7FOlM3wqZIy86FMWmB1Mm
	ZX9s2Waw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ3Gw-00000002PE5-1D7t;
	Sun, 11 Feb 2024 06:25:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v2] x86/usercopy: fix kernel-doc function param name
Date: Sat, 10 Feb 2024 22:25:01 -0800
Message-ID: <20240211062501.16428-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function parameter name in clean_cache_range() to prevent
kernel-doc warnings:

usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2: add Rev-by: Sohil Mehta

From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] x86/usercopy: fix kernel-doc function param name

Correct the function parameter name in clean_cache_range() to prevent
kernel-doc warnings:

usercopy_64.c:29: warning: Function parameter or member 'addr' not described in 'clean_cache_range'
usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
v2: add Rev-by: Sohil Mehta

 arch/x86/lib/usercopy_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -18,7 +18,7 @@
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
- * @vaddr:	virtual start address
+ * @addr:	virtual start address
  * @size:	number of bytes to write back
  *
  * Write back a cache range using the CLWB (cache line write back)
 arch/x86/lib/usercopy_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -18,7 +18,7 @@
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
- * @vaddr:	virtual start address
+ * @addr:	virtual start address
  * @size:	number of bytes to write back
  *
  * Write back a cache range using the CLWB (cache line write back)

