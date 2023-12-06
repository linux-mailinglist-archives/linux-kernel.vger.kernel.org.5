Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D32807A44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442942AbjLFVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442930AbjLFVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:21:55 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1DD5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:22:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3F5A740E00C5;
        Wed,  6 Dec 2023 21:21:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3UUOiSt2RwgL; Wed,  6 Dec 2023 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701897717; bh=GCZsoylEfcEdwCDgWMGB98cf6QKJY7fub7FE4C2RG/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/AoVz+GqAZwdRu/cmElvK6ULSbWUCxNGSLZDDOSjGO4T+BzPVvrD8Vtc56uIfa8A
         Y12C6vE7hfnuIkAje1JNt081OFegiMu7hP2omrCUgErkKI9lxF446ghZ+wp2a+XW1t
         fOaVmWi/57fR2fXU3xw/BCSVSudCNBAyqowuTM9j81A9dPdLZCg9jn280R/1hVoqPR
         oiTHYu86MU1imJCs1kSNAAIZG4RsZEsNDgg1hSFOLHdihBRGIxvzCdkTEcte2POPqP
         dvVctFNaF1ZFJUEv5IIU7gNqF7W/yvFundPIxpqbKAJ4ORGYKG/up0GXWCoKPOAkX7
         rpkmic/K5PF7R9N6l5hzPkVfFbwIUh+2JSjLuomFZW2GyDzcwNhuhehT4jGErchQlG
         o/1KAfJsKzjgcMhJ+18PHehiBZZjarmSTo3LDe86TG3fzY+6d4lz7NG3ZbSXmZA/Ku
         0+iKtNxM21l/CcuLNToRHPk+k+7+iGRErClOSOoycWWgyQBjCCVeyt5W11IQm3pD/T
         vnD9Nn4ph1AKrVnpAarUXNA75BKNdAmefQNr/lgv9spBY3DcaQ2albVijEt2ek2MaO
         jyI6gQPdd0l06AbAWmKUoKi7JXNAS4r4e6BSD6GpD3OoaPh364+mUnkaQIMuEWYbMd
         pRSTisjE62nq/YtDvsNG2Acs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A47740E00A9;
        Wed,  6 Dec 2023 21:21:50 +0000 (UTC)
Date:   Wed, 6 Dec 2023 22:21:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Be more verbose, especially about loading
 errors
Message-ID: <20231206212145.GGZXDl6f/ho5olxNvq@fat_crate.local>
References: <20231206172844.1756871-1-jannh@google.com>
 <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
 <CAG48ez3weAU-Uti0QyBSDNRv8xYqCJ5UbgJvssEWAWpvyon0DA@mail.gmail.com>
 <20231206203158.GEZXDaPslvxtOS/gze@fat_crate.local>
 <CAG48ez3FwbqaU+hP6cAZEGWdHDJdEMuDyqW7SiYrDFf+rOt=bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3FwbqaU+hP6cAZEGWdHDJdEMuDyqW7SiYrDFf+rOt=bA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:51:58PM +0100, Jann Horn wrote:
> Ah, right. I guess that's decent for diagnostics, though I think it
> would be nice to have a more explicit message about not finding a
> microcode update, since otherwise you'd have to read the kernel
> sources to figure out that you have to check for a missing second
> line.

I keep preaching scripting something around:

$ grep microcode /proc/cpuinfo | sort | uniq -c
     16 microcode       : 0x800820d

We also have:

$ grep -r . /sys/devices/system/cpu/vulnerabilities/
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Retpolines, IBPB: conditional, STIBP: disabled, RSB filling, PBRSB-eIBRS: Not affected
...

You could make sure that this says "no microcode" in the microcode
missing case or so and then grep that on large fleets, massage results
and dig into dmesg only on those which fail. Hopefully a small number.

> Yeah, fair, I guess that's a fairly visible indicator that something's
> wrong with microcode. (Though it doesn't tell you whether your
> microcode is just outdated or you have no microcode for the CPU
> family.)

So what you could do on AMD (probably similar on Intel too) is to fetch

git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

scan the microcode blobs in amd-ucode/

==========================================================
|  inst_cpu  |   err_msk  |   err_cmp  | eq_cpu |   res  |
==========================================================
| 0x00800f82 | 0x00000000 | 0x00000000 | 0x8082 | 0x0000 |
| 0x00830f10 | 0x00000000 | 0x00000000 | 0x8310 | 0x0000 |
| 0x008a0f00 | 0x00000000 | 0x00000000 | 0x8a00 | 0x0000 |
| 0x00800f12 | 0x00000000 | 0x00000000 | 0x8012 | 0x0000 |
| 0x00000000 | 0x00000000 | 0x00000000 | 0x0000 | 0x0000 |
----------------------------------------------------------
   ID: 0x0800820d, CPU rev ID: 0x00008082
   ID: 0x0830107b, CPU rev ID: 0x00008310
   ID: 0x08a00008, CPU rev ID: 0x00008a00
   ID: 0x0800126e, CPU rev ID: 0x00008012


ID are the latest released patch revisions. You then compare them to the
revision on the respective machine using that CPU rev ID which can be
computed from CPUID(1).EAX (inst_cpu) using the table above. Table is
also in the blob.

In the example above my workstation has microcode revision 0x800820d and
CPUID(1).EAX on it is 0x00800f82.

So all up to date. :-)

See, easy peasy. :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
