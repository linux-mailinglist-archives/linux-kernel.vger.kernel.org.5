Return-Path: <linux-kernel+bounces-88242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1486DF10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A91F256F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8536BB30;
	Fri,  1 Mar 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFw+Y0w0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0227482C1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288059; cv=none; b=RaJaGbWKl0mP73C8klTxLIMdlOVwUte3jtuGatHn3jyKuMsBLvcd10kkI/FIllhKx5M9yQyh6Vdz7Ifl7aMYhQBoHBCozSZf6yzekL1Wefq1hh/i0G/lY3ZkGBXUPFnzQ8/s2igaHafbKxvmo3c2jTdWBlYwxEp99Vb9xlVpa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288059; c=relaxed/simple;
	bh=sND8jhV+K31Cz2knDCDV+qPQDZGZA9Xo2gOcAqB/Ihk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0TUPBcgtHu4fo2amigbLPAen3C9pUuP36keV2JXe1GIZfWqHeqAYoue3CIYxLKLq9sHGJ4X5wGXuI+pVpCx5prHGk4dhZmvFGj4RA6cACFJRfltOKYnpVsd+B02mL/6lB4wvPHtHRCP5NMXCIMQ07SkU9geYi+10vEJa17Xa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFw+Y0w0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709288056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8s8i3ItjA9wi3+gOCrDxEDREoSwFyWHMRuQO27hhEhI=;
	b=LFw+Y0w0hJfgELuRZEednBm9tLxacgYYRxEzEenyGYwdQ3fsbgbReZ2+OnOE4pxHrbsvIB
	7M4jWKTaIn9JCdrooHriobTg6dWRN8CLOjaPuLfES/pu5uQh6DdWUGXpbJYQJML8voSpvw
	XUK8EdLr+SKyMM86h5/4ERhepnHFna4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-c4D56yyKOrai0fd5slYOSg-1; Fri, 01 Mar 2024 05:14:15 -0500
X-MC-Unique: c4D56yyKOrai0fd5slYOSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDBD68B39A1;
	Fri,  1 Mar 2024 10:14:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8859920229D6;
	Fri,  1 Mar 2024 10:14:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 11E471801492; Fri,  1 Mar 2024 11:14:11 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: kvm@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 3/3] kvm/svm: limit guest_phys_bits to 48 in 4-level paging mode
Date: Fri,  1 Mar 2024 11:14:09 +0100
Message-ID: <20240301101410.356007-4-kraxel@redhat.com>
In-Reply-To: <20240301101410.356007-1-kraxel@redhat.com>
References: <20240301101410.356007-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

If the host runs in 4-level paging mode NPT is restricted to 4 paging
levels too.  Adjust kvm_caps.guest_phys_bits accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e90b429c84f1..8c3e2e3bd468 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5229,6 +5229,11 @@ static __init int svm_hardware_setup(void)
 			  get_npt_level(), PG_LEVEL_1G);
 	pr_info("Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
 
+	if (npt_enabled &&
+	    get_npt_level() == PT64_ROOT_4LEVEL &&
+	    kvm_caps.guest_phys_bits > 48)
+		kvm_caps.guest_phys_bits = 48;
+
 	/* Setup shadow_me_value and shadow_me_mask */
 	kvm_mmu_set_me_spte_mask(sme_me_mask, sme_me_mask);
 
-- 
2.44.0


