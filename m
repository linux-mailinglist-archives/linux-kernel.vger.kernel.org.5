Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1F7C6D60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378508AbjJLLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347230AbjJLLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:53:13 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9757D94
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:52:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 431B340E00B3;
        Thu, 12 Oct 2023 11:52:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x1vVcwXzsvG6; Thu, 12 Oct 2023 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697111540; bh=BhqFVyru2XLjyKZ3twgvU8/mTEynwVJU5dLKj/7BYWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3XucB6pftNr+WVHF+144vqYwXjnq2oCBRHVRyYDFB17m36B1wizyyZ73xlz/r20A
         haLmeHgLrviAO8lFBMnegPvDYKZZfgUEl8xDuawNz6PghaAnAiuEDAiiTeyRQYs34v
         87cfCv9aYffxkUC9f5d5vTqx0FeAN8tafqfSl2Wifmp90xwj8fur4zMncTuYIlnFul
         xpJaI4e4qaJT5D6V7ucToE8B2AH594ZbYBAIVJ58iMS4ZcYLj/Asxovwz5aMEd6Eoe
         6tA4Eu1XTMHZdtkwmkC/IUBcr7CGM6E2fxDvM05DjAD6zyy8KVIalhBH2lTQtEtidx
         RO5h7UcexTYstKUk06/f6rRvPwecuXSu+qyQZWLyJWzHlbOXdk6qERIvAc2YJDFNJb
         nHrnPEquAK4/n4EtuEQGp6ykt+VCgyVbAAlJiia/VxmZs08gFbyYLJB95TMQx5KV4z
         8Pdh72LxFofntEWqbuj1AzankMPYMVIA+8yJjHFC0QsHpFtH6JvwPF13/Sq6CfzngF
         NWcQr0fh3RaK+z6iflvUZIQAwpONigk55Llh21DoN0C4TX83+2r9cUS9I2Kq+51cXS
         wOaHS6YBFuSflYCGKUDxOpPq15OsYIMVXn443+IMs4/SYx4u35tnKeLFMVtkoqg8LE
         /G6SLeoQ2MBRAP/nOsojSDR8=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66B6840E01AE;
        Thu, 12 Oct 2023 11:52:10 +0000 (UTC)
Date:   Thu, 12 Oct 2023 13:52:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Sironi, Filippo" <sironi@amazon.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
Message-ID: <20231012115204.GDZSfd5CPSuEm5RI52@fat_crate.local>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
 <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:46:13AM +0000, Sironi, Filippo wrote:
> I'm happy to make this a compile time configuration where the default is
> still 2 pages, to avoid changing the status quo.

Why don't you keep this patch in your kernels, simply, as this seems to
be an issue only for you currently?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
