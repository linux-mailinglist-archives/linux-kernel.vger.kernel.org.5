Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E2E7CABC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjJPOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:41:22 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58915A2;
        Mon, 16 Oct 2023 07:41:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 626A440E0196;
        Mon, 16 Oct 2023 14:41:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 66KAabpmNXcA; Mon, 16 Oct 2023 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697467277; bh=2b52cJ4/yBgzE5Vy2ztFqnYa/B1bYnqKYLZyqDKPKi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYO4++zZaPNkg4Kq1xQwnH7UDctXiOQcufCVfftW2ur1T91b0Og0oygE/gyQ/VWkM
         Sec1Zw6Vid8I3jFJnL/gKwCV0Jxyg/liPVA81I5BIhSOI7MjifoOIE8i+AwgGNY9Pi
         w1Bmz0MCeniaXz+Vpy6vM+uORosKhi0Qyl3MBkMPufUlCZYc6nnQ4yUmRUgDTosWvT
         Xm+JmNVpP2h+jCF6jbKUAGD4jlPBmbJjTq36KlLlsnenAL4jaxUVq+0avfdoB//J4d
         yh6zY/Zxfvp3HFy77BVO590lB+LkpaY9b5N1T+l+tqKxiDK/L581Dc4GCnpv8eLpiL
         bDCY1cfRnc97QSPTAkWbopUMXsu42RJ7JDN+RiScA5BEjwF9e40Rx3N3BonFJ066ci
         cg/pFyRKHlFBciGFF/Zci0FdSFbdFehDT9f8sbw9XKlKAYMR1ltbQmHe0Tt89kinwI
         rpOP1ldclvVkEcQ4t4vOveQpt+lF8D3gFIjDPtU2xDRaW2v78keXhFNJcRkSHrQssl
         3Z3ccHrCIUnZdO8wDfSwhH7kmqQE/SMKhu7uiJp4SJb2DgWwPnu+VKpTOIWsc8HN7u
         sRnxnMYIhStgiHoY9/xm3WwArp5CROlo5BpY0yqMK0U5WyzWBrPMgLGrsDTWvPAwoO
         9c+XZi2c+jrkKeKeAQg3X+7I=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C89840E01AA;
        Mon, 16 Oct 2023 14:41:06 +0000 (UTC)
Date:   Mon, 16 Oct 2023 16:40:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
Message-ID: <20231016144058.GEZS1LemcrhZvVrC15@fat_crate.local>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
 <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
 <6591377b-7911-444b-abf9-cfc978472d76@intel.com>
 <1c598798-5b28-4a17-bf86-042781808021@amd.com>
 <dd72296c-def6-4fb3-9984-348641cdb6a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd72296c-def6-4fb3-9984-348641cdb6a4@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:24:34AM -0700, Dave Hansen wrote:
> On 10/16/23 07:14, Yazen Ghannam wrote:
> > 1) Keep the current config size for boot time. 
> > 2) Add a kernel parameter
> > and/or sysfs file to allow users to request additional genpool capacity.
> > 3) Use gen_pool_add(), or whichever, to add the capacity based on user
> > input. Maybe this can be expanded later to be automatic. But I think it
> > simpler to start with explicit user input.
> 
> I guarantee virtually nobody will ever use an explicit kernel interface
> to bump the size up.  It'll be the same exact folks that recompile their
> kernels.
> 
> An automatic resizing one doesn't have to be fancy and only has to
> expand once:

Can we slow down here pls?

You expand once and then that stuck bit error increases its rate of MCEs
reported and all of a sudden that raised size is overflowed again.

Or, you add logic which thresholds duplicate errors similar to the cmci
storm logic we have.

*If* that is the case at all.

So can we analyze first what type of errors are reported and why they're
overflowing the pool before we do ad-hoc hackery?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
