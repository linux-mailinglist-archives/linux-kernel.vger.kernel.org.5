Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497C07F2C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjKULzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjKULzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:16 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE78D1;
        Tue, 21 Nov 2023 03:55:05 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 820D040E01E3;
        Tue, 21 Nov 2023 11:55:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kafUwt00W7Tn; Tue, 21 Nov 2023 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700567701; bh=3ViODio9hxdCESGN+YaO4XUuDqr800FK22MlYHsgMTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj0703161sDM55cSRYuw6vSSa2zhOzytw9PbW/w80xmLEVUmGTcYP9gT+WRxh4cBf
         7URtpMyitIoygq7uoPN0kX9xsSm8eEShW+Kaw68gfUxqum9BaDWWwayAwO5fg/m+9z
         MlCJrkOAk5bEDGnHwn2CzudbCWh+UN4FDcR1TM0/fH2oExmPXLw9GbgOai7Ceh7BVa
         bXlynPWZuemPGZq5+WMaPdlZWbOyvucWzm2YTh2ipoO8nnm1YAIzJII9R2SW0VNoC6
         NWacx+wfpOPacv9rq1HWpwa75rgdWB+pkJYrh1HbPWDYpiH+/kl+SDIv6xu6fbG5Qp
         6yItloD/dKgiiuBXDejL9PuvjA5NrEfc6joJr0DJH4Sf190rLaZlQAbYoeos3qgny9
         l72TsKt9auFvVyR5KZF3CoANaRrmVa1XJXShNaxMVCkopYoK+SlRyNLeCUpQ5fE/a8
         5mX6IVoFDBbgj8WnkzIEYVkeNE7Sdz+utF6tl0epMpdrf22E0ugsOyqUm8O1L5nbcx
         CV1bYSJxpOWXOuAGcIemQZtf7kfFuYG2MVAyp5nXDKVqSArEal3g9i1Aclanb5QE+J
         I3tTS6xZ4HHcpj8C9HvxH1/AJ813+kLDmWOCEdgJvx+ofcVn/FMGT150FFHLzG6zG7
         SFBV5+mAApAKCnCNEWtVPnDQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B6CA40E01AD;
        Tue, 21 Nov 2023 11:54:53 +0000 (UTC)
Date:   Tue, 21 Nov 2023 12:54:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVPu/hX9b7lUkrBY@agluck-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
> Before any storm happens, machine_check_poll() may only be called once
> a month, or less, when errors occur.

Err:

[  317.825546] mce: mc_poll_banks_default: CPU2 irq ctxt level: 1
[  317.825585] mce: mc_poll_banks_default: CPU0 irq ctxt level: 1
[  317.825585] mce: mc_poll_banks_default: CPU1 irq ctxt level: 1
[  317.825586] mce: mc_poll_banks_default: CPU3 irq ctxt level: 1
[  317.825586] mce: mc_poll_banks_default: CPU4 irq ctxt level: 1
[  317.825586] mce: mc_poll_banks_default: CPU5 irq ctxt level: 1
[  629.121536] mce: mc_poll_banks_default: CPU1 irq ctxt level: 1
[  629.121536] mce: mc_poll_banks_default: CPU4 irq ctxt level: 1
[  629.121560] mce: mc_poll_banks_default: CPU2 irq ctxt level: 1
[  629.121561] mce: mc_poll_banks_default: CPU0 irq ctxt level: 1
[  629.121561] mce: mc_poll_banks_default: CPU5 irq ctxt level: 1
[  629.121569] mce: mc_poll_banks_default: CPU3 irq ctxt level: 1
[  940.417507] mce: mc_poll_banks_default: CPU2 irq ctxt level: 1
[  940.417508] mce: mc_poll_banks_default: CPU3 irq ctxt level: 1
[  940.417508] mce: mc_poll_banks_default: CPU1 irq ctxt level: 1
[  940.417508] mce: mc_poll_banks_default: CPU4 irq ctxt level: 1
[  940.417509] mce: mc_poll_banks_default: CPU5 irq ctxt level: 1
[  940.417508] mce: mc_poll_banks_default: CPU0 irq ctxt level: 1
...

That's from my coffeelake test box.

The irq context level thing says we're in softirq context when the
polling happens.

> When a storm is detected for a bank, that bank (and any others in storm
> mode) will be checked once per second.

Ok.

> For a bank that doesn't support CMCI, then polling is the only way
> to find errors. You are right, these will feed into the history
> tracker, but while at 5-minute interval will not be able to trigger
> a storm.

Yes. But you need to call into the storm handling code somehow. So you
do that from the polling code.

And if the machine supports CMCI, you do the same - call the polling
code which then does the storm check.

> Since that 5-minute interval is halved every time error is
> found consecutively, it is possible at the 1-second poll interval to
> fill out enough bits to indicate a storm. I think I need to add some
> code to handle that case as it makes no sense to mess with the CMCI
> threshold in IA32_MCi_CTL2 for a bank that doesn't support CMCI.
> Probably will just skip tracking for any such banks.

Ok.

> Aren't interrupts disabled while running the code after the timer fires?

No, see above.

> Whichever of the timer and the CMCI happens first will run. Second to
> arrive will pend the interrupt and be handled when interrupts are
> enabled as the first completes.

So I still don't like the timer calling machine_check_poll() and
cmci_mc_poll_banks() doing the same without any proper synchronization
between the two.

Yes, when you get a CMCI interrupt, you poll and do the call the storm
code. Now what happens if the polling runs from softirq context and you
get a CMCI interrupt at exactly the same time. I.e., is
machine_check_poll() reentrant and audited properly?

I hope I'm making more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
