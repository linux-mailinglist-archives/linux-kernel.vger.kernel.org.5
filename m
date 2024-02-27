Return-Path: <linux-kernel+bounces-83486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E44E869A28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD931C23235
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99D14264A;
	Tue, 27 Feb 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVhV4hp4"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C6130E2A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047166; cv=none; b=H+Sf0wo2YYrMs12u8gj0Aghtdm9K80BPy/hXItjYdz87jpGcKXVVQjqNspZprdcAued2TkrpsRXL4Xc7CHVSKb716Hn06wTqBygBO+KzQ3QCEhvIk5uSnD7G1KB6A+mt9NsFSlzlu+xCSLehnLC4UNBSHLzilSSrZpFoiKu1WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047166; c=relaxed/simple;
	bh=jdfhN4OyjXzPUDJIXCeW6MFLh4wMP85IT2RawiFJ310=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FJV6eRZotkVXrDDw4bzMfe5Qhy53ukPDp0ocOuj+RCtK4yOS5MGF3ELkZDDfrpBL8i7g/qCp9w9R9EO5NVV3+PEMQ2NpG7cZKPaCOocW+bEHxHEbti6+BGBbbel1vLZDQ/TrcFR25IiKYbKw+afXzpS5PYJOpAG2piirqwN+Vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVhV4hp4; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33dadb50731so2310899f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709047162; x=1709651962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lDEMapjacix0ENmdibCWnKJR+d2XnUSO8oxDsRs717I=;
        b=aVhV4hp4hEZJtXPmH0ohbPL4E4rcD1CXuybBNeX5WU90lVMdnJvDr95zo7QbcJrFBG
         N/BEcmV2yiIuz5BNvsBtU4Ipg814c6O+QnYj0B5+B3MrD4ZsmDh6V2/NcyAPQ3Gk9Akd
         gWEW+ki+Hj0ibwObRq6l/6jtlrk6GLUbzhbLMU1/CWIDnFoVasKaOYmVCg98qS9Y1QQu
         YyCTEu0BcinK/0YxgMao96CkZpkxUfLtLhZbtE1vXJ3PwcHiGVnxa0EDDWbpYLMD1lrF
         rhGUTLUTXhGgrtLNXAqGEkW5ej2mqlOJ3Gf9bRyTwfOF4RIF+lKHxysaSIrvj4a62KvW
         BsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047162; x=1709651962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDEMapjacix0ENmdibCWnKJR+d2XnUSO8oxDsRs717I=;
        b=au6JYRElvy5J7sqruG5JV7MvNio+XD/zVWj+Q6TVX3JLnloMe3BTHTzzheJWeRg5Rr
         SDpJajUlnn5lmsD22RC9+4lVy3kToOyX7g/eFNVs32wL3kqqKF/yKkSiyiQyCqi3vhTX
         jsGslSy1mNr2YfYo2iWuuvUaMcuGC+lVInqOecdKq619e4pwemA/9CuLF9PghcKBArP+
         hoh5X6/mMc1StEnxWQF1z/T+3umvlu6mvtDrVPM5Hjn1c5qTweZp32KRPa6BpMCCv+/h
         wVGex/NEArCnMqa0Nr2onsp/e4jUrlsSqM0WKnel+OM25yIoo+VwmvygLoAOdB76ecSn
         XYEQ==
X-Gm-Message-State: AOJu0Yx3cx9N3NLFSOQavV6v2oi8SEqR13l46/4h7mKWVCLlWp0Loree
	ZdSz+jLRAcWbG6ABNH1DAgWKT6ghxiW/inMGPWIybYFWUxWHJPYi8rMl+zCKGk5NtJhk93eFG6e
	lFkR+D/TeW2IgVYNFtEERbewv9foAfL3xnyWI1LeJdDEaR2xL+J1sU+v2XdAVIrbluQqFEQEC2y
	KKiC7wcK73FpAQaMrcUFSiU5/OpdSqkQ==
X-Google-Smtp-Source: AGHT+IErHbkyGQjkub6F6SOJ1CUwS5tsI9YfqpWHph7GPPVLYYtTx+EiGIlBlrtI3P7SXGaQFgHiQetA
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:259:b0:33d:a40d:3599 with SMTP id
 m25-20020a056000025900b0033da40d3599mr19369wrz.0.1709047162295; Tue, 27 Feb
 2024 07:19:22 -0800 (PST)
Date: Tue, 27 Feb 2024 16:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227151907.387873-11-ardb+git@google.com>
Subject: [PATCH v7 0/9] x86: Confine early 1:1 mapped startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is resend #2 of v5 [0] with some touchups applied. 

Changes since v6:
- Drop flawed patch to move some SME/SEV related calls out of the early
  boot path to avoid the potential need for backporting patches #6/#7
  to kernels where SEV support may not be crucial. This problem will be
  dealt with if/when it arises while doing those backports.

Changes since v5:
- drop patches that have been merged
- rebase onto latest tip/x86/boot
- fix comment regarding CR4.PGE wrt flushing of global TLB entries
- avoid adding startup code to .noinstr.text as it triggers objtool
  warnings

[0] https://lore.kernel.org/all/20240221113506.2565718-18-ardb+git@google.com/

Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>

Ard Biesheuvel (9):
  x86/startup_64: Simplify CR4 handling in startup code
  x86/startup_64: Defer assignment of 5-level paging global variables
  x86/startup_64: Simplify calculation of initial page table address
  x86/startup_64: Simplify virtual switch on primary boot
  efi/libstub: Add generic support for parsing mem_encrypt=
  x86/boot: Move mem_encrypt= parsing to the decompressor
  x86/sme: Move early SME kernel encryption handling into .head.text
  x86/sev: Move early startup code into .head.text section
  x86/startup_64: Drop global variables keeping track of LA57 state

 arch/x86/boot/compressed/misc.c                | 15 ++++
 arch/x86/boot/compressed/misc.h                |  4 -
 arch/x86/boot/compressed/pgtable_64.c          | 12 ---
 arch/x86/boot/compressed/sev.c                 |  3 +
 arch/x86/boot/compressed/vmlinux.lds.S         |  1 +
 arch/x86/include/asm/mem_encrypt.h             |  8 +-
 arch/x86/include/asm/pgtable_64_types.h        | 43 ++++-----
 arch/x86/include/asm/sev.h                     | 10 +--
 arch/x86/include/uapi/asm/bootparam.h          |  1 +
 arch/x86/kernel/cpu/common.c                   |  2 -
 arch/x86/kernel/head64.c                       | 61 ++-----------
 arch/x86/kernel/head_64.S                      | 93 ++++++++------------
 arch/x86/kernel/sev-shared.c                   | 23 +++--
 arch/x86/kernel/sev.c                          | 14 +--
 arch/x86/lib/Makefile                          | 13 ---
 arch/x86/mm/kasan_init_64.c                    |  3 -
 arch/x86/mm/mem_encrypt_identity.c             | 83 +++++------------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  8 ++
 drivers/firmware/efi/libstub/efistub.h         |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  3 +
 20 files changed, 147 insertions(+), 255 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


