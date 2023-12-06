Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7080807A12
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379734AbjLFVEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379664AbjLFVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:04:45 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF510C8;
        Wed,  6 Dec 2023 13:04:40 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9A62D40E00C7;
        Wed,  6 Dec 2023 21:04:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id edYgQIUHF9sY; Wed,  6 Dec 2023 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701896676; bh=fH8zZ2zj5dUyDFGH6V40MJLk/dQOHJJyXQL9fgCKjj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOdSCy+AvYB5pbbH/V724arRMPyY4mqZ5h8DDPmPgcVmtz9x+Sy5iUc3sGCeflA8p
         mj8BRk6Xb4Tve8Qgqh+0DFEbqmdJI1evBSyqSRFXq8e7dZMxUG1xapfAb9QoPEVZaO
         OFl3V28unNQeez+kqz1PQPVOYUVkaFQ1gr715hcqf8nUJSUhkL4rsyn8yndHi67+4r
         TIW0iNU/0+XkBtP+zVNnOSvEMup5zO0Cb9wAHUjfYCsaKPZolzOhzJbTZ1pZn58r5W
         xLav22NtK1wjOabL1BVkpTayxmDjVyJUydGtl8X0vzg50AvyPR+r4LxHL3KQgQL1Y3
         PlugFJPrPKSApnqHW1vi1QnkDIDnHRhHZrNxqaZIESgx/r1MzhHSrD/784nhB7UZyA
         MygZZG5FtnZJXxie8ch4LkaxSZeOVPGbigfybKPkfz0bow7EqXb3vfXf7RWMwd3vTg
         6CJjsEHrFbwptpXZKYZ8Bi34ZGIvgBJHQthjI8sse6St6ms2zooeofb3HD2xDLZeOp
         SVM2A6QXpL/J0OYNbT+sui0p1NCuYdErrY0PjeeKZEJdO67R5EGFvgbUVkqYKtgFBO
         HeRzWzbsE0lN8qge59RegFa+nd6+HvsJwlSM9YA+1MkydSuVVA8WSNGIQR1vBc+ndl
         MpLdFJsjSqQvuiIdP8wH5BJ4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A58BA40E00C6;
        Wed,  6 Dec 2023 21:04:27 +0000 (UTC)
Date:   Wed, 6 Dec 2023 22:04:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Sironi, Filippo" <sironi@amazon.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Message-ID: <20231206210421.GFZXDh1UQ7L8K/toOM@fat_crate.local>
References: <20231201112327.42319-1-sironi@amazon.de>
 <ZWos70EKhlAl2VPb@agluck-desk3>
 <5A9651E8-AB49-4B8E-9B98-65708E8E8E4E@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A9651E8-AB49-4B8E-9B98-65708E8E8E4E@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 07:56:59PM +0000, Sironi, Filippo wrote:
> Boris, I just took a quick look and I might be missing something. If cores
> fail to load the microcode or timeout, we taint the kernel, print an error
> message, and then bubble up an error to userspace via:
> 
> load_late_stop_cpus
> load_late_locked
> reload_store
> 
> Right?

Yap.

> We would take servers that fail out of production;

And I'd like to hear about such issues. We added this failure checking
only recently because something might go wrong and we want to warn. But
it all updates fine here so kinda hard to test.

My expectation is that if microcode fails loading on a subset of
machines, the machine would more or less freeze. Depending, ofc, on what
the microcode is updating...

> however, for others it might be interesting to have the correct
> information. The patch - with a reworked commit message - might still
> be useful to a few.

https://lore.kernel.org/r/20231118193248.1296798-3-yazen.ghannam@amd.com

:)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
