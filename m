Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF67F35D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjKUSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKUSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:19:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59997
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:19:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E3AC433C7;
        Tue, 21 Nov 2023 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700590774;
        bh=j7HBjbV0HBXxOEcT0OG9f5FjRXuKR0dQ3RimJ19uarQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UR90IS6tEP7ZH2Mu//OVccMIjGE9Vfl31LFB4El1nPF2ME8r7MMhbJAEfIoHe/tY0
         yflc2zxpNeR3lm0pOY5pTyPelPCqTaXnBpamkUhP3cPZe4uhe/N9ORKaOYvpU6yRbk
         wwRIEoS1TTof4N+ylTO2ur+LBoJM5h4jdbeQuXbjG8RMYJQkA1kltTm8oae4AORsJc
         kofl5OLse5z+UlsudmRzP52jMFc7wzD+CWsOk2JVqNYBZ1B13iknFXUXlNJNp9Cndq
         eJGM+6jfUQIdSPhFsfppv4UaWAe/MqQwNjD32OaNC5SDg74EZuilu0oIHaU0y7Obh6
         3LCOJmrFHWiqQ==
Date:   Tue, 21 Nov 2023 12:19:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tomasz Pala <gotar@polanet.pl>
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
        Benoit =?utf-8?B?R3LDqWdvaXJl?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Manciulea <manciuleas@protonmail.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231121181933.GA240494@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121152407.GA13288@polanet.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:24:07PM +0100, Tomasz Pala wrote:
> On Mon, Nov 20, 2023 at 10:29:33 -0600, Bjorn Helgaas wrote:
> 
> > Thank you!  A BIOS update is almost never the answer because even if
> > an update exists, we have to assume that most users in the field will
> > never install the update.
> 
> Not to mention enabling 64-bit BARs, which is even more cumbersome
> ixgbe-specific magic that requires entirely dedicated tools...
> 
> >> .text .data .bss are not marked as E820_TYPE_RAM!
> and
> >> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000df243000-0x00000000df251fff], contact BIOS vendor for fixes
> >> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000000df243000-0x00000000df251fff]
> [...]
> > I think Linux basically converts the info from EFI GetMemoryMap
> > to an e820 format; I think booting with "efi=debug" would show more
> > details of this.
> 
> The dmesg I've attached today is with efi=debug, but the weird thing is
> - both of the above warnings manifested themself only once, with the
> first (verbose debugging: "MCFG debug") patch applied... Anyway.

OK.  I don't know what (if anything) to do about the above.

> The "memremap attempted on mixed range 0x0000000000000000 size: 0x8000
> WARNING: CPU: 0 PID: 1 at kernel/iomem.c:78 memremap+0x154/0x170" also
> seems to be triggered by "efi=debug", so my guess is that it's unrelated.

Yes, I think so.  This is from efi_debugfs_init(), which we only run
when "efi=debug", and I think it comes from memremapping this area:

  efi: mem00: [Boot Code   |   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000007fff] (0MB)

Bjorn
