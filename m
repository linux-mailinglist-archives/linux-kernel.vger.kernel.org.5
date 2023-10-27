Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB497D98D5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbjJ0Mqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjJ0Mq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:46:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BDDE;
        Fri, 27 Oct 2023 05:46:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CE6C433BB;
        Fri, 27 Oct 2023 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698410783;
        bh=PTdO27UNxLEVa97LeYxxB42XjGnleAMhPmp3girLEm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIpyRceTocf4Na9x0QREHQVyACGBGOnB6gshwaPUhWl/6Hp7u1+s2xL7H4Fteqnpi
         t+fu1xNWeiVh5VtvJfTpyAs7QZqTUZbnUJp9kzcfU5qid8ZR6+ikaHMmph8MByXUaC
         s/zhUlaxUwjAz37K9H5XVgMkEuHsuJRvSoWigvvE=
Date:   Fri, 27 Oct 2023 14:46:21 +0200
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
Message-ID: <2023102740-think-hatless-ab87@gregkh>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
 <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
 <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
 <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
 <2023102731-wobbly-glimpse-97f5@gregkh>
 <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:36:55PM +0200, Miklos Szeredi wrote:
> On Fri, Oct 27, 2023 at 12:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 25, 2023 at 03:17:09PM +0200, Miklos Szeredi wrote:
> 
> > > I don't think the Android use case counts as a regression.
> >
> > Why not?  In the changelog for this commit, it says:
> >
> >     There is a risk with this change, though - it might break existing user
> >     space libraries, which are already using flags2 without setting
> >     FUSE_INIT_EXT.
> >
> > And that's exactly what Android was doing.  Not all the world uses libfuse,
> > unfortunatly.
> 
> No, this is not about libfuse or not libfuse.   It's about upstream or
> downstream.  If upstream maintainers would need to care about
> downstream regressions, then it would be hell.

I agree, that's not what I'm saying here.

> How should Android handle this?  Here's how: they have an internal
> patch, which conflicts with the patch they want to revert.  Well, let
> them revert that patch in their kernel.  It's not like it's a big
> maintenance burden, since it's just a few lines.  This is the sort of
> thing that downstream maintainers do all the time.
> 
> It's a no-brainer, what are we talking about then?

I'm talking about a patch where you are changing the existing
user/kernel api by filtering out values that you previously accepted.
And it was done in a patch saying "this might break userspace", and
guess what, it did!

So why not revert it as obviously you all anticipated that this might
happen?

The "internal" patch from Android was just using the upper values of the
fuse api because they didn't want to conflict with the upstream values
before their code was accepted (and it was submitted already, but not
accepted.)

So how do you want developers to work on changes before they are
accepted with this user/kernel numbering scheme that you have?  You just
broke anyone who was using a not-accepted-in-the-tree value, right?

thanks,

greg k-h
