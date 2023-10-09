Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AA7BE5AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377074AbjJIP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:59:43 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2B92;
        Mon,  9 Oct 2023 08:59:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78ED060009;
        Mon,  9 Oct 2023 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696867179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNWPAUWStk7EM/U4IDIbEqdIo2c3DWzVp72/sDXri9A=;
        b=TDEN3C7yUBzWGXAGJDcmaTSbkJ7LyB2P2TOKJBj4iMdc2RiR4xBJgm1gwPuP/4+Zqr5R5b
        99vHl2hS4hRzWufb7Voumk928DN0kRBPMkWR6u0RhYL4/5OojbzHEnI+Y4PNAA0d+4B/cK
        RV/x/hqX7sMN7liS4x9d2T7Plv3idwYYOEnSbAESa+LXfQHyB2lNrlEU2JEYnVdiJgpoVl
        YLFcMm7rTFD6jXST0rW0xwQhvdHBbPludTE4yaRIat2dzqgWk3Pu4f+curPvqflCm+15/D
        F+PqZaXOb1dpjiRkZj3nF2ohK/EczwU7hedj1f2nRzEjcGqImp1xpA4AkMQ4LA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/11] MIPS: support RAM beyond 32-bit
In-Reply-To: <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-4-gregory.clement@bootlin.com>
 <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com>
Date:   Mon, 09 Oct 2023 17:59:38 +0200
Message-ID: <87edi3bxcl.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun,

> =E5=9C=A82023=E5=B9=B410=E6=9C=884=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:10=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
>> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>>
>> Support platforms where RAM is mapped beyond 32-bit.
>>
>> The kernel parameter ddr32_alias allows to setup the alias to point
>> outside the first 4 GB of memory.
>
> Are you trying to fix the problem that if kernel text is loaded in
> XKPHYS there is no way to to set EBASE to that region?

Yes that exactly we try to fix.

>
> The common practice for other 64bit MIPS system is to load kernel
> in KSEG0 and add low 4G mirror with rest of the high memory to buddy
> system. By doing this Kernel still have access to all memory beyond
> 32 bit, the only draw back is Kernel's text and data can't be relocted
> beyond 32-bit.
>
> Loading kernel into KSEG0 (i.e. with KBUILD_SYM32) have significant benef=
it
> on performance, so I think you shouldn't try to load kernel into XKPHYS
> without a good reason, but it might be helpful to add a BUG_ON at
> CPS driver to handle such situation.

I guess that being in KSEG0 allows to use shorter pointer.  But in our
case the RAM is physically connected beyond 32bits, so it is not
accessible in KSEG0.

>
> Btw: Is your target hardware publicly available? Folks at CIP United
> are looking for EyeQ5 boards for a while, they are supporting MIPS R6
> support at various projects.

We use evaluation boards and I don't know if they are publicly
available.

Gregory

>
> Thanks
> Jiaxun
>
>>
>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/mips/kernel/smp-cps.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
>> index 47e76722a306..fcfb19487612 100644
>> --- a/arch/mips/kernel/smp-cps.c
>> +++ b/arch/mips/kernel/smp-cps.c
>> @@ -34,6 +34,16 @@ static unsigned __init core_vpe_count(unsigned int=20
>> cluster, unsigned core)
>>  	return min(smp_max_threads, mips_cps_numvps(cluster, core));
>>  }
>>=20
>> +static int ddr32_alias;
>> +
>> +static int __init ddr32_alias_setup(char *str)
>> +{
>> +	get_option(&str, &ddr32_alias);
>> +
>> +	return 0;
>> +}
>> +early_param("ddr32_alias", ddr32_alias_setup);
>> +
>>  /**
>>   * plat_core_entry - query reset vector for NMI/reset
>>   *
>> @@ -52,7 +62,7 @@ static u32 plat_core_entry(void)
>>  {
>>  #if defined(CONFIG_USE_XKPHYS)
>>  	return (UNCAC_ADDR(mips_cps_core_entry) & 0xffffffff)
>> -			| CM_GCR_Cx_RESET_BASE_MODE;
>> +			| ddr32_alias | CM_GCR_Cx_RESET_BASE_MODE;
>>  #else
>>  	return CKSEG1ADDR((unsigned long)mips_cps_core_entry);
>>  #endif
>> --=20
>> 2.40.1
>
> --=20
> - Jiaxun

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
