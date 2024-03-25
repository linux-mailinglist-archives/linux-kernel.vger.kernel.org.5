Return-Path: <linux-kernel+bounces-116378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D888998A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DA91F2CBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E94DA18;
	Mon, 25 Mar 2024 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3MgSBoG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF01384B6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331465; cv=none; b=fq9o7l0pP2T1H+6Bu7eWZphX7tPCWY6JG+r44V4X4VvoX7R+8zXlaslz6magJBM6tbz2FF3IV1Hek+9WaFcjpOld6MDcA9IocnWihvhJnCSKN1eiFnTNAmOOomLqQcSdobyiNKfRYSWq5kJmsxyv6DmEs63i3SMG33lHKJ+5yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331465; c=relaxed/simple;
	bh=GmcfUuZNdVqcGJwtOQS12FjSh6lYxIaUMNt7zwU4Puc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI6Urpu1RjmYICdLFYaU5HPHTG8KW3JcGd2ghxcweq3CTM8sTORMYlYiTXHIhE17UDGO71p06rgTJeAD7p3yTHzxneCF7id/+HzN52K5jh2jbalqFdJ+t2gmSSpW2R9GxsoqT/VnEqGURX/6R6mn81ttG9sUgd1sapZpJj7s7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3MgSBoG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711331462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86VbXPThTUyKHsQjCJ3kt+4p36TFqj+xB9/jS6S0RvE=;
	b=X3MgSBoGB5a3fAtnvOcTNnnofCfy9hONnmoyVpL2XGJio+l8Bgm5vdwrZBH6zdFk9b4I8u
	XZjqXX35l2TxUI0r7TXOVRgti7JlVk1mF/tlqKIPicMFb+PlW9dODG4zbwZLZlG/KQ9XBB
	zhns9KZOtMsdHkoRRVgnuIuKpXX7Jlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-BGjv1GpmNs-HwBMKhPUwbQ-1; Sun, 24 Mar 2024 21:50:59 -0400
X-MC-Unique: BGjv1GpmNs-HwBMKhPUwbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB06A101A552;
	Mon, 25 Mar 2024 01:50:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC251C060A4;
	Mon, 25 Mar 2024 01:50:57 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:50:50 +0800
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org,
	chenhuacai@loongson.cn, dyoung@redhat.com, jbohac@suse.cz,
	lihuafei1@huawei.com, chenhaixiang3@huawei.com
Subject: [PATCH v2] crash: use macro to add crashk_res into iomem early for
 specific arch
Message-ID: <ZgDYemRQ2jxjLkq+@MiWiFi-R3L-srv>
References: <20240324033513.1027427-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324033513.1027427-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

There are regression reports[1][2] that crashkernel region on x86_64 can't
be added into iomem tree sometime. This causes the later failure of kdump
loading.

This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
crashkernel resources") was merged.

Even though, these reported issues are proved to be related to other
component, they are just exposed after above commmit applied, I still
would like to keep crashk_res and crashk_low_res being added into iomem
early as before because the early adding has been always there on x86_64
and working very well. For safety of kdump, Let's change it back.

Here, add a macro HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY to limit that
only ARCH defining the macro can have the early adding
crashk_res/_low_res into iomem. Then define
HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY on x86 to enable it.

Note: In reserve_crashkernel_low(), there's a remnant of crashk_low_res
hanlding which was mistakenly added back in commit 85fcde402db1 ("kexec:
split crashkernel reservation code out from crash_core.c").

[1]
[PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
https://lore.kernel.org/all/Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com/T/#u

[2]
Question about Address Range Validation in Crash Kernel Allocation
https://lore.kernel.org/all/4eeac1f733584855965a2ea62fa4da58@huawei.com/T/#u

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- Remove the stray space before 'define' when defining
  HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY in asm/crash_reserve.h of x86.
  This is not suggested for standalone macro defines. Thanks to Ingo.

 arch/x86/include/asm/crash_reserve.h | 2 ++
 kernel/crash_reserve.c               | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 152239f95541..7835b2cdff04 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
 #endif
 }
 
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_RESERVE_H */
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index bbb6c3cb00e4..066668799f75 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -366,7 +366,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -448,8 +450,12 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
+#ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
 	if (crashk_res.start < crashk_res.end)
@@ -462,3 +468,4 @@ static __init int insert_crashkernel_resources(void)
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif
-- 
2.41.0


