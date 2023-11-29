Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB427FD24B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjK2JUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjK2JUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:20:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF69D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:20:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B44BC433C7;
        Wed, 29 Nov 2023 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701249635;
        bh=9/bUgsZvJru7o+tl3Vh3wyeIpClQ1xZ0pzwWFhxKz/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWMeQ3mAoHzz/iv/i+oJhMtraaUmZ/Ohd+Y3P01eAoVHrquxVHA2q19JELUF7HF9z
         JuapIEZiWhTMsh3ylwsc2RhQDnSSjpyWR2wG2LSRKHRgY72gtvSWwv55jkGXqcud3w
         FMfX5EZoaiZs8pSSYDXSsHKhL/3U/Ipf9mpx8rFY=
Date:   Wed, 29 Nov 2023 09:20:32 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112938-unhook-defiance-75ed@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112727-caddie-eardrum-efe8@gregkh>
 <ZWb_l7rC4QK8duU3@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWb_l7rC4QK8duU3@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:08:39AM -0800, Saeed Mahameed wrote:
> On 27 Nov 18:59, Greg Kroah-Hartman wrote:
> > On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
> > > +struct mlx5ctl_dev {
> > > +	struct mlx5_core_dev *mdev;
> > > +	struct miscdevice miscdev;
> > > +	struct auxiliary_device *adev;
> > > +	struct list_head fd_list;
> > > +	spinlock_t fd_list_lock; /* protect list add/del */
> > > +	struct rw_semaphore rw_lock;
> > > +	struct kref refcount;
> > 
> > You now have 2 different things that control the lifespan of this
> > structure.  We really need some way to automatically check this so that
> > people don't keep making this same mistake, it happens all the time :(
> > 
> > Please pick one structure (miscdevice) or the other (kref) to control
> > the lifespan, having 2 will just not work.
> > 
> 
> miscdevice doesn't handle the lifespan, open files will remain open even
> after the miscdevice was unregistered, hence we use the kref to defer the
> kfree until the last open file is closed.

miscdevice has a reference counter and a lifecycle, you can not have two
reference counted objects in the same structure and expect things to
work well.

> > Also, why a rw_semaphore?  Only use those if you can prove with a
> > benchmark that it is actually faster, otherwise it's simpler to just use
> > a normal mutex (hint, you are changing the fields in the structure with
> > the read lock held, which feels very wrong, and so needs a LOT of
> > documentation, or just use a normal mutex...)
> > 
> 
> It is needed so we can protect against underlaying device unloading while
> miscdevice is active, we use rw semaphore since we don't care about
> synchronization between any of the fops, but we want to protect current
> active ioctls and fops from sudden mlx5ctl_remove (auxiliary_driver.remove)
> which can happen dynamically due to underlaying device removal.

Then use a normal mutex.  Only use a rw lock if you can prove the
performance needs it as usually a rw lock is slower and more complex as
you then have to document stuff like:

> So here is the locking scheme:
> 
> write_lock() : only on mlx5_ctl remove and mark the device is down
> via assigning NULL to mcdev->dev, to let all new readers abort and to wait
> for current readers to finish their task.
> 
> read_lock(): used in all fops and ioctls, to make sure underlaying
> mlx5_core device is still active, and to prevent open files to access the
> device when miscdevice was already unregistered.
> 
> I agree, this should've been documented in the code, I will add
> documentation.

Just make it simple and use a normal mutex please.

And fix up the reference counting, it shouldn't be this complex, it's
just a "simple" misc device driver :)

But before you do that, please see my other email about why not using
devlink for all of this instead.

thanks,

greg k-h
