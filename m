Return-Path: <linux-kernel+bounces-50747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB62847D8A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020A31F2CF43
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03B2CA5;
	Sat,  3 Feb 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCaTiZpY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BBA3D
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918965; cv=none; b=VnZTwGcilGVzJAdHQi6K8QtHUNf7aL4HMKLemZAJ7v+4zzVZXuEB5V9xDa9M6sTtJfSjZA4jt2ZS9xWiqEGN4np7nVfDWYTrjvJ8b7bHfHGat0WxIKJ1EoGvlmZVsMPic7NiQpQ61U6j7HXEt5ae6ZJW3VKssBF2ACDbrGYAJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918965; c=relaxed/simple;
	bh=DQsGPwFy3v7uPs21OAJ9r/tyAnYHLR0BBzOxzUXWZ6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmLEgVOj9Ug56sjY/bxKEHiEi92edaYEbZkspBMkvl6GhMMkxq20KFIH5ur6oS3m658eTWlSNTxZWqZH2IjLoQqZmc+OumK+O1UiSvMVc1eZIscXl9gGqLnF+5cpaKoHa4FyyWSKMlSdVyWnAUt9QUh5JRMxBVN690lfX/HWvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCaTiZpY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so4559097276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706918962; x=1707523762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OEEHd6q2TChurvVJ9QWQDtWt/fR7D+phxscUNFsCU/w=;
        b=NCaTiZpYfUYV6aEyCd55jbXAuVRLGHmocKLd11khnbFf2d5SITGcQY1/VCKor88P6T
         3b1ofVmwetI1rzqzVVhX9zsr0ixBt1+8QA5DkNfal0P9y24cGACiyD0+QNg2rf3iIX2K
         y0QwynEX1sSrkt5ZVdphd0vqyUU2M40rf5B3GIQMmAfilEss7MmkQYdSMR1XOoTxBu9+
         vCO6+der2su51qtCCadahvKTHcYjoA18XH4IGAyg/k6PKdjw16h6G2a/Bhfu7JXKKO+4
         jHyCBvzhLs7M2NDnF+eMpyWLdL5BovQm6CW8l3FcjnKmI1mdcLiYjYDm0ipJvfSdJHz/
         XCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918962; x=1707523762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEEHd6q2TChurvVJ9QWQDtWt/fR7D+phxscUNFsCU/w=;
        b=hBaRGzePA22hVUb+qcsH6hfLZPbzglz8CaDzikIzXrnKzUTAVh9f5NbI8HmPQzx5UC
         XSBkDG7l3OMe8yWEqvek5MM1PBVBM+OOpynBY7ubAPJ9FLvXlR0WdSzREI1JiOl4OTch
         PUbe1qATAiW+dYPC8VCMK+93I1uBRU+xFJWe7ngjQvM2tfsUrrWeYgDYNibCK4S9izYK
         FNajYjygnhnE4e7RWdQK6GQgwLYEY/e8oVWUCXfjy8ztkM8xr9X6ZmmkhuCrCaoKHCgN
         ff2I4rU8l8//p0MgFkcUM7PJAMmFxJ2nOuXF21APseMJkprcRWOWXvCZgALkXot7ZVL6
         hfbg==
X-Gm-Message-State: AOJu0YzYgBnFtVBhYVL5UKf965jwm/Pr/gz2jMHP3P1u2bGVHw5+D1qr
	/4EPmgDzKquFx+NMVi/pwkq0xlGJBzRfD1S8ahSBy2FvLS8ltE3VeNtQ+ttRN+NdkfAYH0WOQAV
	9gw==
X-Google-Smtp-Source: AGHT+IEcnlTVvkgM/agP2AI7SK0XtZwpf1RNWRzpnYbOzQzjKWA86nEjOukuZ0+7uKPyvsge0rWvGPAYF88=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2402:b0:dc6:e7e8:caae with SMTP id
 dr2-20020a056902240200b00dc6e7e8caaemr1059362ybb.0.1706918962763; Fri, 02 Feb
 2024 16:09:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Feb 2024 16:09:07 -0800
In-Reply-To: <20240203000917.376631-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203000917.376631-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203000917.376631-2-seanjc@google.com>
Subject: [PATCH v8 01/10] KVM: selftests: Extend VM creation's @shape to allow
 control of VM subtype
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"

Carve out space in the @shape passed to the various VM creation helpers to
allow using the shape to control the subtype of VM, e.g. to identify x86's
SEV VMs (which are "regular" VMs as far as KVM is concerned).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 9 +++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 070f250036fc..d9dc31af2f96 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -90,6 +90,7 @@ enum kvm_mem_region_type {
 struct kvm_vm {
 	int mode;
 	unsigned long type;
+	uint8_t subtype;
 	int kvm_fd;
 	int fd;
 	unsigned int pgtable_levels;
@@ -191,10 +192,14 @@ enum vm_guest_mode {
 };
 
 struct vm_shape {
-	enum vm_guest_mode mode;
-	unsigned int type;
+	uint32_t type;
+	uint8_t  mode;
+	uint8_t  subtype;
+	uint16_t padding;
 };
 
+kvm_static_assert(sizeof(struct vm_shape) == sizeof(uint64_t));
+
 #define VM_TYPE_DEFAULT			0
 
 #define VM_SHAPE(__mode)			\
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4994afbdab40..a53caf81eb87 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -276,6 +276,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
 	vm->mode = shape.mode;
 	vm->type = shape.type;
+	vm->subtype = shape.subtype;
 
 	vm->pa_bits = vm_guest_mode_params[vm->mode].pa_bits;
 	vm->va_bits = vm_guest_mode_params[vm->mode].va_bits;
-- 
2.43.0.594.gd9cf4e227d-goog


