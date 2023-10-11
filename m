Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA07C5A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjJKRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjJKRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:46:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297BB0;
        Wed, 11 Oct 2023 10:46:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E20AC433C7;
        Wed, 11 Oct 2023 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697046396;
        bh=/307fLip+mEBKfJijXaHEHz5w4xTiJRdHKRxGg5HNUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFTcfO13XmNGsmpaWpyxKul+lYgI9+Xk+PoDKht/5kqCTCWV51Rve3aYf9VHeHSw5
         nx+/CVKUljzH/IkDR4NBoUqP2dJFH3swqIgfrBttjdBs32TF167hUPplXB2qoZba9C
         cJG+cSgACCNwZTOoKmuqlaMc+5qnj8iN1Ie55dKM=
Date:   Wed, 11 Oct 2023 19:46:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
Message-ID: <2023101156-helper-waving-09df@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
 <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
 <2023101001-ocelot-veteran-10db@gregkh>
 <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:24:48PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 10, 2023, at 10:27, Greg Kroah-Hartman wrote:
> > On Tue, Oct 10, 2023 at 10:08:43AM +0200, Alexander Graf wrote:
> >> On 10.10.23 10:03, Greg Kroah-Hartman wrote:
> >>
> >> > > Out of these, the NSM communication protocol uses all except Semantic tags
> >> > > and Floats. The CBOR library that this patch imports does not have special
> >> > > handling for Semantic tags, which leaves only floats which are already
> >> > > #ifdef'ed out. That means there is not much to trim.
> >> > > 
> >> > > What you see here is what's needed to parse CBOR in kernel - if that's what
> >> > > we want to do. I'm happy to rip it out again and make it a pure user space
> >> > > problem to do CBOR :).
> >> > Yes, why are we parsing this in the kernel?  What could go wrong with
> >> > adding yet-another-parser in privileged context?  :)
> >> > 
> >> > Why does this have to be in the kernel, the data sent/recieved is over
> >> > virtio, so why does the kernel have to parse it?  I couldn't figure that
> >> > out from the driver, yet the driver seems to have a lot of hard-coded
> >> > parsing logic in it to assume specific message formats?
> >> 
> >> 
> >> The parsing doesn't have to be in kernel and it probably shouldn't be
> >> either. V3 of the patch was punting all the parsing to user space, at which
> >> point you and Arnd said I should give it a try to do the protocol parsing in
> >> kernel space instead. That's why the parser is here.
> >
> > Arnd said that, not me :)
> >
> >> If we conclude that all this in-kernel parsing is not worth it, I'm very
> >> happy to just go back to the the v3 ioctl interface and post v5 with hwrng
> >> merged into misc, but remove all CBOR logic again :)
> >
> > I think the less parsers we have in the kernel, the safer we are for
> > obvious reasons.  Unless you have a parser for this in rust?  :)
> >
> > I don't really know, having a generic interface is good, but at the
> > expense of this api is probably not good.  individual ioctls might be
> > better if there are not going to be any other drivers for this type of
> > thing?
> 
> I was definitely expecting something simpler than what was possible
> in the v4 patch. I had another look now, and it's clear that the
> ioctl interface is still not great because the variable data structures
> shine through for some of the calls, and even to get to this point,
> a whole lot of complexity is required underneath.
> 
> To get anything better, one would probably have to redesign the entire
> interface stack (hypervisor, kernel and userland) to use regular
> fixed data structures, and this seems unlikely to happen.

Why not fix this and do it properly?  What's preventing that from
happening?  We don't want to create an interface here that is broken, or
insecure, or a pain to maintain, right?

thanks,

greg k-h
