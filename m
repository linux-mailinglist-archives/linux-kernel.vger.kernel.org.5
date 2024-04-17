Return-Path: <linux-kernel+bounces-149267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8D8A8E56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9B0B21F68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1712C819;
	Wed, 17 Apr 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+SJYwUl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A06171A1;
	Wed, 17 Apr 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390841; cv=none; b=klqCYtSWb1txQajHJZCFZqns2mm8abTOHnn63ixqYm28oP0TKNVwE9vOE4LHWTipsS3tjCABS32VDYHGOx+PD40CcELVC3endffswzeE7d4df9fCsXf87nWoPr3vFRHQPvHgGU6KxoQ30xFmzkm3KiWIJToa8ZbiHeUH4GntWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390841; c=relaxed/simple;
	bh=yfAR++d0rrHgTRnNzr33OgKYQ10TFx35uAWddPRyoEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MUOcG1kylM4EbqmzGVIG+/GfdJvChXpbk1Uqsm38+u4q+zwtg/ZGxeYRZx05qgaG9Hnhnmi4q/jMHMmOKp0d61GnOeKK3YaGR7aGeklsRmxHUGCyErx7fc3RyusGS0rlHMX8bj9YpC+WHN/+relCGcnoVAInIZh+FwWdEOw3/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+SJYwUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5152C2BD11;
	Wed, 17 Apr 2024 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713390840;
	bh=yfAR++d0rrHgTRnNzr33OgKYQ10TFx35uAWddPRyoEs=;
	h=From:Subject:Date:To:Cc:From;
	b=o+SJYwUl00FoysLq+P4NVNdeYlEdK8rAbHmmYWsWCHYBq9Pwb2gO7IAPLT7Pb49gZ
	 ahRmsMx8MgMGyqORcRD8Ur3c1FI0I034RSIUXlBdIQaiutxCuKQumia9PnsM9g0Kzd
	 Kd7iExYi7ZfmB+DSOr9pChj3ODxPAaHuEJnoJcboDc4ktla3s/CKfDsPLOjpy2Iopb
	 WJE6rucCkTeq1rgkU+a295azZTApEXmpyvS9N+mH/6dxxnxjX1h2q28Mc9cLwPzBA2
	 ETZFIvv0f9EE7hktMCgMTwZpm/TgWiB3z2SfhJnUipFN2WaV2gtALhThM9NUKc5IX+
	 5Q7S4K5PR/NAg==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] x86/purgatory: Avoid kexec runtime warning with LLVM
 18
Date: Wed, 17 Apr 2024 14:53:44 -0700
Message-Id: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhEIGYC/x3MTQqAIBBA4avErBtIMbGuEi3Kphr6RcOE6O5Jy
 w8e7wFPjslDnT3gKLDnY08QeQZ27vaJkIdkkIVUhRIao9E4csSFIlm8+ZpxXcOGwqCtjO6lMKq
 0JaTB6SiV/7xp3/cDof0J0mwAAAA=
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, song@kernel.org, 
 ribalda@chromium.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, ns <0n-s@users.noreply.github.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5403; i=nathan@kernel.org;
 h=from:subject:message-id; bh=yfAR++d0rrHgTRnNzr33OgKYQ10TFx35uAWddPRyoEs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkKLt/y77SIB3jLsRwVlai6olm7iedPla7JoVBXb/UpA
 Sl3as91lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgIlcesnwT3d94av4iVdP3a+d
 sW/eBYedy8r4Jh/jrO1259BIMF0i/pThN8ukitwAt+bES0YhrvMilCI+r85lso8wWMCd18yz8cc
 /ZgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

After LLVM commit d8a04398f949 ("Reland [X86] With large code model, put
functions into .ltext with large section flag (#73037)") [1], which
landed in the 18.x cycle, there is a runtime warning when loading a
kernel via kexec due to the presence of two text sections (.text and
ltext).

  $ kexec -l /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img --reuse-cmdline
  $ dmesg -l warn+
  ...
  [    1.264240] ------------[ cut here ]------------
  [    1.264647] WARNING: CPU: 0 PID: 96 at kernel/kexec_file.c:945 kexec_load_purgatory+0x2c8/0x3c0
  [    1.265322] Modules linked in:
  [    1.265565] CPU: 0 PID: 96 Comm: kexec Not tainted 6.9.0-rc4-00031-g96fca68c4fbf #1 eae91b3fe699ecba2dd0a886471788e49eb36ac0
  [    1.266403] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  [    1.267268] RIP: 0010:kexec_load_purgatory+0x2c8/0x3c0
  [    1.267661] Code: 54 24 0c 48 89 c8 48 29 d0 0f 82 5d ff ff ff 49 03 54 24 1c 48 39 d1 0f 83 4f ff ff ff 49 8b 17 48 39 4a 18 0f 84 30 ff ff ff <0f> 0b e9 3b ff ff ff 66 85 c9 74 18 48 8b 5a 28 48 01 d3 45 31 e4
  [    1.269052] RSP: 0018:ffffbe28007cfb50 EFLAGS: 00010206
  [    1.269447] RAX: 0000000000000000 RBX: 00000000000000d0 RCX: 0000000000000000
  [    1.269982] RDX: ffff988c8174d000 RSI: 0000000000000010 RDI: ffffbe2801d940c0
  [    1.270527] RBP: 0000000000000002 R08: 0000003d8b4c0000 R09: cc0000000025ff00
  [    1.271063] R10: 0000003d8b4c0000 R11: cc0000000025ff00 R12: ffffbe28000d5084
  [    1.271603] R13: 000000013ffff000 R14: ffff988c8174d000 R15: ffffbe28007cfbe0
  [    1.272140] FS:  00007fec73535740(0000) GS:ffff988cbbc00000(0000) knlGS:0000000000000000
  [    1.272744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [    1.273178] CR2: 00007fec736b1390 CR3: 0000000101a24000 CR4: 0000000000350ef0
  [    1.273732] Call Trace:
  [    1.273929]  <TASK>
  [    1.274100]  ? __warn+0xc9/0x1c0
  [    1.274356]  ? kexec_load_purgatory+0x2c8/0x3c0
  [    1.274704]  ? report_bug+0x139/0x1e0
  [    1.274998]  ? handle_bug+0x42/0x70
  [    1.275269]  ? exc_invalid_op+0x1a/0x50
  [    1.275574]  ? asm_exc_invalid_op+0x1a/0x20
  [    1.275900]  ? kexec_load_purgatory+0x2c8/0x3c0
  [    1.276251]  bzImage64_load+0x1c1/0x6a0
  [    1.276556]  kexec_image_load_default+0x49/0x60
  [    1.276907]  __se_sys_kexec_file_load+0x606/0x790
  [    1.277280]  ? arch_exit_to_user_mode_prepare+0x6e/0x70
  [    1.277675]  do_syscall_64+0x90/0x170
  [    1.277955]  ? srso_return_thunk+0x5/0x5f
  [    1.278265]  ? __count_memcg_events+0x50/0xc0
  [    1.278597]  ? srso_return_thunk+0x5/0x5f
  [    1.278901]  ? handle_mm_fault+0xb18/0x11c0
  [    1.279218]  ? vfs_read+0x2c8/0x2f0
  [    1.279498]  ? srso_return_thunk+0x5/0x5f
  [    1.279802]  ? do_user_addr_fault+0x4d2/0x690
  [    1.280138]  ? srso_return_thunk+0x5/0x5f
  [    1.280449]  ? srso_return_thunk+0x5/0x5f
  [    1.280755]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [    1.281136] RIP: 0033:0x7fec7363e88d
  [    1.281411] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 14 0d 00 f7 d8 64 89 01 48
  [    1.282789] RSP: 002b:00007ffd136f4808 EFLAGS: 00000246 ORIG_RAX: 0000000000000140
  [    1.283354] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fec7363e88d
  [    1.283893] RDX: 00000000000000c5 RSI: 0000000000000005 RDI: 0000000000000003
  [    1.284427] RBP: 0000000000000003 R08: 0000000000000000 R09: 00005628517eef10
  [    1.284966] R10: 00005628580a75f0 R11: 0000000000000246 R12: 0000000000000003
  [    1.285500] R13: 00005628517f89a8 R14: 00007ffd136f4b98 R15: 0000000000000004
  [    1.286036]  </TASK>
  [    1.286210] ---[ end trace 0000000000000000 ]---

Unlike LTO and PGO, which were disabled for the purgatory in commit
97b6b9cbba40 ("x86/purgatory: remove PGO flags") and commit 75b2f7e4c9e0
("x86/purgatory: Remove LTO flags"), this optimization has no flag to
opt out of it. One way to resolve this would be to use '.ltext' and
'.lrodata' as the text and read-only data sections in the out of line
assembly in arch/x86/purgatory but there is nothing that stops future
changes from splitting the text section further.

Properly avoid the warning by using a linker script to coalesce all
separate text sections into one, which was alluded to by both the change
that introduced the warning and 75b2f7e4c9e0... I think this really
should have been done then but I wasn't looking too far ahead :) To
avoid backsliding now that all sections are properly described by the
linker script, turn on orphan section warnings as well.

[1]: https://github.com/llvm/llvm-project/commit/d8a04398f9492f043ffd8fbaf2458778f7d0fcd5

---
Nathan Chancellor (2):
      x86/purgatory: Add a linker script
      x86/purgatory: Enable orphan section warnings

 arch/x86/purgatory/.gitignore      |  1 +
 arch/x86/purgatory/Makefile        | 19 +++---------
 arch/x86/purgatory/purgatory.lds.S | 63 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 14 deletions(-)
---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240416-x86-fix-kexec-with-llvm-18-c986b21845c5

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


