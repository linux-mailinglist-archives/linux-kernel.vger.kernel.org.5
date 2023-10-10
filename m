Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A97BF539
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442527AbjJJIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442525AbjJJID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:03:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3E97;
        Tue, 10 Oct 2023 01:03:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F3C433C8;
        Tue, 10 Oct 2023 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696925007;
        bh=TMDEK/WmDL+z/eBbCTgn+47DOA7g0CKzr8YciDEyuNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDHBkFuY1RbOqWqykAYVdGAfDW7e2ynU/l5+/Dpek8x+rxpdWDlBwtBqgxPpz5rAG
         XZRTlkBHJ42xELJ9f8G8SoUagNX//yQNxnB8A5PIGC+VAK2WDbb34NJac1k6LmbtmB
         kt1gV7e1GDLEkzcXMzSDImSt1f6bzawFlzpkcebw=
Date:   Tue, 10 Oct 2023 10:03:24 +0200
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
Message-ID: <2023101009-accustom-manifesto-8bdb@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:55:25AM +0200, Alexander Graf wrote:
> Hey Greg,
> 
> On 10.10.23 08:13, Greg Kroah-Hartman wrote:
> > On Mon, Oct 09, 2023 at 09:20:52PM +0000, Alexander Graf wrote:
> > > To fully support the Nitro Secure Module communication protocol, we need
> > > to encode and decode CBOR binary data. Import an MIT licensed library
> > > from https://github.com/libmcu/cbor (commit f3d1696f886) so that we can
> > > easily consume CBOR data.
> > What is "CBOR"?  I don't see a description of it here.
> 
> 
> CBOR is the "Concise Binary Object Representation"
> (https://en.wikipedia.org/wiki/CBOR) binary format.
> 
> 
> > 
> > And I guess you are going to keep this in sync with upstream?  Or do you
> > really need the full library here (you #ifdef the float stuff out), does
> > your module really need all of the functionality and complexity of this
> > library, or can it use just a much smaller one instead?
> 
> 
> CBOR knows a total of 9 data types:
> 
>   - Unsigned integers
>   - Signed integers
>   - Binary string
>   - UTF-8 string
>   - Arrays
>   - Maps (like a python dictionary)
>   - Semantic tag
>   - Bools
>   - Floats
> 
> Out of these, the NSM communication protocol uses all except Semantic tags
> and Floats. The CBOR library that this patch imports does not have special
> handling for Semantic tags, which leaves only floats which are already
> #ifdef'ed out. That means there is not much to trim.
> 
> What you see here is what's needed to parse CBOR in kernel - if that's what
> we want to do. I'm happy to rip it out again and make it a pure user space
> problem to do CBOR :).

Yes, why are we parsing this in the kernel?  What could go wrong with
adding yet-another-parser in privileged context?  :)

Why does this have to be in the kernel, the data sent/recieved is over
virtio, so why does the kernel have to parse it?  I couldn't figure that
out from the driver, yet the driver seems to have a lot of hard-coded
parsing logic in it to assume specific message formats?

thanks,

greg k-h
