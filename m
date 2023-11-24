Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55077F74A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjKXNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjKXNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:16:34 -0500
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFCD71;
        Fri, 24 Nov 2023 05:16:39 -0800 (PST)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Fri, 24 Nov 2023 14:16:19 +0100
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
        ; Fri, 24 Nov 2023 14:16:18 +0100
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 24 Nov 2023 14:16:19 +0100
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 24 Nov 2023 14:16:19 +0100
Date:   Fri, 24 Nov 2023 14:16:19 +0100
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2 stable-6.1] dmaengine: at_hdmac: get next dma
 transfer from the right list
In-Reply-To: <ZWCcvK5L9vHwSfb2@matsya>
Message-ID: <ce621979-8fcc-4f43-9090-74849fb488f3@pcs.com>
References: <15c92c2f-71e7-f4fd-b90b-412ab53e5a25@pcs.com> <ZWCcvK5L9vHwSfb2@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 24.11.2023 11:04:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for your answer.

I was marking the patches as RFC and for stable 6.1 only.
Between 6.1 and mainline, at_hdmac was ported to use virt-dma, there is 
no possibility for my patches to go to mainline and being backported.
Most likely they are no longer needed in recent kernels.

Kind regards,
Thomas

On Fri, 24 Nov 2023, Vinod Koul wrote:

> On 14-11-23, 13:22, Thomas Pfaff wrote:
> > From: Thomas Pfaff <tpfaff@pcs.com>
> > 
> > In kernel 6.1, atc_advance_work and atc_handle_error are checking for the 
> > next dma transfer inside active list, but the descriptor is taken from the 
> > queue instead.
> 
> Sorry that is not how this works. Please send the patch for mainline and
> add a stable tag to the patches. They will be backported to stable
> kernels
> 
> Also, your patch threading is broken, they appear disjoint and not as a
> series
> 
> Thanks
> 
> > 
> > Signed-off-by: Thomas Pfaff <tpfaff@pcs.com>
> > ---
> > diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> > index 858bd64f1313..68c1bfbefc5c 100644
> > --- a/drivers/dma/at_hdmac.c
> > +++ b/drivers/dma/at_hdmac.c
> > @@ -490,6 +490,27 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
> >  	}
> >  }
> >  
> > +/**
> > + * atc_start_next - start next pending transaction if any
> > + * @atchan: channel where the transaction ended
> > + *
> > + * Called with atchan->lock held
> > + */
> > +static void atc_start_next(struct at_dma_chan *atchan)
> > +{
> > +	struct at_desc *desc = NULL;
> > +
> > +	if (!list_empty(&atchan->active_list))
> > +		desc = atc_first_active(atchan);
> > +	else if (!list_empty(&atchan->queue)) {
> > +		desc = atc_first_queued(atchan);
> > +		list_move_tail(&desc->desc_node, &atchan->active_list);
> > +	}
> > +
> > +	if (desc)
> > +		atc_dostart(atchan, desc);
> > +}
> > +
> >  /**
> >   * atc_advance_work - at the end of a transaction, move forward
> >   * @atchan: channel where the transaction ended
> > @@ -513,11 +534,7 @@ static void atc_advance_work(struct at_dma_chan *atchan)
> >  
> >  	/* advance work */
> >  	spin_lock_irqsave(&atchan->lock, flags);
> > -	if (!list_empty(&atchan->active_list)) {
> > -		desc = atc_first_queued(atchan);
> > -		list_move_tail(&desc->desc_node, &atchan->active_list);
> > -		atc_dostart(atchan, desc);
> > -	}
> > +	atc_start_next(atchan);
> >  	spin_unlock_irqrestore(&atchan->lock, flags);
> >  }
> >  
> > @@ -529,7 +546,6 @@ static void atc_advance_work(struct at_dma_chan *atchan)
> >  static void atc_handle_error(struct at_dma_chan *atchan)
> >  {
> >  	struct at_desc *bad_desc;
> > -	struct at_desc *desc;
> >  	struct at_desc *child;
> >  	unsigned long flags;
> >  
> > @@ -543,11 +559,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
> >  	list_del_init(&bad_desc->desc_node);
> >  
> >  	/* Try to restart the controller */
> > -	if (!list_empty(&atchan->active_list)) {
> > -		desc = atc_first_queued(atchan);
> > -		list_move_tail(&desc->desc_node, &atchan->active_list);
> > -		atc_dostart(atchan, desc);
> > -	}
> > +	atc_start_next(atchan);
> >  
> >  	/*
> >  	 * KERN_CRITICAL may seem harsh, but since this only happens
> > 
> 
> -- 
> ~Vinod
> 
> 


