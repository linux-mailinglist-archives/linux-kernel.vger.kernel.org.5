Return-Path: <linux-kernel+bounces-130871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17B897E48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BDB1F23E95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6192233A;
	Thu,  4 Apr 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nV8IlvDn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9598405F7;
	Thu,  4 Apr 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206625; cv=none; b=RR0wAFTtY2Z+YFjAVf5t7QQggAs98Gh/gGHvHoq9ZMeW/R8A559B7T8s2UMRx+8JGhMFPxqinGEgx4bIfyqorhQsTyFnahdTacRSvvi67XnDviikOulyAtYlpilDvS/k29+twq9OMHLLHh5oHp9LwCOxM2CU/G5CYY951DTbuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206625; c=relaxed/simple;
	bh=kNlVOohDsJ4l9g9VgFw8Gsvsu/WkA6axZ/BYHChW6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceWWVh5ZQi47VI+re4RUo52O0YwdSeNjz39i27AzhT4eHspUcSLJAuVebz5tKtMX1xtxz0LyJ9wTxu9AUrPVqZzIn1271YrysMppx44WrVh1jFtfRSPnt+eB2O2b1VTkuiPxyqcs7CufQ2N4q5GtGg7bKmjDK6qk6i5/udGTwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nV8IlvDn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rs8UK1hKo+nqOnPF+GnwvCjj6a2+ZVwyagFKuIE6Zzw=; b=nV8IlvDnTNubsnhGNK0amcIC6k
	XQUbnYD4psUDaDw5A0Xb3oZuVIHbk/HTp0kv6kiYCbN1bowWItQBOdjrAQFai4bJPhn/suTwLsxRW
	ad8WmBpiPUY4rbtEZGwotA+4qWPTXWqrbftRmjCq06ky7qXZ7dAOUkcNU1V+JkZPGG+SKJuqW9Sof
	aNdH0DO6q8IjTRO6gZkk3Bk9Y5CKUTvOc+gj0W2t8Am4O57FlEG8kuooN83fosIK7JUANAs4OWzA8
	imJJuxKEwzjSuyd+BueQLSp8cJXT7h3d3pWflRhJHFnJOcTgsK0oj5jImI3cztKDzBCdInrrxlgrx
	5viAMrbA==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsF9q-00000001DD6-0H1m;
	Thu, 04 Apr 2024 04:57:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: [PATCH] LoongArch: addrspace: add linux/sizes.h to prevent build errors
Date: Wed,  3 Apr 2024 21:57:01 -0700
Message-ID: <20240404045701.27284-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch's include/asm/addrspace.h uses SZ_32M and SZ_16K, so add
<linux/sizes.h> to provide those macros to prevent build errors:

In file included from ../arch/loongarch/include/asm/io.h:11,
                 from ../include/linux/io.h:13,
                 from ../include/linux/io-64-nonatomic-lo-hi.h:5,
                 from ../drivers/cxl/pci.c:4:
./include/asm-generic/io.h: In function 'ioport_map':
./arch/loongarch/include/asm/addrspace.h:124:25: error: 'SZ_32M' undeclared (first use in this function); did you mean 'PS_32M'?
  124 | #define PCI_IOSIZE      SZ_32M

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/include/asm/addrspace.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -11,6 +11,7 @@
 #define _ASM_ADDRSPACE_H
 
 #include <linux/const.h>
+#include <linux/sizes.h>
 
 #include <asm/loongarch.h>
 

