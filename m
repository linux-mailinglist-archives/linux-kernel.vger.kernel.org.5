Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398A7FB103
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjK1Eq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjK1Eq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:46:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3A194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:46:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7717CC433C8;
        Tue, 28 Nov 2023 04:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701146791;
        bh=6ju1R5RRyXkhMRDskRGgARyIZqqRgrjEMRyhTczqn5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8v8F7Ys3+bAJTpaGczAPINsiPuRhlCQrKDFiYxhX5nPVwX4MfiYG+FhDXEy4YozY
         VZOUcWzwGn7tpg/YF05bEyuUqSG87o/qqbeEALHTHYSfLDMaKSqt3AGjCLRFRXHuke
         GkdQ0BsD6wzant4aPSFZEcLCBEi90llFrAGXrfP3CrYElouSPzw/itWIlQgQcq9AiR
         ufMh/fi2/hAA0s1BG+PzCvN0qMbVUQ/rlpqud1Bi7CNKXqufcSjhkPyQN+ccJIA9Jl
         pai7Eshuk+kD8FSQdp7ns5+JAQkxoCj9oL6vVXzwBjhgYy0Qx9jrJs8TvL8/6tN7H6
         5f/EEtyrhlWBw==
Date:   Mon, 27 Nov 2023 21:46:28 -0700
From:   David Ahern <dsahern@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128044628.GA8901@u2004-local>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127160719.4a8b2ad1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:07:19PM -0800, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 11:26:06 -0800 Saeed Mahameed wrote:
> > This driver is different as it doesn't replace existing mlx5 drivers,
> > mlx5 functionality drivers are still there to expose the device features
> > through the standard stacks, this is just a companion driver to access
> > debug information, by driver and FW design mlx5ctl is not meant to
> > manage or pilot the device like other device specific char drivers.
> 
> You keep saying "debug information" which is really underselling this
> driver. Are you not going to support mstreg?
> 
> The common development flow as far as netdev is concerned is:
>  - some customer is interested in a new feature of a chip
>  - vendor hacks the support out of tree, using oot module and/or
>    user space tooling
>  - customer does a PoC with that hacked up, non-upstream solution
>    - if it works, vendor has to find out a proper upstream API,
>      hopefully agreed on with other vendors
>    - if it doesn't match customer needs the whole thing lands in the bin
> 
> If the vendor specific PoC can be achieved with fully upstream software
> we lose leverage to force vendors to agree on common APIs.

Please elaborate on what "common" API there is to create here?

Do you agree that each ASIC in the device is unique and hence will
have made different trade offs - both features and nerd knobs to tune
and affect the performance and runtime capabilities? If you do not
agree, then we need to have a different discussion ...
If you do, please elaborate on the outline of some common API that
could possibly be done here.

You said no to the devlink parameters as a way to tune an ASIC. This
is a common, established tool, using a common, established message
channel but in an open, free form way of letting a customer see what
tunables there are for a specific H/W version and firmware version
and then set them. That is about as common as can be for different
vendors creating different ASICs with different goals and design
objectives. Yet, you somehow expect all of them to have nerd knob X
and tunable Y. That is not realistic.

> 
> This should all be self-evident for people familiar with netdev, but
> I thought I'd spell it out.
> 
> I understand that the device has other uses, but every modern NIC has
> other uses. I don't see how netdev can agree to this driver as long as
> there is potential for configuring random networking things thru it.
> All major netdev vendors have a set of out of tree tools / "expose
> everything misc drivers", "for debug". They will soon follow your
> example if we let this in.

Out of tree drivers are already ingrained into customers now. Mellanox
(in this case) has tried many different angles at getting access to H/W
unique tunables (i.e., the devlink comment) and now dumping huge amounts
of data. Your response to the devlink parameters attempt is to basically
abuse the firmware upgrade command as a way to push a binary blob that
can contain said settings (and I still have not fully wrapped my head
around the fact that you suggested that option).

What specifically are you looking for? There are different vendors and
different h/w options for specific market based reasons. Your hard line
stance against needs like this is what is pushing out of tree drivers
and tools to continue.
