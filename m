Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C577E630C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKIFJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKIFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:09:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891D2683;
        Wed,  8 Nov 2023 21:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699506560; x=1731042560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R/XIZyqjqAxy76RqlzGRqEx47WSQawvnPw5L1+zjNG0=;
  b=TVYZu9DVt/vZDkgPneJkcYTUw+I7eVx4V0ZuEeJEdOmxBwf4woYtpsOr
   gJitj/uc3SyddR/HdWjyT9YOMxoarX47rRBtY0nNSfIsdNumFpW7f/rBU
   90Jx8pakcQ6A3yO0GtQmo8H1AKm0UdmSOLaaI76pKyIW12MKpw15YAmTq
   dqS62aDseWDPZmRozNqATU+OdPSoiwqwxYhVxKcboyz0mb03g2kAtwEid
   yuEB3joTQCCkUkm5g0bICEQLqEQk6fA13yD+b4grFHDLSmRPW7/3C0IBx
   xGXQWHUwdd9QV+zQGjAgSlB8t7WsriNxCoSfQPURa5PoosUw3bWGcHTvU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476146691"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="476146691"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 21:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="886886252"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="886886252"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2023 21:09:16 -0800
Date:   Thu, 9 Nov 2023 13:07:42 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <ZUxpHk/8pCusjXOb@yilunxu-OptiPlex-7050>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <2023110839-jam-relapsing-7f5d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110839-jam-relapsing-7f5d@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 05:20:53PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
> > > >>
> > > >> In fpga_region_get() / fpga_region_put(): call get_device() before
> > > >> acquiring the mutex and put_device() after having released the mutex
> > > >> to avoid races.
> 
> Why do you need another reference count with a lock?  You already have
> that with the calls to get/put_device().

The low-level driver module could still be possibly unloaded at the same
time, if so, when FPGA core run some callbacks provided by low-level driver
module, its referenced page of code is unmapped...

I actually got this idea from this mail thread:

https://lore.kernel.org/all/20231010003746.GN800259@ZenIV/

And I see get/put of "struct file_operations.owner" in many framework
code for this purpose, to ensure no fops->read/write/ioctl() is ongoing
when module unloading.

> 
> > > > Could you help elaborate more about the race?
> > > > 
> > > 
> > > I accidentally misused the word race. My concern was that memory might
> > > be released after the last put_device(), causing mutex_unlock() to be
> > > called on a mutex that does not exist anymore. It should not happen
> > > for the moment since the region does not use devres, but I think it
> > > still makes the code more brittle.
> > 
> > It makes sense.
> > 
> > But I dislike the mutex itself. The purpose is to exclusively grab the
> > device, but a mutex is too much heavy for this.
> 
> Why "heavy"?  Is this a fast-path?  Have you measured it?

It's not a fast-path. But I didn't make it clear, see below...

> 
> > The lock/unlock of mutex
> > scattered in different functions is also an uncommon style. Maybe some
> > atomic count should be enough.
> 
> Don't make a fake lock with an atomic variable, use real locks if you
> need it.

I mean, here it doesn't not looks like a "locking" senario, although it
works.

The purpose here is to declare a device state, which says the device is
exclusively used by a user, no other user is allowed. But usually we use
mutex to protect against critical code blocks, not to represent a long
live device state.

I'm still OK for the existing mutex usage as it doesn't break anything
and if we don't want change much.

> 
> Or don't even care about module unloading at all!  Why does it matter?
> It can never happen without explicit intervention and it's something
> that a lot of the time, just will cause problems.  Don't do a lot of
> extra work for something that doesn't matter.

mm.. as mentioned above some fundamental subsystems do care about
module unloading, and I tend to keep it same way. But mm... I'm OK to
make things easier if you insist.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
