Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19147C5522
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjJKNUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjJKNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:20:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE48F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:20:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A5C433C8;
        Wed, 11 Oct 2023 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697030417;
        bh=ykRmIq0tYqtR0xjYPm3Se7zVmdYlC2qR118zJz3huxs=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=S5Vn3o+ph/BX9PwI1wPXh1+oZ1OeiF3A64odPINfuclUol++eEMJ9LWcMGT9fmmul
         8mIut7OvT2Y1vzGLM1kjixyWR6nol7ysbBuddEyzEw4REIlKuQ+jedWGuWz4WqkPrE
         EQcIoJxWHyJOZRreb8Ih1S+F5VbdLZdep0SqZV2RyBYmBf4lgmqAZg0P8PCFxZ8tnE
         cPKdoRqnugV6AtfJxhyMPDAVlucG2eFL/9ZNXZr2dlkBZmlyqDLiYScPM6im+BQUKL
         5VQYBnn9R2fXOPXp19c7FmJ90sV3wPic/qQ2F39s0MLloL3QrequbO49R0UR42MXLJ
         AyD31ui858PTA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     yunhui cui <cuiyunhui@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH v6] riscv: add userland instruction dump
 to RISC-V splats
In-Reply-To: <CAEEQ3wkBACC2SdHQZYyVoXzGhd+=wHD9Hf5gL_Yhu1dWuXAVZQ@mail.gmail.com>
Date:   Wed, 11 Oct 2023 15:20:14 +0200
Message-ID: <87jzrt70tt.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yunhui cui <cuiyunhui@bytedance.com> writes:

> Hi Bj=C3=B6rn,
>
> On Tue, Sep 12, 2023 at 8:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>>
>> > Add userland instruction dump and rename dump_kernel_instr()
>> > to dump_instr().
>> >
>> > An example:
>> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
>> > [    0.823817] Run /init as init process
>> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005b=
e18 in bb[10000+5fb000]
>> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-g=
bd644290aa72-dirty #187
>> > [    0.841373] Hardware name:  , BIOS
>> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 00000=
03fffcafda0
>> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 00000=
00000000000
>> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 00000=
00000000000
>> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 00000=
03fffcafe18
>> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000=
00000000000
>> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000=
00000000000
>> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000=
00000000000
>> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000=
00000000000
>> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000=
00000000000
>> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 00000=
00000000000
>> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
>> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 caus=
e: 0000000000000002
>> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000=
 (8053) f002
>> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! exi=
tcode=3D0x00000004
>> >
>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>
>> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Could u help to merge this patch into linux-next? Or can anyone help
> to merge it?

Hey Yunhui,

The next merge-window opens soon, so I'd guess it'll be picked up then!


Cheers,
Bj=C3=B6rn
