Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB27FE8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbjK3FcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjK3FcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:32:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF8D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:32:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151AFC433C7;
        Thu, 30 Nov 2023 05:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701322325;
        bh=pMAZRD6C2KxJP4HEAtpAIDxbTaSlvGsc71rh/SQWRtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzCN1zJVSMh+g5X7qRKecWziuXOdWr00FRIYi06EW39LWAwKZx05wqoCY3qOBN+FI
         rQUnlYiDyKD9a22jXTQtSUBuGXxEmyuBWzZTFv+e7jwBPyI5Qe1Nrk+/o1WVjpL4uX
         pmPh7lSAAQ80/hn/AhNV9ezx+cZYrnDeAh0ifTa6npt+0Ka6SDakf5SBrKTYnTC7u5
         YPfn6eRwh4GVevufSN/gXUaw3bIBXFcoNWM2tBonHNxnmVUJiqKUl1A5IQTD9COAEL
         3NPPQDKNiWlINy8sljZrtPDqJG7/3ulyf92erDT42KHQbXFlD06+WWiS7ACC3gp76r
         T/x+mREHM8E3Q==
Date:   Thu, 30 Nov 2023 11:01:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Message-ID: <20231130053157.GB3043@thinkpad>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
 <20231124100403.GA4536@thinkpad>
 <639d6008-bdfa-4b6e-b622-e916003ec908@quicinc.com>
 <20231128133252.GX3088@thinkpad>
 <5eb0a521-0b72-4d15-9a65-429c4c123833@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eb0a521-0b72-4d15-9a65-429c4c123833@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:29:07AM +0800, Qiang Yu wrote:
> 
> On 11/28/2023 9:32 PM, Manivannan Sadhasivam wrote:
> > On Mon, Nov 27, 2023 at 03:13:55PM +0800, Qiang Yu wrote:
> > > On 11/24/2023 6:04 PM, Manivannan Sadhasivam wrote:
> > > > On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
> > > > > Ensure read and write locks for the channel are not taken in succession by
> > > > > dropping the read lock from parse_xfer_event() such that a callback given
> > > > > to client can potentially queue buffers and acquire the write lock in that
> > > > > process. Any queueing of buffers should be done without channel read lock
> > > > > acquired as it can result in multiple locks and a soft lockup.
> > > > > 
> > > > Is this patch trying to fix an existing issue in client drivers or a potential
> > > > issue in the future drivers?
> > > > 
> > > > Even if you take care of disabled channels, "mhi_event->lock" acquired during
> > > > mhi_mark_stale_events() can cause deadlock, since event lock is already held by
> > > > mhi_ev_task().
> > > > 
> > > > I'd prefer not to open the window unless this patch is fixing a real issue.
> > > > 
> > > > - Mani
> > > In [PATCH v4 1/4] bus: mhi: host: Add spinlock to protect WP access when
> > > queueing
> > > TREs,  we add
> > > write_lock_bh(&mhi_chan->lock)/write_unlock_bh(&mhi_chan->lock)
> > > in mhi_gen_tre, which may be invoked as part of mhi_queue in client xfer
> > > callback,
> > > so we have to use read_unlock_bh(&mhi_chan->lock) here to avoid acquiring
> > > mhi_chan->lock
> > > twice.
> > > 
> > > Sorry for confusing you. Do you think we need to sqush this two patch into
> > > one?
> > Well, if patch 1 is introducing a potential deadlock, then we should fix patch
> > 1 itself and not introduce a follow up patch.
> > 
> > But there is one more issue that I pointed out in my previous reply.
> Sorry, I can not understand why "mhi_event->lock" acquired during
> mhi_mark_stale_events() can cause deadlock. In mhi_ev_task(), we will
> not invoke mhi_mark_stale_events(). Can you provide some interpretation?

Going by your theory that if a channel gets disabled while processing the event,
the process trying to disable the channel will try to acquire "mhi_event->lock"
which is already held by the process processing the event.

- Mani

> > 
> > Also, I'm planning to cleanup the locking mess within MHI in the coming days.
> > Perhaps we can revisit this series at that point of time. Will that be OK for
> > you?
> Sure, that will be great.
> > 
> > - Mani
> > 
> > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > > ---
> > > > >    drivers/bus/mhi/host/main.c | 4 ++++
> > > > >    1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > > > > index 6c6d253..c4215b0 100644
> > > > > --- a/drivers/bus/mhi/host/main.c
> > > > > +++ b/drivers/bus/mhi/host/main.c
> > > > > @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
> > > > >    			mhi_del_ring_element(mhi_cntrl, tre_ring);
> > > > >    			local_rp = tre_ring->rp;
> > > > > +			read_unlock_bh(&mhi_chan->lock);
> > > > > +
> > > > >    			/* notify client */
> > > > >    			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> > > > > @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
> > > > >    					kfree(buf_info->cb_buf);
> > > > >    				}
> > > > >    			}
> > > > > +
> > > > > +			read_lock_bh(&mhi_chan->lock);
> > > > >    		}
> > > > >    		break;
> > > > >    	} /* CC_EOT */
> > > > > -- 
> > > > > 2.7.4
> > > > > 
> > > > > 
> 

-- 
மணிவண்ணன் சதாசிவம்
