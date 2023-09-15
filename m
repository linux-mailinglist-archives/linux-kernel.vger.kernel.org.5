Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A047A1BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjIOKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjIOKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:11:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D102C268A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694772626; x=1695377426; i=deller@gmx.de;
 bh=QOexfBkrKFx5QSiaUReqgS/OH3j3yFKpWiQNhjqiWWE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=q32zpqscIkzRgTflTuNTFu6fE8UZksUh55pxj2vc5cxgKAKAaz9TLPw616maYfZFCP4qriTQnEN
 OPIGgOV4E2b/yO4a6+ZoqGIJfg+BPw6pM1npT8WA95nfyr4Uyt6j8M4Ncda46Ic3VRot54qwVU7gA
 k5a+QiyzNeOv1/Dssu8yocUpdydZ9LYTogwZJs3qPtzClZrl1FuDs7VAKh1d6XQZ0ZraXmD37X6Gk
 auv/hekZuvav7HuW7aMubT2nZWKxLQ9434+Si9Gsl0V/nSXd0GkVa0/LJhyjrgl4jKvnmRzfQ6kXl
 iVS5YwWEIcMTZM32YcZTlX4hdLeGBwhJMMZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1rAXhh0CgF-00TYeT; Fri, 15
 Sep 2023 12:10:26 +0200
Message-ID: <1160d063-8396-b126-15ca-a46807ec4258@gmx.de>
Date:   Fri, 15 Sep 2023 12:10:23 +0200
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
 <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
 <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NHjKD4A+g/FJQYtBwxwcgIaDkB6As5B0qp12+9vpsXTY9lxbU6x
 +tudTSZscur1kvyzkaO3RdDEnPtIyvvv2z+Dvmhvk8knj5JYfILh84yLxORoPtlyJdeFPGs
 HNxVMV5IlbUDcxNz67cgeclcchyfed6cKAAtDdZYiTzgVPdT4WtCSxWVdkCc761yXPXfUOt
 E/GarWXt/GsOk9fKC2xzA==
UI-OutboundReport: notjunk:1;M01:P0:jwSKsw9udR8=;isZiHDrDsLZ+ghtLWD50WoaAMiq
 MIFFEm3WzN/wzycBvj7khuNe4Qf76G7XCkmGXDy2VzJ9jGJLfR7HsHpq3uDd9ftWfjT7pIX7j
 1fj3jAwenj0BsADeERrVWq/zb9m9/H8SNgujWzjbEOgSOK0JGxHUGD6azHxw/QAHlbjgmLdzx
 2gfkqnVQMkk/ygfX0gyGYKMX9Q9u1k0upi54GrCkOHi5WETiMrpgc7oiT9/a9n29BDX5Rd41r
 MzLKuyTJmkTPhdWPIbEKWCwzKv1k+FdZkifM0wuSgXZRW+/m5fPs1AWD8oyG+IoBVVIEXmt9S
 XK/F+7iwQ06JG6KUX+rl+OsK5anNvZ6DvTZyLDcFL9NeG9AywkEsumLS2cRyEzXWBvaCv9Heg
 iNWqRZn9DxP44GJsaBM0plV60JMe7jU6nX3AFCRXEVQ/WSL/XFRS78ex/Jpl/UB8RWDaWwGRg
 Xpw/ozcyrTHszc2vpbfDIE1YhoYFZrRs4oyRB3ji/oH46LAqJZhZQH63YEcFnXgBaiNSfBsQ2
 Xj7u4K9YCgAcT8bQuKkr98hJniHeCPz9VNpZ+mZChzU5jQzise9WRIxRL+PltTUFajiYE6g0W
 piQTc4STxlRGES7mrzQZLSC61LDaT7UWdszcBNxgaZA/wd5QugTHK4JEDBp+VV71yvyiedMe7
 D3e5Fmu9TdgmEFQhqr5rm0ky3Vhr8nS9U2WLjeke3z6VtL9SRP/ZvfzM6emwQ7rFnpz9jSOwN
 JxfmnKMbpC9UZ9sFRzPhLiwq8g1vU+mS16h12Gl2JLE+F7whouS8hFKcquOpL2vYvazUMhHZf
 P6jkVhf4j5KN5NXpDiVZHyWWARVhkyyY8ttHL7yy+ftxo8cKvEbJc56H6YhGi68Acc1j2OEmP
 W5ZIXawASJ2PdDzjDqBM3/mxxSTwPUSaKVyk1wbC52dgC8p6vE+YSQHgSsPuDeaIKrKq6MhG1
 QNRWzw==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 11:23, Huacai Chen wrote:
> On Fri, Sep 15, 2023 at 4:16=E2=80=AFPM Helge Deller <deller@gmx.de> wro=
te:
>>
>> On 9/15/23 05:22, Huacai Chen wrote:
>>> Hi Helge,
>>>
>>> On Wed, Sep 13, 2023 at 3:18=E2=80=AFAM Helge Deller <deller@gmx.de> w=
rote:
>>>>
>>>> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
>>>> more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata(=
)
>>>> and init_section_contains() to verify if a lock is located inside a
>>>> kernel static data section.
>>>>
>>>> This change triggers a failure on LoongArch, for which the vmlinux.ld=
s.S
>>>> script misses to put the locks (as part of in the .data.rel symbols)
>>>> into the Linux data section.
>>>> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
>>>> into the kernel data section (from _sdata to _edata).
>>>>
>>>> Additionally, move other wrongly assigned symbols too:
>>>> - altinstructions into the _initdata section,
>>
>>> I think altinstructions cannot  be put into _initdata because it will
>>> be used by modules.
>>
>> No.
>> arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of the=
 kernel
>> and altinstructions are replaced before modules are loaded.
>> For altinstructions in modules the linker script scripts/module.lds.S i=
s used.

> OK, then what about .got/.plt? It seems arm64 also doesn't put them in
> the data section.

arm64 seems to throw away all plt entries already at link time (and just k=
eeps
the got.plt in the read-only data section).
It even checks at link time, that there are no plt entries in the binary:
         ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure link=
ages detected!")

I don't know for loongarch, but if you need the plt entries for loongarch,=
 it's
safest & best to put them into the read-only data section too, which is wh=
at my patch does.
Up to now, you have them completely outside of code & data sections.

In the end you need to decide for your platform. My patch is a suggestion,=
 which I think
is correct (untested by me, but Guenter replied he tested it).
But to fix the lockdep problem at minimum the move of the .data.rel sectio=
n
is needed.

Helge

>>
>>>> - PLT symbols behind the read-only section, and
>>>> - *(.la_abs) into the data section.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more"=
)
>>>> Cc: stable <stable@kernel.org> # v6.4+
>>>>
>>>> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/ker=
nel/vmlinux.lds.S
>>>> index b1686afcf876..bb2ec86f37a8 100644
>>>> --- a/arch/loongarch/kernel/vmlinux.lds.S
>>>> +++ b/arch/loongarch/kernel/vmlinux.lds.S
>>>> @@ -53,33 +53,6 @@ SECTIONS
>>>>           . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>>>           _etext =3D .;
>>>>
>>>> -       /*
>>>> -        * struct alt_inst entries. From the header (alternative.h):
>>>> -        * "Alternative instructions for different CPU types or capab=
ilities"
>>>> -        * Think locking instructions on spinlocks.
>>>> -        */
>>>> -       . =3D ALIGN(4);
>>>> -       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>>>> -               __alt_instructions =3D .;
>>>> -               *(.altinstructions)
>>>> -               __alt_instructions_end =3D .;
>>>> -       }
>>>> -
>>>> -#ifdef CONFIG_RELOCATABLE
>>>> -       . =3D ALIGN(8);
>>>> -       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>>>> -               __la_abs_begin =3D .;
>>>> -               *(.la_abs)
>>>> -               __la_abs_end =3D .;
>>>> -       }
>>>> -#endif
>>>> -
>>>> -       .got : ALIGN(16) { *(.got) }
>>>> -       .plt : ALIGN(16) { *(.plt) }
>>>> -       .got.plt : ALIGN(16) { *(.got.plt) }
>>>> -
>>>> -       .data.rel : { *(.data.rel*) }
>>>> -
>>>>           . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>>>           __init_begin =3D .;
>>>>           __inittext_begin =3D .;
>>>> @@ -94,6 +67,18 @@ SECTIONS
>>>>
>>>>           __initdata_begin =3D .;
>>>>
>>>> +       /*
>>>> +        * struct alt_inst entries. From the header (alternative.h):
>>>> +        * "Alternative instructions for different CPU types or capab=
ilities"
>>>> +        * Think locking instructions on spinlocks.
>>>> +        */
>>>> +       . =3D ALIGN(4);
>>>> +       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>>>> +               __alt_instructions =3D .;
>>>> +               *(.altinstructions)
>>>> +               __alt_instructions_end =3D .;
>>>> +       }
>>>> +
>>>>           INIT_DATA_SECTION(16)
>>>>           .exit.data : {
>>>>                   EXIT_DATA
>>>> @@ -113,6 +98,11 @@ SECTIONS
>>>>
>>>>           _sdata =3D .;
>>>>           RO_DATA(4096)
>>>> +
>>>> +       .got : ALIGN(16) { *(.got) }
>>>> +       .plt : ALIGN(16) { *(.plt) }
>>>> +       .got.plt : ALIGN(16) { *(.got.plt) }
>>>> +
>>>>           RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>>>>
>>>>           .rela.dyn : ALIGN(8) {
>>>> @@ -121,6 +111,17 @@ SECTIONS
>>>>                   __rela_dyn_end =3D .;
>>>>           }
>>>>
>>>> +       .data.rel : { *(.data.rel*) }
>>>> +
>>>> +#ifdef CONFIG_RELOCATABLE
>>>> +       . =3D ALIGN(8);
>>>> +       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>>>> +               __la_abs_begin =3D .;
>>>> +               *(.la_abs)
>>>> +               __la_abs_end =3D .;
>>>> +       }
>>>> +#endif
>>>> +
>>>>           .sdata : {
>>>>                   *(.sdata)
>>>>           }
>>

