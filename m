Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD277FE67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354394AbjHQTPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354668AbjHQTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:15:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0B30F5;
        Thu, 17 Aug 2023 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wjawszGYwlc1+n1slj6SEY36aeLR7+yb2wb5c2CH3WE=; b=KCs8+hRICKYDwiHAC565/y4OkK
        dGV9Ny7cicErgMbHuw1wHhFdV1s87Y5wcXmNhk8lqH+EiI/0t2QOMv4RkL81uMKrqcD52jeyx9m0G
        LYSKpfn6PjNg5hL/1JjfpLgbvq20s/IIfQb78wKoUU15LMKDcluj3fQkHxg/8gyt4pmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWiS4-004Q97-Np; Thu, 17 Aug 2023 21:14:36 +0200
Date:   Thu, 17 Aug 2023 21:14:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Michele Dalle Rive <dallerivemichele@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <02d0771b-ba9b-4bed-afe5-9ece5100dadf@lunn.ch>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understood correctly from Zulip, you cannot (right now) show your
> use case because it is confidential and therefore you cannot upstream
> it

Is there a clear path for it to become public and mergable?

There is also a general trend that code developed behind closed doors
needs a complete re-write when made public and reviewed by mainline
developers. And that rewrite could involve the APIs to other
subsystems, like sockets. So any API you define now with a 'toy' in
kernel user, could in fact be totally useless by the time your real
target gets merged.

As Jon pointed out, we kernel maintainers need to help people coming
from a different background. Within the community it is well known
that internal APIs are unstable. Any developer can change any API, and
all its in kernel users if there is a need to do so. This makes
maintaining out of tree modules hard. There are a number of 'vendor
crap' drivers which do do this, with lots of ugly code to work around
differences between kernel versions. To some extent, that works
because the C APIs are not that volatile. My guess is, the Rust APIs
are going to be a lot more volatile for a number of years while
developers figure out what good APIs look like, and rework them again
and again, and again. Anybody trying to maintain an out of tree rust
module is going to be in a world of pain. In tree however, benefits
from the fast that any developer who wants to change an API needs to
also change all users...

       Andrew
