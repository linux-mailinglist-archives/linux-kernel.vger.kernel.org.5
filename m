Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD647D1C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjJUKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjJUKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:16:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D1810FC
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2484C433C8;
        Sat, 21 Oct 2023 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697883338;
        bh=xE0tYUlCrfmA5ifWfxBsHGThFtSt5cm5A10aM2uArNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNrC8WRT6OA/H2vcGgO2NLbvKH7IiXL6J9wRT+BNNZ2qyFCDI+Fa6vk4Pe8BaCt/6
         jiCDihCdWQq2LENnubfRV+HuqBI0jQel8x65j1Fq79hogoQ7yeqwLU6PFWc8vyk4f3
         yCITKQ0u4J/rBeG2jDSOSS966GtmGy6nixvMIMo4=
Date:   Sat, 21 Oct 2023 12:15:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Hardik Gajjar <hgajjar@de.adit-jv.com>, mathias.nyman@intel.com,
        yangyingliang@huawei.com, jinpu.wang@ionos.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v4] usb: core: hub: Add quirks for reducing device
 address timeout
Message-ID: <2023102105-attribute-pajamas-a0dc@gregkh>
References: <2023101155-unframed-satirical-f7ec@gregkh>
 <20231011164525.97616-1-hgajjar@de.adit-jv.com>
 <2023101620-shaky-sensitize-9708@gregkh>
 <20231017161021.GA62775@vmlxhi-118.adit-jv.com>
 <2023101750-bless-humorous-45c7@gregkh>
 <6c25beed-06fe-4be0-b51a-18e159d25072@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c25beed-06fe-4be0-b51a-18e159d25072@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:59:54PM -0400, Alan Stern wrote:
> On Tue, Oct 17, 2023 at 06:53:44PM +0200, Greg KH wrote:
> > On Tue, Oct 17, 2023 at 06:10:21PM +0200, Hardik Gajjar wrote:
> > > More logs and detailed in patch V1:
> > > https://lore.kernel.org/linux-usb/20230818092353.124658-1-hgajjar@de.adit-jv.com/T/#m452ec9dad94e8181fdb050cd29483dd89437f7c1
> > > > 
> > > > > Achieving this is impossible in scenarios where the set_address is
> > > > > not successful and waits for a timeout.
> > > > 
> > > > Agreed, broken hardware is a pain, but if your device is allowed to take
> > > > longer, it can, and will, so you have to support that.
> > > > 
> > > The problem is not caused by the device taking an extended amount of time to
> > > process the 'set_address' request. Instead, the issue lies in the absence of
> > > any activity on the upstream bus until a timeout occurs.
> > 
> > So, a broken device.  Why are you then adding the hub to the quirk list
> > and not the broken device?  We are used to adding broken devices to
> > qurik lists all the time, this shouldn't be new.
> 
> Adding a quirk for the device isn't feasible, because the problem occurs 
> before the device has been initialized and enumerated.  The kernel 
> doesn't know anything about the device at this point; only that it has 
> just connected.

Ah, ick, you are right, but we do know the "broken hub" id, so that
makes a bit more sense.  Should this be a hub-only type quirk?

> > > This situation arises when the host has already transmitted the 'set_address' command to the hub,
> > > assuming that the device operates at full speed. However, the device connected
> > > to the hub undergoes a state change from full speed to high-speed during this process.
> > 
> > During which process?  While the set-address happens?  That feels like a
> > hub bug then.
> > 
> > > > > The shortened address device timeout quirks provide the flexibility
> > > > > to align with a 3-second time limit in the event of errors.
> > > > > By swiftly triggering a failure response and swiftly initiating
> > > > > retry procedures, these quirks ensure efficient and rapid recovery,
> > > > > particularly in automotive contexts where rapid smartphone enumeration
> > > > > and screen projection are vital.
> > > > 
> > > > Screen projection is a requirement that you should not be relying on USB
> > > > for as USB has a different set of required timeouts, right?  This sounds
> > > > like a bad hardware design, if not an impossible one.
> > > > 
> > > 
> > > Screen projection for us means displaying the connected phone on the screen and
> > > launching Carplay and Android Auto for the user. This works perfectly in nearly all
> > > cases, except in scenarios like this one where a combination of a special hub and
> > > a specific phone model is causing the issue
> > 
> > So which is broken, the hub or phone?
> 
> It sounds like both of them are broken to some extent, although we can't 
> tell for sure without seeing what's actually happening on the USB bus 
> (i.e., bus analyzer output):
> 
> 	The phone seems to take too long to activate its high-speed
> 	terminations and deactivate the full-speed terminations.
> 
> 	The hub doesn't seem to realize that the phone has disconnected 
> 	its full-speed connection and switched to high-speed.
> 
> But without real data, these are just best guesses.

Agreed, Hardik, can you look at some bus traces to figure out where the
root problem here is?

thanks,

greg k-h
