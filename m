Return-Path: <linux-kernel+bounces-47382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D21844D46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B2BB2BBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28484482FC;
	Wed, 31 Jan 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWimYWUP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525841206
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743865; cv=none; b=H3u7pHWgd7Dhq7T+SMAp2JrxqW5eGYLycxW7HOFJnhxSbRbO4V8/htoqUhAYNoX9/ZATiUf8llSc09mziEdSiErDYmNvk0xY3+5pROzQFJw2hxHf0LA6RWAPJie2KJApX8bPDjZIL9os3OPtGq50oxwwar7KNtXEORlBj87iSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743865; c=relaxed/simple;
	bh=xtXUWbFA5RhV5p2JPvTvy0REVEPRTKEXEP3AJq7jDQk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJE9guW6Qg9/n6VLR+O7yshcpF6lrQxXtNe6PEStsj2TAqyN/vZy6fB1oNu982Bj8qdfczPLCZBPfPe314icVTdkNw+t+SCmrRazIUYQMHnnr+HUOJUfUfbaMIPTw73qzgaCfx5mM7IjyJn15oUTRBefLmtduy9aznFjRftfzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWimYWUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706743861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QNgMG1V+sShKZyZWPsvsaqKoL4Gh/7stnAPwzAP7cc=;
	b=WWimYWUPlw8kK2Kh2McbC/1dswStMwdYAf7RgfCM+2ZAo3TdzJDwQjDpuL4sCI3ukuduLA
	CTVFRix9LRRaZIRmXmePeF76o4FmzIKmpjKBguUo6xOWzmUUDQE99X1J+nW9cxlGvCxKRS
	p03u010ib6vXZjsNDDtkWT2ILG/q9yI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ub6N-GuYMlS0zu0_pDbJ1Q-1; Wed, 31 Jan 2024 18:30:58 -0500
X-MC-Unique: Ub6N-GuYMlS0zu0_pDbJ1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCA85185A780;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4870C2590D;
	Wed, 31 Jan 2024 23:30:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 8/8] KVM: remove unnecessary #ifdef
Date: Wed, 31 Jan 2024 18:30:56 -0500
Message-Id: <20240131233056.10845-9-pbonzini@redhat.com>
In-Reply-To: <20240131233056.10845-1-pbonzini@redhat.com>
References: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

KVM_CAP_IRQ_ROUTING is always defined, so there is no need to check if it is.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/uapi/linux/kvm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 589aba934c51..9fb9dd9a8fd5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -921,8 +921,6 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
 
-#ifdef KVM_CAP_IRQ_ROUTING
-
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
 	__u32 pin;
@@ -987,8 +985,6 @@ struct kvm_irq_routing {
 	struct kvm_irq_routing_entry entries[];
 };
 
-#endif
-
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
 /*
  * Available with KVM_CAP_IRQFD_RESAMPLE
-- 
2.39.0


