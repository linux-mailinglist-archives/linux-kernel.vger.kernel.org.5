Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F480775A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378465AbjLFR0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379265AbjLFR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:26:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9311711F;
        Wed,  6 Dec 2023 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zaZMCfpXWHDewSKfYQmdUR7glYYV0yHmqBv04S10bVk=; b=IBkeXZF15BDRNRFf9NMuJ/0yUO
        qdy1IhDZ+H3egZn8hxUb4s5eJuCWOyvPy80Y9UjXaKMONiMfQIu3NePzrtpjUqCgs+hD/exMKD6Hu
        +feC0hk4/mH+e2Id1sCR4ptvm40J8VJzdyWqrqCTLb8V+ZCMPSLzob5atCI3TK57Q0h7ErbsRhUOB
        vydFCGEL2ZvQilLozlkxSW6Fifv/icDIdrQuD42COGiA3wwr/ILWWu80gLENtHg9DGQcHdMS6pN+N
        kFH6JFsPFSaMgjSXucdcDxj90cy0IwcRAWcDOihSDLq/VP8mj9ei7Bwekh39zBp/M+u0F/VtycciH
        2zBD6xZw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAvew-00Astm-1O;
        Wed, 06 Dec 2023 17:26:06 +0000
Message-ID: <c10194f2-097f-4455-9932-19961edbf990@infradead.org>
Date:   Wed, 6 Dec 2023 09:26:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pm.c:undefined reference to `i8042_command'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
References: <202312041909.lwhcU35R-lkp@intel.com>
 <5f1caaf8-1edf-444a-b017-c4d08e52213b@infradead.org>
 <f712a65b-4984-46e8-bd43-1309b5cd41f0@app.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f712a65b-4984-46e8-bd43-1309b5cd41f0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 22:52, Arnd Bergmann wrote:
> On Wed, Dec 6, 2023, at 06:24, Randy Dunlap wrote:
>>> All errors (new ones prefixed by >>):
>>>
>>>    mips64el-linux-ld: arch/mips/loongson2ef/lemote-2f/pm.o: in function `setup_wakeup_events':
>>>>> pm.c:(.text+0x118): undefined reference to `i8042_command'
>>>>> mips64el-linux-ld: pm.c:(.text+0x154): undefined reference to `i8042_command'
>>
>>
>> How do we feel about this?
>> I suppose that an ARCH or mach or board should know what it requires.
>>
>>
>> ---
>>  arch/mips/loongson2ef/Kconfig |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff -- a/arch/mips/loongson2ef/Kconfig b/arch/mips/loongson2ef/Kconfig
>> --- a/arch/mips/loongson2ef/Kconfig
>> +++ b/arch/mips/loongson2ef/Kconfig
>> @@ -40,6 +40,9 @@ config LEMOTE_MACH2F
>>  	select ARCH_HAS_PHYS_TO_DMA
>>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>>  	select ARCH_MIGHT_HAVE_PC_SERIO
>> +	select INPUT
>> +	select SERIO
>> +	select SERIO_I8042
>>  	select BOARD_SCACHE
>>  	select BOOT_ELF32
> 
> I think it's bad style to force-select an optional subsystem.
> How about making the entire file optional? It seems that there
> are already __weak functions in its place.

Yes, I agree in general.

Hopefully the maintainer will opine your suggestion.
Jiaxun?

Thanks.

> 
> --- a/arch/mips/loongson2ef/lemote-2f/Makefile
> +++ b/arch/mips/loongson2ef/lemote-2f/Makefile
> @@ -8,5 +8,6 @@ obj-y += clock.o machtype.o irq.o reset.o dma.o ec_kb3310b.o
>  #
>  # Suspend Support
>  #
> -
> +ifdef CONFIG_SERIO_I8042
>  obj-$(CONFIG_SUSPEND) += pm.o
> +endif
> 
>      Arnd

-- 
~Randy
