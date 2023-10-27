Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3217D9E25
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjJ0QlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0QlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:41:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325E128;
        Fri, 27 Oct 2023 09:41:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 968FEFF806;
        Fri, 27 Oct 2023 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698424873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDwZ/D783hZpHUTxyWo8uzzbNmWM8NcPjgEWVvEEako=;
        b=DNrWGMessoxhVg7xnqd8tUEPfepPu0KPkEFW56MkmCexLtJnFa90eWYDFOvgkUfEb24Ig5
        hBgncSqlKInZXIANXon/JKnScU2mWXunQVNziicq5U/QWJnZF38lxBXZ/SQXoqnnBTyTHw
        HBnHCOxbmGBHYZZKo5c8EFnm2/6HCbfhzC8otjYbTfBDQbtE7LglEn1SjemVL0SLE9ucnB
        AbRj6eegfB+QqjJRjUjbqFlwbvzhBlID4rY0xNgrz8LdihZ3SmqdfBCPgfl7r0dwSfaL5u
        5wHdIIh85RVtq7jB/krQqW/Itdo3spWhFcWYx3Yu2CovwHZ2pryTawpLmu8z3A==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/5] MIPS: Fix kernel in XKPHYS
In-Reply-To: <875y2s81lx.fsf@BL-laptop>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
 <875y2s81lx.fsf@BL-laptop>
Date:   Fri, 27 Oct 2023 18:41:12 +0200
Message-ID: <87zg046ms7.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory CLEMENT <gregory.clement@bootlin.com> writes:

> Hello Jiaxun,
>
>
>> Hi all,
>>
>> This series fixes support for loading kernel to XKPHYS space.
>> It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].
>>
>> Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
>> QEMU patch on the way.
>>
>> Gregory and Vladimir, do let me know if I missed anything.
>
> Thanks for this series, I reviewed it and tested it on my platform, so
> you can add for all the patches:
>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> However I add to fix the patch " MIPS: Handle mips_cps_core_entry within
> lower 4G", I think you missed a case. I will comment on it.
>
> Gregory

I forgot to say that if your series is not merged in 6.7, then I would
like to bring it in my series as I have to change some part of the code
to add support for the memory aliasing workaround.

Thanks,

Gregory


>
>
>>
>> Thanks
>> - Jiaxun
>>
>> [1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/
>>
>> Jiaxun Yang (5):
>>   MIPS: Export higher/highest relocation functions in uasm
>>   MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
>>   MIPS: Fix set_uncached_handler for ebase in XKPHYS
>>   MIPS: Handle mips_cps_core_entry within lower 4G
>>   MIPS: Allow kernel base to be set from Kconfig for all platforms
>>
>>  arch/mips/Kconfig               | 18 +++++++++++++----
>>  arch/mips/include/asm/mips-cm.h |  1 +
>>  arch/mips/include/asm/uasm.h    |  2 ++
>>  arch/mips/kernel/genex.S        | 19 +++++++++++++----
>>  arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++------
>>  arch/mips/kernel/traps.c        | 36 +++++++++++++++++++++++----------
>>  arch/mips/mm/uasm.c             |  6 ++++--
>>  7 files changed, 82 insertions(+), 27 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
