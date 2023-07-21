Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4B75C2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGUJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGUJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:12:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3243AB1;
        Fri, 21 Jul 2023 02:11:39 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6kH01G4LzNmSR;
        Fri, 21 Jul 2023 17:07:56 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 17:11:16 +0800
Message-ID: <df5a23f0-43cc-dd85-f47b-c068a7f2785f@huawei.com>
Date:   Fri, 21 Jul 2023 17:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next] modpost: move some defines to the file head
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, <masahiroy@kernel.org>
CC:     <mcgrof@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <mhng-7876bf10-0477-4ca6-af22-e3479e8ad123@palmer-ri-x1c9a>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <mhng-7876bf10-0477-4ca6-af22-e3479e8ad123@palmer-ri-x1c9a>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, kindly ping, the build issue still exist in Linux-next.

On 2023/7/13 0:28, Palmer Dabbelt wrote:
> On Wed, 12 Jul 2023 08:55:23 PDT (-0700), masahiroy@kernel.org wrote:
>> +To: Luis Chamberlain, the commiter of the breakage
>>
>>
>>
>> On Wed, Jul 12, 2023 at 10:44 AM Kefeng Wang 
>> <wangkefeng.wang@huawei.com> wrote:
>>>
>>> with "module: Ignore RISC-V mapping symbols too", build error occurs,
>>>
>>> scripts/mod/modpost.c: In function ‘is_valid_name’:
>>> scripts/mod/modpost.c:1055:57: error: ‘EM_RISCV’ undeclared (first 
>>> use in this function)
>>>   return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
>>>
>>> Fix it by moving the EM_RISCV to the file head, also some other
>>> defines in case of similar problem in the future.
>>
>>
>>
>> BTW, why is the flag 'is_riscv' needed?
>>
>>
>> All symbols starting with '$' look special to me.
>>
>>
>>
>> Why not like this?
>>
>>
>>        if (str[0] == '$')
>>                  return true;
>>
>>        return false;
> 
> There's a bit of commentary in the v1 
> <https://lore.kernel.org/all/20230707054007.32591-1-palmer@rivosinc.com/>, but essentially it's not necessary.  I just wanted to play things safe and avoid changing the mapping symbol detection elsewhere in order to deal with RISC-V.
> 
> IIRC we decided $ was special in RISC-V because there were some other 
> ports that behaved that way, but it wasn't universal.  If folks are OK 
> treating $-prefixed symbols as special everywhere that's fine with me, I 
> just wasn't sure what the right answer was.
> There's also some similar arch-specific-ness with the labels and such in 
> here.
> 
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  scripts/mod/modpost.c | 32 ++++++++++++++++----------------
>>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>>> index 7c71429d6502..885cca272eb8 100644
>>> --- a/scripts/mod/modpost.c
>>> +++ b/scripts/mod/modpost.c
>>> @@ -60,6 +60,22 @@ static unsigned int nr_unresolved;
>>>
>>>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>>>
>>> +#ifndef EM_RISCV
>>> +#define EM_RISCV               243
>>> +#endif
>>> +
>>> +#ifndef R_RISCV_SUB32
>>> +#define R_RISCV_SUB32          39
>>> +#endif
>>> +
>>> +#ifndef EM_LOONGARCH
>>> +#define EM_LOONGARCH           258
>>> +#endif
>>> +
>>> +#ifndef R_LARCH_SUB32
>>> +#define R_LARCH_SUB32          55
>>> +#endif
>>> +
>>>  void __attribute__((format(printf, 2, 3)))
>>>  modpost_log(enum loglevel loglevel, const char *fmt, ...)
>>>  {
>>> @@ -1428,22 +1444,6 @@ static int addend_mips_rel(uint32_t *location, 
>>> Elf_Rela *r)
>>>         return 0;
>>>  }
>>>
>>> -#ifndef EM_RISCV
>>> -#define EM_RISCV               243
>>> -#endif
>>> -
>>> -#ifndef R_RISCV_SUB32
>>> -#define R_RISCV_SUB32          39
>>> -#endif
>>> -
>>> -#ifndef EM_LOONGARCH
>>> -#define EM_LOONGARCH           258
>>> -#endif
>>> -
>>> -#ifndef R_LARCH_SUB32
>>> -#define R_LARCH_SUB32          55
>>> -#endif
>>> -
>>>  static void section_rela(struct module *mod, struct elf_info *elf,
>>>                          Elf_Shdr *sechdr)
>>>  {
>>> -- 
>>> 2.41.0
>>>
