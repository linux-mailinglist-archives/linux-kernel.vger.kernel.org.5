Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4EE7E244C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKFNU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjKFNUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:20:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57C94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:20:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42CBC433C7;
        Mon,  6 Nov 2023 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699276821;
        bh=jzqcfpbOrk/5AJCHOBbHDhPfio1D8dMtQdDoPsbqqgs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MB8DxRON0RWJ8uMv1cLkg2c3FsYAcjyhHlmsyx0oa9uZCNEGq9svpWruXhGbP/SqH
         +tBlw/LrH0Tm5LPdOnR341sG4mN4tMcI0ZIO5w1QLIVH0LxpEgcM2LxmthSrKMj639
         37yKBL5mvo2xm4lOJDy2xw91ByBsX0Y7BMwZvHy9gTK5UfR4SQ+K7yTHMNKEtpzPvk
         6wT79/vLfVfliTLUkEvyZ7fpKSYyw26MP2LMMz3ymUtYa+uZpH9Rg95JRhyqksXTMG
         O3msLKGydJBIoxNjDKKjvewaTEpPOtk8JTkfaARImymEooaSfhSWJWukcI2bruSzEC
         DbDAY9QZ67Nng==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset
 failures
In-Reply-To: <8D87B330-8FA1-46BE-949E-5A8DFB8AACF3@walle.cc> (Michael Walle's
        message of "Thu, 26 Oct 2023 18:02:20 +0300")
References: <20231026012017.518610-1-acelan.kao@canonical.com>
        <mafs0fs1xmrit.fsf@kernel.org>
        <8D87B330-8FA1-46BE-949E-5A8DFB8AACF3@walle.cc>
Date:   Mon, 06 Nov 2023 14:20:18 +0100
Message-ID: <mafs01qd3hvcd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26 2023, Michael Walle wrote:

> Am 26. Oktober 2023 16:39:54 OESZ schrieb Pratyush Yadav <pratyush@kernel.org>:
>>On Thu, Oct 26 2023, AceLan Kao wrote:
>>
>>> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>>>
>>> When the software reset command isn't supported, we now report it
>>> as an informational message(dev_info) instead of a warning(dev_warn).
>>> This adjustment helps avoid unnecessary alarm and confusion regarding
>>> software reset capabilities.
>>
>>I still think the soft reset command deserves a warn, and not an info.
>>Because it _is_ a bad thing if you need to soft reset and are unable to
>>do so. Your bootloader (or linux if you rmmod and modprobe again) might
>>not be able to detect the flash mode and operate it properly. 
>
> agreed.. but.. 
>
>>I think we should just not unconditionally run this and instead only
>>call it when the flash reset is not connected -- that is only call this
>>under a check for SNOR_F_BROKEN_RESET, like we do for 4-byte addressing
>>mode.
>
> .. keep in mind that this is a restriction of the flash controller. the Intel one seems to be the only affected one (for now) and it's doing a reset (according to mika) on its own. 
>
> snor_broken_reset is a property of the flash. 

The documentation for the property says:

  broken-flash-reset:
    type: boolean
    description:
      Some flash devices utilize stateful addressing modes (e.g., for 32-bit
      addressing) which need to be managed carefully by a system. Because these
      sorts of flash don't have a standardized software reset command, and
      because some systems don't toggle the flash RESET# pin upon system reset
      (if the pin even exists at all), there are systems which cannot reboot
      properly if the flash is left in the "wrong" state. This boolean flag can
      be used on such systems, to denote the absence of a reliable reset
      mechanism.

So it is more a property of the system as a whole perhaps.

>
>
>>I don't have a strong opposition to this patch but I do think it is
>>fixing the problem in the wrong place.
>
> if the flash controller doesn't let you issue a soft reset (or does so on its own), what's the fix?

I think in those cases we could inquire the controller if it can do a
soft reset (probably via spi_mem_supports_op()). If it can not do so
_and_ the flash reset is broken, refuse to enter stateful modes like
8D-8D-8D or 4-byte addressing.

We already do so for the broken reset thing in
spi_nor_spimem_adjust_hwcaps():

	/*
	 * If the reset line is broken, we do not want to enter a stateful
	 * mode.
	 */
	if (nor->flags & SNOR_F_BROKEN_RESET)
		*hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);

We should probably also add a spi_nor_spimem_can_soft_reset() (function
doesn't exist as of now -- just using an example name) check here.

Note: This restriction is placed only for X-X-X modes, and not 4-byte
addressing mode, which is an inconsistency on SPI NOR's part. See below.

Alternatively, if we are more willing to let users shoot themselves in
the foot if they so wish, we can just throw a warning that you might not
be able to recover, like we do in spi_nor_init():

	/*
	 * If the RESET# pin isn't hooked up properly, or the system
	 * otherwise doesn't perform a reset command in the boot
	 * sequence, it's impossible to 100% protect against unexpected
	 * reboots (e.g., crashes). Warn the user (or hopefully, system
	 * designer) that this is bad.
	 */
	WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
		  "enabling reset hack; may not recover from unexpected reboots\n");
	err = spi_nor_set_4byte_addr_mode(nor, true);

In that case, we would only run spi_nor_soft_reset() if the reset is
broken and let the user deal with the consequences if it fails.

-- 
Regards,
Pratyush Yadav
