Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8577E6326
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjKIF1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:27:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E40B2696;
        Wed,  8 Nov 2023 21:27:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB8C433C8;
        Thu,  9 Nov 2023 05:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699507648;
        bh=K/EltZdhut9CI7X7hKADOT3ZnXycefB40uP/C3yBgaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiBBrSris5pVcrHom7/fijwUFt0TuPYpdZmOZmQqlVa+QThFQIu8RtWOa8JdCYELb
         BSkbfASa/a6ovTp4uO71dgZF8m6lYXM1tW5LuwpM+tBafgOvjVSv10xmnQWknWB4YM
         UHUhSLmi9xUTtsxBczUUKLWpBG3UszfOqjKhRCrU=
Date:   Thu, 9 Nov 2023 06:27:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <2023110922-lurk-subdivide-4962@gregkh>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <2023110839-jam-relapsing-7f5d@gregkh>
 <ZUxpHk/8pCusjXOb@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUxpHk/8pCusjXOb@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:07:42PM +0800, Xu Yilun wrote:
> On Wed, Nov 08, 2023 at 05:20:53PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
> > > > >>
> > > > >> In fpga_region_get() / fpga_region_put(): call get_device() before
> > > > >> acquiring the mutex and put_device() after having released the mutex
> > > > >> to avoid races.
> > 
> > Why do you need another reference count with a lock?  You already have
> > that with the calls to get/put_device().
> 
> The low-level driver module could still be possibly unloaded at the same
> time, if so, when FPGA core run some callbacks provided by low-level driver
> module, its referenced page of code is unmapped...

Then something is designed wrong here, the unloading of the low-level
driver should remove the access to the device itself.  Perhaps fix that?

> > > The lock/unlock of mutex
> > > scattered in different functions is also an uncommon style. Maybe some
> > > atomic count should be enough.
> > 
> > Don't make a fake lock with an atomic variable, use real locks if you
> > need it.
> 
> I mean, here it doesn't not looks like a "locking" senario, although it
> works.
> 
> The purpose here is to declare a device state, which says the device is
> exclusively used by a user, no other user is allowed. But usually we use
> mutex to protect against critical code blocks, not to represent a long
> live device state.
> 
> I'm still OK for the existing mutex usage as it doesn't break anything
> and if we don't want change much.
> 
> > 
> > Or don't even care about module unloading at all!  Why does it matter?
> > It can never happen without explicit intervention and it's something
> > that a lot of the time, just will cause problems.  Don't do a lot of
> > extra work for something that doesn't matter.
> 
> mm.. as mentioned above some fundamental subsystems do care about
> module unloading, and I tend to keep it same way. But mm... I'm OK to
> make things easier if you insist.

You can care, but my point being that don't make it very complex and
slow just for something that no one will ever do in normal device
operation.

thanks,

greg k-h
