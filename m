Return-Path: <linux-kernel+bounces-19574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2BC826F02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15F31F22EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9B41744;
	Mon,  8 Jan 2024 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftxwX6d8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286B4175C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704718353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fD1GykFikbXTFKh3tVS8W6aZYCFQw2YGT7ld2MYyAJI=;
	b=ftxwX6d8po3E6L/dzICEM9btBB3uO7uqEP9pOeK0ruDJUgoSxTAgJ0+k8GVPD2vaLWDHEa
	FJR0t+7x0t7EwTFJHZmGoGXsyKZFQkVVJaFaJIqvKLaF3ifVgWfhQo/hWJnUeLLc9bceMD
	IdTbDf+Cb7Wl4/rhObM8fFev+EyP/9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-OX0Np3ZbPcOLiTJaY-vt2Q-1; Mon, 08 Jan 2024 07:52:30 -0500
X-MC-Unique: OX0Np3ZbPcOLiTJaY-vt2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96F0D185A786;
	Mon,  8 Jan 2024 12:52:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FA9D492BC7;
	Mon,  8 Jan 2024 12:52:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: add missing "depends on KVM"
Date: Mon,  8 Jan 2024 07:52:28 -0500
Message-Id: <20240108125228.115731-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Support for KVM software-protected VMs should not be configurable,
if KVM is not available at all.

Fixes: 89ea60c2c7b5 ("KVM: x86: Add support for "protected VMs" that can utilize private memory")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index cce3dea27920..10c56603cc06 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -77,7 +77,7 @@ config KVM_WERROR
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
-	depends on X86_64
+	depends on KVM && X86_64
 	select KVM_GENERIC_PRIVATE_MEM
 	help
 	  Enable support for KVM software-protected VMs.  Currently "protected"
-- 
2.39.1


