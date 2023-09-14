Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B727A0AED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbjINQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:41:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8751FDC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694709625; x=1695314425; i=deller@gmx.de;
 bh=BPMo+H8KWB+kOjZY/A9qgBPQBv2St3LuqxU/RGbM92o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UoLFaKEe21F7QTQTz5CVwKfjTQRQE74Q3qBUJJHHoizJ46GPws1M8TsrS56hLutOvHG5WTp47ZT
 rqBwLtC5DVHuZ0sH83/NsWixr2iXRDpgEgKoXp9m9+KIJNPYbEFx6m90hJ6KxMGED3FPMGoQ/AoRy
 LMfa4npZHiSAkV8K+SeFwRV5ieKBWVqVwJwooEzlJilzukeKASMNuF/tU1YbnYQ9X4Za2GPQ2cULI
 FoMP3fGim+kCURLebZKurYDvOy5a3kLDNCbwijq8amRZiETIHLckHLOB56rNCZ0ymSCQ7tQOpgobk
 P3Y5oiepg6sfWZWS4BWF7aEwOXovrZGMGsyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.145.203]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1r8M7Z2Fc4-00RcTW; Thu, 14
 Sep 2023 18:40:25 +0200
Message-ID: <981897ec-93a2-28f8-8c12-bc7b5e029058@gmx.de>
Date:   Thu, 14 Sep 2023 18:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
To:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <ZQC5jS/Kc/JiBEOa@p100>
 <9d0cb447-2556-4609-a96f-13875ddeeda3@roeck-us.net>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <9d0cb447-2556-4609-a96f-13875ddeeda3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tG/Am0xeATwJq1gejFjQUCaQOKupskcqB7iEBKV7ldNFocQv5hl
 5YGcNW7PqKRvgEemBoUKO9cBZiwA6jHPxkcfCoAR+OBjrOzQI68IarmBK46d8dZJm9vQqLu
 p25ZYHd/1ESbYtwTjNSYsYezzxkd6/bEhn53gdic0vMLgonyo9gIZQ55u21FBDuh1x7VLVr
 IVCoqjbamS4aNZW29xxmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KAgDSiHeoWk=;stj9L4avZWYcxrvgYmaGOiko9Qm
 bJYy4nIkk8WYIv6eKJM7FozDd6tt9KyGr9LxOK7OdNcIIlcRAwnBhx60QB+YSbt0xTjenPHLd
 3ystPe85Tze4/vvL1TPAXHnVU/pVDpm5s32eu1IG7LpV9gVIk0hbva3tFOLYonWiJM33HGnn3
 RAXlNeROH4jnE26TZ4Tding4jEPK6bzWd6UWOkoSrzkEtEDyLFe/bcSih/JNcbU5SpmH3tC4w
 gY+Q10atHoMVp4zwUFh8nwE6/hH8heEeijTTsoqLSbEdZDHpUkIkTsNxbgsH2rf9D8M7zWsf7
 OSU9o/Rcci2FS66YEa32fbEkMTGafPzaL5CwOtg1nBw76gYOlMOO4fFKnfWHOw3/W/OExwysr
 Kl1MJjdC9v+eFoHEuusQiXCi82Oeb0WYtxuDeM94SHyG1OaJAbciy3FPbSts+Ri7umOYiicdM
 BWySzP3uePYMk4zbR9NAfrFGldJ3W1YA9t5iGdV9MKtsq4NYtb94FZpYgt7s5akjD4dlpEHuv
 PBiJzbUgbs9qI6HSpW/7JJnRxULmNHS3N7UBMo7f9c/DfmDiwZad/zpzKeoTNNPhAD2YhW/Ef
 kCbPOZfRsmMituYRuvLMFjpcVYqer6YPLbKEJDqM57iq2UlSiCnVcpowVOwkKUpyrchg14jCF
 yP7uZlFdh5hq3Nzx8ZcmFVJJCIT8mkEYBzPT0inO/HDRugppUu1xCI3JIlxV2QoCwSV5p2sIK
 WEfNskB2gch6fLQzz1935dwAUV8OF5KVTWf3oTKEK7xhg7qMPs0d1d7hpKxfK0a4A1aIC0tYv
 J7eDnh+/taydsCOAIEua7xvSa9Y4IRhvjcKSpyhXQtAI4DnJQ2De84TKX+QIvMfee1gm8XNUv
 BSGQH14Lx8umGspChjNHfc1KhihvD68ttY5UOoriTnf/IMCV+/L/JwZqaPk9cu3T+aAMLlaIg
 mTaaag==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING to Loongarch maintainers!

Without this patch, lockdep is broken on LoongArch on kernel v6.1 and abov=
e.
(patch below wrongly mentions kernel 6.4, but actually it needs backport t=
o v6.1 too).

Helge

On 9/12/23 22:31, Guenter Roeck wrote:
> On Tue, Sep 12, 2023 at 09:18:37PM +0200, Helge Deller wrote:
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
>> - PLT symbols behind the read-only section, and
>> - *(.la_abs) into the data section.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
>> Cc: stable <stable@kernel.org> # v6.4+
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
>>
>> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kerne=
l/vmlinux.lds.S
>> index b1686afcf876..bb2ec86f37a8 100644
>> --- a/arch/loongarch/kernel/vmlinux.lds.S
>> +++ b/arch/loongarch/kernel/vmlinux.lds.S
>> @@ -53,33 +53,6 @@ SECTIONS
>>   	. =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>   	_etext =3D .;
>>
>> -	/*
>> -	 * struct alt_inst entries. From the header (alternative.h):
>> -	 * "Alternative instructions for different CPU types or capabilities"
>> -	 * Think locking instructions on spinlocks.
>> -	 */
>> -	. =3D ALIGN(4);
>> -	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>> -		__alt_instructions =3D .;
>> -		*(.altinstructions)
>> -		__alt_instructions_end =3D .;
>> -	}
>> -
>> -#ifdef CONFIG_RELOCATABLE
>> -	. =3D ALIGN(8);
>> -	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>> -		__la_abs_begin =3D .;
>> -		*(.la_abs)
>> -		__la_abs_end =3D .;
>> -	}
>> -#endif
>> -
>> -	.got : ALIGN(16) { *(.got) }
>> -	.plt : ALIGN(16) { *(.plt) }
>> -	.got.plt : ALIGN(16) { *(.got.plt) }
>> -
>> -	.data.rel : { *(.data.rel*) }
>> -
>>   	. =3D ALIGN(PECOFF_SEGMENT_ALIGN);
>>   	__init_begin =3D .;
>>   	__inittext_begin =3D .;
>> @@ -94,6 +67,18 @@ SECTIONS
>>
>>   	__initdata_begin =3D .;
>>
>> +	/*
>> +	 * struct alt_inst entries. From the header (alternative.h):
>> +	 * "Alternative instructions for different CPU types or capabilities"
>> +	 * Think locking instructions on spinlocks.
>> +	 */
>> +	. =3D ALIGN(4);
>> +	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
>> +		__alt_instructions =3D .;
>> +		*(.altinstructions)
>> +		__alt_instructions_end =3D .;
>> +	}
>> +
>>   	INIT_DATA_SECTION(16)
>>   	.exit.data : {
>>   		EXIT_DATA
>> @@ -113,6 +98,11 @@ SECTIONS
>>
>>   	_sdata =3D .;
>>   	RO_DATA(4096)
>> +
>> +	.got : ALIGN(16) { *(.got) }
>> +	.plt : ALIGN(16) { *(.plt) }
>> +	.got.plt : ALIGN(16) { *(.got.plt) }
>> +
>>   	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>>
>>   	.rela.dyn : ALIGN(8) {
>> @@ -121,6 +111,17 @@ SECTIONS
>>   		__rela_dyn_end =3D .;
>>   	}
>>
>> +	.data.rel : { *(.data.rel*) }
>> +
>> +#ifdef CONFIG_RELOCATABLE
>> +	. =3D ALIGN(8);
>> +	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
>> +		__la_abs_begin =3D .;
>> +		*(.la_abs)
>> +		__la_abs_end =3D .;
>> +	}
>> +#endif
>> +
>>   	.sdata : {
>>   		*(.sdata)
>>   	}

