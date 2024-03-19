Return-Path: <linux-kernel+bounces-108075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24D788059C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36771C22807
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8045786B;
	Tue, 19 Mar 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFGfVrGA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111753A29F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877446; cv=none; b=K/SfscoOcUiwwCR3BDjKeW0x49nlA6/a4CRdvw1l5xp8H7Nbidhd0/mXWnv5+Rz8DHBw5kAM8hGmXRVxoWApvdLKf8/6/JsQpQuvS6VF9GZ4Wr+/sSQNb8OPper1uMd/0rJxaI0SFLz+LqUgxtJ/Lzajkkrw0KIiROVUaqG4Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877446; c=relaxed/simple;
	bh=YPTM1T70r+StwrYOX5kIVeUVf2/7dW9x9jVyxzH4fig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWG0LBAqOGL/9krnn5y0s7vV9LsHIkbpcx9cJeOOXc8ICwzGdYRQzi75apDB3OGCUtXmGmeI0WwSGZ/TZb1VtBZCAU1wqRIzJhTtW3VG72MSRX1HHCVR2mAK45VyWVIRFSY0XBVO8RtMnNQIgsFu5xCMnofQ4MA/qfWeSixyrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFGfVrGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710877443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDt7X7yNhjVARhSoo5jN+fQwr1OciTrVloAsDOU8mSc=;
	b=JFGfVrGATkBZm3YSg6jDQlr4NyY5E8PME5jV5+zWzTWzOjQs05OXDrt/qNfALH9Nl9e+Fy
	KgMcIMgv1Ba/DTcpTfFSsdtKayARNBtltcztrfF/r6vR1QYI+8wLJQzo6ffbNiTQ7OYhO3
	WHnl//Qeqhuyf38fvOuKHgwB7+dhHE4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-jVYbmsx4OL6fsaxiYfMHhQ-1; Tue,
 19 Mar 2024 15:43:58 -0400
X-MC-Unique: jVYbmsx4OL6fsaxiYfMHhQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39D7E3C0252B;
	Tue, 19 Mar 2024 19:43:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1507A492BCA;
	Tue, 19 Mar 2024 19:43:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	seanjc@google.com
Subject: [PATCH v4 16/15] fixup! KVM: SEV: sync FPU and AVX state at LAUNCH_UPDATE_VMSA time
Date: Tue, 19 Mar 2024 15:43:55 -0400
Message-ID: <20240319194357.2766768-1-pbonzini@redhat.com>
In-Reply-To: <20240318233352.2728327-1-pbonzini@redhat.com>
References: <20240318233352.2728327-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

A small change to add EXPORT_SYMBOL_GPL, and especially to actually match
the format in which the processor expects x87 registers in the VMSA.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/fpu/xstate.c |  1 +
 arch/x86/kvm/svm/sev.c       | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..eeaf4ec9243d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -990,6 +990,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
+EXPORT_SYMBOL_GPL(get_xsave_addr);
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cee6beb2bf29..66fa852b48b3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -679,9 +679,17 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->x87_rip = xsave->i387.rip;
 
 	for (i = 0; i < 8; i++) {
-		d = save->fpreg_x87 + i * 10;
+		/*
+		 * The format of the x87 save area is totally undocumented,
+		 * and definitely not what you would expect.  It consists
+		 * of an 8*8 bytes area with bytes 0-7 and an 8*2 bytes area
+		 * with bytes 8-9 of each register.
+		 */
+		d = save->fpreg_x87 + i * 8;
 		s = ((u8 *)xsave->i387.st_space) + i * 16;
-		memcpy(d, s, 10);
+		memcpy(d, s, 8);
+		save->fpreg_x87[64 + i * 2] = s[8];
+		save->fpreg_x87[64 + i * 2 + 1] = s[9];
 	}
 	memcpy(save->fpreg_xmm, xsave->i387.xmm_space, 256);
 
-- 
2.43.0



