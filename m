Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD27E2CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKFTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjKFTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:21:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB9BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:21:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE79C433C8;
        Mon,  6 Nov 2023 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699298465;
        bh=DNSe1kWEmQIx9RbnW/5BezE7eNr7BvDl2djBhzSMnZI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CzC22BIRJwDgnZhVgMFNrwGQ5hFQ1zOJg1uk/iLLj+M01dpVFAB45brwdB7ujupSF
         R7/p/7lDbOlboRHRksVysmedjqGCD1rEj15+YNNxEcKbvR0ZcwMgUd15YNSmtAWfSV
         guY0MJwBtUmQzi//vxXtES0P3GhkIEwIpD6Bu8fdpkAi2FC7brpjThZtcDfG93o4e5
         g/sK7RDWpD17ghwsc1iI92Jxz6pi5YwauAUg8efYDQQD0IIAWjka94bIdhbjb81feI
         nIwR6qQSwjozFZsIPET4cK/SLAYZD9UfZILECpFhS4zLNlFRJ3+QUjJMOCt3em/XSW
         HkMIi/enxHOpQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
        Atish Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Topel <bjorn@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>, sunilvl@ventanamicro.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: CONFIG_EFI should not depend on CONFIG_RISCV_ISA_C
In-Reply-To: <mhng-7bef396f-1601-4934-8c85-08196c54aa76@palmer-ri-x1c9>
References: <mhng-7bef396f-1601-4934-8c85-08196c54aa76@palmer-ri-x1c9>
Date:   Mon, 06 Nov 2023 20:21:04 +0100
Message-ID: <87ttpyu1r3.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> writes:

> On Tue, 24 Oct 2023 12:26:48 PDT (-0700), bjorn@kernel.org wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> UEFI/PE mandates that the kernel Image starts with "MZ" ASCII
>> (0x5A4D). Convenient enough, "MZ" is a valid compressed RISC-V
>> instruction. This means that a non-UEFI loader can simply jump to
>> "code0" in the Image header [1] and start executing.
>>
>> The Image specification [1] says the following about "code0":
>>   |   This header is also reused to support EFI stub for RISC-V. EFI
>>   |   specification needs PE/COFF image header in the beginning of the
>>   |   kernel image in order to load it as an EFI application. In order
>>   |   to support EFI stub, code0 is replaced with "MZ" magic string
>>   |   and res3(at offset 0x3c) points to the rest of the PE/COFF
>>   |   header.
>>
>> "MZ" is not a valid instruction for implementations without the C
>> extension.
>>
>> A non-UEFI loader, loading a non-C UEFI image have the following
>> options:
>>   1. Trap and emulate "code0"
>>   2. Avoid "code0" if it is "MZ", and have the kernel entry at
>>      "code1".
>>
>> Replace the compressed instruction with a hex code variant, that works
>> for CONFIG_RISCV_ISA_C=3Dn builds. Further, this change also make sure
>> that the "code0" instruction is 32b aligned.
>
> IMO this breaks the Image format on non-C systems: they'll jump straight=
=20
> to the start (as there's no symbols left or anything) and then just fail=
=20
> to execute the C instructions.

That's right! My idea, which was probably really poor articulated, was
to add trap/emulate in OpenSBI/non-C for the MZ instructions.

> We could amend the Image format to require bootloaders to handle this=20
> (ie, look at the first instructions and emulate them if there's no C),=20
> that would require some bootloader updates but given this doesn't work=20
> maybe that's fine.
>
> We could also just stop producing Image+PE binaries on non-C systems=20
> (ie, just produce PE).

Yes, or make the Image loader in Qemu et al more robust, by e.g.
checking code0/code1. The Image spec does say that code0 is 'MZ' for
PE+Image builds, and for non-C capable systems one could argue that it
should be checked/skipped by the loader.

Does the arguments above make sense for you? I.e.:
  1.   Merge this patch
  2a.  Add the trap/emu to OpenSBI
  (2b. Improve the image loader in Qemu?)


Bj=C3=B6rn
