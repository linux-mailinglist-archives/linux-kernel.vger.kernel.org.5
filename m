Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD87FBBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbjK1Ncy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjK1Ncx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:32:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF94A0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:33:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4029EC433C8;
        Tue, 28 Nov 2023 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701178379;
        bh=rVPeT5nmw8qQQiIaFmZSBajpfC/FLGYEM+kVR8C6eHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfuRN5v73BRdDwtDvjVqEUkAx+rPfYn3oODDhKDz0wCkZ0zFl69z2eutxwvQFVs7C
         Mv92SCFYOLddDui4lzfsEeyOftKENRBdUN/xgoOPwAjXkXW9UevjxziO30/4cYKAu8
         GcblBt8q280nOqbtevoOV4V5uK8jq4C/hOPK230N/19LtVMBZmoe/XcXHsSGSCRXLZ
         E6uFiToI0W+CqdbJzCH4LyDd389+WqEBgRJiJyLKFMyzylCPIIiHqSjTb6MZkPgn8z
         OjMr5p9S3dCjdjlnifW/BrSMLWBxwf9zIAkTOAi8BcmMLPRSHEKNbtsMrBWYevmcyp
         oulf8qynZq4mw==
Date:   Tue, 28 Nov 2023 19:02:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Message-ID: <20231128133252.GX3088@thinkpad>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
 <20231124100403.GA4536@thinkpad>
 <639d6008-bdfa-4b6e-b622-e916003ec908@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <639d6008-bdfa-4b6e-b622-e916003ec908@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:13:55PM +0800, Qiang Yu wrote:
> 
> On 11/24/2023 6:04 PM, Manivannan Sadhasivam wrote:
> > On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
> > > Ensure read and write locks for the channel are not taken in succession by
> > > dropping the read lock from parse_xfer_event() such that a callback given
> > > to client can potentially queue buffers and acquire the write lock in that
> > > process. Any queueing of buffers should be done without channel read lock
> > > acquired as it can result in multiple locks and a soft lockup.
> > > 
> > Is this patch trying to fix an existing issue in client drivers or a potential
> > issue in the future drivers?
> > 
> > Even if you take care of disabled channels, "mhi_event->lock" acquired during
> > mhi_mark_stale_events() can cause deadlock, since event lock is already held by
> > mhi_ev_task().
> > 
> > I'd prefer not to open the window unless this patch is fixing a real issue.
> > 
> > - Mani
> In [PATCH v4 1/4] bus: mhi: host: Add spinlock to protect WP access when
> queueing
> TREs,  we add
> write_lock_bh(&mhi_chan->lock)/write_unlock_bh(&mhi_chan->lock)
> in mhi_gen_tre, which may be invoked as part of mhi_queue in client xfer
> callback,
> so we have to use read_unlock_bh(&mhi_chan->lock) here to avoid acquiring
> mhi_chan->lock
> twice.
> 
> Sorry for confusing you. Do you think we need to sqush this two patch into
> one?

Well, if patch 1 is introducing a potential deadlock, then we should fix patch
1 itself and not introduce a follow up patch.

But there is one more issue that I pointed out in my previous reply.

Also, I'm planning to cleanup the locking mess within MHI in the coming days.
Perhaps we can revisit this series at that point of time. Will that be OK for
you?

- Mani

> > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > ---
> > >   drivers/bus/mhi/host/main.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > > index 6c6d253..c4215b0 100644
> > > --- a/drivers/bus/mhi/host/main.c
> > > +++ b/drivers/bus/mhi/host/main.c
> > > @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
> > >   			mhi_del_ring_element(mhi_cntrl, tre_ring);
> > >   			local_rp = tre_ring->rp;
> > > +			read_unlock_bh(&mhi_chan->lock);
> > > +
> > >   			/* notify client */
> > >   			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
> > > @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
> > >   					kfree(buf_info->cb_buf);
> > >   				}
> > >   			}
> > > +
> > > +			read_lock_bh(&mhi_chan->lock);
> > >   		}
> > >   		break;
> > >   	} /* CC_EOT */
> > > -- 
> > > 2.7.4
> > > 
> > > 
> 

-- 
மணிவண்ணன் சதாசிவம்
