Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118427BB449
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjJFJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjJFJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:33:00 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F6DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:32:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 439A140E0177;
        Fri,  6 Oct 2023 09:32:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GGquypxA69mw; Fri,  6 Oct 2023 09:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696584772; bh=3UDS7cLVUNdY360dA5csdl+o8S66VLEskwbzM1Hym1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=es+WGVvlauGEc0R7kh4lMoLMDuF3Pr7d6qJosft6lwYEptqEZ+0nSthGxwGZKvLYZ
         la5bnArN8vaNLKh8/SbMaSsG8JYib/6WCR1w3fBe6tLbm62yz53fofAJc6dKwH8nU2
         WGMm6t3ebjLZvQL7GF+320nMsfkJyL4YtXe7ZhcFoEAvE2LapFOby2QiLr42rNcTB/
         SgCaoS6WtRswJ5VB24Q07TSQYd6GAQJrvDBWZoeUsWal/iOSu6zj2aqWuYT0KfCnvw
         j3Ihq/hJuXrk2d4zONUTsnzHJ9sEHWtUeKzFidi9FTD5epJWsAMSNucmGur834TWJu
         KAnXpKcpTYaSc0hzxu7I5fyM3GfpDW/t0wL8UaffubZ8MtU+F5fmyzm8i6F2TV2gus
         ANj20cz+xWRf7/FaqQ7qk7F0yh0gdhAVDywJMOE3I8un9tsmef+ww1KtTPPsqXCZm5
         AWYJhKwMfV2ETzVK9ls2M4ccCalGPMcclP7k84wCtfSfYB6QZX48+cJ6nqVpp7X0ZF
         1G+0JW2ZxVa3SN5NikQcXm73+KD79rbnh3wtxO8hr+/OLUKT8iQ7x5juFVuIN3i7t6
         v4DHk78vg5i36WlvDAgEfPNYBu5acD9OkQDyMgvJ9SoCO23Dg0DBkgM+eR9cM1Hn7q
         NCI88OXpZbjjAtzdtXqOgb00=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BE9640E0193;
        Fri,  6 Oct 2023 09:32:49 +0000 (UTC)
Date:   Fri, 6 Oct 2023 11:32:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
Message-ID: <20231006093244.GAZR/UPJidkn7GIGeL@fat_crate.local>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
 <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:21:13AM +0200, Ren=C3=A9 Rebe wrote:
> Thank you Borislav, were you able to reproduce this on Zen 4 you have
> access to?

I'm still working on it and I'll have something soon.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
