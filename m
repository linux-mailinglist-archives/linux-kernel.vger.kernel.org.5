Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DA7FA90A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjK0Sjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0Sju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:39:50 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9EC198;
        Mon, 27 Nov 2023 10:39:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5F9DD40E01A5;
        Mon, 27 Nov 2023 18:39:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oFSSdf7Hu-bc; Mon, 27 Nov 2023 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701110391; bh=0q2n0tc3kXV9vWzdDmVxky0SQ9EQ+gjJnqD2au8hEUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhyIroyyhiKWoClkCs8L/YRrESKzuGAQyU3KcodlxHkIShp5hhJQstiazv8MG/Dv1
         xzseEtSkVD/1+3pY7PIx7NlvxyfHJBhKGQsl6Su7TaDiPHDyFCN4aD/LCl5I/lloZO
         FqE4UI/Gkv1NLb2iTvqMUkDc02wfSSScdoA/idLd2uek9qRw/Hw4IRCnnpazyid+eI
         T95YxoWb3+zNoWjKLfg9mXCo8rS5gdU7Tf62pLAr2B4xAcIxCytQHAHCFXScLXvwKw
         QrwWDnUZhUve42Ux68KrWeMctZD5I1gFML1y+SR5K7ILm4XLbalMZ3kf1F/VBK8uB5
         cRp5iPO0YgwKMoARtxDpNGpvUw0+T+muhvrLw/87XlsrFRau9bU7oxGP2cTom3mGW3
         OmKfM+gN1L2inoHtjJlEpVUXue827X/krkmlPE5zzAzfOixP0ao9bLPZpMLO7nra7e
         Y2Eke7/nBAf9nsVXZuA/9mH0slPzkpCSLUodKY17kTvkzxZQMPkxUrKJlFqYh2vzUj
         ZGR+Ex/M2kYD+rFlZL5z2Y95ZoOApvxJAFJNybHDiQHnLCjyMhKBqlBDxxZIghNsQZ
         6Yd9lHag+28dLKmxbfkR93swNpSNOf2LjJ4/gS3mPz0yhdXtybeCIiurApK45nanbl
         7AoqCgUSlRCyCbZ7G1rlaWIs=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E68A40E014B;
        Mon, 27 Nov 2023 18:39:42 +0000 (UTC)
Date:   Mon, 27 Nov 2023 19:39:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Message-ID: <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:53:02PM +0530, Abhinav Singh wrote:
> Hello, thanks for reviewing this. As of now this is only a warning issue in
> kernel. I saw this post by linus
> https://www.spinics.net/lists/linux-sparse/msg10066.html and thought of
> submitting a patch. Also a similar patch of mine got accepted
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2560740.html,
> so thought about opening this one as well.

Lemme try to understand what you're saying: just because someone
accepted a patch of yours, then others should not ask you to improve
your commit message so that it explains *why* a change should be done.

How about you put the gist of what Linus is saying in your commit
message? Don't you think it would be a much better commit message then?

Especially if it explains why, even if it is the case that 0 == NULL, we
don't want those in the kernel.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
