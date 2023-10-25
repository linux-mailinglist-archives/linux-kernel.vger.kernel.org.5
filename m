Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD32C7D6F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjJYOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjJYOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:23:09 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A6A3;
        Wed, 25 Oct 2023 07:23:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5A8740E01B1;
        Wed, 25 Oct 2023 14:23:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pEKZKcsmeGeS; Wed, 25 Oct 2023 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698243784; bh=LwW8DqCiV3GFD9iEkJnIWOh8C/eNrtUPX3dlHtbPm+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIxx2lBoaqa6WX5jqPE1Aq/iCWkEv6LXOV14cXrKfkGIlnNUi5RLi7D3f9BNSC4V7
         SRYtySNARRwiKs8HuvQnpvn12YXVRT9O33LEZ1SR6gMSWKfpPP1n4A6rc6zQEn5JW4
         Ig3O2h7ayarehgRf0vuUI8LFon5W+IkbHbcIFXIWzG08mo7mOjCziW2upi75gPDt5P
         /mWEdFzgKRWXVUpHNLQT+1kqJwusgndDQmJAuZVzOx902E4r4JWu/ZWlbX8/vuBZg9
         C1cPv19EKUI+1mqIA+lVXDrCaBhhKcpAx6AlpiU2p/MeXxExNuBmkMGV2Gp6Cq1XQv
         3wyVguZNaamnWpI8gA0apu7NLH2camDUv9Wk3YVlMhEaPqz3YucBFx9+IMT8DZ/CU/
         D5oTJqcp+XDRo5PlII2jzJ6P2zldSjKNe7ZmSFxdcU5Ng6nvxLaJefupkPYeBLncaw
         rXtKo1+c+ThtUY7GUBFek36H408y0GW7/DE9OePbUnJtDZrcrXtMoagPwLJAxfrBID
         umSfTpV6Faj4L7vQYPPo0510GT078E6rcs4ptvd6bGntDCwjzq/PM5gnMb1xJe/Ytn
         KuPrf2GtUXFuuDX3vSu7gH+KxDa6zJMOmbRPlwr+xidjIP8yI+xg7dJ2cxMTrOPD3/
         JnuTG3L/2J5U4tuICqwxTkl8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBEF840E014B;
        Wed, 25 Oct 2023 14:22:50 +0000 (UTC)
Date:   Wed, 25 Oct 2023 16:22:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jeshua Smith <jeshuas@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Message-ID: <20231025142245.GHZTkktbRl1wjfNc15@fat_crate.local>
References: <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>
 <20231024152708.GFZTfiTL9C6onZKn99@fat_crate.local>
 <MN2PR12MB33738FA73A69BC6AEB64BD63DBDEA@MN2PR12MB3373.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB33738FA73A69BC6AEB64BD63DBDEA@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 25, 2023 at 02:09:37PM +0000, Jeshua Smith wrote:
<... snip a very detailed and good explanation... >

> Writing 128 nor-flash pages would then take 120us * 128 = 15ms
> typical, or 1800us * 128 = 230.4ms max.

This is perfectly suitable to be in the commit message - it explains in
exact detail why the change is needed.

> Actual use case:
>
> Kernel panic -> Pstore calls APEI's ERST code to write the ~32KB error
> log to persistent store -> ERST code writes the error log to
> nor-flash, which takes more than 1ms to complete. This is expected, as
> communicated by the platform to the OS via the maximum time field in
> the ERST table.

This is actually very important and it justifies the need for that
change even more - you want to flush out the complete panic message to
pstore and not only the first couple of lines.

> ... and therefore the extended (ERST-defined) timeout is only applied
> for implementations that indicate that they are "slow". I assume that
> platforms which bother to set the "slow" bit will also specify actual
> timings, and platforms which don't are OK with the current 1ms
> timeout.

Yap, makes perfect sense to me.

> Does that answer your questions?

Yes, thanks for taking the time to explain this in such a detail and
precisely. I think you should use the main bits of what you wrote here
and add them to the commit message - after this there are no more
questions why this patch is needed, IMO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
