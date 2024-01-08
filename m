Return-Path: <linux-kernel+bounces-19568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20893826EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94A61F22805
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9546447;
	Mon,  8 Jan 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYdfqgy3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22E45C0A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704718065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6WD9hXyfeZb3+kCnOFBPgopN+rupvbModgd55kTPhM=;
	b=IYdfqgy32Gfw8YXpmpiUXccczEGBUmrXHikYVNl8ELAT6b5lh4dNDF2/xIFr5NhMD6mGFS
	Gc6F8wW8jQ8RK5frhnukkJhVANaSribewLn00K+g9Bm5F4TOSUhHpZIWMIVECShZZeZkVR
	BZka4ngLGRlk4Vkfh7LDbRCqHMQVX9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Unz3kWhUO7KiiPXg9AA_FQ-1; Mon,
 08 Jan 2024 07:47:42 -0500
X-MC-Unique: Unz3kWhUO7KiiPXg9AA_FQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2D1C29AC01D;
	Mon,  8 Jan 2024 12:47:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95F8A3C39;
	Mon,  8 Jan 2024 12:47:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v2 2/5] KVM: fix direction of dependency on MMU notifiers
Date: Mon,  8 Jan 2024 07:47:37 -0500
Message-Id: <20240108124740.114453-3-pbonzini@redhat.com>
In-Reply-To: <20240108124740.114453-1-pbonzini@redhat.com>
References: <20240108124740.114453-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

KVM_GENERIC_MEMORY_ATTRIBUTES requires the generic MMU notifier code, because
it uses kvm_mmu_invalidate_begin/end.  However, it would not work with a bespoke
implementation of MMU notifiers that does not use KVM_GENERIC_MMU_NOTIFIER,
because most likely it would not synchronize correctly on invalidation.  So
the right thing to do is to note the problematic configuration if the
architecture does not select itself KVM_GENERIC_MMU_NOTIFIER; not to
enable it blindly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ace72be98fb2..184dab4ee871 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -97,7 +97,7 @@ config KVM_GENERIC_MMU_NOTIFIER
        bool
 
 config KVM_GENERIC_MEMORY_ATTRIBUTES
-       select KVM_GENERIC_MMU_NOTIFIER
+       depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
 config KVM_PRIVATE_MEM
-- 
2.39.1



