Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD97BF5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442900AbjJJI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442875AbjJJI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:27:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B11ED;
        Tue, 10 Oct 2023 01:27:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272FFC433C9;
        Tue, 10 Oct 2023 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696926432;
        bh=IsEPIRqztj/gpHEaupHz40fvwhnyENE4HA0MBVHyF6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlsVzCFGq7uR0uj6Kew58xuH6g26clrrWJwJB6t9itWIufmYLQ3avQd8H3In3eN+6
         pSq0L8cRtw+u37RyNZGOAM/zd7YW3RIzYgd8N6w0Cj9dAYnQpPUXW449yzYO0JXTd9
         Cv9FVLnsMoDdIahr2iXnaDfLGzictWZdZtpV0aRE=
Date:   Tue, 10 Oct 2023 10:27:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
Message-ID: <2023101001-ocelot-veteran-10db@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
 <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:08:43AM +0200, Alexander Graf wrote:
> 
> On 10.10.23 10:03, Greg Kroah-Hartman wrote:
> > 
> > On Tue, Oct 10, 2023 at 09:55:25AM +0200, Alexander Graf wrote:
> > > Hey Greg,
> > > 
> > > On 10.10.23 08:13, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 09, 2023 at 09:20:52PM +0000, Alexander Graf wrote:
> > > > > To fully support the Nitro Secure Module communication protocol, we need
> > > > > to encode and decode CBOR binary data. Import an MIT licensed library
> > > > > from https://github.com/libmcu/cbor (commit f3d1696f886) so that we can
> > > > > easily consume CBOR data.
> > > > What is "CBOR"?  I don't see a description of it here.
> > > 
> > > CBOR is the "Concise Binary Object Representation"
> > > (https://en.wikipedia.org/wiki/CBOR) binary format.
> > > 
> > > 
> > > > And I guess you are going to keep this in sync with upstream?  Or do you
> > > > really need the full library here (you #ifdef the float stuff out), does
> > > > your module really need all of the functionality and complexity of this
> > > > library, or can it use just a much smaller one instead?
> > > 
> > > CBOR knows a total of 9 data types:
> > > 
> > >    - Unsigned integers
> > >    - Signed integers
> > >    - Binary string
> > >    - UTF-8 string
> > >    - Arrays
> > >    - Maps (like a python dictionary)
> > >    - Semantic tag
> > >    - Bools
> > >    - Floats
> > > 
> > > Out of these, the NSM communication protocol uses all except Semantic tags
> > > and Floats. The CBOR library that this patch imports does not have special
> > > handling for Semantic tags, which leaves only floats which are already
> > > #ifdef'ed out. That means there is not much to trim.
> > > 
> > > What you see here is what's needed to parse CBOR in kernel - if that's what
> > > we want to do. I'm happy to rip it out again and make it a pure user space
> > > problem to do CBOR :).
> > Yes, why are we parsing this in the kernel?  What could go wrong with
> > adding yet-another-parser in privileged context?  :)
> > 
> > Why does this have to be in the kernel, the data sent/recieved is over
> > virtio, so why does the kernel have to parse it?  I couldn't figure that
> > out from the driver, yet the driver seems to have a lot of hard-coded
> > parsing logic in it to assume specific message formats?
> 
> 
> The parsing doesn't have to be in kernel and it probably shouldn't be
> either. V3 of the patch was punting all the parsing to user space, at which
> point you and Arnd said I should give it a try to do the protocol parsing in
> kernel space instead. That's why the parser is here.

Arnd said that, not me :)

> If we conclude that all this in-kernel parsing is not worth it, I'm very
> happy to just go back to the the v3 ioctl interface and post v5 with hwrng
> merged into misc, but remove all CBOR logic again :)

I think the less parsers we have in the kernel, the safer we are for
obvious reasons.  Unless you have a parser for this in rust?  :)

I don't really know, having a generic interface is good, but at the
expense of this api is probably not good.  individual ioctls might be
better if there are not going to be any other drivers for this type of
thing?

it's a tough call, let's see what a unified driver, no parser, looks
like, that should be pretty simple and small so maybe stick with that?

thanks,

greg k-h
