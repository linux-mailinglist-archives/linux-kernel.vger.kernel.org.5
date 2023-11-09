Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BC7E6454
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjKIHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjKIHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C00271F;
        Wed,  8 Nov 2023 23:30:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE60AC433C7;
        Thu,  9 Nov 2023 07:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699515013;
        bh=FA3I58jU0wFxNV8uXganb4fGiYQhPijI/pg4Lq7JIz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBB4lTjtqObDudXAPQ5ggKg62fOtfqvJgyZuLFSAMbD5h4x+rieC0Qs7i07wYIYdA
         TYr2IYya9lVKeMJmLvQleOg4E+jR/Sk/0ArueekVX3zrNnooqPFq63MJAedinMHCrG
         m24NHJT5+UA+IQbASzYl33wOMcyIVdI+fnj3rnGw=
Date:   Thu, 9 Nov 2023 08:30:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <2023110918-showroom-choosy-ad14@gregkh>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <2023110839-jam-relapsing-7f5d@gregkh>
 <ZUxpHk/8pCusjXOb@yilunxu-OptiPlex-7050>
 <2023110922-lurk-subdivide-4962@gregkh>
 <ZUyHSs+oI9AsQdZE@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyHSs+oI9AsQdZE@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:16:26PM +0800, Xu Yilun wrote:
> On Thu, Nov 09, 2023 at 06:27:24AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 09, 2023 at 01:07:42PM +0800, Xu Yilun wrote:
> > > On Wed, Nov 08, 2023 at 05:20:53PM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
> > > > > > >>
> > > > > > >> In fpga_region_get() / fpga_region_put(): call get_device() before
> > > > > > >> acquiring the mutex and put_device() after having released the mutex
> > > > > > >> to avoid races.
> > > > 
> > > > Why do you need another reference count with a lock?  You already have
> > > > that with the calls to get/put_device().
> > > 
> > > The low-level driver module could still be possibly unloaded at the same
> > > time, if so, when FPGA core run some callbacks provided by low-level driver
> > > module, its referenced page of code is unmapped...
> > 
> > Then something is designed wrong here, the unloading of the low-level
> > driver should remove the access to the device itself.  Perhaps fix that?
> 
> Actually the low-level driver module on its own has no way to garantee its
> own code page of callbacks not accessed. It *is* accessing its code page
> when it tries (to release) any protection.

It is not up to the low-level driver to do this, it's up to the code
that calls into it (i.e. the fpga core code) to handle the proper
reference counting.

> Core code must help, and something like file_operations.owner is an
> effective way.

Yes, that should be all that you need.

thanks,

greg k-h
