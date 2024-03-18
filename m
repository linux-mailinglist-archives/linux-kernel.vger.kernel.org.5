Return-Path: <linux-kernel+bounces-106809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBE87F40E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD59B22616
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21F5FDDA;
	Mon, 18 Mar 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6e33VYH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70A5F86C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710804842; cv=none; b=nfFTkVFL8BkxN85koDE2L3RmOdy0juDYhbhmcBxMnYO+fAoBHOmiuxtX4P2MRhNmH/gZiJe6HBYR1gFDhOTsqqTqCcTHTlaJ7h4VfTsUMDx+77Q7v4WZLR2Iy6Q1sHwbOlmiFEhQ+CNAsyS6XGxB8mM1/V4ZYQTQqb6CUgSy2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710804842; c=relaxed/simple;
	bh=EcmswukeZI313nMpV8tNY2A/YJT9P17ql1iH81L5DCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKp+kAVZsZBEzezcwaDmShGHkPMcQxaCYk9u3AjPRH4E8aRjS22JAZ6lTpZa+cEm46DVG/KFsgviXnJpmh4JwDlRVvSqdpxHBBkRuBpv2LKeE4b9d1UFt109gskZpA8UQbaTJTJBbeJU0KESEdX3r3i39qOUIX1NyW5NcfcUNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6e33VYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710804838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU08kKmFr2y+l/PfA7wEzPvqxMRumVnT+OH5USVjR9A=;
	b=X6e33VYHVnTcZTjXDsoToB27RZ5GMdb9WKMiSdkDO8YfmIWzf5m9xc3QWspQbapMPS0Jgg
	uP6iS/eTgBQByuURsCBpoZxe1NvRgw1bFBdQPcusWYe5zEC+A88OEGdShgMPF+yuxk9CeT
	ciQzwLpeBJ0XOHtss4H+RxAPHVUWrOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ueGFrfW5NUGeIrIZwqWvTA-1; Mon, 18 Mar 2024 19:33:56 -0400
X-MC-Unique: ueGFrfW5NUGeIrIZwqWvTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA9B101A552;
	Mon, 18 Mar 2024 23:33:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56A611C060A4;
	Mon, 18 Mar 2024 23:33:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com,
	seanjc@google.com
Subject: [PATCH v4 13/15] KVM: SEV: allow SEV-ES DebugSwap again
Date: Mon, 18 Mar 2024 19:33:50 -0400
Message-ID: <20240318233352.2728327-14-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The DebugSwap feature of SEV-ES provides a way for confidential guests
to use data breakpoints.  Its status is record in VMSA, and therefore
attestation signatures depend on whether it is enabled or not.  In order
to avoid invalidating the signatures depending on the host machine, it
was disabled by default (see commit 5abf6dceb066, "SEV: disable SEV-ES
DebugSwap by default", 2024-03-09).

However, we now have a new API to create SEV VMs that allows enabling
DebugSwap based on what the user tells KVM to do, and we also changed the
legacy KVM_SEV_ES_INIT API to never enable DebugSwap.  It is therefore
possible to re-enable the feature without breaking compatibility with
kernels that pre-date the introduction of DebugSwap, so go ahead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dc22b31faebd..1a11840facfb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -42,7 +42,7 @@ static bool sev_es_enabled = true;
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 /* enable/disable SEV-ES DebugSwap support */
-static bool sev_es_debug_swap_enabled = false;
+static bool sev_es_debug_swap_enabled = true;
 module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
 static u64 sev_supported_vmsa_features;
 


