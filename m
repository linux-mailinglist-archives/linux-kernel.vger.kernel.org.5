Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F1B7E26C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKFO1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjKFO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:27:38 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BFBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:27:34 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3FDA7D4B;
        Mon,  6 Nov 2023 15:27:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699280850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUP1R4gND1+LvVnTYb5qvkeE13We2IemdOImxK0D8ok=;
        b=WID7QANRSvNtcNk5VasH3BiQDf2fEK9w6ELkyaWRTTC2KTk0nXomapk+28ui84KEsPoN1c
        E8827W9nLe/92OVnHmfbuaQq62ZY1mJZiM/BZCTj7Fn+mu5eFSDpNUrgAT+//Cj8Fr5kaW
        7W7d+cQ1W1B76jlPybAd0e3lCW6MEdY5MXi2e7vEcEMmEVZpq3r/jqX6RTLwqTOMnaeW3u
        JlSGNWL1Ar8Wk+F8BXOV6XDTp58gHYM6woSKCX/oYO9rtaF+wRqg9YvbQ3QM9fpsmtwJgc
        L54ZtiJTMiowDgAz2qTuyyut2uvLg8LjO/djPJuueQGyD2kgE2KilA+TC97BQg==
MIME-Version: 1.0
Date:   Mon, 06 Nov 2023 15:27:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <pratyush@kernel.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset
 failures
In-Reply-To: <mafs01qd3hvcd.fsf@kernel.org>
References: <20231026012017.518610-1-acelan.kao@canonical.com>
 <mafs0fs1xmrit.fsf@kernel.org>
 <8D87B330-8FA1-46BE-949E-5A8DFB8AACF3@walle.cc>
 <mafs01qd3hvcd.fsf@kernel.org>
Message-ID: <994df862c4f9f0c5974d064b84a2431c@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> When the software reset command isn't supported, we now report it
>>>> as an informational message(dev_info) instead of a 
>>>> warning(dev_warn).
>>>> This adjustment helps avoid unnecessary alarm and confusion 
>>>> regarding
>>>> software reset capabilities.
>>> 
>>> I still think the soft reset command deserves a warn, and not an 
>>> info.
>>> Because it _is_ a bad thing if you need to soft reset and are unable 
>>> to
>>> do so. Your bootloader (or linux if you rmmod and modprobe again) 
>>> might
>>> not be able to detect the flash mode and operate it properly.
>> 
>> agreed.. but..
>> 
>>> I think we should just not unconditionally run this and instead only
>>> call it when the flash reset is not connected -- that is only call 
>>> this
>>> under a check for SNOR_F_BROKEN_RESET, like we do for 4-byte 
>>> addressing
>>> mode.
>> 
>> .. keep in mind that this is a restriction of the flash controller. 
>> the Intel one seems to be the only affected one (for now) and it's 
>> doing a reset (according to mika) on its own.
>> 
>> snor_broken_reset is a property of the flash.
> 
> The documentation for the property says:
> 
>   broken-flash-reset:
>     type: boolean
>     description:
>       Some flash devices utilize stateful addressing modes (e.g., for 
> 32-bit
>       addressing) which need to be managed carefully by a system. 
> Because these
>       sorts of flash don't have a standardized software reset command, 
> and
>       because some systems don't toggle the flash RESET# pin upon 
> system reset
>       (if the pin even exists at all), there are systems which cannot 
> reboot
>       properly if the flash is left in the "wrong" state. This boolean 
> flag can
>       be used on such systems, to denote the absence of a reliable 
> reset
>       mechanism.

But still, this property is a child of the flash node. Anyway, we cannot
force a user to change their DTS, just to avoid that (spurious) warning 
in
this case.

Also, we don't *have* to change the DTS because we know that it is a
property of the spi driver anyway. So we could just ask it.

> So it is more a property of the system as a whole perhaps.
> 
>> 
>> 
>>> I don't have a strong opposition to this patch but I do think it is
>>> fixing the problem in the wrong place.
>> 
>> if the flash controller doesn't let you issue a soft reset (or does so 
>> on its own), what's the fix?
> 
> I think in those cases we could inquire the controller if it can do a
> soft reset (probably via spi_mem_supports_op()). If it can not do so
> _and_ the flash reset is broken, refuse to enter stateful modes like
> 8D-8D-8D or 4-byte addressing.

Mh, I tend to agree but see some drawbacks. What cases do we have.

For the controller:
  (1) Just a regular/dumb spi controller where the commands are somewhat
      opaque. That's the usual case.
  (2) We have some kind of high level controller which just allows a 
subset
      of commands but also do it's own handling, esp. bring the reset 
into a
      known state on bootup/reset.

For the flash:
  (a) The flash has a dedicated reset line
  (b) The flash doesn't have a dedicated reset line, but supports s/w 
reset
  (c) none of the above

(b) will also always just be a best effort thing. What if there is a 
hardware
reset and linux doesn't get to call the soft reset on shutdown. So I'd 
treat
(b) the same as (c). Except that we enter 4byte addressing mode even if 
the
flash doesn't have a reset line. I don't know if we can change this 
behavior
at this point. Might break some boards.

Let's start with the easy one (1a). The DT shouldn't contain the broken 
flash
reset property, but because there is a proper reset line we can just 
enter
stateful modes. Now we have (1c) where we cannot enter stateful modes, 
but
we do for the 4byte addressing mode (correct?). And as a workaround we 
try
our best to disable that mode (by disabling the mode and by doing a soft
reset).

If I understand you correctly, you suggest to keep the current behavior 
for
just (1b) and refuse any modes for (1c). I tend to disagree, because how 
useful
is the flash if it cannot enter 4byte mode (and doesn't have 4b 
opcodes). I'd
argue it's useless :) Or at least it is really unexpected that we can 
just
address the first 16MiB, and bad things will probably happen if 
partitions
go beyond that boundary.

That leaves us with (2). I don't thing we should do anything specific 
here
unless there is a real problem and let the controller handle all the 
cases
for us. Mika confirmed, that the intel controller will do the handling.
By just looking whether the controller might support the soft-reset 
operation,
we cannot know if we will have a problem on reboots or not. Maybe that
controller will issue the "get me out of 8d8d8d" sequence on it's own.
Therefore, the query to the SPI controller should rather be, "do we need
a soft reset at all" - or can we enter stateful modes without caring on 
how
to exit them.

-michael

> We already do so for the broken reset thing in
> spi_nor_spimem_adjust_hwcaps():
> 
> 	/*
> 	 * If the reset line is broken, we do not want to enter a stateful
> 	 * mode.
> 	 */
> 	if (nor->flags & SNOR_F_BROKEN_RESET)
> 		*hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
> 
> We should probably also add a spi_nor_spimem_can_soft_reset() (function
> doesn't exist as of now -- just using an example name) check here.
> 
> Note: This restriction is placed only for X-X-X modes, and not 4-byte
> addressing mode, which is an inconsistency on SPI NOR's part. See 
> below.
> 
> Alternatively, if we are more willing to let users shoot themselves in
> the foot if they so wish, we can just throw a warning that you might 
> not
> be able to recover, like we do in spi_nor_init():
> 
> 	/*
> 	 * If the RESET# pin isn't hooked up properly, or the system
> 	 * otherwise doesn't perform a reset command in the boot
> 	 * sequence, it's impossible to 100% protect against unexpected
> 	 * reboots (e.g., crashes). Warn the user (or hopefully, system
> 	 * designer) that this is bad.
> 	 */
> 	WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
> 		  "enabling reset hack; may not recover from unexpected reboots\n");
> 	err = spi_nor_set_4byte_addr_mode(nor, true);
> 
> In that case, we would only run spi_nor_soft_reset() if the reset is
> broken and let the user deal with the consequences if it fails.
