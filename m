Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE647FC350
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbjK1SdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjK1SdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:33:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A185A1707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:33:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7647C433C8;
        Tue, 28 Nov 2023 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701196386;
        bh=8t+nxF5kzapSyOyWkOkLTgL5cDyaTYjvQxjaeHBHWAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ji5Mr0vv8Hc2+b/BfbEDgicpDcHAbkEIrDsex/+IDpghEGBRGi9yLBZkUYjsghVCM
         wfHuqJ15rUqcFA0Ezby1v7+y76eicLTzuvCt5blvzbVZDDo9Gkd3Cn8oacWsPjlwXA
         Vtb1FaAVPlszqn0pZ2gU2Abwgjpzksvq1yhGF7F/v14cHgQ77YkNO8+QNrN0cvW9+q
         8GoBpHr98wPj4o3w7bdZsvzyEE045MawcgYLVTWyVi9w8to+2MO+WOi+zWvOnoRma7
         mGFd/hECSmvgRjbjmTVEYAyqvtaxP8B0hb0gxUHFg8GwXE53vBb2mAsV6ea4AuAKIB
         JVOqLoqDw/dhw==
Date:   Tue, 28 Nov 2023 10:33:04 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128103304.25c2c642@kernel.org>
In-Reply-To: <20231128175224.GR436702@nvidia.com>
References: <20231127144017.GK436702@nvidia.com>
        <2023112752-pastel-unholy-c63d@gregkh>
        <20231127161732.GL436702@nvidia.com>
        <2023112707-feline-unselect-692f@gregkh>
        <ZWTtTjgBrNxpd9IO@x130>
        <20231127160719.4a8b2ad1@kernel.org>
        <20231128044628.GA8901@u2004-local>
        <20231128065321.53d4d5bb@kernel.org>
        <20231128162413.GP436702@nvidia.com>
        <20231128084421.6321b9b2@kernel.org>
        <20231128175224.GR436702@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 13:52:24 -0400 Jason Gunthorpe wrote:
> > The question at LPC was about making devlink params completely
> > transparent to the kernel. Basically added directly from FW.
> > That what I was not happy about.  
> 
> It is creating a back-porting nightmare for all the enterprise
> distributions.

We don't care about enterprise distros, Jason, or stable kernel APIs.

> > You can add as many params at the driver level as you want.
> > In fact I asked Saeed repeatedly to start posting all those
> > params instead of complaining.  
> 
> That really isn't what you said in the video.
> 
> Regardless, configurables are only one part of what mlx5ctl addresses,
> we still have all the debugability problems, which are arguably more
> important.

Read-only debug interfaces are "do whatever you want" in netdev.
Params controlling them (ie. writing stuff) need to be reviewed 
but are also allowed.

Doesn't mlx5 have a pile of stuff in debugfs already?

Nobody bothered to answer my "are you not going support mstreg over
this" question (arbitrary register writes).

> > Let the users complain about the user problems. Also something
> > I repeatedly told Saeed. His response was something along the lines
> > of users are secret, they can't post on the list, blah, blah.  
> 
> You mean like the S390 team at IBM did in the video?
> 
> This is not a reasonable position. One of the jobs of the vendors is
> to aggregate the user requests. Even the giant hyperscale customers
> that do have the capacity to come on this list prefer to delegate
> these things to us.
> 
> If you want to get a direct user forum the kernel mailing list is not
> an appropriate place to do it.

Agree to disagree.

> > You know one user who is participating in this thread?
> > *ME*
> > While the lot of you work for vendors.  
> 
> I'm sick of this vendor bashing. You work for *one* user. You know who
> talks to *every* user out there? *ME*.
> 
> User and vendors need debugging of this complex HW. I don't need to
> bring a parade of a dozen users to this thread to re-enforce that
> obvious truth. Indeed when debugging is required the vendor usually
> has to do it, so we are the user in this discussion.
> 
> You didn't answer the question, what is your alternative debug-ability
> vision here?

Covered above. And it's been discussed multiple times.

Honestly I don't want to spend any more time discussing this.
Once you're ready to work together in good faith let me know.

On future revisions of this series please carry:

Nacked-by: Jakub Kicinski <kuba@kernel.org>
