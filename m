Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1566B77A593
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjHMIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjHMIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:24:25 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23081712
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 01:24:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A34F40E0196;
        Sun, 13 Aug 2023 08:24:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id atE8nOIJa23x; Sun, 13 Aug 2023 08:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691915062; bh=G3ibQwU37RFcsYxcrChlV1/YJThVqCmpLaOJU4zCpg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmn78NjpPNcfc0Rmcp/sHlT8GByDZtJpAEk3v2iyPo9aEvL+ZVKZfj5ipMGovWci7
         hZa+xLB+2k7bzXEdI/n5vPqqzia2B9LnMLVz0YQRPGujk2nEp8zrcKUg8Il/b3c6Z4
         sTcu2T9UAnoVBwDoFgZKrjc5vOl8ntoND69V1NL9vUr6Ukz98PT27jHyObxeFrfDBz
         33xKreoVIEWkJaGPTxjS9MYW7ARAPAgUvrggrAx3xwGlyvw2nnd8HEwx2DyFgYkYdd
         VutDuBnNYqpdN7Y7D8GAUbbO23iU2jzEeRugErkhU9Qqf29QHmt1bkHeSysJNlT9RF
         pC9zcffsrTE1O3vToXkiRzzqyhw8fwstlJU5lfU6jyLzJX0XA3z3AQaPjjg5ku9z0Z
         whjk79bSNr48etaa/1hsyrpCAPGzYL0iM+nGat27S1aW/s+RgTRjrg8nO7741NPdfv
         z6fR2YfiIStuzGRBCIRoUSRJltUaAhVZmeWKfXGDTC15hcNj1PBxNRWWqLlHHeZQF1
         fsKWCZJe0t5FmODlI+pTbigvlf5ScHJEkYW3WdPNZ1kjZfMU07gndGJsozdkx0P+Dd
         6nFwZfZ3LtoqQxOs3kC62fJAuDLHL7OoFTJyj1qaw7x8drU9XDmSwym5aQBclXDGYc
         bJ3vKMUZ9gZtDm8/XmOQT6jo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5C4140E0185;
        Sun, 13 Aug 2023 08:24:19 +0000 (UTC)
Date:   Sun, 13 Aug 2023 10:24:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
Message-ID: <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local>
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 03:55:11AM +0500, Mikhail Gavrilov wrote:
> Hi,
> I use Fedora Rawhide and noted that between commits 14f9643dc90a and
> 13b937206866 the gaming performance of my computer decreased in two
> times.
> I start bisecting and bisect blame this commit
> 138bcddb86d8a4f842e4ed6f0585abc9b1a764ff.

What do you have on your kernel command line?

What does

grep -r . /sys/devices/system/cpu/vulnerabilities/

say?

Please send a full dmesg, privately is fine too.

If the bisection points to this patch, then it sounds like you have IBPB
enabled as SRSO mitigation which is the heaviest one.

The default one - safe RET - should be a lot better.

> Maybe it is possible to find another approach for solving security
> issue without slowing down?

Yeah, magic. :-)

> If not, then provide an option to turn off this slowdown.

spec_rstack_overflow=off

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
