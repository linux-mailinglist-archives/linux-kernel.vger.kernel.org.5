Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FE7DA537
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 07:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjJ1Fay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 01:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJ1Faw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 01:30:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6610A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 22:30:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C73C433C7;
        Sat, 28 Oct 2023 05:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698471049;
        bh=DAtpQvMGMBvuauUAWILOC1KqmmeeZ++9aiDqUvAqdrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jO2XJe1j/4bVAIJKcz+lj2mlLLvQJiVvCjeuPAzfVTpLFkoYH8cj+b+fOyqZ2P2bA
         znQG9GyLj5+1cFPsoZ05qggzL/s95rE72ti0ouqovxEEiZXvI5bTpVXzHKxWaYlS0A
         5YjOVEJ8lWU3/lR5pcMzTHlJ/BtRWQCUOnZrA4gA=
Date:   Sat, 28 Oct 2023 07:30:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     Dan Scally <dan.scally@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, etalvala@google.com,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de
Subject: Re: [PATCH v8 2/4] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Message-ID: <2023102823-embargo-envy-5fcb@gregkh>
References: <20231019185319.2714000-1-arakesh@google.com>
 <20231024183605.908253-1-arakesh@google.com>
 <20231024183605.908253-2-arakesh@google.com>
 <421d1996-8544-45ac-9f31-551ef597546c@ideasonboard.com>
 <1d3777ec-ac12-4a9a-a19c-fb7d5013a0a6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d3777ec-ac12-4a9a-a19c-fb7d5013a0a6@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 01:31:26PM -0700, Avichal Rakesh wrote:
> >> @@ -322,6 +325,7 @@ uvc_video_free_requests(struct uvc_video *video)
> >>   static int
> >>   uvc_video_alloc_requests(struct uvc_video *video)
> >>   {
> >> +    struct uvc_request *ureq;
> >>       unsigned int req_size;
> >>       unsigned int i;
> >>       int ret = -ENOMEM;
> >> @@ -332,29 +336,34 @@ uvc_video_alloc_requests(struct uvc_video *video)
> >>            * max_t(unsigned int, video->ep->maxburst, 1)
> >>            * (video->ep->mult);
> >>
> >> -    video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
> >> -    if (video->ureq == NULL)
> >> -        return -ENOMEM;
> >> +    INIT_LIST_HEAD(&video->ureqs);
> > 
> > 
> > Probably unecessary here; it's done in uvc_video_free_requests() and uvcg_video_init() already
> 
> Ah, that is fair. Added a BUG_ON instead, like we do for video->req_size
> so we still catch cases where the state might be inconsistent.

Please no, that means you just crashed a machine and all data is lost
and the user will get very mad.

Either handle the error properly or it's something that can never happen
and so you don't need to handle it.

thanks,

greg k-h
