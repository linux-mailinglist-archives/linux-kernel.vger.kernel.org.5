Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6359B7C5EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjJKU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjJKU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:56:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4D90;
        Wed, 11 Oct 2023 13:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AE2C433C7;
        Wed, 11 Oct 2023 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697057767;
        bh=QzNo7KGA7wDrWljwqf1UihreSsQi8vsYIXDzHfhUKmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DNk4zAVc9ARRGwKGPbYQ39VlzTaZRFrNjryjUlzVOL21RrmVfeuOL6QC7ZFrXU+hJ
         Lrv7QOzt6CK88lxkd2Ge47R3WjlU7QSTml6/KhPPX2CLCj6UJ7vKKoPEi/1GkgAtER
         5E7+8dOUqlZyQvXWtDsrGXmrOnkaDXNVGjcdutHk=
Date:   Wed, 11 Oct 2023 22:56:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petre Eftime <petre.eftime@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alexander Graf <graf@amazon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: Re: [PATCH v4 1/2] Import CBOR library
Message-ID: <2023101149-cyclic-backless-640d@gregkh>
References: <20231009212053.2007-1-graf@amazon.com>
 <20231009212053.2007-2-graf@amazon.com>
 <2023101010-overwrite-parakeet-91d5@gregkh>
 <0ee221bc-ea99-4724-9ebd-436e91417e4b@amazon.com>
 <2023101009-accustom-manifesto-8bdb@gregkh>
 <b3a8c722-c0e2-4c8c-aef0-29af0a93572d@amazon.com>
 <2023101001-ocelot-veteran-10db@gregkh>
 <2339287b-8b17-413b-aa86-f618ea7fc3fa@app.fastmail.com>
 <2023101156-helper-waving-09df@gregkh>
 <CAHO81f5m3Lgus-YBbmmHDHoNsrHQ1GYkddtyv3_rJ_g0NT5Nzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHO81f5m3Lgus-YBbmmHDHoNsrHQ1GYkddtyv3_rJ_g0NT5Nzw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:48:43PM +0300, Petre Eftime wrote:
> On Wed, Oct 11, 2023 at 8:46 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 11, 2023 at 02:24:48PM +0200, Arnd Bergmann wrote:
> > > On Tue, Oct 10, 2023, at 10:27, Greg Kroah-Hartman wrote:
> > > > On Tue, Oct 10, 2023 at 10:08:43AM +0200, Alexander Graf wrote:
> > > >> On 10.10.23 10:03, Greg Kroah-Hartman wrote:
> > > >>
> > > >> > > Out of these, the NSM communication protocol uses all except Semantic tags
> > > >> > > and Floats. The CBOR library that this patch imports does not have special
> > > >> > > handling for Semantic tags, which leaves only floats which are already
> > > >> > > #ifdef'ed out. That means there is not much to trim.
> > > >> > >
> > > >> > > What you see here is what's needed to parse CBOR in kernel - if that's what
> > > >> > > we want to do. I'm happy to rip it out again and make it a pure user space
> > > >> > > problem to do CBOR :).
> > > >> > Yes, why are we parsing this in the kernel?  What could go wrong with
> > > >> > adding yet-another-parser in privileged context?  :)
> > > >> >
> > > >> > Why does this have to be in the kernel, the data sent/recieved is over
> > > >> > virtio, so why does the kernel have to parse it?  I couldn't figure that
> > > >> > out from the driver, yet the driver seems to have a lot of hard-coded
> > > >> > parsing logic in it to assume specific message formats?
> > > >>
> > > >>
> > > >> The parsing doesn't have to be in kernel and it probably shouldn't be
> > > >> either. V3 of the patch was punting all the parsing to user space, at which
> > > >> point you and Arnd said I should give it a try to do the protocol parsing in
> > > >> kernel space instead. That's why the parser is here.
> > > >
> > > > Arnd said that, not me :)
> > > >
> > > >> If we conclude that all this in-kernel parsing is not worth it, I'm very
> > > >> happy to just go back to the the v3 ioctl interface and post v5 with hwrng
> > > >> merged into misc, but remove all CBOR logic again :)
> > > >
> > > > I think the less parsers we have in the kernel, the safer we are for
> > > > obvious reasons.  Unless you have a parser for this in rust?  :)
> > > >
> > > > I don't really know, having a generic interface is good, but at the
> > > > expense of this api is probably not good.  individual ioctls might be
> > > > better if there are not going to be any other drivers for this type of
> > > > thing?
> > >
> > > I was definitely expecting something simpler than what was possible
> > > in the v4 patch. I had another look now, and it's clear that the
> > > ioctl interface is still not great because the variable data structures
> > > shine through for some of the calls, and even to get to this point,
> > > a whole lot of complexity is required underneath.
> > >
> > > To get anything better, one would probably have to redesign the entire
> > > interface stack (hypervisor, kernel and userland) to use regular
> > > fixed data structures, and this seems unlikely to happen.
> >
> > Why not fix this and do it properly?  What's preventing that from
> > happening?  We don't want to create an interface here that is broken, or
> > insecure, or a pain to maintain, right?
> >
> > thanks,
> >
> > greg k-h
> 
> I would think the proposal to have fixed structures would be a
> downgrade in terms of maintainability, usability and security, not an
> improvement.
> 
> This current interface allows the hypervisor to extend the existing
> functionality at any time, and the Linux kernel does not have to
> change anything for that to work, the application does not have to be
> recompiled to use the new kernel headers at any point. Adding new
> APIs, adding new fields to API responses, or adding optional
> parameters to the API is fully backwards compatible, would also not
> require changes in userspace, as the CBOR data structures that are not
> recognized can simply be skipped. This allows easy backwards
> compatibility in most cases, and the userspace would be able to opt in
> to new features only if it requires them, without forcing the upgrade
> if it's not required.
> 
> With fixed structures, then the driver would need to be more
> explicitly versioned and would need to be able to handle multiple
> versions of the API at the same time, which is both more complex, less
> flexible and more prone to errors.

Yes, but you are trading off the complexity of adding
yet-another-protocol-parser to the kernel vs. making a strict
user/kernel api, right?

Which one is correct?  Can you verify that this parser really is correct
and doesn't have any overflows/security issues in it?  I can't, maybe
someone needs to write it in rust :)

thanks,

greg k-h
