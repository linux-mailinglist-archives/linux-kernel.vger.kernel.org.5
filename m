Return-Path: <linux-kernel+bounces-77581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24A8607C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531D32869C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338CAD32;
	Fri, 23 Feb 2024 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSkTntJj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989F28FD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648985; cv=none; b=K+rlVpse3qYyo72JIIdQKAlMM4lmpgkNJXcbxutBQIGN807Ek79QjUxdlMQWGzT/QVx9casVCaYBMjJraGKbzW6kgdcGTl+bFXz1ARJBdA4uNvkI5BSFuXVd7J3U7K5SqmzFw4+HQTzJMl8VjGfw/Bxs5Z4uPrST6cga+RdWY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648985; c=relaxed/simple;
	bh=pRhaWQopgyeylx63BqxVOojIfSEkv0VhiWmUmKJ6n8U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hmSoQpOHbc6+KbiKOO+fgezCqGov8bHin8GndFAXe5oAUJ0U3bpcsedv0xAGh8+s70gVmIrAUIyq3tLnxUKgPxfUGO87bEcgyZLzybd6OXFDoMiZ+kYpMJuSmV72yPhy2Ale7H+eKueNwZtiYz5YkJ4Dln3ZbhpTwOODnmUOApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSkTntJj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so423739276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708648981; x=1709253781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zjc59DluW49ttFqszZ9w9JOq4NwZpI0t2wGHcPtZrIc=;
        b=OSkTntJjMiV/7KE+PSmxSTP+suksaP0o7Xaj5oPhU6mewsEkUbZ70Aq6Gk2ytT4s5q
         PuhBV7FYpwGaX1rab6Ruw/wSLv3ORYXsfgmvVrGYQEb8AAO9UH1dD6IqzflS6ImMXcW3
         37leqbl/MDbOlNFV1mm8sd4scmeiTDtDIjUoIJQI9SgmX5wTh8ZO0kDotk1244BgI32F
         FV69bGkYvhc0Goj87Mj6Uw0ym8/26Oun9C04RvMayQILHvi5wySzITv1g3aW2KfMS7QK
         c13cBpEz8UW+JJxXk+60PNGpej85KV9aLE9pzCYvQeQ+32XKTR97ntNAYyyb8OLpWMPl
         7JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708648981; x=1709253781;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjc59DluW49ttFqszZ9w9JOq4NwZpI0t2wGHcPtZrIc=;
        b=PAFWwMN3cHceWV7S0t4j2dU1Y4Gl3X/0FgnnKQRHppvUL2L0s46JSpisSclBqfyGvV
         FuMBWgOfgeG1Ncb438hmALdMPs+gYbGF692Y8pkjRFqVDGUWgWTE0OlwjP+UHbOLAG3s
         MHw+k/2/tLbX+PCziUBg3SAfGIgLibmIGOe8v0iL2qO+1+qHq7Kr261sdYFI9oIOuv9e
         +y2s8+F5jnSZYcyQ5DfkwzAvENdUjNHBnvkQTDzyMr9JITjZqUo1SIqu5OYu+uStFP01
         EbW0Z4Q+VmXqlPFGxoM1mG3+5tRwcWS7aTk7h83Wcz8VrAxtXE82S3A1KiANYdJ6jdeE
         7Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCXPuA7eZoIY9fkz96LX8eb0xbxk2OLOWIuIoUKjBLbZf0604TKp7EssuSS4ioD8UikjFeGaZaelgyn+qB5iJG4rW1+OJ3tZ/01NkYQ5
X-Gm-Message-State: AOJu0YxDhcYHdWS/54YKaZp6t1/L2tLmJYASQZDuxZPfvuZiRacrtQ72
	uSNBPrDPlHv/XtWyj+sdgyIcnUE7BOTgYycDpssv/nJR0q+PnkfwpZhwyYYXvyHn3X+WwMUgUff
	nmg==
X-Google-Smtp-Source: AGHT+IG1xzJWlosTep8wtCbhiO7612+88ajrhSavDwxiYQqemKwzSboM+bUS3n19nYfTfskN3+FLs1ydHTk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:68d0:0:b0:dcd:c091:e86 with SMTP id
 d199-20020a2568d0000000b00dcdc0910e86mr26998ybc.13.1708648981584; Thu, 22 Feb
 2024 16:43:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 16:42:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223004258.3104051-1-seanjc@google.com>
Subject: [PATCH v9 00/11] KVM: selftests: Add SEV and SEV-ES smoke tests
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
	Michael Roth <michael.roth@amd.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Peter Gonda <pgonda@google.com>, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Add basic SEV and SEV-ES smoke tests.  Unlike the intra-host migration tests,
this one actually runs a small chunk of code in the guest.

Unless anyone strongly objects to the quick and dirty approach I've taken for 
SEV-ES, I'll get all of this queued for 6.9 soon-ish.

As for _why_ I added the quick-and-dirty SEV-ES testcase, I have a series to
cleanup __svm_sev_es_vcpu_run(), and found out that apparently I have a version
of OVMF that doesn't quite have to the right <something> for SEV-ES, and so I
could even get a "real" VM to reach KVM_RUN.  I assumed (correctly, yay!) that
hacking together a selftest would be faster than figuring out what firmware
magic I am missing.

v9:
 - Drop is_kvm_sev_supported() and rely purely on KVM capabilities.
 - Check X86_FEATURE_SEV to ensure SEV is actually enabled.
 - Collect tags. [Carlos, Itaru]

v8:
 - https://lore.kernel.org/all/cc9a1951-e76c-470d-a4d1-8ad67bae5794@amd.com
 - Undo the kvm.h uAPI breakage.
 - Take advantage of "struct vm_shape", introduced by the guest_memfd
   selftests, to simply tracking the SEV/SEV-ES subtypes.
 - Rename the test to "sev_smoke_test" instead of "sev_all_boot_test",
   as the "all" is rather nonsensical, and the test isn't booting anything
   in the traditional sense of the word.
 - Drop vm->protected and instead add an arch hook to query if the VM has
   protected memory.
 - Assert that the target memory region supports protected memory when
   allocating protected memory.
 - Allocate protected_phy_pages for memory regions if and only if the VM
   supports protected memory.
 - Rename kvm_host.h to kvm_util_arch.h, and move it to selftests/kvm where
   it belongs.
 - Fix up some SoB goofs.
 - Convert the intrahost SEV/SEV-ES migration tests to use common ioctl()
   wrappers.

Ackerley Tng (1):
  KVM: selftests: Add a macro to iterate over a sparsebit range

Michael Roth (2):
  KVM: selftests: Make sparsebit structs const where appropriate
  KVM: selftests: Add support for protected vm_vaddr_* allocations

Peter Gonda (5):
  KVM: selftests: Add support for allocating/managing protected guest
    memory
  KVM: selftests: Explicitly ucall pool from shared memory
  KVM: selftests: Allow tagging protected memory in guest page tables
  KVM: selftests: Add library for creating and interacting with SEV
    guests
  KVM: selftests: Add a basic SEV smoke test

Sean Christopherson (3):
  KVM: selftests: Extend VM creation's @shape to allow control of VM
    subtype
  KVM: selftests: Use the SEV library APIs in the intra-host migration
    test
  KVM: selftests: Add a basic SEV-ES smoke test

 tools/testing/selftests/kvm/Makefile          |   2 +
 .../kvm/include/aarch64/kvm_util_arch.h       |   7 ++
 .../selftests/kvm/include/kvm_util_base.h     |  50 +++++++-
 .../kvm/include/riscv/kvm_util_arch.h         |   7 ++
 .../kvm/include/s390x/kvm_util_arch.h         |   7 ++
 .../testing/selftests/kvm/include/sparsebit.h |  56 ++++++---
 .../kvm/include/x86_64/kvm_util_arch.h        |  23 ++++
 .../selftests/kvm/include/x86_64/processor.h  |   8 ++
 .../selftests/kvm/include/x86_64/sev.h        | 107 ++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  67 ++++++++--
 tools/testing/selftests/kvm/lib/sparsebit.c   |  48 ++++----
 .../testing/selftests/kvm/lib/ucall_common.c  |   3 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  32 ++++-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 114 ++++++++++++++++++
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  67 ++++------
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  88 ++++++++++++++
 16 files changed, 583 insertions(+), 103 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/riscv/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/s390x/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c


base-commit: 60eedcfceda9db46f1b333e5e1aa9359793f04fb
-- 
2.44.0.rc0.258.g7320e95886-goog


