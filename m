Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28217FDFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjK2S7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjK2S7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:59:03 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2ECD5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:10 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1r8Pm3-0000qX-8i; Wed, 29 Nov 2023 19:59:03 +0100
Message-ID: <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
Date:   Wed, 29 Nov 2023 19:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231129172200.430674-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a few more comments after decompiling the FIT image:

On 29.11.23 18:21, Simon Glass wrote:
> +    with fsw.add_node('kernel'):
> +        fsw.property_string('description', args.name)
> +        fsw.property_string('type', 'kernel_noload')

The specification only says no loading done, but doesn't explain what it
means for a bootloader to _not_ load an image. Looking into the U-Boot commit
b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
apparently no loading means ignoring load and entry address?

I presume missing load and entry is something older U-Boot versions
were unhappy about? Please let me know if the semantics are as I understood,
so I can prepare a barebox patch supporting it.

> +        fsw.property_string('arch', args.arch)
> +        fsw.property_string('os', args.os)
> +        fsw.property_string('compression', args.compress)
> +        fsw.property('data', data)
> +        fsw.property_u32('load', 0)
> +        fsw.property_u32('entry', 0)
> +
> +
> +def finish_fit(fsw, entries):
> +    """Finish the FIT ready for use
> +
> +    Writes the /configurations node and subnodes
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        entries (list of tuple): List of configurations:
> +            str: Description of model
> +            str: Compatible stringlist
> +    """
> +    fsw.end_node()
> +    seq = 0
> +    with fsw.add_node('configurations'):
> +        for model, compat in entries:
> +            seq += 1
> +            with fsw.add_node(f'conf-{seq}'):
> +                fsw.property('compatible', bytes(compat))

The specification says that this is the root U-Boot compatible,
which I presume to mean the top-level compatible, which makes sense to me.

The code here though adds all compatible strings from the device tree though,
is this intended?

> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', arch)
> +        fsw.property_string('compression', compress)
> +        fsw.property('compatible', bytes(compat))

I think I've never seen a compatible for a fdt node before.
What use does this serve?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

