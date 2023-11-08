Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44AA7E5AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKHQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjKHQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:12:37 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670D19A5;
        Wed,  8 Nov 2023 08:12:34 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 667A94000C;
        Wed,  8 Nov 2023 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699459952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UkJQ7GDDcqGNmdP1cyiXZEQfrc5evDlkv29wrBp07Cc=;
        b=gzcREKerJc4rsIRxBIX6K0zNm8Zf/0FbCJIZTbQ5jyiqeQxxI5Kw6sgXX+SxVYXSfxqyHO
        z9EXhUPM4zDjjO2J60eMBmiLWoIwaRAuiQIlj4vfvfrW2nu4hLjge5YUWjs89W/BSXNcRT
        Ig7D0IUvKOAxXzj6V1RUVz5/bI6LWr5jNdMdNUA4yv7wGlZe0vMNtmmMDfVL2tq0wLwZll
        LU3v0qJPEgjp8DdbIbkYxx21NZLJDfUpFR9uqiE5qtL/zv7fBDtUSRUvCttS0AiVViv0S3
        JeC+UaE6IJQe0heR6POU28366f2KZiTQH/1OiNbwM2tJY+vmxo0uYJL2qX08vA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 00/10] MIPS: Fix kernel in XKPHYS
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
Date:   Wed, 08 Nov 2023 17:12:31 +0100
Message-ID: <87r0l06x74.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun,

> Hi all,
>
> This series fixes support for loading kernel to XKPHYS space.
> It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].
>

Thanks for this new series, I was able to test it this week and I have a
few comments.


> Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
> QEMU patch on the way.
>
> For EyeQ5's memory layout, I think you just need to write devicetree memory
> node as:
>
> memory@0 {
> 	device_type = "memory";
> 	reg = < 0x0 0x08000000 0x0 0x08000000
> 		0x8 0x08000000 0x0 0x78000000>;
> };
>
> And set kernel load addesss to somewhere in RAM, everything should
> work.

With this setup and a workaround that I had to do and I will comment in
for the patch "MIPS: Refactor mips_cps_core_entry implementation", I
managed to boot the kernel and the 8 core of my setup are detected.

>
> It makes me a little bit confused that in EyeQ5 enablement patch, you set
> load address to:
>> +else
>> +load-$(CONFIG_MIPS_GENERIC)	+= 0xa800000080100000
>> +endif
> Where does not have memory aviailable.
>
> I guess you might want to set it to 0xa800000800100000?
> Though I would suggest you to set it to 0xa800000808000000, to avoid
> collisions with low mem and reserved mem.

Indeed I used CONFIG_PHYSICAL_START=0xa800000808000000

Gregory
>
> Gregory and Vladimir, do let me know if I missed anything.
>
> Thanks
> - Jiaxun
>
> [1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/
>
> Jiaxun Yang (10):
>   MIPS: Export higher/highest relocation functions in uasm
>   MIPS: spaces: Define a couple of handy macros
>   MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
>   MIPS: Fix set_uncached_handler for ebase in XKPHYS
>   MIPS: Refactor mips_cps_core_entry implementation
>   MIPS: Allow kernel base to be set from Kconfig for all platforms
>   MIPS: traps: Handle CPU with non standard vint offset
>   MIPS: Avoid unnecessary reservation of exception space
>   MIPS: traps: Enhance memblock ebase allocation process
>   MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
>
>  arch/mips/Kconfig                           |  27 ++--
>  arch/mips/include/asm/addrspace.h           |   5 +
>  arch/mips/include/asm/mach-generic/spaces.h |   5 +-
>  arch/mips/include/asm/mips-cm.h             |   1 +
>  arch/mips/include/asm/smp-cps.h             |   4 +-
>  arch/mips/include/asm/traps.h               |   1 -
>  arch/mips/include/asm/uasm.h                |   2 +
>  arch/mips/kernel/cps-vec.S                  | 110 +++++--------
>  arch/mips/kernel/cpu-probe.c                |   5 -
>  arch/mips/kernel/cpu-r3k-probe.c            |   2 -
>  arch/mips/kernel/genex.S                    |  19 ++-
>  arch/mips/kernel/head.S                     |   7 +-
>  arch/mips/kernel/smp-cps.c                  | 167 +++++++++++++++++---
>  arch/mips/kernel/traps.c                    |  85 +++++++---
>  arch/mips/mm/uasm.c                         |   6 +-
>  15 files changed, 293 insertions(+), 153 deletions(-)
>
> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
