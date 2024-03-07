Return-Path: <linux-kernel+bounces-95734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD48751E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9C01F264ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CB1E48A;
	Thu,  7 Mar 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oPy5Ka8A"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C3161
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821840; cv=none; b=oB6cXRZOrD6pLymIN5ePd8ZtyYTfIJpo4zT3EUmv771TjwphczJ2SjVBVCaV4AIwfYqEMp2wBv8MNfvk4MqxMxPtGuxXh6IfWON3dGeb1HQDOT/Ie2yQT6sk7UEczWxxETrLbuiBakflqiuKmVVVkNyclIBa9LV6XdyKEGjCYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821840; c=relaxed/simple;
	bh=b8c2rbZQCm2Gm0FG6LOTNUT6P2d2I+qVsfeJAtpoIyI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p+EC8jpSNlp+O9xIAdslueyfPzxXx4z2iKhpZkKfSq9nbkmG/7S9nssuqSsUen8ggipCuLxaD8wCsd9dqu1P9Cepo/bjMOFV7DaHSKKU63NR6X5io6NlExM2TxenILCMsog16SDirHs69ofcPFbg1DtmaZPog6rGfLFyL69XKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPy5Ka8A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4129fb7a631so6124885e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709821836; x=1710426636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=83Bewg3+akMvf+sHLDReU3DGma3K6LrqnSOngHQMXXI=;
        b=oPy5Ka8As4ANNBPE8VhSkPrDeEWSl04Ik118MIR6QR0f0QlAWQYvbiZtlmOc3Bjx4C
         pHVWKkTRh4JivBY+ErM/yWoeTH4if6nn68jLyW4jLNYOD5l59yrCVYBVSx+/Z4aW9sl1
         +dhI8YHXw8a9xcmbl2PJ+QGzedm9umeNJq7tFxXq7W2Ue61d4ttcKVAhzYs36VpTkdjr
         Nu8aQNjaYqU+rQkaeVyAJjYXjLp8tlZTKYsG9GSUo1dgzz55Huw/cPkUs6SlZ01ul3X2
         NGxbBvtiKHB7XlDkzADfFDCZe/6SduCpiHUkWq5cTFJKrhUiUhA2uOxymNJ9we67pUwl
         q2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821836; x=1710426636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83Bewg3+akMvf+sHLDReU3DGma3K6LrqnSOngHQMXXI=;
        b=HDkbG+ol7unQCuTgWL9ABIi17mNwhPz5v2OX1PwRCKKjDTtBV/C7/rywGc/O0teIJF
         AKuOATcxbnmz3YaziB7evJODyjv0tyDI+owSc1hy8hUFEQ5//L1rxaw8XOD1H9f8NKPQ
         lPtxiSx8ukqbw6AXrGlzK1yHSoyZ9HS+ECBM6CviIaCMPxcLIyrjNMfwGXH6us6pScnv
         t5dJEq6ArlgM2Zqc2beN/UQXBREzejMHtJ7ar+xlGF4wUHfwfFIywDktq2/Ft0WMtRBg
         U/1BNt8qiYzG7h62GXWMRbZaSvJBt3lxldalLdv9PysPdUAH2dWzthR4fNz9uHCkUyXo
         sDmw==
X-Forwarded-Encrypted: i=1; AJvYcCUJkDV7Kk9TvyaqNJGFKtJ4g+IjHyHMXnnfSNckDIG0DbkuwQOPpxiUtJk7R/NzEI3obyYoBnLQYbaTKo/MPeGczrfQTXrQdTRCUJkM
X-Gm-Message-State: AOJu0YybuK/SIK9jXaodpg7HbwaNCAdR60SKYhpoaD1o+5LcaZ5bKWyi
	3tpdC4usYgNYtsS0pmbJ7nrDdcNBEC1tTwFGabrS9UeIneqOZK+Gul6ihixV1b1omjoJNQ==
X-Google-Smtp-Source: AGHT+IGxScHufKt4KgVt8PheC/LLxMRlHFOpN/XeeJQjUOmrt91fKvLdxmN9MDdy2n479Q+YnFJJhb+r
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b82:b0:412:ed43:df5 with SMTP id
 n2-20020a05600c3b8200b00412ed430df5mr169103wms.2.1709821836482; Thu, 07 Mar
 2024 06:30:36 -0800 (PST)
Date: Thu,  7 Mar 2024 15:30:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=ardb@kernel.org;
 h=from:subject; bh=z7isjpuMYk5LTI5zyvNF+op06Ai4h/PbldOC/OdgFqI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXl+WZOkWAH7u/Gr7bf/VleJTllZ4GWx7KQJk/Z4Ghn9
 evXQp06SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQ+2TP8j9sb/NY4QesAa2Km
 ecaHL3Yi5svU6l+8Wln/5vH3A0KKPxj+2Zczvlu7Uybb9mthd92XR1UZrJu+JF9pu7v3m9r+nzr OzAA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307143027.206179-6-ardb+git@google.com>
Subject: [RFC PATCH v6.10 0/4] x86: Rid .head.text of all abs references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@google.com
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Questions below!

This series removes the last remaining absolute symbol references from
head.text. Doing so is necessary because code in this section may be
called from a 1:1 mapping of memory, which deviates from the mapping
this code was linked and/or relocated to run at. This is not something
that the toolchains support: even PIC/PIE code is still assumed to
execute from the same mapping that it was relocated to run from by the
startup code or dynamic loader. This means we are basically on our own
here, and need to add measures to ensure the code works as expected in
this manner.  (This work was inspired by boot problems on Clang-built
SEV-SNP guest kernels, where the confusion between RIP-relative and
absolute references was causing variable accesses to fault)

Given that the startup code needs to create the kernel virtual mapping
in the page tables, early references to some kernel virtual addresses
are valid even if they cannot be dereferenced yet. To avoid having to
make this distinction at build time, patches #3 and #4 replace such
valid references with RIP-relative references with an offset applied.

Patches #1 and #2 remove some absolute references from .head.text that
don't need to be there in the first place.

Questions:
- How can we police this at build time? Could we teach objtool to check
  for absolute ELF relocations in .head.text, or does this belong in
  modpost perhaps?

- Checking for absolute symbol references is not a complete solution, as
  .head.text code could call into other code as well. Do we need rigid
  checks for that too? Or could we have a soft rule that says you should
  only call __head code from __head code?

Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org

Ard Biesheuvel (4):
  x86/sev: Avoid WARN()s in early boot code
  x86/xen/pvh: Move startup code into .ref.text
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text

 arch/x86/include/asm/setup.h |  3 +-
 arch/x86/kernel/head64.c     | 38 ++++++++++++--------
 arch/x86/kernel/head_64.S    |  2 ++
 arch/x86/kernel/sev.c        | 15 +++-----
 arch/x86/platform/pvh/head.S |  2 +-
 5 files changed, 33 insertions(+), 27 deletions(-)


base-commit: 428080c9b19bfda37c478cd626dbd3851db1aff9
-- 
2.44.0.278.ge034bb2e1d-goog


