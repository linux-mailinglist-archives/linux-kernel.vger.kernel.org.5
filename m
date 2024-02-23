Return-Path: <linux-kernel+bounces-78116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB43860F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BA8286548
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D05D46D;
	Fri, 23 Feb 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYIpRfCs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06C5CDC8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683762; cv=none; b=SNssVAY6VeqwK9wjsfy19KkUNp2WryxWhT3CnRVw9/172zxOAbUnQUdN0rX25Pw1KznGQu0YE+ETGLj1MgWDagVXBZfh9GxrQ28GWo0AbEuoQ8AS7R8/fChSQNwfq2i61e/tsAqW03Tvt6UZbdYoTsKrykwkq7V5wBspsuI0exI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683762; c=relaxed/simple;
	bh=2sdOaj3qeTjo5QFG7kEZXfTFYVoe+AW5wZkGGLb5zJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q20c/nd3FlkNznboMED6bMgloMQdM0kn3A26DZpWUT8UkI2CIK8QHsVEnt06bjplxRXE2uJjxDcH4L2bEmR6fjeHuYLI7u0VKCWfx/3mE81uaCrTPCSqavVYW6oG5Utj7i52JlNkBInE9iGjvHvjeMGnYH5REDTORgXtmPJgPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYIpRfCs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708683757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLriUIlQJsX00hHBYbo+OHC/S+IX7onkvIWqKOkdsoc=;
	b=PYIpRfCsz0WE5Z9PAvvXadZ/WSgG+94S+6zFsMrkdso09gecmoVC0O04rt5v0Cnz4UL7nF
	JNVsoFQBvPMq3q/YqJP7FCFp48EUb8GmHjAHenoDYO5yov72p2FqLu9xVi/O5aZlyKnUSm
	LSJ9kc/U2eSRMZj9us5jP826w48jU7E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-gpWk31CfP_WLbHx7YPc6SA-1; Fri,
 23 Feb 2024 05:22:33 -0500
X-MC-Unique: gpWk31CfP_WLbHx7YPc6SA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CF2F29AA39C;
	Fri, 23 Feb 2024 10:22:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E41B492BC6;
	Fri, 23 Feb 2024 10:22:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: x86@kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Xin Li <xin@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86: irq: unconditionally define KVM interrupt vectors
Date: Fri, 23 Feb 2024 05:22:29 -0500
Message-Id: <20240223102229.627664-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Unlike arch/x86/kernel/idt.c, FRED support chose to remove the #ifdefs
from the .c files and concentrate them in the headers, where unused
handlers are #define'd to NULL.

However, the constants for KVM's 3 posted interrupt vectors are still
defined conditionally in irq_vectors.h.  In the tree that FRED support was
developed on, this is innocuous because CONFIG_HAVE_KVM was effectively
always set.  With the cleanups that recently went into the KVM tree to
remove CONFIG_HAVE_KVM, the conditional became IS_ENABLED(CONFIG_KVM).
This causes a linux-next compilation failure in FRED code, when
CONFIG_KVM=n.

In preparation for the merging of FRED in Linux 6.9, define the interrupt
vector numbers unconditionally.

Cc: x86@kernel.org
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Xin Li (Intel) <xin@zytor.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/irq_vectors.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 3f73ac3ed3a0..d18bfb238f66 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -84,11 +84,9 @@
 #define HYPERVISOR_CALLBACK_VECTOR	0xf3
 
 /* Vector for KVM to deliver posted interrupt IPI */
-#if IS_ENABLED(CONFIG_KVM)
 #define POSTED_INTR_VECTOR		0xf2
 #define POSTED_INTR_WAKEUP_VECTOR	0xf1
 #define POSTED_INTR_NESTED_VECTOR	0xf0
-#endif
 
 #define MANAGED_IRQ_SHUTDOWN_VECTOR	0xef
 
-- 
2.39.1


