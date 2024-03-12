Return-Path: <linux-kernel+bounces-100056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18894879140
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E14B22038
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355278290;
	Tue, 12 Mar 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUPW3hIz"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567A78273
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236564; cv=none; b=olS8rs/4hPvlNVVeU4p9a24TgXEFjRhUVBhS+mSz2Gh7MrEgN/AbwqMqrt3YEFVMRGLaOMB6eBMGTGzjwhIGMLhU2G+yjA2ZRmsO3pGaDVVdT6/nW1B4FhHq6reI01ATN8TfTlsj+BM5J9clZLs+FeA6hqpxp2veX8usB3uJRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236564; c=relaxed/simple;
	bh=NdpMw7RHS5h3YMK0M3pErDwAAojtlAy3xOysGpP5Fow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FU6EmcLWO7K65puOQb971wvHeM3pFWslFAXFhnT+LYlbCMguOhPeMsHgJXXoFic8zBK1COcv77NRhwrJxyX6tvsKyNZlm1T6Dv9E6zIBrDFk2fBHY0J7E9qqjHXwv5AX5iduQWvGWkeTkuW6Dx5Sz5nzhcwZDoRYiw7PL08HBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUPW3hIz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so2059731f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710236560; x=1710841360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMKRhz5uixRPFvzPai5DQNWzpKKnVCelrc/9AAn5Zs0=;
        b=mUPW3hIzsv7zVNrbl9pVmbrBYCdaz/nVFHay7nbcItJ0bke29oG5zeGZ6UxqYPx9ph
         fsuyeCIeD1Ju8a1Ud9uw1lDT4HV7Z900hQCWu1g/C0Z/8+esqjTd4lgdv2pns3/stb1e
         xAUd+l33hvvBeU8/74yjlUyJrjSbNe/SKFl4WI0kCOQRsx8CFqhdiVN+SRLDMeXKF6rF
         rRjJNfo5QufDqDj3W7sweAhRHHKTTAD1IO+wZ6FVLNahFaSnPDXq5uxHyqrtLjaToId4
         Mh6S6iRydRQ286fzd3Aryl+3XAletvG8KDhxLfh1HQzmZ/nWAzLjAkz75h3n1TXR2/Vy
         7j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236560; x=1710841360;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMKRhz5uixRPFvzPai5DQNWzpKKnVCelrc/9AAn5Zs0=;
        b=oFLlh8v1mGWNtpRC/kMspNpSsHQ05fDLeH5T4ONZbhjwY3q2bDLCM6jddu4GyQ4Tcx
         q+QXEmK8mBE5glZ4vI9T1wsZiB36Yyhn8fuPCIePHDcB/xa9akjWUJmVOnoYdR3AYMsv
         TGuh/hGSeZW72tsEx3Ex5iz+S+tkZEmFx+IEprF07u4YTJ6RdTodkcdoslGCKChhnTNN
         6DE4WHyeuVW8sDjUETg0DuO4KyYOXihKsbZPhhxiPd3OHPFs3s2wXApjfREc1B2Ij7Ft
         YPOl++BFh2dOKeePvg6epbP2NQWDCMJ5Hy4NKH4MaM91ATfyVWZOxyfkYOhNkY0meIwz
         +IxQ==
X-Gm-Message-State: AOJu0Yxz87YSVsDFjm25quZ8ygu7GtzCEyDwZRdmO344ShlzDciOKyNG
	jgnMo8ZSQDu+uZoFKxr8NPZfd/ssW1RD1z5S8iofxdwpvmQYthcR
X-Google-Smtp-Source: AGHT+IHTaoXQMFCaHypuVWZHQnl/7JomuBzPdp/Dqof/LYlqPtOMAw+z2j7nCbb9OF6ZGfRoGeByRQ==
X-Received: by 2002:a05:6000:1bd1:b0:33e:8c7e:608c with SMTP id j17-20020a0560001bd100b0033e8c7e608cmr3842586wrv.13.1710236560104;
        Tue, 12 Mar 2024 02:42:40 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033dd2c3131fsm8496615wro.65.2024.03.12.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 10:42:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/boot changes for v6.9
Message-ID: <ZfAjjSP7raRzEA5/@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-03-12

   # HEAD: 2e2bc42c8381d2c0e9604b59e49264821da29368 Merge branch 'linus' into x86/boot, to resolve conflict

x86/boot changes for v6.9:

 - Continuing work by Ard Biesheuvel to improve the x86 early startup code,
   with the long-term goal to make it position independent:

      - Get rid of early accesses to global objects, either by moving them
        to the stack, deferring the access until later, or dropping the
        globals entirely.

      - Move all code that runs early via the 1:1 mapping into .head.text,
        and move code that does not out of it, so that build time checks can
        be added later to ensure that no inadvertent absolute references were
        emitted into code that does not tolerate them.

      - Remove fixup_pointer() and occurrences of __pa_symbol(), which rely
        on the compiler emitting absolute references, which is not guaranteed.

 - Improve the early console code.

 - Add early console message about ignored NMIs, so that users are at least
   warned about their existence - even if we cannot do anything about them.

 - Improve the kexec code's kernel load address handling.

 - Enable more X86S (simplified x86) bits.

 - Simplify early boot GDT handling

 - Micro-optimize the boot code a bit

 - Misc cleanups.

MERGE NOTES:

As discussed in the x86/sev pull request thread on lkml, your smart-merge 
of arch/x86/include/asm/coco.h via x86/sev in:

  38b334fc767e Merge tag 'x86_sev_for_v6.9_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

.. conflicts with pending changes in x86/boot, which internally merged 
x86/sev as well but used a different (and worse) resolution.

See the details in merge commit 38b334fc767e, which picks your better 
resolution and explains the background. Please merge x86-boot-2024-03-12~1 
if you'd like to do the conflict merge resolution yourself.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (16):
      x86/startup_64: Drop long return to initial_code pointer
      x86/boot/64: Simplify global variable accesses in GDT/IDT programming
      x86/boot/64: Use RIP_REL_REF() to assign 'phys_base'
      x86/boot/64: Use RIP_REL_REF() to access early_dynamic_pgts[]
      x86/boot/64: Use RIP_REL_REF() to access '__supported_pte_mask'
      x86/boot/64: Use RIP_REL_REF() to access early page tables
      x86/boot/64: Use RIP_REL_REF() to access early_top_pgt[]
      efi/x86: Set the PE/COFF header's NX compat flag unconditionally
      x86/startup_64: Simplify CR4 handling in startup code
      x86/startup_64: Defer assignment of 5-level paging global variables
      x86/startup_64: Simplify calculation of initial page table address
      x86/startup_64: Simplify virtual switch on primary boot
      efi/libstub: Add generic support for parsing mem_encrypt=
      x86/boot: Move mem_encrypt= parsing to the decompressor
      x86/sme: Move early SME kernel encryption handling into .head.text
      x86/sev: Move early startup code into .head.text section

Brian Gerst (1):
      x86/boot/64: Load the final kernel GDT during early boot directly, remove startup_gdt[]

Chris Koch (1):
      kexec: Allocate kernel above bzImage's pref_address

H. Peter Anvin (1):
      x86/boot: Add error_putdec() helper

Kirill A. Shutemov (1):
      x86/trampoline: Bypass compat mode in trampoline_start64() if not needed

NOMURA JUNICHI(野村　淳一) (1):
      x86/boot: Add a message about ignored early NMIs

Uros Bizjak (1):
      x86/boot: Use 32-bit XOR to clear registers


 Documentation/arch/x86/boot.rst                |   3 +-
 arch/x86/Kconfig                               |  10 +-
 arch/x86/boot/compressed/ident_map_64.c        |   2 +-
 arch/x86/boot/compressed/misc.c                |  59 ++++++--
 arch/x86/boot/compressed/misc.h                |   3 +
 arch/x86/boot/compressed/sev.c                 |   3 +
 arch/x86/boot/header.S                         |   4 -
 arch/x86/include/asm/desc.h                    |   1 +
 arch/x86/include/asm/mem_encrypt.h             |   8 +-
 arch/x86/include/asm/pgtable_64_types.h        |   2 +-
 arch/x86/include/asm/setup.h                   |   2 +-
 arch/x86/include/asm/sev.h                     |  10 +-
 arch/x86/include/uapi/asm/bootparam.h          |   1 +
 arch/x86/kernel/head64.c                       | 179 +++++++++----------------
 arch/x86/kernel/head_64.S                      | 148 ++++++++------------
 arch/x86/kernel/kexec-bzimage64.c              |   5 +-
 arch/x86/kernel/sev-shared.c                   |  23 ++--
 arch/x86/kernel/sev.c                          |  14 +-
 arch/x86/kernel/sev_verify_cbit.S              |   2 +-
 arch/x86/lib/Makefile                          |  13 --
 arch/x86/mm/mem_encrypt_identity.c             |  74 +++-------
 arch/x86/realmode/rm/trampoline_64.S           |  33 ++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   8 ++
 drivers/firmware/efi/libstub/efistub.h         |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |   3 +
 25 files changed, 277 insertions(+), 335 deletions(-)

