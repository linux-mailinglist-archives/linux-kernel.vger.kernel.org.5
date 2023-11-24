Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD27F70C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjKXKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbjKXKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:04:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082E91
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:04:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48068C433C8;
        Fri, 24 Nov 2023 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700820251;
        bh=odyegxK7uxxBKnGsjhd8OdJQcNHKmuTu63nAYxY3t2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fW/cmt1TnBYSriyoDoMYuXJEjNH09il9ygKQUnnl5ODH1Wr4IfG4Y93l6CbHMIkvU
         WdRO66wZVI6cOKxPozmzXAtliC+A0SXhgb3rANXFTcpI8DECN74dAXajeWG/4bgXVc
         hru+IlPXZuZ7As/Yj8pyZCrhdTzKJ9RnHGTzZoZke5XVwMKib7d/xeqhAKRqgrT7U5
         r07Hlt5ewNzEZTaxBK/Kqi+BRziZUliGYLT/327vvKele7g2dQpAif2AbkiQg5cQ+9
         ffFrzzCmaOUX3wv6lFkFY9+9myZABvN3CxMgW2FTRNEJVgUyifLQObqRDR0enfupJr
         D5aRl8/ymt0oA==
Date:   Fri, 24 Nov 2023 15:34:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Message-ID: <20231124100403.GA4536@thinkpad>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
> Ensure read and write locks for the channel are not taken in succession by
> dropping the read lock from parse_xfer_event() such that a callback given
> to client can potentially queue buffers and acquire the write lock in that
> process. Any queueing of buffers should be done without channel read lock
> acquired as it can result in multiple locks and a soft lockup.
> 

Is this patch trying to fix an existing issue in client drivers or a potential
issue in the future drivers?

Even if you take care of disabled channels, "mhi_event->lock" acquired during
mhi_mark_stale_events() can cause deadlock, since event lock is already held by
mhi_ev_task().

I'd prefer not to open the window unless this patch is fixing a real issue.

- Mani

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/bus/mhi/host/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 6c6d253..c4215b0 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  			mhi_del_ring_element(mhi_cntrl, tre_ring);
>  			local_rp = tre_ring->rp;
>  
> +			read_unlock_bh(&mhi_chan->lock);
> +
>  			/* notify client */
>  			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>  
> @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  					kfree(buf_info->cb_buf);
>  				}
>  			}
> +
> +			read_lock_bh(&mhi_chan->lock);
>  		}
>  		break;
>  	} /* CC_EOT */
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
