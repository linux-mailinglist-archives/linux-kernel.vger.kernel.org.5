Return-Path: <linux-kernel+bounces-82196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738486809D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F704B273A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3513472D;
	Mon, 26 Feb 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsT8yu5l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3805132C0A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974240; cv=none; b=BzXY10GFMMR7DoHxOOj684dRE7xDN1ntiIdNdjPl74UFN4HL4jc0/+IOeNvCTFhUMBGl3TsGBM9IPKfzyoCRGuuFZYDeUAKSu4Sd/SS6CQpijAeSpwHSyx1MkCOzgg4+LQSa3MnjFarhdSA3PXb5PrXMZ22du280vwdfxXrPc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974240; c=relaxed/simple;
	bh=yQ4+cUh1wFZP/DwoOESRlRUOq9oDhCd15lNRun6wmBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlY/nbkO2z0y5urF8cbYDO0PEanQryEoiKufh3wABbxnTKpH0iQ1mUFh/nsYgybIebYdbajktbhWjTQZu9NWKvd4okQDXZT2pleNRxA4g+qwb6xk8Bzpd0tk23SB5h++7pACKeHxiDsc7qdhd7Pdfz+KbX/TSeEVKvEzCki1v84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsT8yu5l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708974235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sh44m/6LSbtyCFX1lr2LXY+Z5ZsaGdYMgSlDHZYYvY=;
	b=RsT8yu5lxg7boW+QL9vP9Ye8B/TZnLA9Kj23cuJO/raV9//308wWdOngtRufJcPklVibAc
	DRSzbdVzwD5ZEEPKO2MKKonfapt3s3fl10eSV8VRGpvUcM/gQybj9t2pSeiRHGP8TdRSRV
	XLRUxynmHbuTvlR0prY2EqyfTuBKSws=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-r79btMwjNJWMB0x_odPoNw-1; Mon,
 26 Feb 2024 14:03:48 -0500
X-MC-Unique: r79btMwjNJWMB0x_odPoNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78A633C14942;
	Mon, 26 Feb 2024 19:03:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 50ABD492BC6;
	Mon, 26 Feb 2024 19:03:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com
Subject: [PATCH v3 09/15] KVM: SEV: disable DEBUG_SWAP by default
Date: Mon, 26 Feb 2024 14:03:38 -0500
Message-Id: <20240226190344.787149-10-pbonzini@redhat.com>
In-Reply-To: <20240226190344.787149-1-pbonzini@redhat.com>
References: <20240226190344.787149-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Disable all VMSA features in KVM_SEV_INIT and KVM_SEV_ES_INIT.  They are
not actually supported by SEV (a SEV guest does not have a VMSA to which
you can apply features) and they cause unexpected changes in measurement
for SEV-ES.

Going on, the way to enable them will be to use a new initialization ioctl
that takes the VMSA features as a parameter.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b46612db0594..2db0b2b36120 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -252,7 +252,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	sev->active = true;
 	sev->es_active = argp->id == KVM_SEV_ES_INIT;
-	sev->vmsa_features = sev_supported_vmsa_features;
+	sev->vmsa_features = 0;
 
 	ret = sev_asid_new(sev);
 	if (ret)
-- 
2.39.1



