Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF77C5742
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346970AbjJKOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbjJKOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:46:33 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23D2CF;
        Wed, 11 Oct 2023 07:46:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A47A3240006;
        Wed, 11 Oct 2023 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697035588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QVKjHGSsp7llyLK7zXvNe55S5HhglD1KOhqWrzK24o=;
        b=efH6MLyFYuKhVRsjsyQIblreJjjFhdUvrP5SIy7uZrN57o+MGaBWpe60IvUsA06T59aCRI
        0790bKGL0Q07jyaZwaDkl/cvzo2ZPcDGSCON/4vtiPXpc4MMNbq/UVSYJ6oFYk4b7YSEwV
        hXaqJSs2sB/02RlvLWyMuu3J76p1VzXe0E9ibdPEKkWzw4vKe9uMX04889lq+BU/g14xgl
        0/ytgcvLysO37RAI1C7JlJ26pSJXnpSBPD3Tb3RqYwkBhTGh0BxZz5XlbkfzJPIxahdVb4
        NZB7h7jzUmygp+rBhXjFNr8UrQ/oFHf1Grvnfi1np6EIscieXSEgBn8PPHFSvw==
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
In-Reply-To: <e5b8c68e-8a1d-45e7-92bf-db0c2fa812ad@app.fastmail.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-4-gregory.clement@bootlin.com>
 <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com>
 <87edi3bxcl.fsf@BL-laptop>
 <e5b8c68e-8a1d-45e7-92bf-db0c2fa812ad@app.fastmail.com>
Date:   Wed, 11 Oct 2023 16:46:26 +0200
Message-ID: <878r89b4jh.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun,

> =E5=9C=A82023=E5=B9=B410=E6=9C=889=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=884:59=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
>> Hello Jiaxun,
>>
>>> =E5=9C=A82023=E5=B9=B410=E6=9C=884=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:10=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
>>>> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>>>>
>>>> Support platforms where RAM is mapped beyond 32-bit.
>>>>
>>>> The kernel parameter ddr32_alias allows to setup the alias to point
>>>> outside the first 4 GB of memory.
>>>
>>> Are you trying to fix the problem that if kernel text is loaded in
>>> XKPHYS there is no way to to set EBASE to that region?
>>
>> Yes that exactly we try to fix.
>>
>>>
>>> The common practice for other 64bit MIPS system is to load kernel
>>> in KSEG0 and add low 4G mirror with rest of the high memory to buddy
>>> system. By doing this Kernel still have access to all memory beyond
>>> 32 bit, the only draw back is Kernel's text and data can't be relocted
>>> beyond 32-bit.
>>>
>>> Loading kernel into KSEG0 (i.e. with KBUILD_SYM32) have significant ben=
efit
>>> on performance, so I think you shouldn't try to load kernel into XKPHYS
>>> without a good reason, but it might be helpful to add a BUG_ON at
>>> CPS driver to handle such situation.
>>
>> I guess that being in KSEG0 allows to use shorter pointer.  But in our
>> case the RAM is physically connected beyond 32bits, so it is not
>> accessible in KSEG0.
>
> For most system there should be a mirror of part of DDR which is accessib=
le
> at KSEG0 and kernel runs from here. As per my interpretion of your code E=
yeQ5
> is also doing this? If not could you please briefly describe the memory m=
ap?
>
> For Kernel in KSEG0 the pointer is still 64bit but we can use fewer inst
> to load ABS pointer into register, see [1].
>

There is a kind of mirror but its physical address start at 0x8000000
so beyond the first 512MBytes that are used for KSEG0.

In short the 32bits mapping is the following:

 - the controllers registers of the SoC are located  until 0x8000000,
 - then from 0x8000000 to 0x10000000 there is the alias to low addresses
   of the DDR
 - then the SPIflash is mapped to from 0x10000000 to 0x20000000
 - after the PCIe Memory 32-bit addr space is from 0x20000000 to
   0x40000000

Gregory

> [1]: https://elinux.org/images/1/1f/New-tricks-mips-linux.pdf

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
