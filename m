Return-Path: <linux-kernel+bounces-64466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D07853EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EB6B217B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC16217C;
	Tue, 13 Feb 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+P7yzee"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078612E59
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863878; cv=none; b=EuDIA/4ZyJdKzXiRRf7ZHZmMH+GxWWssOsSI0DIW4R4lJdAZnb2QjG3X92BtEIgWeEihSjDYNjxdE6WtwrnYkPPR9kIIi5NLOIBa+a7hPE6KqtvloNiQLERhum0twAPuhB4Q8RptAGEzypnEtkIVsXIaGNG5J6jQSl+Xez+ax1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863878; c=relaxed/simple;
	bh=erK6GWFY7xEm2lYTQd3vIvBXye4Meuq1JC5KAD5dx2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbLuIqsSC+DYIpVJnMmYlraUUMnZK259zDYlSVZIS+9przI4lUkdYtDKYSHMJc65/bZh7Hy4zzaG2qhSYnXyCnU0yHfBT53QglzQ8WG/3DZ0UnJPv2dUbWiUOt0lXEAjYIuC7EVqfnTsjD8KkbRvgurKaN+t5IWM03UkUeLPTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W+P7yzee; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AWuogxr7Ulz+Dcz/mwmjE3NbKxkvlrjdQKwO2hx8vd4=; b=W+P7yzeeExx5y9d7dWx2JJDp7p
	b3sSChkLCoxQRLv5wT5Zdz9TbK20qSgVVtRgTIL1eGoS/gmj84m41kqirwUk10SrRewTKfODukafN
	zM8rXBty38iRvOOxFn7aZ6qpMjy4JPAAGLfUwUu/T+vvwx0L+FHSFtwFW8aN+EUfi6egEN0vDXOKt
	EcL1iiYRYdWh30FZLklhZhQwAJNwgzuB0jiXiEn9QBM61pjDkHv0jIZQ0bhQXeeyXkVf0u5GbG54Z
	zz/WoKl99f9Q+3lM50P4x5t1YLMG9uSYGQ8tMGcjjr3KCnmBSPEzAr5+AJVI4DcO/a2Uwlgaut/73
	H9Z414Yg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ra1PX-0000000B663-3dZE;
	Tue, 13 Feb 2024 22:37:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v3] x86/usercopy: fix kernel-doc function param name
Date: Tue, 13 Feb 2024 14:37:55 -0800
Message-ID: <20240213223755.9872-1-rdunlap@infradead.org>
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
v3: fix duplication (!?) of patch description and patch diff

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

