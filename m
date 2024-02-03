Return-Path: <linux-kernel+bounces-50752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB27847D94
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135F2282FA6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBF10A3D;
	Sat,  3 Feb 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjb9Ij/6"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F4EEAB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918974; cv=none; b=B3VhLB3Jc+9BNEdqpHcrYHvrL8PfOkjML5VeR4aQQlXQ7ovDnSGtMy3WWq+QxOeqU1SvE3JrFGXPK/x6GOB7qazbT9hHxkBze2AUJlUnQ/XMkZyiK+ewo/CaOQ5Wk3ThjqjJklDE+cw/VfRyMFTsVg9AVNE8RPQlqCZg0Ah0HFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918974; c=relaxed/simple;
	bh=D8mb0FRK9gpBnBRXkQEG+PB9Dag5X8x5Fbzx9RXG+Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SRk4pbz6DUHQ9B1mb7MntX64PU/+Wn6852aQ8zPT9iH191/hgaX9chfJ4eY2cLLCGmwczPU0BwbLxf9elKuGApHoWIPgBde9kSmnuH4A9o72ta9321HpzcPpZ/1uzm2wraG0dQZnjSEdzkHpsRWQi2gsD71kCqDx5u17bX/ot1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjb9Ij/6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d45d23910aso26054245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 16:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706918973; x=1707523773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uGdQAEk26j5OxpYXu3PaMK7EeL8Au0IOP5m2/Y3bZT0=;
        b=vjb9Ij/6tmv+EekvnSYVIlmbw7VBjrmOZp+aU/COej0BFX1gexhugakIc0C53NjjGf
         TUcpWjHo/jGoTlU8hnPwYl9yQX9h7/J13VZydkPJ1EGR+vSL8Qv0b8/LzSTT/FPCBXCx
         avmHI0sDDTogW2uBzRhR7LtPj1NUvlqfdkm8mho8NPTd9cKZnMIvMtewqNmPDxTZ6+Wr
         nXExugYjWuWs3H8fTsWvW1XvYdSgqrQnqvXBPSBZaiJlLzPtnRcp/YkKZ4CxlBraZ3Sr
         aHHyXufNt4tSytE6stJz1IU5aDrxRRUAdlKig4Iyd24OVyWTq1pxjhT655Vp8Zhp7Q9G
         3bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706918973; x=1707523773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGdQAEk26j5OxpYXu3PaMK7EeL8Au0IOP5m2/Y3bZT0=;
        b=tHYgnBPIV0E6S7J1bcogqYImJUkArQ63WW0XjLsW02Vt1pxi5/QMifZkMS5nfYbo7X
         7mznFbRlw6huR0SXjtNY+3REzS8JDeHwmrJU7zTybhRqIwHEezBe9YWlxWSd7uP0ggyU
         zzcqTiyDZWXRmUXf0UZvTxnxqg9e/zfslDSe2Z3sq5dMbdsG5QYCOsUKiRlfSSNOk1mB
         clbm15vp55G6xE76Ha2VObxao3GiYCDKyvRVT9mFsYpZun56Cl0zn1K5z9cV5JWMGKxc
         5kXarr/K+lNhUuU4NkxQ7PbHC2Jtb2LFbiwFfmL8fDS54MBkX7H0KEqoeb7tT0CCg7qx
         AF/Q==
X-Gm-Message-State: AOJu0YxTkYiZOdWpqbYGnPzu7/RCGYKN1m4CVltfLJxeStZzNYpiMsYI
	phyY11G1zESkCeROTQuDFFYXmIzNK7RburBNGCoeRN+nogxOjUrXurEpXj3Yvp3sYVYIMi5hKvW
	yWQ==
X-Google-Smtp-Source: AGHT+IFjC15kDw5iExzgefryGqdvDfKmWm4cQaCALbm/PwXRZkCDFthW43qe2jb3I/GBr57667GkOb1b5Sk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80c:b0:1d9:855b:629f with SMTP id
 u12-20020a170902e80c00b001d9855b629fmr3990plg.11.1706918972726; Fri, 02 Feb
 2024 16:09:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Feb 2024 16:09:12 -0800
In-Reply-To: <20240203000917.376631-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240203000917.376631-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240203000917.376631-7-seanjc@google.com>
Subject: [PATCH v8 06/10] KVM: selftests: Explicitly ucall pool from shared memory
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

From: Peter Gonda <pgonda@google.com>

Allocate the common ucall pool using vm_vaddr_alloc_shared() so that the
ucall structures will be placed in shared (unencrypted) memory for VMs
with support for protected (encrypted) memory, e.g. x86's SEV.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerly Tng <ackerleytng@google.com>
cc: Andrew Jones <andrew.jones@linux.dev>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 816a3fa109bf..f5af65a41c29 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -29,7 +29,8 @@ void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 	vm_vaddr_t vaddr;
 	int i;
 
-	vaddr = __vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR, MEM_REGION_DATA);
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR,
+				      MEM_REGION_DATA);
 	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
 	memset(hdr, 0, sizeof(*hdr));
 
-- 
2.43.0.594.gd9cf4e227d-goog


