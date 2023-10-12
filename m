Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117027C7888
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443009AbjJLVVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443010AbjJLVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:21:02 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E37BE;
        Thu, 12 Oct 2023 14:21:00 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4S62cT30VwzCT;
        Thu, 12 Oct 2023 23:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1697145658; bh=TaFBxjLod3uos3quRT45Zb/J+JK5WWkvgFBpk4JPSEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3vS/REggArqteGlr9HGCH5hE+NNntBKcU1JhqPMggIKfY4K8p2o6auKIptfIP4jA
         jIp39nMRAP9qPeg57o3mqc0Dc+UBL1wCDWoLrCXx0IxWklAUSiyYeyI7bYDWA9Jmp/
         ukto59bZzrjHBwqFyrdHJSViqfz6VHB72G9ZNYJr2TbBUSrgnnRNsRp4ESwtJl2RXe
         u8JPM7mHdD3JMVJ7EdePsRVmJMSjjPO5UJ+mcSsCK2hWN0rYIu8GRFl2gzcOgFBXec
         0/f10TvlpDLx50aTTqY8ZMfbEq45i1OjlX/FDOAstT7cVvWCpawvwnP7tC6OfmFpgV
         IdcuNZ1R1ezxg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date:   Thu, 12 Oct 2023 23:20:55 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: chipidea: Simplify Tegra DMA alignment code
Message-ID: <ZShjNzj-8wR1f3qu@qmqm.qmqm.pl>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
 <a0d917d492b1f91ee0019e68b8e8bca9c585393f.1695934946.git.mirq-linux@rere.qmqm.pl>
 <ZScZWFJCCMr7oWwX@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZScZWFJCCMr7oWwX@orome.fritz.box>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:53:28PM +0200, Thierry Reding wrote:
> On Thu, Sep 28, 2023 at 11:06:03PM +0200, Micha³ Miros³aw wrote:
> > The USB host on Tegra3 works with 32-bit alignment. Previous code tried
> > to align the buffer, but it did align the wrapper struct instead, so
> > the buffer was at a constant offset of 8 bytes (two pointers) from
> > expected alignment.  Since kmalloc() guarantees at least 8-byte
> > alignment already, the alignment-extending is removed.
> > 
> > Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/usb/chipidea/host.c | 45 +++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index abddd39d1ff1..0cce19208370 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -30,8 +30,7 @@ struct ehci_ci_priv {
> >  };
> >  
> >  struct ci_hdrc_dma_aligned_buffer {
> > -	void *kmalloc_ptr;
> > -	void *old_xfer_buffer;
> > +	void *original_buffer;
> >  	u8 data[];
> >  };
> >  
> > @@ -380,60 +379,52 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
> >  	return 0;
> >  }
> >  
> > -static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb)
> > +static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb, bool copy_back)
> >  {
> >  	struct ci_hdrc_dma_aligned_buffer *temp;
> > -	size_t length;
> >  
> >  	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
> >  		return;
> > +	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
> 
> This threw me off a bit until I realized it was already there
> previously, just in a different place. Is there a particular reason why
> this is moved?

I figured that it is easier to understand if the test and clear of the
URB_ALIGNED_TEMP_BUFFER bit is in a single place. Seeing it again, I
think it could be replaced with __test_and_clear_bit() in a future commit.

Best Regards
Micha³ Miros³aw
