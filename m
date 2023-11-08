Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5447A7E5B09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjKHQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:20:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664CB1FE4;
        Wed,  8 Nov 2023 08:20:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778FFC433C8;
        Wed,  8 Nov 2023 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699460456;
        bh=1c0TPr9Mh1z2jbt+QY5QF7YVZL0tMNZzUWR+SxoLkcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/M4VcXAJbdWulLibWK3e5pU1/Sqdh2BXeuKOMkAPQSSNoIAyw1HsAqY1+v7ezYTd
         d3cBl3hDzBCUArZforg1wRj3lg0/zwJsH2qBNo1XjkdVcbH1QCl7J92nI0ekSSpdQx
         srHqL3a+82blq2uV7Ua5bQRQn5pioJDHmY9Am2bI=
Date:   Wed, 8 Nov 2023 17:20:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <2023110839-jam-relapsing-7f5d@gregkh>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
> > >>
> > >> In fpga_region_get() / fpga_region_put(): call get_device() before
> > >> acquiring the mutex and put_device() after having released the mutex
> > >> to avoid races.

Why do you need another reference count with a lock?  You already have
that with the calls to get/put_device().

> > > Could you help elaborate more about the race?
> > > 
> > 
> > I accidentally misused the word race. My concern was that memory might
> > be released after the last put_device(), causing mutex_unlock() to be
> > called on a mutex that does not exist anymore. It should not happen
> > for the moment since the region does not use devres, but I think it
> > still makes the code more brittle.
> 
> It makes sense.
> 
> But I dislike the mutex itself. The purpose is to exclusively grab the
> device, but a mutex is too much heavy for this.

Why "heavy"?  Is this a fast-path?  Have you measured it?

> The lock/unlock of mutex
> scattered in different functions is also an uncommon style. Maybe some
> atomic count should be enough.

Don't make a fake lock with an atomic variable, use real locks if you
need it.

Or don't even care about module unloading at all!  Why does it matter?
It can never happen without explicit intervention and it's something
that a lot of the time, just will cause problems.  Don't do a lot of
extra work for something that doesn't matter.

thanks,

greg k-h
