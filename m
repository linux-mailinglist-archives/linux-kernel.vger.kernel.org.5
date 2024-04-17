Return-Path: <linux-kernel+bounces-148815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39388A87BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025541C21F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08E1487D2;
	Wed, 17 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQWm7y2n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642D146D4B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368097; cv=none; b=WU7VxXrPAJ89z/DLBSm5skdXzBB//f0HU6aRX1FCGlVgqGg1nBRuyAmKUPQgou1cbnTBbOg2x4WAlOscYK59kP4eobm+FXmV+/nuiTZylzXV4Npd3pPaYhfPM9JmOtk89Lz5nZz0wq8h16hfmbiOM9AjBP1cDD0jtMNiL+AB34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368097; c=relaxed/simple;
	bh=P7qL8n859l6t9aHE/CUbWmDOIT6vHCAOzzjvKY5e/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF6HD+dFKTXKP8qHwGw38YNU+/fYP2sLEC3IOqna3lqwN5YRkksofC6BtZSo35YLoAwZT4bEsEhadk0vsG9EbzT/bogkUr/Mh6v4OSk3+M0uChMqv17pNgKqJJXfKkmRbM+scF0mM/ncwP5j7A15Xql8K1MpEj5WkdXMHoVsOnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQWm7y2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713368095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpEqSEJva6pseMNSTEMb3KlMpGn0cTWl47IYQ+iVjpE=;
	b=CQWm7y2n/5jNssZZxwvSzraGEO3Q/TkxTUwHrVG3bNdGUMyDFb52rRbV0lVHMVC7SQIC+V
	FWwn9eRPSq90v25VTuIfEPtRRz+4Ihjq6CA3MeYHFIn4ApHowpjpH9kKI5FMn/QBq+kKbr
	E7KUCIFMdJ7y7ab6EDg445N+4IR/iOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-FUEJyAKJPkKzrD_fx3WfIA-1; Wed, 17 Apr 2024 11:34:52 -0400
X-MC-Unique: FUEJyAKJPkKzrD_fx3WfIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 808C69C2F22;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50B11581CD;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 1/7] KVM: Document KVM_MAP_MEMORY ioctl
Date: Wed, 17 Apr 2024 11:34:44 -0400
Message-ID: <20240417153450.3608097-2-pbonzini@redhat.com>
In-Reply-To: <20240417153450.3608097-1-pbonzini@redhat.com>
References: <20240417153450.3608097-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Isaku Yamahata <isaku.yamahata@intel.com>

Adds documentation of KVM_MAP_MEMORY ioctl. [1]

It populates guest memory.  It doesn't do extra operations on the
underlying technology-specific initialization [2].  For example,
CoCo-related operations won't be performed.  Concretely for TDX, this API
won't invoke TDH.MEM.PAGE.ADD() or TDH.MR.EXTEND().  Vendor-specific APIs
are required for such operations.

The key point is to adapt of vcpu ioctl instead of VM ioctl.  First,
populating guest memory requires vcpu.  If it is VM ioctl, we need to pick
one vcpu somehow.  Secondly, vcpu ioctl allows each vcpu to invoke this
ioctl in parallel.  It helps to scale regarding guest memory size, e.g.,
hundreds of GB.

[1] https://lore.kernel.org/kvm/Zbrj5WKVgMsUFDtb@google.com/
[2] https://lore.kernel.org/kvm/Ze-TJh0BBOWm9spT@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Message-ID: <9a060293c9ad9a78f1d8994cfe1311e818e99257.1712785629.git.isaku.yamahata@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f0b76ff5030d..c16906a42db1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6352,6 +6352,60 @@ a single guest_memfd file, but the bound ranges must not overlap).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
+4.143 KVM_MAP_MEMORY
+------------------------
+
+:Capability: KVM_CAP_MAP_MEMORY
+:Architectures: none
+:Type: vcpu ioctl
+:Parameters: struct kvm_map_memory (in/out)
+:Returns: 0 on success, < 0 on error
+
+Errors:
+
+  ========== ===============================================================
+  EINVAL     The specified `base_address` and `size` were invalid (e.g. not
+             page aligned or outside the defined memory slots).
+  EAGAIN     The ioctl should be invoked again and no page was processed.
+  EINTR      An unmasked signal is pending and no page was processed.
+  EFAULT     The parameter address was invalid.
+  EOPNOTSUPP The architecture does not support this operation, or the
+             guest state does not allow it.
+  ========== ===============================================================
+
+::
+
+  struct kvm_map_memory {
+	/* in/out */
+	__u64 base_address;
+	__u64 size;
+	/* in */
+	__u64 flags;
+	__u64 padding[5];
+  };
+
+KVM_MAP_MEMORY populates guest memory in the page tables of a vCPU.
+When the ioctl returns, the input values are updated to point to the
+remaining range.  If `size` > 0 on return, the caller can just issue
+the ioctl again with the same `struct kvm_map_memory` argument.
+
+In some cases, multiple vCPUs might share the page tables.  In this
+case, if this ioctl is called in parallel for multiple vCPUs the
+ioctl might return with `size` > 0.
+
+The ioctl may not be supported for all VMs, and may just return
+an `EOPNOTSUPP` error if a VM does not support it.  You may use
+`KVM_CHECK_EXTENSION` on the VM file descriptor to check if it is
+supported.
+
+Also, shadow page tables cannot support this ioctl because they
+are indexed by virtual address or nested guest physical address.
+Calling this ioctl when the guest is using shadow page tables (for
+example because it is running a nested guest) will also fail.
+
+`flags` must currently be zero.
+
+
 5. The kvm_run structure
 ========================
 
-- 
2.43.0



