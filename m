Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1EF7FC2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjK1Oxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346277AbjK1OxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:53:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77626199A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:53:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D815C433C7;
        Tue, 28 Nov 2023 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701183203;
        bh=B9FcAaCoKjQRFY+givAubtsXoVo7FWF9cxhOehkimQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DglLFbxyNYXQj/POi6iv2merVEcCqPoympudM6Mop1/zsc+IhDDh0eqjHiTpzA+f5
         UvdWIPdyaO6k65di8upkRo7Ics+CYE/1vTx7Wlly/Tjdy8lhRkvlkQt+K1JzN7pkFV
         GilPv8Nj+zQFR2Id0dwT3OW1SjHSsSrwICx9QFcunl4Ix47e08enP8oONRPmLmEysT
         a7wwLbVr6mCNzXa/PYkPLKDk7daVzngDIzBo3Lo4uve86/Bmfy+MyMy3ugA3gPXBOQ
         T4zlbpIPCmQoDVtvDAa59Pb0b8u9dpa2ONldqnbhahdVBc/POq3aE1iw+9bE4mHke4
         Xf0bSUrLzrWew==
Date:   Tue, 28 Nov 2023 06:53:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128065321.53d4d5bb@kernel.org>
In-Reply-To: <20231128044628.GA8901@u2004-local>
References: <20231121070619.9836-1-saeed@kernel.org>
        <20231121070619.9836-3-saeed@kernel.org>
        <2023112702-postal-rumbling-003f@gregkh>
        <20231127144017.GK436702@nvidia.com>
        <2023112752-pastel-unholy-c63d@gregkh>
        <20231127161732.GL436702@nvidia.com>
        <2023112707-feline-unselect-692f@gregkh>
        <ZWTtTjgBrNxpd9IO@x130>
        <20231127160719.4a8b2ad1@kernel.org>
        <20231128044628.GA8901@u2004-local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 21:46:28 -0700 David Ahern wrote:
> > You keep saying "debug information" which is really underselling this
> > driver. Are you not going to support mstreg?
> > 
> > The common development flow as far as netdev is concerned is:
> >  - some customer is interested in a new feature of a chip
> >  - vendor hacks the support out of tree, using oot module and/or
> >    user space tooling
> >  - customer does a PoC with that hacked up, non-upstream solution
> >    - if it works, vendor has to find out a proper upstream API,
> >      hopefully agreed on with other vendors
> >    - if it doesn't match customer needs the whole thing lands in the bin
> > 
> > If the vendor specific PoC can be achieved with fully upstream software
> > we lose leverage to force vendors to agree on common APIs.  
> 
> Please elaborate on what "common" API there is to create here?

Damn, am I so bad at explaining basic things or y'all are spending
5 seconds reading this and are not really paying attention? :|

> Do you agree that each ASIC in the device is unique and hence will
> have made different trade offs - both features and nerd knobs to tune
> and affect the performance and runtime capabilities? If you do not
> agree, then we need to have a different discussion ...
> If you do, please elaborate on the outline of some common API that
> could possibly be done here.

We have devlink params. If that doesn't scale we can look for other
solutions but let's see them not scale _in practice_ first.

> You said no to the devlink parameters as a way to tune an ASIC.

What? When?

> This is a common, established tool, using a common, established message
> channel but in an open, free form way of letting a customer see what
> tunables there are for a specific H/W version and firmware version
> and then set them. That is about as common as can be for different
> vendors creating different ASICs with different goals and design
> objectives. Yet, you somehow expect all of them to have nerd knob X
> and tunable Y. That is not realistic.

I don't know what you're talking about.

> > This should all be self-evident for people familiar with netdev, but
> > I thought I'd spell it out.
> > 
> > I understand that the device has other uses, but every modern NIC has
> > other uses. I don't see how netdev can agree to this driver as long as
> > there is potential for configuring random networking things thru it.
> > All major netdev vendors have a set of out of tree tools / "expose
> > everything misc drivers", "for debug". They will soon follow your
> > example if we let this in.  
> 
> Out of tree drivers are already ingrained into customers now. Mellanox
> (in this case) has tried many different angles at getting access to H/W
> unique tunables (i.e., the devlink comment) and now dumping huge amounts
> of data. Your response to the devlink parameters attempt is to basically
> abuse the firmware upgrade command as a way to push a binary blob that
> can contain said settings (and I still have not fully wrapped my head
> around the fact that you suggested that option).
> 
> What specifically are you looking for? There are different vendors and
> different h/w options for specific market based reasons. Your hard line
> stance against needs like this is what is pushing out of tree drivers
> and tools to continue.

Sounds like you'd like a similar open-ended interface for your device.
