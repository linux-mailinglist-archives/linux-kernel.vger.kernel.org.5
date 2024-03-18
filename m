Return-Path: <linux-kernel+bounces-106739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6287F2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA331C2168B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE95B21C;
	Mon, 18 Mar 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ+druJ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325A5A102
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799810; cv=none; b=mLuG597vmkAeazts66n42coAFKdjl+N6VYqPVgRB+dGcxrLQl8KDj45lpthfxWW/Pe+VkmR2WElqWBfYCDdunBXgxQ+uVTHL0JwkkmnSdVAtiLQcLBKfsER6D5sSQDAiGvhnZZNNnvm5Xq2DChYCqKTBLAY7ljujh56Gmn6v9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799810; c=relaxed/simple;
	bh=pUDyVdDIhWF+AxxFzQPbcKbrYmlXF2FtVHpKnNJHuHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHB/5fsgd2VFOP9CVVk87pkzOpic6vFMrFobcAusuZEY+mU3qevj9N1Xu+BU8ul6YVxYOoFLMWM9voWxKNNOByI9dhM+sQJ9dICOVcpdUthSsJYVtLfjImZVHZfhJbjRfiT16cfX+L+3elJumli8VwN5ITY5X5juYU7V9FUKmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ+druJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710799808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIk57Yw9TtyXvEW7JA55T78f0IPlsLYi8PGmRhytf78=;
	b=TJ+druJ4T2bRtEBGJr6B2mGfJuWYB8ZEpdfoODMc8GJ1GGnG648inWL2xPdGsMKkqMfGjT
	BTwi4qxyOeNlVd8V5gsbvt9O8w8NzK7wWvty9UVxmX1EFLM16iEqrrzCYyvSOrDv0caX3r
	KFciJCAShsIf+DYlgIzcl+1/wQQ5u9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-3C53FmV2MF685amG0XGf_A-1; Mon, 18 Mar 2024 18:10:04 -0400
X-MC-Unique: 3C53FmV2MF685amG0XGf_A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C500C185A781;
	Mon, 18 Mar 2024 22:10:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A31DD492BD6;
	Mon, 18 Mar 2024 22:10:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/7] KVM: SVM: Set sev->asid in sev_asid_new() instead of overloading the return
Date: Mon, 18 Mar 2024 18:09:56 -0400
Message-ID: <20240318221002.2712738-2-pbonzini@redhat.com>
In-Reply-To: <20240318221002.2712738-1-pbonzini@redhat.com>
References: <20240318221002.2712738-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Sean Christopherson <seanjc@google.com>

Explicitly set sev->asid in sev_asid_new() when a new ASID is successfully
allocated, and return '0' to indicate success instead of overloading the
return value to multiplex the ASID with error codes.  There is exactly one
caller of sev_asid_new(), and sev_asid_free() already consumes sev->asid,
i.e. returning the ASID isn't necessary for flexibility, nor does it
provide symmetry between related APIs.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240131235609.4161407-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f760106c31f8..7c000088bca6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -179,7 +179,8 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 
 	mutex_unlock(&sev_bitmap_lock);
 
-	return asid;
+	sev->asid = asid;
+	return 0;
 e_uncharge:
 	sev_misc_cg_uncharge(sev);
 	put_misc_cg(sev->misc_cg);
@@ -246,7 +247,7 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	int asid, ret;
+	int ret;
 
 	if (kvm->created_vcpus)
 		return -EINVAL;
@@ -257,10 +258,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	sev->active = true;
 	sev->es_active = argp->id == KVM_SEV_ES_INIT;
-	asid = sev_asid_new(sev);
-	if (asid < 0)
+	ret = sev_asid_new(sev);
+	if (ret)
 		goto e_no_asid;
-	sev->asid = asid;
 
 	ret = sev_platform_init(&argp->error);
 	if (ret)
-- 
2.43.0



