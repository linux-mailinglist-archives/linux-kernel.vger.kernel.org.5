Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C876D064
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHBOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjHBOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:45:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788FE62
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BO8Ij+6E7OiVZbyL3pQYd1kEkHL5/xtBrMMcnoXeckM=; b=0Cs9hCSs06dj+eUXJC/+Clv05T
        jn0e/O9hJ8BExdiiA2TvU/dUBzCN8Vx4cEOWtmZoX+h5v/pjCKKzFIJjXC0yo4ueXteW2xOmrbQvk
        kPNdjvLJx3OEXejAxnSUcid3sIjhN5pnudjcuDZ5Y8Fq0DkDUYbqni3XR2zKS4XWj32bkhAFnwBER
        8EZshTE84YW1rwYDXDiAb4QaswyuLI4YKgVDSaZjWZhsyyadFDrCmziiqaCqxgbTPtdVUDcHX/Y7P
        TKMX/BROcnle/BOgSQ8uOoiRJ/wqEHXJU3Wd8tMn1mwayAUBoEsUvvdOxpc+81ARDfHzFXBFgfvgZ
        Qrqn3Qng==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRD5w-00571R-0j;
        Wed, 02 Aug 2023 14:45:00 +0000
Message-ID: <182b08ea-04f3-3282-e3c3-9448bab6568a@infradead.org>
Date:   Wed, 2 Aug 2023 07:44:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] powerpc: Use shared font data
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230725000141.165985-1-linux@treblig.org>
 <878rb0em3s.fsf@mail.lhotse> <ZMOaz9EqqeaPGokA@gallifrey>
 <871qgl1vs2.fsf@mail.lhotse>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <871qgl1vs2.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 05:19, Michael Ellerman wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
>> * Michael Ellerman (mpe@ellerman.id.au) wrote:
>>> linux@treblig.org writes:
>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>
>>>> PowerPC has a 'btext' font used for the console which is almost identical
>>>> to the shared font_sun8x16, so use it rather than duplicating the data.
>>>>
>>>> They were actually identical until about a decade ago when
>>>>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>>>>                         "broken bar" to "vertical line"")
>>>>
>>>> which changed the | in the shared font to be a solid
>>>> bar rather than a broken bar.  That's the only difference.
>>>>
>>>> This was originally spotted by PMD which noticed that sparc does
>>>
>>> PMD means "Page Middle Directory" to most Linux folks, I assume that's
>>> not what you meant :)
>>
>> Ah, any good TLA is ripe for reuse:
>>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> 
> Thanks.
> 
> Unfortunately this patch causes a warning:
> 
>   WARNING: unmet direct dependencies detected for FONT_SUN8x16
>     Depends on [n]: FONT_SUPPORT [=y] && FRAMEBUFFER_CONSOLE [=y] && (!SPARC && FONTS [=n] || SPARC)
>     Selected by [y]:
>     - BOOTX_TEXT [=y] && PPC_BOOK3S [=y]
> 
> And breaks allmodconfig with:
> 
>   ld: arch/powerpc/kernel/btext.o:(.toc+0x0): undefined reference to `font_sun_8x16'
>   make[3]: *** [../scripts/Makefile.vmlinux:36: vmlinux] Error 1
> 
> I guess the Kconfig logic needs some more work.

Also please see:
  https://lore.kernel.org/all/dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org/
for a similar problem on UML.

-- 
~Randy
