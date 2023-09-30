Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D97B3EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjI3GUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3GUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:20:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410E1A7;
        Fri, 29 Sep 2023 23:20:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73349C433C7;
        Sat, 30 Sep 2023 06:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696054852;
        bh=YegthhuJUQjE8I3ZgOwiTP7mRlYp60Jw2QVs8hlYzb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPbui3hSWp5RMgU5g80OtG2U83WWfinhOHJMZyekdTalYgai3RnAAFyR6b6/Mijah
         lOdVqUphEVdsJMxohsqY94PKCFcObB1+Wm6j8DO9rquehs2Pnc/tK767E3PIHlQFws
         NduXwqhO6AWS/nyXhCGiFWbnZ8hY7zTtJC7JDXg0=
Date:   Sat, 30 Sep 2023 08:20:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] misc: Add Nitro Secure Module driver
Message-ID: <2023093054-swimming-whoopee-7ef8@gregkh>
References: <20230929133320.74848-1-graf@amazon.com>
 <20230929133320.74848-2-graf@amazon.com>
 <74b2d869-0d96-46f9-a180-b405992e6c51@app.fastmail.com>
 <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a44a2df0-beb9-4a43-ade4-267ad819729e@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:26:16PM +0200, Alexander Graf wrote:
> Hi Arnd!
> 
> On 29.09.23 19:28, Arnd Bergmann wrote:
> > On Fri, Sep 29, 2023, at 09:33, Alexander Graf wrote:
> > > When running Linux inside a Nitro Enclave, the hypervisor provides a
> > > special virtio device called "NSM". This device has 2 main functions:
> > > 
> > >    1) Provide attestation reports
> > >    2) Modify PCR state
> > >    3) Provide entropy
> > > 
> > > This patch adds the core NSM driver that exposes a /dev/nsm device node
> > > which user space can use to request attestation documents and influence
> > > PCR states. A follow up patch will add a hwrng driver to feed its entropy
> > > into the kernel.
> > > 
> > > Originally-by: Petre Eftime <petre.eftime@gmail.com>
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Hi Alex,
> > 
> > I've taken a first look at this driver and have some minor comments.
> 
> 
> Thanks a bunch!
> 
> 
> > The main point here is that I think we need to look at possible
> > alternatives for the user space interface, and (if possible) change
> > to a set of higher-level ioctl commands from the simple passthrough.
> 
> 
> I'm slightly torn on that bit. I think in hindsight the NSM device probably
> should have been a reserved vsock CID and the hwrng one should have just
> been virtio-rng.
> 
> The problem is that Nitro Enclaves were launched in 2020 and since an
> ecosystem developed in multiple languages to support building code inside:
> 
> https://github.com/aws/aws-nitro-enclaves-nsm-api/blob/main/src/driver/mod.rs#L66
> https://github.com/donkersgoed/aws-nsm-interface/blob/main/aws_nsm_interface/__init__.py#L264-L274
>   https://github.com/hf/nsm/blob/main/nsm.go#L99-L129
> 
> 
> All of these use the (downstream) ioctl that this patch also implements. We
> could change it, but instead of making it easier for user space to adapt the
> device node, it would probably hurt more.
> 
> I agree that this is not a great place to be in. This driver absolutely
> should have been upstreamed 3 years ago. But I can't turn back time (yet)
> :).

As you know, this is no excuse to put an api in the kernel that isn't
correct or good for the long-term.  Just because people do foolish
things outside of the kernel tree never means we have to accept them in
our tree.  Instead we can ask them to fix them properly as part of us
taking the code.

So please, work on doing this right.

thanks,

greg k-h
