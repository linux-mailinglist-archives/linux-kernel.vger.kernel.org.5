Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113437578AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGRJ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjGRJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:57:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99261735;
        Tue, 18 Jul 2023 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689674189; x=1721210189;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kT+WCGrXIntkSsi5bhLytk40kQrUFODgYPeYw5k0HEc=;
  b=auZQ3noyM/lkFfLBiUNfkzT7eHLN9LlLp+5leHYFqSltEVgUj+nO9Lw6
   hj3WVDCVbxM3vzQv7R5EO0etMgu/Lt7y88eQgRbfbUWfm1qByW15sfReG
   wdNeDWLTygCEgMi6ar7rpmjEEyMaReYHuKEU7VgUGux5i3pVt2tQW3gT8
   Gs9ahjb8jYvrhNCUWFCv1jv8mTKynBx3cgHuEhIXm/IZQnoVP7tD7TapX
   W4e8yU1accLGmkKruBVSw+sMbnV3zVCW66UMdhSejbHmA5JYfdjgn8RHc
   fkZY56Sa0KHgWQL5MHNLRy4kDd6I5gEk5C10xBOjpT7C9oTEtYAh+mV5X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368804780"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="368804780"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 02:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="673847895"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="673847895"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.252.47.53])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 02:56:26 -0700
Date:   Tue, 18 Jul 2023 12:56:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shenwei.wang@nxp.com, linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix possible integer overflow
In-Reply-To: <3652da4b-8ccf-34a8-bdb7-757a3109ac54@kernel.org>
Message-ID: <e0fe2036-e22-3bb4-a5a-afab1a5869e@linux.intel.com>
References: <20230718065645.6588-1-sherry.sun@nxp.com> <3652da4b-8ccf-34a8-bdb7-757a3109ac54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Jiri Slaby wrote:

> On 18. 07. 23, 8:56, Sherry Sun wrote:
> > This patch addresses the following Coverity report, fix it by casting
> > sport->port.frame_time to type u64.
> > 
> > CID 32305660: Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)
> > Potentially overflowing expression sport->port.frame_time * 8U with type
> > unsigned int (32 bits, unsigned) is evaluated using 32-bit arithmetic,
> > and then used in a context that expects an expression of type u64 (64
> > bits, unsigned).
> > 
> > Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based EOP
> > logic")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >   drivers/tty/serial/fsl_lpuart.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c
> > index c1980ea52666..07b3b26732db 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1373,7 +1373,7 @@ static inline int lpuart_start_rx_dma(struct
> > lpuart_port *sport)
> >     	sport->last_residue = 0;
> >   	sport->dma_rx_timeout = max(nsecs_to_jiffies(
> > -		sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
> > +		(u64)sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
> 
> Can you explain how that can overflow? In the worst case (1 start bit, 8 data
> bits, 2 stop bits, parity bit, address bit, 50 bauds), frame_time would
> contain:
> 13*1e9/50 = 260,000,000. (260 ms)
> 
> Then the multiplication above is:
> 260,000,000*8 = 2,080,000,000. (2 seconds)
> 
> which is still less than 2^32-1.

I was wondering the same thing.

This isn't a real bug. All findings from code analysis tools must be 
carefully evaluated to filter wheat out of chaff and this falls into the 
latter category. Please make sure next time you understand and explain 
also in the changelog how the problem can be manifested for real before 
sending this kind of patches.


-- 
 i.
