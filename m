Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226577FDBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbjK2Plz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjK2Plw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:41:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D665BD48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:41:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2037C433C7;
        Wed, 29 Nov 2023 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701272518;
        bh=I0q1v9bTrML80ulyQEMrxjRfQVCMCsDWuy/OAJgwr14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmfAEXxApvLS9zisQRc2UEwCdAKwaGApUmoUpGZBIBcZwqMeFwloflFMG+V4tzXs9
         IYPlb1H6ghk4xFDyb+yNNwkdE9UYh5aCZGY3tHJT0ChBnKfGJxr1cUPFWLmPaoLc9P
         D12BdnNjOkJ1asrWz+QjUl0KojS/I309PlYs9IBE=
Date:   Wed, 29 Nov 2023 15:41:54 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112951-civil-risotto-50dc@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112727-caddie-eardrum-efe8@gregkh>
 <ZWb_l7rC4QK8duU3@x130>
 <2023112938-unhook-defiance-75ed@gregkh>
 <20231129130200.GV436702@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129130200.GV436702@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:02:00AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 29, 2023 at 09:20:32AM +0000, Greg Kroah-Hartman wrote:
> > On Wed, Nov 29, 2023 at 01:08:39AM -0800, Saeed Mahameed wrote:
> > > On 27 Nov 18:59, Greg Kroah-Hartman wrote:
> > > > On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
> > > > > +struct mlx5ctl_dev {
> > > > > +	struct mlx5_core_dev *mdev;
> > > > > +	struct miscdevice miscdev;
> > > > > +	struct auxiliary_device *adev;
> > > > > +	struct list_head fd_list;
> > > > > +	spinlock_t fd_list_lock; /* protect list add/del */
> > > > > +	struct rw_semaphore rw_lock;
> > > > > +	struct kref refcount;
> > > > 
> > > > You now have 2 different things that control the lifespan of this
> > > > structure.  We really need some way to automatically check this so that
> > > > people don't keep making this same mistake, it happens all the time :(
> > > > 
> > > > Please pick one structure (miscdevice) or the other (kref) to control
> > > > the lifespan, having 2 will just not work.
> > > > 
> > > 
> > > miscdevice doesn't handle the lifespan, open files will remain open even
> > > after the miscdevice was unregistered, hence we use the kref to defer the
> > > kfree until the last open file is closed.
> > 
> > miscdevice has a reference counter and a lifecycle, you can not have two
> > reference counted objects in the same structure and expect things to
> > work well.
> 
> This second refcount is hidden well:
> 
> struct miscdevice {
> 	int minor;
> 	const char *name;
> 	const struct file_operations *fops;
> 	struct list_head list;
> 	struct device *parent;
> 	struct device *this_device;
> 	const struct attribute_group **groups;
> 	const char *nodename;
> 	umode_t mode;
> };

Ugh, you are right, I was wrong, there is no reference count here, using
a miscdevice _requires_ you to have a separate reference count, like you
all did.  My fault.

> > > write_lock() : only on mlx5_ctl remove and mark the device is down
> > > via assigning NULL to mcdev->dev, to let all new readers abort and to wait
> > > for current readers to finish their task.
> > > 
> > > read_lock(): used in all fops and ioctls, to make sure underlaying
> > > mlx5_core device is still active, and to prevent open files to access the
> > > device when miscdevice was already unregistered.
> > > 
> > > I agree, this should've been documented in the code, I will add
> > > documentation.
> > 
> > Just make it simple and use a normal mutex please.
> 
> A normal mutex would make the entire ioctl interface single threaded,
> this is not desirable.

Why not?  It's an ioctl for a single device, surely this isn't
performance criticial.  And then only grab it when needed, on
read/write/ioctl path it shouldn't be needed at all due to the proper
reference counting of the structures.  Only on open/close, right?

And again, for a rw semaphore, benchmarks matter, often, if not almost
always, a normal mutex is faster for stuff like this.  If not, then a
benchmark will show it.

> > But before you do that, please see my other email about why not using
> > devlink for all of this instead.
> 
> We've been over this already, the devlink discussion is about some
> configuration stuff.

It was?  I see device-specific diagonostic data for the mlx5 driver
being exported through devlink today, that's not configuration.  Why not
just add more?

> It has never been suggested to cover the debug interface. This series
> is primarily about debug, the devlink thing is a distraction to main
> point.

For me it is the main point at the moment.  Please explain why devlink
does not work for the information that you have created a misc device
where you want an ioctl api instead, as I honestly do not understand.

thanks,

greg k-h
