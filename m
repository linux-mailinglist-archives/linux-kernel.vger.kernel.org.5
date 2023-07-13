Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624E9751D00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjGMJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjGMJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:17:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EF1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h06qPR0arlbUfd9D1oOiKIFmgreKcx0kfXCJd2RsPps=; b=PRbX94DiNwyui0gBuvyKQXV+uf
        3scrOndug2Z/LVkQmBOqtgV5xFQ6c/+bdc6LfkzPT31yrF8vHdM29dA5FFi9/HVc2IpVuHVjqIVTv
        b1ck/z4mht9owjFosLGlru0jYfkkKhvKVP2eHKcpeel4oos2pSApg7TbojL5N4g+OpOqQIun+Dlh9
        6g1fUfnUILN7B1PUiKtvhon6VM/g/bkNE7YSRaGr15jOv47RTsOKlHdRY7sNr5Btvc8P/AxhdG07j
        SqwVnLk4EJxXaJtHmECAaogjGUTMLfxp8VuDw419TICf4JLhPMpPLdL1Bm8AG/XrvTdFgKBKNOkC9
        M+Fnl5Hw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJsRD-004aaI-0N;
        Thu, 13 Jul 2023 09:16:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 688C930007E;
        Thu, 13 Jul 2023 11:16:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CF5A245CA117; Thu, 13 Jul 2023 11:16:37 +0200 (CEST)
Date:   Thu, 13 Jul 2023 11:16:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        bluca@debian.org, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230713091637.GE3138667@hirez.programming.kicks-ass.net>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
 <875y6o429i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y6o429i.fsf@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:57:45AM +0200, Vitaly Kuznetsov wrote:

> this was an RFC to answer a fairly straitforward question: is upstream
> Linux interested in / is a suitable place for having SBAT revocation
> mechanism or not.

If only it would have actually had that question in :/ But then we
would've still had the whole WTF is a SBAT(SHIT) and why should we care
discussion.

Fundamentally, I don't think upstream can care; upstream doesn't have a
signing key, it will never be revoked, bumping the upstream number
doesn't make sense -- ever.

> We can, of course, iron out the details whether it
> should be "linux.org"/"linux.com"/"lore.kernel.org/lkml/" or
> "linux.onion" and where to put objcopy call, whether to silence its

Seriously ?!? kernel.org is the only sane option here, none of the
others make any damn sense.

> output or not but these are rather implemntation details. I don't
> particularly see why anyone would need to get additional sign-offs to
> just ask a question (which I don actually think was asked before!) and
> IMO an RFC/patch is usually the best way to do so.

But there wasn't no question, was there. There isn't a single '?' in
that thing. And it starts of with random implementation detail blabber.

> Following the discussion, it seems that at least x86 maintainer[s] are
> opposed to the very idea of having SBAT revocation mechanism integrated
> upstream because it's hard to meaningfully define what epoch is. This is
> OK (which doesn't mean we all agree to that) but as there's real need to
> revoke "bad" (in UEFI SecureBoot sense) kernels, distros will likely
> come up with their custom, downstream only ways to do it. Without an
> upstream reference, however, they may come up with very differently
> looking SBAT sections, this may or may not be problematic in the future,
> who knows.

Well, if the various stake-holders can't even agree on things, things
are very bleak indeed.

I just don't see why upstream would want/need to carry any of this
because it has no meaning to us, we don't play in the secure boot pen,
not haz key etc.. (for good reasons IIUC).


