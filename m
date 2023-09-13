Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B779F37F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjIMVL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:11:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 059DB1720
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:11:22 -0700 (PDT)
Received: (qmail 969791 invoked by uid 1000); 13 Sep 2023 17:11:22 -0400
Date:   Wed, 13 Sep 2023 17:11:22 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Randy Li <ayaka@soulik.info>, linux-usb@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: USB: DMA: mapping existing buffer is not supported?
Message-ID: <52643326-3a43-43b3-9be1-f13a255a7fc8@rowland.harvard.edu>
References: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
 <2023091323-trombone-storeroom-cbd3@gregkh>
 <c0f75cbb-4d5d-0954-4bb6-20a82cfe5e2f@soulik.info>
 <2023091306-affection-lifter-3d9d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023091306-affection-lifter-3d9d@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:32:12PM +0200, Greg KH wrote:
> On Thu, Sep 14, 2023 at 04:09:06AM +0800, Randy Li wrote:
> > 
> > On 2023/9/14 03:19, Greg KH wrote:
> > > On Thu, Sep 14, 2023 at 03:06:58AM +0800, Randy Li wrote:
> > > > Hello
> > > > 
> > > > I was trying to understand why USB webcams (UVC) have to copy video data
> > > > through the CPU (uvc_video_complete() schedules uvc_video_copy_data_work()
> > > > for this purpose). During my investigation, I noticed that functions
> > > > like|usb_sg_*() and |usb_buffer_*() are not available since kernel version
> > > > 2.6.12.
> > > What do you mean by "not available"?  I see them in the tree today, why
> > > do you think they are not present?
> > > 
> > usb_buffer_dmasync_sg(), usb_buffer_map(), usb_buffer_dmasync() and usb_buffer_unmap() are all disabled
> > by #if 0 in include/usb/usb.h
> > 
> > usb_buffer_map_sg() and usb_buffer_unmap_sg() are just declaration without definition.
> 
> Sorry, I was looking at the usb_sg_* calls, those are there if you want
> to use them.
> 
> But again, why not just use the normal sg field in the urb itself for
> the scatter-gather pointer?  Will that not work for you?
> 
> > > > If the USB subsystem can no longer work with existing buffers, I propose
> > > > that we consider removing the remaining documentation in the "Working with
> > > > existing buffers" section of Documentation/driver-api/usb/dma.rst.
> > > I don't understand, what is wrong with the information there exactly?
> > > Have you tried following the suggestions there?
> > Besides my answer to first question, I found no code use them today.

That's exactly what it says at the end of the file:

----------------------------------------------------------------------------
Note that several of those interfaces are currently commented out, since
they don't have current users.  See the source code.  Other than the dmasync
calls (where the underlying DMA primitives have changed), most of them can
easily be commented back in if you want to use them.
----------------------------------------------------------------------------

So Randy, the answer to your question is that those routines are not 
available any more because nothing needs to use them.  If you would like 
to submit a patch removing the "Working with existing buffers" section 
from the documentation file, feel free to do so.

Alan Stern
