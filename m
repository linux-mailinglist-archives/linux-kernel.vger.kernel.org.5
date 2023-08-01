Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC01076A7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHAEoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHAEoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFDE10C7;
        Mon, 31 Jul 2023 21:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 750B761291;
        Tue,  1 Aug 2023 04:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7C5C433C8;
        Tue,  1 Aug 2023 04:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690865040;
        bh=GjKxAXGP2fKgPoDAoWw83ehKfw7SlLEc4M0e89fOPiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8O3nyeM0AMZiXnYX0AoDHRnq4zfo0vJyJ6dzhbcI0J93lY0sqLVVxBaIBTeQMpPc
         waQSRhp9l1X1aaUEVrDs4Ci89XxyQnzZhvdKdRP2PjYQlzLe4P+8a7KPm9czHrKBmF
         7onO7P5feclOx0fwZdFCi5RmOqz6zhEGSGb+WfXY=
Date:   Tue, 1 Aug 2023 06:43:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elson Serrao <quic_eserrao@quicinc.com>
Cc:     Surong Pang <surong.pang@unisoc.com>, Thinh.Nguyen@synopsys.com,
        felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org,
        Orson.Zhai@unisoc.com, Chunyan.Zhang@unisoc.com,
        Zhiyong.liu@unisoc.com, Surong.Pang@gmail.com
Subject: Re: [PATCH V2] usb: dwc3: gadget: Let pm runtime get/put paired
Message-ID: <2023080128-bubble-frosty-92c8@gregkh>
References: <20230801011548.30232-1-surong.pang@unisoc.com>
 <e8d9652f-3b81-319a-7ca6-9b656eac6f40@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d9652f-3b81-319a-7ca6-9b656eac6f40@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:33:04PM -0700, Elson Serrao wrote:
> 
> 
> On 7/31/2023 6:15 PM, Surong Pang wrote:
> > Pm_runtime_get is called when setting pending_events to true.
> > Pm_runtime_put is needed for pairing with pm_runtime_get.
> > 
> > Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
> > Signed-off-by: Surong Pang <surong.pang@unisoc.com>
> > 
> > ---
> > V2: add Fixes tag, fix Fixes tag
> > ---
> >   drivers/usb/dwc3/gadget.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 5fd067151fbf..9c835c5f9928 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -4720,5 +4720,6 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
> >   		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
> >   		dwc->pending_events = false;
> >   		enable_irq(dwc->irq_gadget);
> > +		pm_runtime_put(dwc->dev);
> >   	}
> >   }
> 
> I am already handling this change as part of below series. Will be uploading
> a separate patch based on the feedback from Roger.
> 
> https://lore.kernel.org/all/be57511d-2005-a1f5-d5a5-809e71029aec@quicinc.com/

But this should be fixed now, and properly backported to stable kernels.
There's no need to wait for a different patch series if this one is
correct, right?

thanks,

greg k-h
