Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0E808646
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjLGKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLGKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2A13D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:19:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69D0C433C8;
        Thu,  7 Dec 2023 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701944369;
        bh=GgmN1cXZRvYyrO5Za71JcbY+USCjTcDuzYzSDftrw30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbc2vsr1WbWd/B9lktm68noqpyL+z96638ipI7qoMr4APTeA50qlcrdqQXlJzPjtw
         /rKXPrgjYgnyzcZRql4ztw1w8Ks03s8Bx+df3CldSZ0S7MqGYFcLQJxbSl/fBnBK2o
         oAsAUPesGN3VL9jFwq0pB+bpRoDd2OhPhN/APTdo=
Date:   Thu, 7 Dec 2023 11:19:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter
 driver_sync_probe=
Message-ID: <2023120724-overstep-gesture-75be@gregkh>
References: <20231206115355.4319-1-laoar.shao@gmail.com>
 <2023120644-pry-worried-22a2@gregkh>
 <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 10:08:40PM +0800, Yafang Shao wrote:
> On Wed, Dec 6, 2023 at 9:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> > > After upgrading our kernel from version 4.19 to 6.1, certain regressions
> > > occurred due to the driver's asynchronous probe behavior. Specifically,
> > > the SCSI driver transitioned to an asynchronous probe by default, resulting
> > > in a non-fixed root disk behavior. In the prior 4.19 kernel, the root disk
> > > was consistently identified as /dev/sda. However, with kernel 6.1, the root
> > > disk can be any of /dev/sdX, leading to issues for applications reliant on
> > > /dev/sda, notably impacting monitoring systems monitoring the root disk.
> >
> > Device names are never guaranteed to be stable, ALWAYS use a persistant
> > names like a filesystem label or other ways.  Look at /dev/disk/ for the
> > needed ways to do this properly.
> 
> The root disk is typically identified as /dev/sda or /dev/vda, right?

Depends on your system.  It can also be identified, in the proper way,
as /dev/disk/by-uuid/eef0abc1-4039-4c3f-a123-81fc99999993 if you want
(note, fake uuid, use your own disk uuid please.)

Why not do that?  That's the most stable and recommended way of doing
things.

> This is because the root disk, which houses the operating system,
> cannot be removed or hotplugged.

Not true at all, happens for many systems (think about how systems that
run their whole OS out of ram work...)

> Therefore, it usually remains as the
> first disk in the system. With the synchronous probe, the root disk
> maintains a stable and consistent identification.
> 
> >
> > > To address this, a new kernel parameter 'driver_sync_probe=' is introduced
> > > to enforce synchronous probe behavior for specific drivers.
> >
> > This should be a per-bus thing, not a driver-specific thing as drivers
> > for the same bus could have differing settings here which would cause a
> > mess.
> >
> > Please just revert the scsi bus functionality if you have had
> > regressions here, it's not a driver-core thing to do.
> 
> Are you suggesting a reversal of the asynchronous probe code in the
> SCSI driver?

For your broken scsi driver, yes.

> While reverting to synchronous probing could ensure
> stability, it's worth noting that asynchronous probing can potentially
> shorten the reboot duration under specific conditions. Thus, there
> might be some resistance to reverting this change as it offers
> performance benefits in certain scenarios. That's why I prefer to
> introduce a kernel parameter for it.

I don't want to add a new parameter that we need to support for forever
and add to the complexity of the system unless it is REALLY needed.
Please work with the scsi developers to resolve the issue for your
hardware, as it's been working for everyone else for well over a year
now, right?

thanks,

greg k-h
