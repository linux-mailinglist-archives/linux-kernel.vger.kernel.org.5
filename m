Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361AE7F3243
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjKUPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjKUPYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:24:16 -0500
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64D92;
        Tue, 21 Nov 2023 07:24:11 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:24:07 +0100
From:   Tomasz Pala <gotar@polanet.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-2?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Manciulea <manciuleas@protonmail.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231121152407.GA13288@polanet.pl>
References: <20231118142143.GA14101@polanet.pl>
 <20231120162933.GA197390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20231120162933.GA197390@bhelgaas>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:29:33 -0600, Bjorn Helgaas wrote:

> Thank you!  A BIOS update is almost never the answer because even if
> an update exists, we have to assume that most users in the field will
> never install the update.

Not to mention enabling 64-bit BARs, which is even more cumbersome
ixgbe-specific magic that requires entirely dedicated tools...

>> .text .data .bss are not marked as E820_TYPE_RAM!
and
>> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000df243000-0x00000000df251fff], contact BIOS vendor for fixes
>> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000000df243000-0x00000000df251fff]
[...]
> I think Linux basically converts the info from EFI GetMemoryMap
> to an e820 format; I think booting with "efi=debug" would show more
> details of this.

The dmesg I've attached today is with efi=debug, but the weird thing is
- both of the above warnings manifested themself only once, with the
first (verbose debugging: "MCFG debug") patch applied... Anyway.

The "memremap attempted on mixed range 0x0000000000000000 size: 0x8000
WARNING: CPU: 0 PID: 1 at kernel/iomem.c:78 memremap+0x154/0x170" also
seems to be triggered by "efi=debug", so my guess is that it's unrelated.

-- 
Tomasz Pala <gotar@pld-linux.org>
