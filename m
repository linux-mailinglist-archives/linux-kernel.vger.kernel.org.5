Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C1A79F2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjIMUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIMUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:32:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C31BC6;
        Wed, 13 Sep 2023 13:32:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31378C433C7;
        Wed, 13 Sep 2023 20:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694637135;
        bh=uY+EB846F61CVw8N9dFpG1XQqtaFWYaybWPzlomSKaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY81LAsQEBg6NW9vY0d0R/w4li29m0xY3wqU138w79z3CSIUdMNBVdR6CcFMiyjps
         E7/koIxPZyApqe4VL+Tq6A3IXGxVkyCmD5qXh4FvuVe1HEN67xx+2ZVJFahzFMeyV9
         fYhxUhF/UADPH1lOeEq4t7BCl6+bRjOdZs2qaGcY=
Date:   Wed, 13 Sep 2023 22:32:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-usb@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: USB: DMA: mapping existing buffer is not supported?
Message-ID: <2023091306-affection-lifter-3d9d@gregkh>
References: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
 <2023091323-trombone-storeroom-cbd3@gregkh>
 <c0f75cbb-4d5d-0954-4bb6-20a82cfe5e2f@soulik.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0f75cbb-4d5d-0954-4bb6-20a82cfe5e2f@soulik.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:09:06AM +0800, Randy Li wrote:
> 
> On 2023/9/14 03:19, Greg KH wrote:
> > On Thu, Sep 14, 2023 at 03:06:58AM +0800, Randy Li wrote:
> > > Hello
> > > 
> > > I was trying to understand why USB webcams (UVC) have to copy video data
> > > through the CPU (uvc_video_complete() schedules uvc_video_copy_data_work()
> > > for this purpose). During my investigation, I noticed that functions
> > > like|usb_sg_*() and |usb_buffer_*() are not available since kernel version
> > > 2.6.12.
> > What do you mean by "not available"?  I see them in the tree today, why
> > do you think they are not present?
> > 
> usb_buffer_dmasync_sg(), usb_buffer_map(), usb_buffer_dmasync() and usb_buffer_unmap() are all disabled
> by #if 0 in include/usb/usb.h
> 
> usb_buffer_map_sg() and usb_buffer_unmap_sg() are just declaration without definition.

Sorry, I was looking at the usb_sg_* calls, those are there if you want
to use them.

But again, why not just use the normal sg field in the urb itself for
the scatter-gather pointer?  Will that not work for you?

> > > If the USB subsystem can no longer work with existing buffers, I propose
> > > that we consider removing the remaining documentation in the "Working with
> > > existing buffers" section of Documentation/driver-api/usb/dma.rst.
> > I don't understand, what is wrong with the information there exactly?
> > Have you tried following the suggestions there?
> Besides my answer to first question, I found no code use them today.

The old-style usb-storage driver uses the usb_sg_* calls, and the uas.c
driver uses the sg fields and provides line-speed transfers (the speed
limit is in the device, not the kernel).

thanks,

greg k-h
