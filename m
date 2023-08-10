Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E67776F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjHJFI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCF196
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE60632CA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626F3C433C7;
        Thu, 10 Aug 2023 05:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691644135;
        bh=ltls7Xy4ElJg5NFV7SuJ3Wpgo3N85rLluLSWpMQltU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehZ1bnIWQJcTIoq8oGlqWmFYToNHrYUYZmhryU4gBToY57nJtzGyGoA2fNFIaGcD5
         oeyibd47GuNXCHy+wYpppc8bX0OWjxFAbebx1+wTblgAruc+JusNzpo2BvvbeKjbpJ
         /QrD9EM4lg+vQMZh/ETZUk+g0M7+Z09uReh93BTw=
Date:   Thu, 10 Aug 2023 07:08:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
Message-ID: <2023081043-cake-catwalk-1ba8@gregkh>
References: <20230628171108.1150742-1-gary@garyguo.net>
 <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
 <20230809230249.01ffc009.gary@garyguo.net>
 <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:29:06AM +0200, Miguel Ojeda wrote:
> > All my kernel contributions are permissively licensed if possible, so I
> > am fine with this being either MIT or GPL-2.0 (I think GPL-2.0 is
> > deprecated in as a SPDX license identifier and it should be
> > GPL-2.0-only going forward, though).
> 
> Yeah, the 3.0 version of the SPDX license list deprecated `GPL-2.0`,
> but the kernel still allows `GPL-2.0` and lists it first. I recall
> thinking about this before the initial merge, and I think I went with
> the original form because the main `COPYING` file still uses that.
> After that I am just keeping it consistent, though I am not sure when
> the kernel will migrate.

The kernel will migrate when we have converted all files in the tree to
SPDX and can worry about things like the SPDX version level.  We have a
ways to go still...

> > Given this is non-kernel specific generic code, I think it might worth
> > following the convention of the paste and pin-init code and make it
> > `Apache-2.0 OR MIT`? This would also make it the same license as the
> > `paste` crate (although we don't have to keep the same license as this
> > is a different implementation).
> >
> > I'll leave the final decision to you.
> 
> Since you prefer it and it makes sense that someone may want to use it
> (`concat` and `expand`) elsewhere, let's go with that. I will add:
> 
>     // SPDX-License-Identifier: Apache-2.0 OR MIT

Be VERY careful with dual licenses please, and especially non-GPL ones
in the kernel tree.  It gets tricky very very quickly and you need to
know what you are doing.  So much so that I really want to see a lawyer
sign off on such a thing so that everyone involved understands the
issues that this requires.

Otherwise please, just default to GPL-2.0 for kernel code, unless you
have real reasons why it can't be that way, as remember, the overall
license of the codebase is that.

thanks,

greg k-h
