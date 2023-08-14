Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9131477C173
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjHNUX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjHNUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:23:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57465E5B;
        Mon, 14 Aug 2023 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mKonTCdLfpftC39X0RxcU5vrM/gZaTRV3WAv3PeJxKU=; b=r1zGp4cyztm3cyDrkZa6P4lbcz
        J1A3caAUbRKvsDQD8zVQqAKyZxV/8CWackctoAFcEbLIcmQPAz9h6e/Ruy0Cb7JlYHZF9t7LR8nD7
        JdUm2mJLR2OAku/qYV/6t06HvdJFrpsJo8jibZbCv2VIMLL7kXGQW7kwwKYt6UwSPWTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVe5t-0045SL-6U; Mon, 14 Aug 2023 22:23:17 +0200
Date:   Mon, 14 Aug 2023 22:23:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michele Dalle Rive <dallerivemichele@gmail.com>,
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
Message-ID: <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081411-apache-tubeless-7bb3@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:25:49PM +0200, Greg KH wrote:
> On Mon, Aug 14, 2023 at 11:22:55AM +0200, Michele Dalle Rive wrote:
> > This patch series is intended to create Rust abstractions for Sockets
> > and other fundamental network entities. 
> > 
> > Specifically, it was added:
> > - Ip address and Socket address wrappers (for `in_addr`, `in6_addr`,
> >   `sockaddr_in`, `sockaddr_in6`, `sockaddr_storage`).
> > - Socket wrapper.
> > - Socket flags and options enums.
> > - TCP and UDP specific abstractions over the Rust Socket structure.
> > 
> > This series is a RFC because I would appreciate some feedback about:
> > - The structure of the module: is the division of the files and modules
> >   appropriate or should it be more or less fine-grained?
> >   Also, should the `net` module export all the structures of its
> >   submodules? I noticed that it is done in the standard library.
> > - Whether the documentation is comprehensive enough.
> > - A few other specific questions, written in the individual patches.
> > 
> > I would greatly appreciate any kind of feedback or opinion. 
> > I am pretty new to the patch/mailing list world, so please point out any
> > mistake I might make.
> 
> The best feedback is "who will use these new interfaces?"  Without that,
> it's really hard to review a patchset as it's difficult to see how the
> bindings will be used, right?

There is a long standing tradition in Linux, you don't get a new API
merged without a user.

There is not too much use of in kernel sockets. Network file systems
like NFS, and SMB are one. These need to be careful with memory usage,
you could be busy writing blocks out because the system is low on
memory and trying to free some up, and asking for more memory might
not work.  Sending kernel log messages to a server. But that needs
care because of the different contexts it can be used in. Without
knowing what it will be used for, it is hard for us the point the
special considerations which need to be made.

So please also let us see the code using this API.

	Andrew
