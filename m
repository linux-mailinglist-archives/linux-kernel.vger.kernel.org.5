Return-Path: <linux-kernel+bounces-151197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB28AAB06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B32B1C20B23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DA757F6;
	Fri, 19 Apr 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUgu6JdS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24A38D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517174; cv=none; b=agfGWRYYfFdtk7u9Qf4zZ39fAkYh3lurj5vx7IKeJT9aTUJSx2f/vOU3OocJrNOpr6cpkmPFBCSlTo7uh+7WPvp60CmRGZrUy/DLJpODcz+5zH5hin9MetDWB5I3a1I1zrLZ+0K/6WRkpRLtl3hSDDPKjOpuNhzUKIAJNJEj5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517174; c=relaxed/simple;
	bh=iRkpDnaskXPP0egnn6MrAKOO3BaX7qM3TsGiRSbbcL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGnwJxvwhyZAHCdlWgNj5ClwmSASJY2nHXKgTp65giMgySuHMg/uveJoIfZhHCE7FZmMKPv+1tp4wduAlKZQe/QjNT4rzQDJD6VyT0Qqinzeuh5c1nZMMxQ4TMV4B9jvHkohdcxDvs3Ckars9I/KB7g55sD83a8CqOYPOZmG5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUgu6JdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713517171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3n3T3dQQzJdP5pnfnrGlCZLigrTHAZ95pIVOwtMaJg=;
	b=DUgu6JdStsA60aPgxEVpLivOjch6jqy/qkyWgOmmWQhCBEQv9oxR5UMTRZcIjtr59R55pv
	lRKJN2luMZxlwcpfMRKo7gWZgwvIEBUxzFlZi7CWo86OxAd+k3DAMJ6fD2K1XJwB9ef5na
	0e8YboDV9Mx5xAvEs2X6ZipD5PaDsrA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-lTWG8KZGOyiE9Yfm2zaZqA-1; Fri,
 19 Apr 2024 04:59:29 -0400
X-MC-Unique: lTWG8KZGOyiE9Yfm2zaZqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B27823804073;
	Fri, 19 Apr 2024 08:59:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8024F2037D42;
	Fri, 19 Apr 2024 08:59:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 1/6] KVM: Document KVM_PRE_FAULT_MEMORY ioctl
Date: Fri, 19 Apr 2024 04:59:22 -0400
Message-ID: <20240419085927.3648704-2-pbonzini@redhat.com>
In-Reply-To: <20240419085927.3648704-1-pbonzini@redhat.com>
References: <20240419085927.3648704-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Isaku Yamahata <isaku.yamahata@intel.com>

Adds documentation of KVM_PRE_FAULT_MEMORY ioctl. [1]

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
 Documentation/virt/kvm/api.rst | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f0b76ff5030d..bbcaa5d2b54b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6352,6 +6352,56 @@ a single guest_memfd file, but the bound ranges must not overlap).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
+4.143 KVM_PRE_FAULT_MEMORY
+------------------------
+
+:Capability: KVM_CAP_PRE_FAULT_MEMORY
+:Architectures: none
+:Type: vcpu ioctl
+:Parameters: struct kvm_pre_fault_memory (in/out)
+:Returns: 0 on success, < 0 on error
+
+Errors:
+
+  ========== ===============================================================
+  EINVAL     The specified `gpa` and `size` were invalid (e.g. not
+             page aligned).
+  ENOENT     The specified `gpa` is outside defined memslots.
+  EINTR      An unmasked signal is pending and no page was processed.
+  EFAULT     The parameter address was invalid.
+  EOPNOTSUPP Mapping memory for a GPA is unsupported by the
+             hypervisor, and/or for the current vCPU state/mode.
+  ========== ===============================================================
+
+::
+
+  struct kvm_pre_fault_memory {
+	/* in/out */
+	__u64 gpa;
+	__u64 size;
+	/* in */
+	__u64 flags;
+	__u64 padding[5];
+  };
+
+KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
+for the current vCPU state.  KVM maps memory as if the vCPU generated a
+stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
+CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
+
+In some cases, multiple vCPUs might share the page tables.  In this
+case, the ioctl can be called in parallel.
+
+Shadow page tables cannot support this ioctl because they
+are indexed by virtual address or nested guest physical address.
+Calling this ioctl when the guest is using shadow page tables (for
+example because it is running a nested guest with nested page tables)
+will fail with `EOPNOTSUPP` even if `KVM_CHECK_EXTENSION` reports
+the capability to be present.
+
+`flags` must currently be zero.
+
+
 5. The kvm_run structure
 ========================
 
-- 
2.43.0



