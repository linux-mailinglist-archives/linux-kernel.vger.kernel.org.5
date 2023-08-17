Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3477F401
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjHQKDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349977AbjHQKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E722D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2AC64F45
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C47C433C8;
        Thu, 17 Aug 2023 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692266575;
        bh=lW9/v/Opq7Tqu51ERKYkMPKnGxso6nLfK0q1mdCNrsU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fI7bnbVMq3itrQOao9vU4L0SOVnvpnC9v0HOf/90utdAMXD4ugPN20wWc+t/bXjRI
         aDciWdcxEh2EPGH9Ck/mvC08v8UONzzEBP3sK+wale3vF7oTIdQ/n3438lZYE4aguP
         PKfYkWJKyf8QkysdjpsyYsqtbq6WGSEHBxrGgTSgpC9QOTy3mEf2j7E37PlIUj+InV
         CEzi6C8uPkcQUSmmZv3DkgIizUgbS/mRHuPerBZFpCwUpcQ/cy0WSXCwWImqg67af5
         UuL8dKaUevr7RZdbcaBznnP+u7Mja6HZHwnUbyATGQ88rL5JHiP7pjzWUtNRl98i2I
         JGWKt2HarJEYA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     yunhui cui <cuiyunhui@bytedance.com>
Cc:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mpe@ellerman.id.au, jpoimboe@kernel.org, mark.rutland@arm.com,
        svens@linux.ibm.com, guoren@kernel.org, jszhang@kernel.org,
        ebiederm@xmission.com, bjorn@rivosinc.com, heiko@sntech.de,
        xianting.tian@linux.alibaba.com, mnissler@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] riscv: Dump user opcode bytes on
 fatal faults
In-Reply-To: <CAEEQ3w=MgH82+BMpwmUHnUevMJsJUqgeBRWSZnU_iizMLK37UQ@mail.gmail.com>
References: <20230329082950.726-1-cuiyunhui@bytedance.com>
 <87v8dfqays.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3w=MgH82+BMpwmUHnUevMJsJUqgeBRWSZnU_iizMLK37UQ@mail.gmail.com>
Date:   Thu, 17 Aug 2023 12:02:52 +0200
Message-ID: <871qg29eb7.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yunhui cui <cuiyunhui@bytedance.com> writes:

> Hi Bj=C3=B6rn,
>
> On Wed, Aug 16, 2023 at 11:11=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Hi Yunhui,
>>
>> Waking up the dead! ;-)
>>
>
>>
>> X86's show_opcodes() is used both for kernel oops:es, and userland
>> unhandled signals. On RISC-V there's dump_kernel_instr() added in commit
>> eb165bfa8eaf ("riscv: Add instruction dump to RISC-V splats").
>>
>> Wdyt about reworking that function, so that it works for userland epc as
>> well? I think it's useful to have the surrounding instruction context,
>> and not just on instruction.
>
> Okay,  Based on your suggestion, I'm going to rename dump_kernel_instr
> to dump_instr. Like:
> static void dump_instr(const char *loglvl, struct pt_regs *regs)
> {
> ...
>                 if (user_mode(regs))
>                         bad =3D get_user_nofault(val, &insns[i]);
>                 else
>                         bad =3D get_kernel_nofault(val, &insns[i]);
> ...
> }
>
> What do you think?

Yeah, looks good! Does that work for you?


Bj=C3=B6rn
