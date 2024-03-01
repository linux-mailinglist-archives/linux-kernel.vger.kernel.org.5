Return-Path: <linux-kernel+bounces-88244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2886DF15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DC31C20BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3106BFD6;
	Fri,  1 Mar 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGH8YR2e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838C6BB4E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288062; cv=none; b=EKWPudeZxMm7IqNp2WJecMzChoYH71ml5GDltGPdpsFgbQZicR7dGoQJPfch3sXJVjhW6Y381igN9b7mPcOONpxFBJoAlJd7oCAwXLbmUUf0L9868O2kMGhnIB4QZcYu2YhBrsoKA5YvOBZFOAoqWwCybChC7JIW7yoihFm6v3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288062; c=relaxed/simple;
	bh=x+nTTwmEfaKEpgrbbMiWdsUHJXOKVRsj2CPeKkTwj3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU7IIld8ELkkeuJexAMq/IrOZJDl/pjh7rfLJl/pzVx3LoNjjrk6S7oQ1bESfbZRIGn/XQmDFdBxbBXB+/cXjdl0DDx4hTyBSMPLJf8CWbG/i/1qyrk+JMT/QZF2L2VazxKG0FMP1KiEwp/GuiYWDoTaYFv5mR3k7cdHtKHoZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGH8YR2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709288060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+QSb4VJ1jHAbQmwW/SLNpPZK+rj9N/eRYzdT8VP+cg=;
	b=BGH8YR2eViefAlFVHWhVEuaPmGuqAi2oc5uPcCNvW/XdiiqfH27jHrbkpmyU1PuBaL1tyn
	jrpAaTzyS72X6V2c+det44shHYXWxBHabbIhgY1RJ5SO8FWIwNcJOZC6gKsMNbQIJGBMBN
	st4Xf7YD57zMbKtMlFmC9u4fLxNLBDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-QWOY9T-_N0yzeq7pYgncJQ-1; Fri, 01 Mar 2024 05:14:16 -0500
X-MC-Unique: QWOY9T-_N0yzeq7pYgncJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58473108BD87;
	Fri,  1 Mar 2024 10:14:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1F02166B33;
	Fri,  1 Mar 2024 10:14:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id DAB481801491; Fri,  1 Mar 2024 11:14:10 +0100 (CET)
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
Subject: [PATCH 2/3] kvm/vmx: limit guest_phys_bits to 48 without 5-level ept
Date: Fri,  1 Mar 2024 11:14:08 +0100
Message-ID: <20240301101410.356007-3-kraxel@redhat.com>
In-Reply-To: <20240301101410.356007-1-kraxel@redhat.com>
References: <20240301101410.356007-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

If EPT has no support for 5-level paging the guest physical address
space is limited to 48 bits.  Adjust kvm_caps.guest_phys_bits
accordingly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1111d9d08903..8bd644a5022d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7899,6 +7899,11 @@ static __init void vmx_set_cpu_caps(void)
 
 	if (cpu_has_vmx_waitpkg())
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
+
+	if (enable_ept &&
+	    !cpu_has_vmx_ept_5levels() &&
+	    kvm_caps.guest_phys_bits > 48)
+		kvm_caps.guest_phys_bits = 48;
 }
 
 static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
-- 
2.44.0


