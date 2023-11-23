Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE57F641B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbjKWQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:40:07 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D5DD;
        Thu, 23 Nov 2023 08:40:13 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7597940E0257;
        Thu, 23 Nov 2023 16:40:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LqBXCnrJpKOI; Thu, 23 Nov 2023 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700757609; bh=ReRjYVadwY+865FlobuR5wcJUj8JlrwxeGT4ZGKVa4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTWcnNotIVPtq2mv+TMP/V+jjYXbjl9KNh1eXXcKPvj+AclKGajEsdAD37WinvTie
         B0RIOFDEKve2w3koO+uhEK7hJJRujm6ONP4rGPoDDvRJ08dvprms/4lVMZCyavGT7J
         42p7ll8/08DjIXMCH4ErVeUtFyK3eVwRz/USTNNONPQtfHsoVwNRAPzxD35GoQyxWw
         cJwmxkE1Vzatb0cN4FJKrP7WxIiWScfrQ2sOKV6UH4eGeSVurDO9TeHb8QlVjiUqNn
         Z7EbHlc2j/QiZtgFrxMuhghyVAz89nkoIngRvnUueI+PLcnbu8TrW0tU9UhRiHiKo3
         pvnBtoVWtdCUWUKKxmIHGsN1LCr8v4ClE2DuCa7qM4c8r/hWpNY1d+Lt5cbTyA3L3a
         hOBy2XHa9yGVRqlKF6y1COUOLXmH+CIA/90AnF1ghhe6E8U1YZ4aVr7zUL+R+FW9Le
         AQxk6OE5iOoV5ieooR7fjYckJDMGSTYD7BeWTxg8PBLzFP8XqCAI+UYf608c49Jv5M
         oAm0oJvIb0IomgDV5JzTmBaRkqKt33+KDI3G37aEzhyqq8Bx76JiZ1kMBzkIH8Jmfd
         oZCtiIYY2fu48j0Hu6b2DBob6bGGHlQnhQX36QQE7F5nmeH8mmZxTJw7GmeO0dOHX7
         wdCVbz9PKE2MCMPczI/m5twI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A89740E014B;
        Thu, 23 Nov 2023 16:39:56 +0000 (UTC)
Date:   Thu, 23 Nov 2023 17:39:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Message-ID: <20231123163951.GFZV+AV8pNL6pUwxNH@fat_crate.local>
References: <20231122222007.3199885-1-arnd@kernel.org>
 <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
 <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>
 <20231123143019.GDZV9h+zIVj5pBQySh@fat_crate.local>
 <ece872de-46fa-4138-959d-28e76e6b5edb@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ece872de-46fa-4138-959d-28e76e6b5edb@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 08:41:33AM -0600, Gustavo A. R. Silva wrote:
> To avoid that, I would just say (in the changelog text) that this patch
> is fixing some -Wstringop-overflow warnings, without specifying any
> commit ID.

Doh, obviously.

I hope Arnd is reading this. :-)

Thx, lemme do that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
