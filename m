Return-Path: <linux-kernel+bounces-158500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA668B2153
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485C1B24108
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EB84E18;
	Thu, 25 Apr 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vDTFK80L"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926F12AAD5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046673; cv=none; b=Q6CePVJ/3U+qze0fNmSruijhy24nHrnOuDa5u0036fap046DjSasU0/K3kVbX+yaNwQLQBFV9ig5zhFbSKTr9igPnLhqugmv66T+kklOLN/dqskNBMzYnCMmH/Qm4Qzpu57agi8C4Lw3R/cHjJzH6bGkZDMRQGOfNn2LKL8IxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046673; c=relaxed/simple;
	bh=ytR3Vl0dN39S+AB04SdwTonDtyAReQA1wPyHLbia+N4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J8xCCFKuNQJTf3ud3GEBmFIimN89J9bVEQVapmQYrp5hPecsPujdFqKpbdmrSzBh/GU+0cSBHAJK2ECaIt0/1cn/rod8ko+IX8k00DnDNtkfy3GVMHVfwxC5qhHUmfiTw4/YsQCt2pwJDQ6cSAp+lI6U9hNZVxtmAYp8jVcudHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDTFK80L; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4169d69ce6bso4350215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714046670; x=1714651470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k4HkZiE9Bg1eMnr/aOhpvfPYeVv0kHg9/79ux86+D6c=;
        b=vDTFK80L1mGb5eP4VQUwKYZCmSPP1pILsnGBXh12v/JAmy8F9QbtEWuON7uHVDE8oJ
         3txS+L0Mtkst66Klj6O8pROrt3Js4DFE8hzG902g0qGrwSYEtbd3B9PJZPc0Zs1lvwHB
         teRuWLd7cfqiWqMbCRu9B2SuE9O08H4u8OPXa1MhZMIb08NWvfks+Cw3ASXA5DJyYdF1
         /hTRaK948ywNfrfK8E7Gb3VL54MVERB24ObU4mfleklPxZCyN+f2lmD9aa7R85SklI3L
         wznFf2yB4A3yrn7ee9wEzjcb9jWzfLJFAWSVGa1qILJexteh6vMvV9anadWksyTfAjxD
         uGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046670; x=1714651470;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4HkZiE9Bg1eMnr/aOhpvfPYeVv0kHg9/79ux86+D6c=;
        b=VDCpR5koOr+J7J0Dq09oW2Yh4k3hl/Tvu80JpoPdZcQuZsn0Qh7ZEF4/zixj28Ajzp
         RBedEyXVW4Srvn2kXliH7SN3x3WHQF9jMkS9Gj9rpccBNDgSCK2KdhLJZN6i8qeJI5n4
         eEMhfUPNujXz5DnRbFzKDMXDYJ2CiQmx/CZkuavgIbkrCvgO1tI2iDlu3e1/jXJaeHxU
         EqiSK0Wme/3UHvA0jKK9IOT6MXxenZ6acJkvluDvYiL/vSyCAUTfVz4QDstj8XWJO+iu
         q+fHReheDzwZHE/r4eU43XcWSP4/ErEo1ski5oqPx6D27Asnsam5U7IzBoM94yFr4G/s
         op+g==
X-Gm-Message-State: AOJu0YynAh593iloAB5Wi799+4FB52JPWgrakw0q6rCtwaEfX7qjdPnU
	hpHLN0lMQbLZroMDMA9wcHjs/lNHTSF3rM1y92hB7NfhUjuyZ+Ke2VOhgGsGRlLHZDsGjIuMSd9
	CNaYy3e4TtTfawQua3pUCfNmgBwSWyP/Bj6YLTfzz/A15+HviVzi9iv3V9hruGsKDzM8Xgi9TsQ
	GIu/AvXqo2WHv4sD+V4oDXctZopjO5pA==
X-Google-Smtp-Source: AGHT+IESdyWfxfQWyqLYwxeXWkAiIjXjf2kg6V6Tnoz0pXGoyXfgpp/3kESmFAi7Wr9I/ddg40BhMLy1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:6a0f:b0:41a:370b:edd0 with SMTP id
 jj15-20020a05600c6a0f00b0041a370bedd0mr22137wmb.5.1714046669650; Thu, 25 Apr
 2024 05:04:29 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=ardb@kernel.org;
 h=from:subject; bh=zTuY31jzZZlrgbz5r4jr3o5eeE+5xSEu+UgFKJ+mjPY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3L7aDBVabt3tZ3QmO5VgdFprzg8qmYdalY6EjN7Nu8X
 7X8jiV3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInM+svwV8ZtasbTGxtrWqIn
 2rpX1NxfVhVatKvw/ul/HTePvnx1dxXDX7GqSp1v++JqTlSsKZxQwxS982J2ThrTmSm7l3/9t/C QAxsA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425120416.2041037-6-ardb+git@google.com>
Subject: [PATCH v2 0/4] x86: Rid .head.text of all abs references
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
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
this manner.

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

Changes since v1/RFC:
- rename va_offset to p2v_offset
- take PA of _text in C code directly

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Brian Gerst <brgerst@gmail.com>

Ard Biesheuvel (4):
  x86/sev: Avoid WARN()s in early boot code
  x86/xen/pvh: Move startup code into .ref.text
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text

 arch/x86/include/asm/setup.h |  2 +-
 arch/x86/kernel/head64.c     | 38 ++++++++++++--------
 arch/x86/kernel/head_64.S    |  9 ++++-
 arch/x86/kernel/sev.c        | 15 +++-----
 arch/x86/platform/pvh/head.S |  2 +-
 5 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


