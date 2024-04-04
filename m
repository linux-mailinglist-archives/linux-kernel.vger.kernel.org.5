Return-Path: <linux-kernel+bounces-131986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD9898E44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52B41C21167
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266A7133413;
	Thu,  4 Apr 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfNJSGKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347751D6A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256641; cv=none; b=XQEMk5iU9JAt5zyp3hPWkSe8IrfLADsZqhbgQXrJ8ailTvohW4YtC1YkG3m5nw1JHmUE+91EfnVy5eDE1cMVYVFUQuJTuPMAoKIMePC2RjlRjFeXqRpP+e6JbkSiY+ClQGKiS8OX2YjX40PgS8jZtNAWLDteD3X0XGMk5+ZXMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256641; c=relaxed/simple;
	bh=DRZa6qCcwIxu3J6+pogOtSfaCQJILFOI4TxKUix+niw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLrImKYro/1+9768BUT5T0rPzrUyNGp3GRG+Nzt/pLVbSBs6x6JQSbishNr6HEPWMU7DoWXIRAqA3lHrlYnKT++9Bt9CwK8+bnTfgmtJkytPDTR0k80ke/WIEcK6uqJul/S8L74+e7z0xejX+wF1RBMUP+uLy0Zfd2Dtfl0x3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfNJSGKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712256638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBXensWpE7Hh5cackwpZC/rR1Lhmxd3u0UUm9CSpoqA=;
	b=DfNJSGKP5Qdc9876gzH9kdkiJzLxAGC04cpjo0COqV8xqALg0MlTPlP2wNy8DedwvCShHe
	X3m1Wrt17YlF7NGC/mU5XtpCxhYjnBRYqWXSacPXgUAlEsGWKgt0JgkkAUQoxgAobOBzbD
	VKI7sxXiiHqvdVRA3xt9eSyF2i2Tuk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-MlBolUypPySfhWFHt7vqkA-1; Thu, 04 Apr 2024 14:50:36 -0400
X-MC-Unique: MlBolUypPySfhWFHt7vqkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33930101A531;
	Thu,  4 Apr 2024 18:50:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1641C060A4;
	Thu,  4 Apr 2024 18:50:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH 07/11] KVM: guest_memfd: extract __kvm_gmem_get_pfn()
Date: Thu,  4 Apr 2024 14:50:29 -0400
Message-ID: <20240404185034.3184582-8-pbonzini@redhat.com>
In-Reply-To: <20240404185034.3184582-1-pbonzini@redhat.com>
References: <20240404185034.3184582-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

In preparation for adding a function that walks a set of pages
provided by userspace and populates them in a guest_memfd,
add a version of kvm_gmem_get_pfn() that has a "bool prepare"
argument and passes it down to kvm_gmem_get_folio().

Populating guest memory has to call repeatedly __kvm_gmem_get_pfn()
on the same file, so make the new function take struct file*.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 486748e65f36..a537a7e63ab5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -540,33 +540,29 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	fput(file);
 }
 
-int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
+		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
 {
 	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
-	struct kvm_gmem *gmem;
+	struct kvm_gmem *gmem = file->private_data;
 	struct folio *folio;
 	struct page *page;
-	struct file *file;
 	int r;
 
-	file = kvm_gmem_get_file(slot);
-	if (!file)
+	if (file != slot->gmem.file) {
+		WARN_ON_ONCE(slot->gmem.file);
 		return -EFAULT;
+	}
 
 	gmem = file->private_data;
-
 	if (xa_load(&gmem->bindings, index) != slot) {
 		WARN_ON_ONCE(xa_load(&gmem->bindings, index));
-		r = -EIO;
-		goto out_fput;
+		return -EIO;
 	}
 
 	folio = kvm_gmem_get_folio(file_inode(file), index, true);
-	if (!folio) {
-		r = -ENOMEM;
-		goto out_fput;
-	}
+	if (!folio)
+		return -ENOMEM;
 
 	if (folio_test_hwpoison(folio)) {
 		r = -EHWPOISON;
@@ -583,9 +579,21 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 out_unlock:
 	folio_unlock(folio);
-out_fput:
-	fput(file);
 
 	return r;
 }
+
+int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
+		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
+{
+	struct file *file = kvm_gmem_get_file(slot);
+	int r;
+
+	if (!file)
+		return -EFAULT;
+
+	r = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, true);
+	fput(file);
+	return r;
+}
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
-- 
2.43.0



