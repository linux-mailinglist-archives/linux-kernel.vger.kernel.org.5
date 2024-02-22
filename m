Return-Path: <linux-kernel+bounces-77217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D822686023C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9262B28C3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B96AFA5;
	Thu, 22 Feb 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cA+0l/V"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAE14B825
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628796; cv=none; b=IegpyP/4sNfqxPuCtiMYJTbKT5J879dxyo/AQm1pZMGtpbqrjb/RL/KFQTmsRZar1YXkDjnasQjl3DuuGs7tkgjw3vl2BOxCqHHxaZgQsmKkbImjhfBZLUD3+kyX7modM0qtQnlSbaKRV0RoDTty5B5qtNNF4wgwupMpB48b73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628796; c=relaxed/simple;
	bh=DBKd2morSwroTrZIRb0qYYPphxV4+AKVqaeMPMvzsQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyLnr+FlG1HExKlp+JroAXDyBiOohIY58o0mCgxTJ8yU/E+ckZuqeiSk1rejx9MBIO8yfnFdy/JsD3kaq323KeloyzFiQaOBigT8Y4YVtSadQSkTYRU3YpXuE5HeHs00k28yv3xrqAodRNFhtaIzj7KwdS1Vm+jDGxrmBsAx5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cA+0l/V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so28927276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708628779; x=1709233579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MASCieoOmvRc5i6iG9M3g3ZXhEgirZz44Dugjtnu36A=;
        b=3cA+0l/VurD3QzleDHD1ODW5FfwpfP4zF+Jwp4hgjHGHZTqzG8CsGwTmac33GHMQw9
         eiqG7W/0d5Mm15lXHl7cB10RuLxvZWSdCpxbav8PUtdDIjC5jeIw71JDOFv0N4moUeup
         114k6ZB+2Qpl5mG7h3Up7Q5Boyy5aAkXi/36DfXvDxIvdi+WdbLTrtH/Jd03RZlWSQ/J
         dPGlHCf0hIfb4sd8frlQuEJYJ95daBv66aGdkomoSCOagUZ1Kh0yQZo/kIWkHeMWmZQC
         kDSF+6eT6ccSnGjZJ7FzsXKR/2TX7Q1pkpmvfbjfAD6Sih63eXKEvbCwSJu30CQi5l6A
         hxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628779; x=1709233579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MASCieoOmvRc5i6iG9M3g3ZXhEgirZz44Dugjtnu36A=;
        b=dWPqr5Y6Mtk/54u+AKB5loKzvrB7t+vp9pTf8Zy8I+6JuJsYrjAtXMPMYzQkDjTyFF
         sJRLQ8S/WZd6mOyk+hP1TVE7MAouKWghW7H/V1hU8SWNudlxjwYltAtoWXbDcNBMWlPc
         dZrybNWWANkj2EsWPRewOV4N6M0CMYu3B8b+YgK1CjN+uDsDCAnD5D7nyOloqG7vjnfR
         PeYzC6w33cT9Uo8QGCFryWjAsJ0TFwvSTardVicfBd0WwOmW5KJTaKy5nVSz5yq9uZuA
         OIFRuPPcF7ylZcUDupKfNQv8HjcVBBN+oBVB6tCq35eNCvahYhmtHXoVqk/HOWUvZGHb
         jsRg==
X-Forwarded-Encrypted: i=1; AJvYcCXAKTOLcTX1kA3gxnxpyad5AJABjKqtfYc8R4hOqiB7lhmf4bL3b9hLyn0Pv12kArHpYkHsJSriH5i2l//CbcCcw4q33XWKLiGfLhDn
X-Gm-Message-State: AOJu0Yzs6O/GopnW8KzOzwd4+dMuNofPfJkQtRy8scw1YtljzU7Ih0CP
	ccJWQd1ll8ZhtkWjTGBf3SdHWd/TAmZoOpgd7yPHummQKaeH0lAkLKCtAzKq9whnGHJCYwBzlgc
	AzQ==
X-Google-Smtp-Source: AGHT+IHzR4+OxBeBMa9TEXxxOXE/WUrye0G+hXJjfZ5qp8/7mtfxoxs2C+8UXluI/ahLVjx6JNA9HAA5PoY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2484:b0:dcd:2f2d:7a0f with SMTP id
 ds4-20020a056902248400b00dcd2f2d7a0fmr166ybb.9.1708628778771; Thu, 22 Feb
 2024 11:06:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 11:06:09 -0800
In-Reply-To: <20240222190612.2942589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222190612.2942589-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222190612.2942589-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it
 clear they're a WIP
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rewrite the help message for KVM_SW_PROTECTED_VM to make it clear that
software-protected VMs are a development and testing vehicle for
guest_memfd(), and that attempting to use KVM_SW_PROTECTED_VM for anything
remotely resembling a "real" VM will fail.  E.g. any memory accesses from
KVM will incorrectly access shared memory, nested TDP is wildly broken,
and so on and so forth.

Update KVM's API documentation with similar warnings to discourage anyone
from attempting to run anything but selftests with KVM_X86_SW_PROTECTED_VM.

Fixes: 89ea60c2c7b5 ("KVM: x86: Add support for "protected VMs" that can utilize private memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 arch/x86/kvm/Kconfig           | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index bd93cafd3e4e..0b5a33ee71ee 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8820,6 +8820,11 @@ means the VM type with value @n is supported.  Possible values of @n are::
   #define KVM_X86_DEFAULT_VM	0
   #define KVM_X86_SW_PROTECTED_VM	1
 
+Note, KVM_X86_SW_PROTECTED_VM is currently only for development and testing.
+Do not use KVM_X86_SW_PROTECTED_VM for "real" VMs, and especially not in
+production.  The behavior and effective ABI for software-protected VMs is
+unstable.
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 5895aee5dfef..4336b3fff0cf 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -81,9 +81,10 @@ config KVM_SW_PROTECTED_VM
 	depends on KVM && X86_64
 	select KVM_GENERIC_PRIVATE_MEM
 	help
-	  Enable support for KVM software-protected VMs.  Currently "protected"
-	  means the VM can be backed with memory provided by
-	  KVM_CREATE_GUEST_MEMFD.
+	  Enable support for KVM software-protected VMs.  Currently, software-
+	  protected VMs are purely a development and testing vehicle for
+	  KVM_CREATE_GUEST_MEMFD.  Attempting to run a "real" VM workload as a
+	  software-protected VM will fail miserably.
 
 	  If unsure, say "N".
 
-- 
2.44.0.rc0.258.g7320e95886-goog


