Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738B7D996D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjJ0NMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbjJ0NL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:11:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F8128;
        Fri, 27 Oct 2023 06:11:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F8EC433C7;
        Fri, 27 Oct 2023 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698412316;
        bh=gqKsefNfAE2NujQeI+bmZ4vCEw2udQtY+8UsABoc8uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKjhLe9bI0q1V1YbURGnamPRx0+wvhNbwtlXsYzvK+Zz1qR7e6FJG2xtVs8dskOWy
         6YEGMk3ctlnFnU65GCAH6qHjQpPyOuiffGYCAkb9qPdi2BDSiT+EvX421HNpx1cnvt
         nYa+gZ+nEtv31U7EshS+voJ5AwY69U8oyuchrb8E=
Date:   Fri, 27 Oct 2023 15:11:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Message-ID: <2023102757-cornflake-pry-e788@gregkh>
References: <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
 <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
 <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh>
 <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
 <2023102740-think-hatless-ab87@gregkh>
 <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:03:28PM +0200, Miklos Szeredi wrote:
> On Fri, Oct 27, 2023 at 2:46 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > I'm talking about a patch where you are changing the existing
> > user/kernel api by filtering out values that you previously accepted.
> > And it was done in a patch saying "this might break userspace", and
> > guess what, it did!
> >
> > So why not revert it as obviously you all anticipated that this might
> > happen?
> 
> Because it's a useful patch, and while I mentioned the possibility of
> a regression, I definitely didn't expect it to happen.

But it did :(

> And I still think that the Android case doesn't count, because it's
> just a completely different environment.  What can happen on Android
> may not happen on non-Android and vice versa.  Why should I revert a
> useful patch, because it causes a regression in a downstream kernel,
> because of an Android only patch?

It's not all that different of an environment, they use a stock kernel,
you can boot an android device just fine for many years without any
changes.

I would argue there are less changes in an android kernel than an
"enterprise" linux distro kernel these days by far :)

> > The "internal" patch from Android was just using the upper values of the
> > fuse api because they didn't want to conflict with the upstream values
> > before their code was accepted (and it was submitted already, but not
> > accepted.)
> >
> > So how do you want developers to work on changes before they are
> > accepted with this user/kernel numbering scheme that you have?  You just
> > broke anyone who was using a not-accepted-in-the-tree value, right?
> 
> Again, upstream and downstream.  There's a reason why some companies
> have upstream first policies: because it's less painful in the long
> run.  Android having decided to go ahead and add that patch is not my
> problem, and I really really don't want to care.

I think you rejected Android's changes, so what were they supposed to
do?  Or someone did, I can't remember when it was submitted, but i do
remember seeing the patches flow by on some list...

> Having said all that, if there's a regression that someone reports for
> upstream flags (even on a vendor kernel), I'll just revert the patch
> right away.

So because Android userspace is sending a flag value that is not in the
upstream table, this breakage is ok?  Or do you mean something else, I'm
getting confused.

thanks,

greg k-h
