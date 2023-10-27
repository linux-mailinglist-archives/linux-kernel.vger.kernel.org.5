Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42337D9C64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbjJ0O6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0O6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:58:14 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6B5E510E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:58:12 -0700 (PDT)
Received: (qmail 571154 invoked by uid 1000); 27 Oct 2023 10:58:11 -0400
Date:   Fri, 27 Oct 2023 10:58:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jayant Chowdhary <jchowdhary@google.com>,
        Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <7c30f943-aaad-47dd-9ae3-02f1ca57e49b@rowland.harvard.edu>
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
 <20231027075117.GJ26306@pendragon.ideasonboard.com>
 <ZTuanepgXLXRoSMW@pengutronix.de>
 <20231027114752.GB12144@pendragon.ideasonboard.com>
 <ZTu9oEw1QEOxbHCf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTu9oEw1QEOxbHCf@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:39:44PM +0200, Michael Grzeschik wrote:
> On Fri, Oct 27, 2023 at 02:47:52PM +0300, Laurent Pinchart wrote:
> > On Fri, Oct 27, 2023 at 01:10:21PM +0200, Michael Grzeschik wrote:
> > > On Fri, Oct 27, 2023 at 10:51:17AM +0300, Laurent Pinchart wrote:
> > > > On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
> > > >> This patch is based on top of
> > > >> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
> > > >>
> > > >> When we use an async work queue to perform the function of pumping
> > > >> usb requests to the usb controller, it is possible that thread scheduling
> > > >> affects at what cadence we're able to pump requests. This could mean usb
> > > >> requests miss their uframes - resulting in video stream flickers on the host
> > > >> device.
> > > >>
> > > >> In this patch, we move the pumping of usb requests to
> > > >> 1) uvcg_video_complete() complete handler for both isoc + bulk
> > > >>    endpoints. We still send 0 length requests when there is no uvc buffer
> > > >>    available to encode.
> > > >
> > > > This means you will end up copying large amounts of data in interrupt
> > > > context. The work queue was there to avoid exactly that, as it will
> > > > introduce delays that can affect other parts of the system. I think this
> > > > is a problem.
> > > 
> > > Regarding Thin's argument about possible scheduling latency that is already
> > > introducing real errors, this seemed like a good solution.
> > > 
> > > But sure, this potential latency introduced in the interrupt context can
> > > trigger other side effects.
> > > 
> > > However I think we need some compromise since both arguments are very valid.
> > 
> > Agreed.
> > 
> > > Any ideas, how to solve this?
> > 
> > I'm afraid not.
> 
> We discussed this and came to the conclusion that we could make use of
> kthread_create and sched_setattr with an attr->sched_policy = SCHED_DEADLINE
> here instead of the workqueue. This way we would ensure that the worker
> would be triggered with hard definitions.
> 
> Since the SG case is not that heavy on the completion handler, we could
> also make this kthread conditionaly to the memcpy case.

If you don't mind a naive suggestion from someone who knows nothing 
about the driver...

An attractive possibility is to have the work queue (or kthread) do the 
time-consuming copying, but leave the submission up to the completion 
handler.  If the data isn't ready (or there's no data to send) when the 
handler runs, then queue a 0-length request.

That will give you the best of both worlds: low latency while in 
interrupt context and a steady, constant flow of USB transfers at all 
times.  The question of how to schedule the work queue or kthread is a 
separate matter, not directly relevant to this design decision.

Alan Stern
