Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406597E501A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjKHFps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHFpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:45:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE810FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 21:45:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8901EC433C7;
        Wed,  8 Nov 2023 05:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699422344;
        bh=ZJ8x7Mt7gQXHdi02Gq4i+nsQf9NrZ1V5KywJxSI82oI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fcd3Qyqx80CCLvxRm8agoxw0mjJMFvnEyNLLI5sawaxHL2OcZCffbG6BPh8nlKfVr
         QHV2WhvmC4gKf4oYELd8WvmxAyO/BBYn5q912cgbAhr4UJkjtJ+YX6Lo9ci4qjH2Lv
         llPyuB26iEw9hYXzL5ixvzW9orB3IS2T1hyKYxQLccaBSszk2uncZq4DOqexa3ZM9B
         lFN8arR7gnZEVJRUuLinXP8OzXcLC6vCYilv65R6kiZR9j2+qPScnbE/nQMDPVTu6x
         0NdZo/yKWN3FzMl/bHSl411gHG0PcKuuxYn+s7HlaBVqF1jRW7Due90aii2szEETkW
         tblKnWFk/x2VA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
        Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Topel <bjorn@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>, sunilvl@ventanamicro.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: CONFIG_EFI should not depend on CONFIG_RISCV_ISA_C
In-Reply-To: <87ttpyu1r3.fsf@all.your.base.are.belong.to.us>
References: <mhng-7bef396f-1601-4934-8c85-08196c54aa76@palmer-ri-x1c9>
 <87ttpyu1r3.fsf@all.your.base.are.belong.to.us>
Date:   Wed, 08 Nov 2023 06:45:43 +0100
Message-ID: <871qd04x2w.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Palmer Dabbelt <palmer@dabbelt.com> writes:
>
>> On Tue, 24 Oct 2023 12:26:48 PDT (-0700), bjorn@kernel.org wrote:
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>>
>>> UEFI/PE mandates that the kernel Image starts with "MZ" ASCII
>>> (0x5A4D). Convenient enough, "MZ" is a valid compressed RISC-V
>>> instruction. This means that a non-UEFI loader can simply jump to
>>> "code0" in the Image header [1] and start executing.
>>>
>>> The Image specification [1] says the following about "code0":
>>>   |   This header is also reused to support EFI stub for RISC-V. EFI
>>>   |   specification needs PE/COFF image header in the beginning of the
>>>   |   kernel image in order to load it as an EFI application. In order
>>>   |   to support EFI stub, code0 is replaced with "MZ" magic string
>>>   |   and res3(at offset 0x3c) points to the rest of the PE/COFF
>>>   |   header.
>>>
>>> "MZ" is not a valid instruction for implementations without the C
>>> extension.
>>>
>>> A non-UEFI loader, loading a non-C UEFI image have the following
>>> options:
>>>   1. Trap and emulate "code0"
>>>   2. Avoid "code0" if it is "MZ", and have the kernel entry at
>>>      "code1".
>>>
>>> Replace the compressed instruction with a hex code variant, that works
>>> for CONFIG_RISCV_ISA_C=3Dn builds. Further, this change also make sure
>>> that the "code0" instruction is 32b aligned.
>>
>> IMO this breaks the Image format on non-C systems: they'll jump straight=
=20
>> to the start (as there's no symbols left or anything) and then just fail=
=20
>> to execute the C instructions.
>
> That's right! My idea, which was probably really poor articulated, was
> to add trap/emulate in OpenSBI/non-C for the MZ instructions.
>
>> We could amend the Image format to require bootloaders to handle this=20
>> (ie, look at the first instructions and emulate them if there's no C),=20
>> that would require some bootloader updates but given this doesn't work=20
>> maybe that's fine.
>>
>> We could also just stop producing Image+PE binaries on non-C systems=20
>> (ie, just produce PE).
>
> Yes, or make the Image loader in Qemu et al more robust, by e.g.
> checking code0/code1. The Image spec does say that code0 is 'MZ' for
> PE+Image builds, and for non-C capable systems one could argue that it
> should be checked/skipped by the loader.
>
> Does the arguments above make sense for you? I.e.:
>   1.   Merge this patch
>   2a.  Add the trap/emu to OpenSBI
>   (2b. Improve the image loader in Qemu?)

FWIW, the OpenSBI patch would be something like:

From: =3D?UTF-8?q?Bj=3DC3=3DB6rn=3D20T=3DC3=3DB6pel?=3D <bjorn@rivosinc.com>
Date: Wed, 8 Nov 2023 06:29:06 +0100
Subject: [PATCH] lib: sbi_illegal_insn: Emulate 'MZ'/c.li s4,-13 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The Linux kernel RISC-V image format allows that UEFI Images, can also
be booted by non-UEFI firmware. However for that to work, the PE/Image
combo requires that 'MZ' is a valid instruction. On RISC-V, 'MZ' is
only a valid instruction if the hardware is C capable.

Emulate "c.li s4,-13" for non-C capable hardware.

Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
---
 lib/sbi/sbi_illegal_insn.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/sbi/sbi_illegal_insn.c b/lib/sbi/sbi_illegal_insn.c
index 2be47575a365..c9588e364264 100644
--- a/lib/sbi/sbi_illegal_insn.c
+++ b/lib/sbi/sbi_illegal_insn.c
@@ -102,6 +102,19 @@ static int system_opcode_insn(ulong insn, struct sbi_t=
rap_regs *regs)
 	return 0;
 }
=20
+static int compressed_insn(ulong insn, struct sbi_trap_regs *regs)
+{
+	/* Only handle 'MZ'/c.li s4,-13/0x5a3d */
+	if (!misa_extension('C') && (insn & 0xffff) =3D=3D 0x5a4d) {
+		regs->s4 =3D -13;
+		regs->mepc +=3D 4;
+
+		return 0;
+	}
+
+	return truly_illegal_insn(insn, regs);
+}
+
 static const illegal_insn_func illegal_insn_table[32] =3D {
 	truly_illegal_insn, /* 0 */
 	truly_illegal_insn, /* 1 */
@@ -140,6 +153,7 @@ static const illegal_insn_func illegal_insn_table[32] =
=3D {
 int sbi_illegal_insn_handler(ulong insn, struct sbi_trap_regs *regs)
 {
 	struct sbi_trap_info uptrap;
+	ulong tmp;
=20
 	/*
 	 * We only deal with 32-bit (or longer) illegal instructions. If we
@@ -159,7 +173,10 @@ int sbi_illegal_insn_handler(ulong insn, struct sbi_tr=
ap_regs *regs)
 			uptrap.epc =3D regs->mepc;
 			return sbi_trap_redirect(regs, &uptrap);
 		}
-		if ((insn & 3) !=3D 3)
+		tmp =3D insn & 3;
+		if (tmp =3D=3D 1)
+			return compressed_insn(insn, regs);
+		else if (tmp !=3D 3)
 			return truly_illegal_insn(insn, regs);
 	}
=20

base-commit: cbdd86973901b6be2a1a2d3d6b54f3184fdf9a44
--=20
2.40.1
