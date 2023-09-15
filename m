Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255617A188B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjIOIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjIOIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:23:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7484496
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694766124; x=1695370924; i=deller@gmx.de;
 bh=OR4Did5RevJvBurZYl1SM45SkH4oF0Uw+9Fs3Z+P5S4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=h9b6chk/BpUpZUpbv3+exlxHysKGLiDihuIeVmTmKQzIHxAAIGQoTQi7QJxdZPgwPuXWabCSGao
 BW8EhIfQzLClsjXDi9QiQfGKY6Rw/8iEdpDfBLOPREahxCjW6E9+d81ow63vBAz6ejsn9gGM0MdF/
 J8kqK65pWxIoa0A0vdqK3NrNKiu0tjJfkNLIscfxChdygsUUBLd5EU8JoaW2Z6K3sX/W02BUyGw7e
 dQMqY9Ap85BGWk2V1BvhMHiPWsZSQNHnpNRN6fEuKlY2Vp1iehSoXiH3+IYg4kTmCgQqLqROWf74W
 bXf3vpUuBPHQyWn1D0KKLiNzrNHCPqQfcY2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1qiixJ250A-003sUe; Fri, 15
 Sep 2023 10:16:03 +0200
Message-ID: <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
Date:   Fri, 15 Sep 2023 10:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <ZQC5jS/Kc/JiBEOa@p100>
 <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l9KjxxyKl6giIE9PfdGvuKtuG2ugvajJsOLnRAlh3ewEEEseOsw
 E9XCYhPbB5r0g34yeYKGNJcBwSQk57JJjIRl3stdCSldzXMtkwu20W9BSyrAJzO5Cn+Os+X
 sp54eGw5pR3TP8oMV2g5XyiSp/DQLEQvcXfS1SYLRnFlDQX1gEuGqZWb2frLq2lZSRwFHDG
 6Fa3YTbivgcwPkv9uiMEA==
UI-OutboundReport: notjunk:1;M01:P0:2j3ob6BpQhw=;Fq5YiXn/BmMIZkWZpT+lAc3baoD
 HfEKCK3uNjM/aKgA8Q/D/1MZNBdhFSf5MWChlI+P29dSmrPD5qAAf14E/q47OvgEY08Sp72JE
 k6byETAFR4MFPSiE9mxYwekyRqfFzaNmQdC59omUUjKQhxl824MY8cVNU6efpAd6Q5GPQgfwp
 fla/UkuFZp052nymqkeN94OiEaCUULsaRLDGwodirWdJzNNPjaLkeniWqYzETcivdgy3eww2c
 8w2AHW6XLsYiR6kVxwxP8OagYmmV2+G4ZS+riTQrnHmc5b6OcsuVtZYNPCEDkQ6peMGYZimtE
 +Dlgta85RvN31Fs0r6x/e5lWLARHZ6VRBuqAnH1b5A/mMGMGuGkQERYn4/+8Czyp8pngOeeVb
 yDdGiZu6JyC0TJ+HG3E84svdUuBsyMOezEQRSWp+hv2Dt+G93jr9hW/YohtmkmTQSj8h9klLy
 cHIAZnAgMCwss8ZS1/EVab+dgRogs6G/BhHujfhE7nwQpiAlpcmj9g9u1nzMuF35zdTMy1OJe
 r27QEYz5/HZ4NL1IwOBEDIU5moq2t8uDhTwnG1Z5owcQz4BdaosD4i8HyhkussdQkbj08MH1H
 i3YTJT/Uv+emtDEeNHz/vdqXd4OxtmT0gt58A9mF8BseJY3b9CF5hVCNhVVvSsbu/FepuWaf5
 jwXqq2QuNgn7vlU3cJpXRHqQi5x5baFl0MLIdd80l7+XxD7zJ+rlXqi5pYzbqTVKSQu5Y3Uki
 tHPruowt/M5lMp6niPW8l8TDLtHoy1DdvuCqEmM1lnSn81611yVRxetswPCxpOFkxLE2wM3Jo
 oXawoBURROXnkdcMied7PlM8+MxvleRoa9PgoLaFsdjFhDB/tqvbZwQmIC+SkYCr7j6yd0Srr
 hTaRbNXUhBgwYbTUn7XkQOeL2HeonpTV06tE6YkuiVuvLoafXvw9jiKiRaFmMee3FHIyp1SiW
 7azqcdrYFOusnhb2X8XLKvwBzH4=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 05:22, Huacai Chen wrote:
> Hi Helge,
>
> On Wed, Sep 13, 2023 at 3:18=E2=80=AFAM Helge Deller <deller@gmx.de> wro=
te:
>>
>> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
>> more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
>> and init_section_contains() to verify if a lock is located inside a
>> kernel static data section.
>>
>> This change triggers a failure on LoongArch, for which the vmlinux.lds.=
S
>> script misses to put the locks (as part of in the .data.rel symbols)
>> into the Linux data section.
>> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
>> into the kernel data section (from _sdata to _edata).
>>
>> Additionally, move other wrongly assigned symbols too:
>> - altinstructions into the _initdata section,

> I think altinstructions cannot  be put into _initdata because it will
> be used by modules.

No.
arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of the ke=
rnel
and altinstructions are replaced before modules are loaded.
For altinstructions in modules the linker script scripts/module.lds.S is u=
sed.

Helge


>> - PLT symbols behind the read-only section, and
>> - *(.la_abs) into the data section.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
>> Cc: stable <stable@kernel.org> # v6.4+
>>
>> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
>> index b1686afcf876..bb2ec86f37a8 100644
>> --- a/arch/loongarch/kernel/vmlinux.lds.S
>> +++ b/arch/loongarch/kernel/vmlinux.lds.S
>> @@ -53,33 +53,6 @@ SECTIONS
>>          . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>          _etext =3D .;
>>
>> -       /*
>> -        * struct alt_inst entries. From the header (alternative.h):
>> -        * "Alternative instructions for different CPU types or capabil=
ities"
>> -        * Think locking instructions on spinlocks.
>> -        */
>> -       . =3D ALIGN(4);
>> -       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>> -               __alt_instructions =3D .;
>> -               *(.altinstructions)
>> -               __alt_instructions_end =3D .;
>> -       }
>> -
>> -#ifdef CONFIG_RELOCATABLE
>> -       . =3D ALIGN(8);
>> -       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>> -               __la_abs_begin =3D .;
>> -               *(.la_abs)
>> -               __la_abs_end =3D .;
>> -       }
>> -#endif
>> -
>> -       .got : ALIGN(16) { *(.got) }
>> -       .plt : ALIGN(16) { *(.plt) }
>> -       .got.plt : ALIGN(16) { *(.got.plt) }
>> -
>> -       .data.rel : { *(.data.rel*) }
>> -
>>          . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>          __init_begin =3D .;
>>          __inittext_begin =3D .;
>> @@ -94,6 +67,18 @@ SECTIONS
>>
>>          __initdata_begin =3D .;
>>
>> +       /*
>> +        * struct alt_inst entries. From the header (alternative.h):
>> +        * "Alternative instructions for different CPU types or capabil=
ities"
>> +        * Think locking instructions on spinlocks.
>> +        */
>> +       . =3D ALIGN(4);
>> +       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>> +               __alt_instructions =3D .;
>> +               *(.altinstructions)
>> +               __alt_instructions_end =3D .;
>> +       }
>> +
>>          INIT_DATA_SECTION(16)
>>          .exit.data : {
>>                  EXIT_DATA
>> @@ -113,6 +98,11 @@ SECTIONS
>>
>>          _sdata =3D .;
>>          RO_DATA(4096)
>> +
>> +       .got : ALIGN(16) { *(.got) }
>> +       .plt : ALIGN(16) { *(.plt) }
>> +       .got.plt : ALIGN(16) { *(.got.plt) }
>> +
>>          RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>>
>>          .rela.dyn : ALIGN(8) {
>> @@ -121,6 +111,17 @@ SECTIONS
>>                  __rela_dyn_end =3D .;
>>          }
>>
>> +       .data.rel : { *(.data.rel*) }
>> +
>> +#ifdef CONFIG_RELOCATABLE
>> +       . =3D ALIGN(8);
>> +       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>> +               __la_abs_begin =3D .;
>> +               *(.la_abs)
>> +               __la_abs_end =3D .;
>> +       }
>> +#endif
>> +
>>          .sdata : {
>>                  *(.sdata)
>>          }

