Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC68080F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjLGGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:43:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F570D5E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:43:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5281EC433C8;
        Thu,  7 Dec 2023 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701931438;
        bh=sksjh5ChWPYyf6bJcZNzXZ+iAfli+dlUwRYAmrfj+b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGCUCUWcJvKOTVj4/UhBQV3+duLk5NBfUf+iBvA/pGMddZAWUFejwRoenQGTdiFB8
         jh3kowD1Pnm6Y/BuPrZuLzUM/0IlVy4VxiTCRJYLj0ZboHlug/kXfpOlUJWlck0nc0
         lAwwqhESwBEk9co5FBp8wS9GfL7tgr2LVcOAf40ZTi7kWsH0PFu7/JqOv9KLj1s6vZ
         tT5z1tgp5f2gxpJrq3BF/kxMEDeUphwCHrjd5XhLNqO00heAon9kWeCm56H6dICLqw
         rTYxrnUaXEv+iy4TyvAorx8f4EaB2h8mCYjBV+SyYGi6V4qFADgQ2aD01PUZqQIURi
         SIQ3TfWsrZIXQ==
Date:   Thu, 7 Dec 2023 12:13:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Message-ID: <20231207064347.GE2932@thinkpad>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
 <20231124100403.GA4536@thinkpad>
 <639d6008-bdfa-4b6e-b622-e916003ec908@quicinc.com>
 <20231128133252.GX3088@thinkpad>
 <5eb0a521-0b72-4d15-9a65-429c4c123833@quicinc.com>
 <20231130053157.GB3043@thinkpad>
 <9873ee7b-7ef1-4327-8e22-49e1cd3872f1@quicinc.com>
 <20231206134848.GG12802@thinkpad>
 <947af144-e2a2-49bc-9f39-31f6ee5b1aa1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <947af144-e2a2-49bc-9f39-31f6ee5b1aa1@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:27:19PM +0800, Qiang Yu wrote:
> 
> On 12/6/2023 9:48 PM, Manivannan Sadhasivam wrote:
> > On Wed, Dec 06, 2023 at 10:25:12AM +0800, Qiang Yu wrote:
> > > On 11/30/2023 1:31 PM, Manivannan Sadhasivam wrote:
> > > > On Wed, Nov 29, 2023 at 11:29:07AM +0800, Qiang Yu wrote:
> > > > > On 11/28/2023 9:32 PM, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Nov 27, 2023 at 03:13:55PM +0800, Qiang Yu wrote:
> > > > > > > On 11/24/2023 6:04 PM, Manivannan Sadhasivam wrote:
> > > > > > > > On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
> > > > > > > > > Ensure read and write locks for the channel are not taken in succession by
> > > > > > > > > dropping the read lock from parse_xfer_event() such that a callback given
> > > > > > > > > to client can potentially queue buffers and acquire the write lock in that
> > > > > > > > > process. Any queueing of buffers should be done without channel read lock
> > > > > > > > > acquired as it can result in multiple locks and a soft lockup.
> > > > > > > > > 
> > > > > > > > Is this patch trying to fix an existing issue in client drivers or a potential
> > > > > > > > issue in the future drivers?
> > > > > > > > 
> > > > > > > > Even if you take care of disabled channels, "mhi_event->lock" acquired during
> > > > > > > > mhi_mark_stale_events() can cause deadlock, since event lock is already held by
> > > > > > > > mhi_ev_task().
> > > > > > > > 
> > > > > > > > I'd prefer not to open the window unless this patch is fixing a real issue.
> > > > > > > > 
> > > > > > > > - Mani
> > > > > > > In [PATCH v4 1/4] bus: mhi: host: Add spinlock to protect WP access when
> > > > > > > queueing
> > > > > > > TREs,  we add
> > > > > > > write_lock_bh(&mhi_chan->lock)/write_unlock_bh(&mhi_chan->lock)
> > > > > > > in mhi_gen_tre, which may be invoked as part of mhi_queue in client xfer
> > > > > > > callback,
> > > > > > > so we have to use read_unlock_bh(&mhi_chan->lock) here to avoid acquiring
> > > > > > > mhi_chan->lock
> > > > > > > twice.
> > > > > > > 
> > > > > > > Sorry for confusing you. Do you think we need to sqush this two patch into
> > > > > > > one?
> > > > > > Well, if patch 1 is introducing a potential deadlock, then we should fix patch
> > > > > > 1 itself and not introduce a follow up patch.
> > > > > > 
> > > > > > But there is one more issue that I pointed out in my previous reply.
> > > > > Sorry, I can not understand why "mhi_event->lock" acquired during
> > > > > mhi_mark_stale_events() can cause deadlock. In mhi_ev_task(), we will
> > > > > not invoke mhi_mark_stale_events(). Can you provide some interpretation?
> > > > Going by your theory that if a channel gets disabled while processing the event,
> > > > the process trying to disable the channel will try to acquire "mhi_event->lock"
> > > > which is already held by the process processing the event.
> > > > 
> > > > - Mani
> > > OK, I get you. Thank you for kind explanation. Hopefully I didn't intrude
> > > too much.
> > Not at all. Btw, did you actually encounter any issue that this patch is trying
> > to fix? Or just fixing based on code inspection.
> > 
> > - Mani
> Yes, we actually meet the race issue in downstream driver. But I can not
> find more details about the issue.

Hmm. I think it is OK to accept this patch and ignore the channel disabling
concern since the event lock is in place to prevent that. There would be no
deadlock as I mentioned above, since the process that is parsing the xfer event
is not the one that is going to disable the channel in parallel.

Could you please respin this series dropping patch 3/4 and also addressing the
issue I mentioned in patch 4/4?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
