Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3710804168
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjLDWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:14:58 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA2FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:15:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2146540E025E;
        Mon,  4 Dec 2023 22:15:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 27-xfoZL0UxI; Mon,  4 Dec 2023 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701728100; bh=U8NuLJqSAzsrFzM8akP53EFrDTdJYEnJkE7Ri2t+fos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMhvRlYht6UF1qvW180ZyJAVlrs068SM27D2lSj8C22yqtaS2H90OF0hZ6Q2QcHed
         s9Rn2u4GI2aCrulCk308ObnQi9mbTOsYwuJaYJnYdMNuaYAoMhGmH/ePiaVNP7+VDB
         qnIOAIRI1O2u/IW96Cb23p1t0NNXXdGf2/09ZE7mrSiZnWBDj8p6bAOAA5bKO99dT2
         PZLuAnFn0c9W6pMIdeSM81tC0BXWZ1syp6BnRl5Bry4MC1+X4Uwx6EkusJLJFjPh/4
         riOW+I1xk1/qOY5LPghMmGJ8oLI9Lp0c1eJbJfIWe1u4MP3BlL8NcmG/bETLysVhuG
         3/aslSbEyZ+GnoUEgLBcBSVUBGLqpccm2B/HrNDSeOS9Ff56UvtekW5/kmXXJGSTRL
         cdFjkwteywMgBqofQFP1IerYL3RePy/MS80+TDayxhVX9NgoiqO67dhXphfd+ZicFw
         msm6vRqEoiVe43wxTXBZ+TlWBC/G0MUBVw5vqyyhVWr+1gE1e+gOIUa9b3tVlE78XD
         tdq5E2W6FXCpC9T0w6JcVKHM1IYIr5bLE14Z3IrY2vEmtslNIpYunA3ZkndLtM9tPN
         UsCO4iB9KCZnYhmJG/JGBrU/I7kb9dc0qZXFcODC+bc1ByVowIrXQlN38goTx5HFv8
         OW6F0cXrK2G8WkMewiZ92Lkc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 481E940E01AD;
        Mon,  4 Dec 2023 22:14:56 +0000 (UTC)
Date:   Mon, 4 Dec 2023 23:14:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     X86 ML <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Do the C-bit verification only on the BSP
Message-ID: <20231204221455.GFZW5PX/goIKpeYlwT@fat_crate.local>
References: <20231130132601.10317-1-bp@alien8.de>
 <1726d92e-2574-40dc-8991-eed0184f957e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1726d92e-2574-40dc-8991-eed0184f957e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:06:42AM -0600, Tom Lendacky wrote:
> You're ignoring RAX now on return, so you can probably just make
> sev_verify_cbit() a void function now. You would still need to save RAX
> because of the calling convention, though, so it doesn't make this code any
> cleaner (other than the comment could then just say restore CR3 value).
> You're call, I'm good either way.

I'm thinking I should leave that change for the patch which converts
sev_verify_cbit() to C...

Thx for looking.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
