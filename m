Return-Path: <linux-kernel+bounces-110983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371058866A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9576F284FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE1C132;
	Fri, 22 Mar 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d5u4Vk4c"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17295C127
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088273; cv=none; b=UWr8C2YZdzTYu2KucW8mhXQJHo+XK8mXK7z79di78Bvu+Z0GSdWz1GBgWoA9/8BSgeWXTgPJ/7kqofdaYJQBp9ljBAQRjOxGn6sjFftoakMoTbuu4VJTc08dHkpIu7OfSffxuNP4M/vCZgdR94zp0a4GtD2MDZc3bBE5i7n4kY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088273; c=relaxed/simple;
	bh=vKn8m1DHwhDiog5OyjdVZMOak55qk31tA/1OfFLNQAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IejBXRvycD+0Hm+b8L9uywcPdnsRWvDO9sAMcP5ZdE1unRaL+JEm9HERkJtWW/nD305pOVmoND8vZAncNIjApOZ6jl+xC3jnIjWBqikzZdXJ/ACcFNqNYGrJ5B7xWwQ158z6r7dPwr6xvC2ZibMsTxpTY/qcWI9rsrx5TxoLFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d5u4Vk4c; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711088268; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5ItwkbfBI36gD4+fLsboHG2pr+jRHC/1cyKhqHaieO4=;
	b=d5u4Vk4cwjQjoxR/NjeQy1EaerxzO5XeRfjoVL/rxglOWPEer3oL8cH+VLpvm7f++drgL5+7rqkN5+cv1JnycdzMnS3/vujXK/K3q6iWbwB15P+Cx1ucXyQC+ogura0anKbKXJ5THXMWLj0CIlMCi8j5Ju9gL7MkACB3mK23oJc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W31.zcW_1711088262;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W31.zcW_1711088262)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 14:17:48 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kirill.shutemov@linux.intel.com
Cc: dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/virt/tdx: Remove duplicate include
Date: Fri, 22 Mar 2024 14:17:41 +0800
Message-Id: <20240322061741.9869-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/arch/x86/virt/vmx/tdx/tdx.c: linux/acpi.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8609
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..49a1c6890b55 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -27,7 +27,6 @@
 #include <linux/log2.h>
 #include <linux/acpi.h>
 #include <linux/suspend.h>
-#include <linux/acpi.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
-- 
2.20.1.7.g153144c


