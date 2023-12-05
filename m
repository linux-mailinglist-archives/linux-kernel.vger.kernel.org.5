Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEA804DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjLEJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjLEJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:32:00 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE349B;
        Tue,  5 Dec 2023 01:32:06 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4169FC022; Tue,  5 Dec 2023 10:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701768725; bh=Bcs2wqbN9pFVw67N2sNg9eeh6V11qjKxUE3FaK/pUSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFTMUKXrihhDPAXEq6ldua3G1TG6BFCYfSdnMZVvsrIkdaiL5tRpFWgWUiHwXQSja
         lP3w87pKZyI+0ctVEoF51b8dm3zwwA+5fD8femtJakh9CThlmdMYGtNepsDc5ys2fV
         poR8aiWuxQu/DffkdVEbYPwBCMNq0EPJ3T9QOF6WSvrIaT9z4+/gn0x7Sl2ngtzmHy
         1aenxesO023aylpNmoGXrs7cA1n7MKujJJfjzW5zlioIEuxKVsF2NNyypE2T+sm9pW
         SmLbAVEDeRQIsf11jpLmElPeFHS8Flas3P0oub32MoIDGUYmOPfBhRzeUqc3nUaAFc
         dA3/YWg7cN+HQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7F8ECC009;
        Tue,  5 Dec 2023 10:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701768724; bh=Bcs2wqbN9pFVw67N2sNg9eeh6V11qjKxUE3FaK/pUSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aW6B6SpX7GCIFOKh1snzGGYDqWdOHLrB2fzRC5ZxtYbsQMtDsIpyZK8HIgMuCV+gj
         Bcn00mMZ+oGZNIpxt2G72E5g2rVJb84YmptEXh05b2Vio1Q48groPrD1wSAwS4mwig
         OQkEtroJPLaPmBRJMp3iNqdS5qZBXWe8GTfhNWYCXU+OBlGIZHBgMCWIHIsRuFvbuy
         qbrHrm9WkIrOaUcrKKLN23N47vaXfmRpokGhD1P5pREqAJWiGKSftubt96DIkFXaJR
         ZJe3EiVPELTs3epJmoDYarjYKUpfMEANLfR/0O3clADUtEWrYCQ46CgJt+ZFDCWlbd
         rhZ/Qvucjdv5w==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 8d6a1af9;
        Tue, 5 Dec 2023 09:31:57 +0000 (UTC)
Date:   Tue, 5 Dec 2023 18:31:42 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZW7t_rq_a2ag5eoU@codewreck.org>
References: <ZW7oQ1KPWTbiGSzL@codewreck.org>
 <20231205091952.24754-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205091952.24754-1-pchelkin@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Pchelkin wrote on Tue, Dec 05, 2023 at 12:19:50PM +0300:
> If an error occurs while processing an array of strings in p9pdu_vreadf
> then uninitialized members of *wnames array are freed.
> 
> Fix this by iterating over only lower indices of the array. Also handle
> possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> fails.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: I've missed that *wnames can also be left uninitialized. Please
> ignore the patch v1.

While I agree it's good to initialize it in general, how is that a
problem here? Do we have users that'd ignore the return code and try to
use *wnames?
(The first initialization is required in case the first p9pdu_readf
fails and *wnames had a non-null initial value, but the second is
unrelated)

I don't mind the change even if there isn't but let's add a word in the
commit message.

> As an answer to Dominique's comment: my organization marks this
> statement in all commits.

Fair enough, I think you'd get more internet points with a 'Reported-by'
but I see plenty of such messages in old commits and this isn't
something I want to argue about -- ok.

-- 
Dominique Martinet | Asmadeus
