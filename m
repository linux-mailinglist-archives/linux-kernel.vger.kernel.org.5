Return-Path: <linux-kernel+bounces-81621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95486787A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904ADB20F26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91112A172;
	Mon, 26 Feb 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZrOwdNw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB81C6B9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957802; cv=none; b=mEkrvmkzhEUs8t7dGbsEWrTKhxtAqO5S+cFVU0Dg6ecsd2pnZLlSnyrxOq8NBhralfy+aA19WAWccBO8erTwcCm9lYwMCAljQkLNIsBufkIyvr2qVRiWvXJccnIWOtKtABlF6Kgz3WrdtlRswivVuMnmtHDu0/UQAwx3VWxBzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957802; c=relaxed/simple;
	bh=GxyKtyr8y2GGNleGTNJQc6bjOKRyUmun2Zs6Q+zFUck=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bGjj30YrHf1cIpynDt1sp1sKHVId4G+7TD0CRbxgoLUKVyd4JCRR7jwRZMMqScbgFeEKzkVoA3oYJQWL97Yw3ntY6N5/c6rJFe2TN9FidMtTzVnlTLaKtDxZTwv6pYXlp8R4Or8g7p3nFqCkLGngRsxs/1YJfoS+DhW90UG4kSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZrOwdNw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608dc99b401so25165607b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957799; x=1709562599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qk9DVI/N7z1DEPC3xb/u1IGXiRcelHgvUcFP5TLGTuQ=;
        b=xZrOwdNwyQKmtOynN9zcYSdZfygPpZTGAGZpAsIapRzQUmT6Hy031bMT0ACbLQZbPz
         st1EoPEQOSZtr8Y+J76lAg+UXBCsyJ62phfMDJquWJuwNvi4RtP+CqTd4aRl4NV4eGOL
         eu2WbXBGdvdW2mnnY5Xiux85bgzo6VErrfwrZoPiAagGLvr8apf5zKdoR7daZP+N3F6/
         a78Nios0S/KbgdHWzB8/l+rR3rm8GvgVP00pzv941krP2StF0bhljnQ+65BJwSTWMtc9
         YQfyD3zxjgBa6BwiInf4Jl0jyLjcAEigtj67gAOm2zKxWyxIIGYBLRYLjjIn0JE61bZa
         7baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957799; x=1709562599;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qk9DVI/N7z1DEPC3xb/u1IGXiRcelHgvUcFP5TLGTuQ=;
        b=cwhUlc4LaxfpZEjVi5IMq+f4Yi9eJTNvRanwDDv2EjLdIRLX+Eyp21+kqJBb/Ad2gh
         FY/fWTchv8Q0+PyAnpemCeHA7dAZ0QkBil9Rx0swQjtQ/ZQVNfMY5NShU7xi5atoZ2sq
         kKJazexgRmNWyVUhIkKfDkmS+ahFz3y9+as9RNq4fvWBJV9sVmRodx3+7fmiAKH11wcO
         Of9mlpT3DtQNfpQLk179gK1EV/BikVsZ/2AjhL8+9AkG8ZQ/Fpg227l/7qtZbN6Deof3
         se4zn71PYc6XE8Y+lpAYC3NSzrJSYUoAo4dtgEr/jlztWMWvo+aLK8ovnFdd7uGyXSks
         pbwg==
X-Gm-Message-State: AOJu0YxrEF+IUPP3AVGVL1aSRBCQjUgEPN/ygwO6IzGcRQmMJLrkmbxL
	P/OlV1ATiOoiHY10VSxRB7eiC8TbPxCiY6j/OCQk2cN7dqVZWcnRC6m1wSH2JWeHs7QcyY9v5lq
	O+dGMJ+03/xjImM7fgScOgAQ9uoWapdn3b6G7B0pEECJiyg5qiNn8dZSH1pX1SjcXZjJjgreVv1
	tBVDYyZf2wGg3/6nUWpaWg0fxQL8HiEA==
X-Google-Smtp-Source: AGHT+IFwTviWyEGB0IsoH5ZugJuS8x+/9+v7SF1BJxPtoMdBDPS1prxh4VVCFjf8phCwdIO2+6mIo6ih
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:d74d:0:b0:608:ba07:3093 with SMTP id
 z74-20020a0dd74d000000b00608ba073093mr1946015ywd.1.1708957799656; Mon, 26 Feb
 2024 06:29:59 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-12-ardb+git@google.com>
Subject: [PATCH v6 00/10] x86: Confine early 1:1 mapped startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a resend of v5 [0] with some touchups applied. 

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

Ard Biesheuvel (10):
  x86/startup_64: Simplify CR4 handling in startup code
  x86/startup_64: Defer assignment of 5-level paging global variables
  x86/startup_64: Simplify calculation of initial page table address
  x86/startup_64: Simplify virtual switch on primary boot
  x86/sme: Avoid SME/SVE related checks on non-SME/SVE platforms
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
 arch/x86/kernel/head64.c                       | 67 +++-----------
 arch/x86/kernel/head_64.S                      | 93 ++++++++------------
 arch/x86/kernel/sev-shared.c                   | 23 +++--
 arch/x86/kernel/sev.c                          | 14 +--
 arch/x86/lib/Makefile                          | 13 ---
 arch/x86/mm/kasan_init_64.c                    |  3 -
 arch/x86/mm/mem_encrypt_identity.c             | 89 +++++--------------
 drivers/firmware/efi/libstub/efi-stub-helper.c |  8 ++
 drivers/firmware/efi/libstub/efistub.h         |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |  3 +
 20 files changed, 152 insertions(+), 262 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


