Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87A580133D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379312AbjLAS7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:59:34 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC4D63
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:59:40 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE78740E024E;
        Fri,  1 Dec 2023 18:59:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h5zhT2Plc5PS; Fri,  1 Dec 2023 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701457176; bh=Sa0cafuz+AWafdjLOmnmmmM3WuhPAqWmC9ercK9Ypo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTbCjKJrsKFxTa7it2RAdQhuqcSkXxvnFd2VFDysyr5QALEwl8MCfW4E698PBLXYY
         a651qHR134/6KofnPX9UMI4udZdSSpK4RMLyded36M0EwMhRNeIb2Af1gSn0ne4tyL
         o6LEwe67RUFM0X3lkSRpHAJT8RtU7ZBKgqR/mzO2DWwdfjfDywTvx56ubLs84lIvGL
         gBInBFlXk5hXh1aLoeFGiasKhVpwKdpoCJmwn8EP/gcLBb+IRlaJwYa+8IR0oio1vK
         FDworEM5W6GCcHuGNmmt5CZyfHdAN6+HGk3IHCOuPN8enl8vNAeFq4OL9kGtBz/VV2
         eVClFb8cXbw2/GhdkJVIPyRPpNqEM9QhGxHiW0waHuY4ZFWbdr0/RgddEcmEYw9ME5
         IN3CK8BafWAL8FlHVWOPqs5O6W1Xcwy0AYcpxxGBaS6Scg5trDojZyJSBQIsyoawV3
         d16KNMuwXGEA/rnE6V9en5fyxPiixu6/DYF4OZ1hTgNEn4M0uqTPsgVxEF+BbwwJFz
         NtaPJuTNC+H+kXy7MP/pSuMP3BY9n1W7sviCkppR+X8CRRoWnteChBiVcrYTaV/8RI
         pHfMf35YP4i/4zFUnvC9n8oMA/kc474wigM9GC65Tv4+Nc3l/ptdq8MoCV3VCcvGxZ
         LGGpj2VWp3R/pfVvxIBsLCyA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2512D40E0030;
        Fri,  1 Dec 2023 18:59:27 +0000 (UTC)
Date:   Fri, 1 Dec 2023 19:59:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vkeg.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of
 boot_cpu_data
Message-ID: <20231201185922.GEZWotChARf77oe3iL@fat_crate.local>
References: <20231201112327.42319-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201112327.42319-1-sironi@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:23:27AM +0000, Filippo Sironi wrote:
> Unfortunately, boot_cpu_data isn't updated on late microcode loading,

Looks good to me here:

[   50.881231] microcode: Unsafe microcode update: Microcode header does not specify a required min version
[   50.892577] microcode: Late microcode loading without minimal revision check.
[   50.900099] microcode: You should switch to early loading, if possible.
[   50.958919] microcode: load: updated on 6 primary CPUs with 0 siblings
[   50.965856] microcode: revision: 0xbe -> 0xf0

That comes from:

	pr_info("revision: 0x%x -> 0x%x\n", old_rev, boot_cpu_data.microcode);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
