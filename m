Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816BC78E18D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjH3VmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbjH3VmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8610C1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693431573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9rN+XvG3W5MtI1zkWYv3XAxym9MPbLYYoSUuqke5xI=;
        b=dcDC6T+Fw2xAA9htneO2nIB6vm/1lMvkBO6NajaqwNbpTnYUY/WifZ0B8mgxjKx6B/DAfg
        6mx/96h7Ntn4wqCjcGO9td7AK3GJE3JtCBKrNwZnZGRAX6jvCx/ZHHQIwtoZ2/+TtqRg8s
        C3DoUGUrgcXfmrDeHaL6M4ToQjsAHGE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-glDDiIOLNl2uJAThJvos-Q-1; Wed, 30 Aug 2023 16:50:31 -0400
X-MC-Unique: glDDiIOLNl2uJAThJvos-Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-64aa2ddc31aso2005296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428630; x=1694033430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9rN+XvG3W5MtI1zkWYv3XAxym9MPbLYYoSUuqke5xI=;
        b=YjnYcwMHHLHzl907rDDyXaut7jzxzMzrW71EU5bM0clE3Mutx5rt6PgFzEr9hwsW2Y
         n7ATSHc8lEiZGuOpkgfmhSkCfp5K5J73fzHCmNPLra5tUhPylvmj97SlI+55Zp5+CEnb
         35tfDP6HVPT83O/g35HEkUJgLMlGRscI8v+rSbrAO7Jle74e/hdbxYo6F4q9Zj7StDiO
         qMwC3xjyn109se9GWwzQfTIM8F284B2lKzXsQlD8/Reo0PpUXO8wT58itIo7/YYorIU0
         2737+tcmIwj53zUeh5r4LHyiVwtUZiKPwE2dWKQ3BuVb5GWLkiSm6gTzlCl7hxCfaPOJ
         VXZw==
X-Gm-Message-State: AOJu0YzLLE3mUSeAX7xzZhixe9gH1fy7dTL4ZiTGyjydvOG732lnOjds
        pFgZ7u1hDX8f6DplShvb2UQtbrn4J54UO1TuDs5vUEIeCDcwTn61jexpcBET/W3uCfIceuIg0aS
        ThZjuwUCJ0BT8x7atzvT+tgHh
X-Received: by 2002:a05:6214:2129:b0:64f:51fe:859c with SMTP id r9-20020a056214212900b0064f51fe859cmr1323820qvc.43.1693428630643;
        Wed, 30 Aug 2023 13:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFyH2l1IUSesBjXsZ4wZZY3c12bBagQeWqFAJ/4NNfxQsYl+zCfIno1rc7oHhyxyt8nj4Pg==
X-Received: by 2002:a05:6214:2129:b0:64f:51fe:859c with SMTP id r9-20020a056214212900b0064f51fe859cmr1323800qvc.43.1693428630339;
        Wed, 30 Aug 2023 13:50:30 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::49])
        by smtp.gmail.com with ESMTPSA id n8-20020a0ce488000000b0063f82020d8bsm4325999qvl.60.2023.08.30.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:50:29 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:50:27 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: stmmac: Fix comment about default
 addend calculation
Message-ID: <5yyadzbyph637rh3i5h4caogck2uwwbf23iufdqhr5ltmmzwjw@iv7ld65nrn4g>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
 <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
 <krvdz4filnpzhdy7tjkaisa2uzeh2sjzc2krno2rns24ldka37@abay33wdcck4>
 <matyki35liqllsiokgn4xrfxabk4wzelif56vtlkvauhkpssor@ohy5a25yk6ja>
 <b5jay65dndlpzdu7qjxa5ty5vudz62h3xosiu7mjdjvzieoylq@sk7h7erb25bd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5jay65dndlpzdu7qjxa5ty5vudz62h3xosiu7mjdjvzieoylq@sk7h7erb25bd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:16:31PM +0300, Serge Semin wrote:
> On Tue, Aug 29, 2023 at 10:01:20AM -0500, Andrew Halaney wrote:
> > On Sun, Aug 27, 2023 at 03:02:07AM +0300, Serge Semin wrote:
> > > Hi Andrew
> > > 
> > > On Thu, Aug 24, 2023 at 01:32:57PM -0500, Andrew Halaney wrote:
> > > > The comment neglects that freq_div_ratio is the ratio between
> > > > the subsecond increment frequency and the clk_ptp_rate frequency.
> > > > 
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index dfead0df6163..64185753865f 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
> > > >  	/* Store sub second increment for later use */
> > > >  	priv->sub_second_inc = sub_second_inc;
> > > >  
> > > 
> > > > -	/* calculate default addend value:
> > > > -	 * formula is :
> > > > -	 * addend = (2^32)/freq_div_ratio;
> > > > -	 * where, freq_div_ratio = 1e9ns/sub_second_inc
> > > > +	/* Calculate default addend so the accumulator overflows (2^32) in
> > > > +	 * sub_second_inc (ns). The addend is added to the accumulator
> > > > +	 * every clk_ptp cycle.
> > > > +	 *
> > > > +	 * addend = (2^32) / freq_div_ratio
> > > > +	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
> > > >  	 */
> > > >  	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
> > > >  	temp = temp << 32;
> > > 
> > > I am not well familiar with the way PTP works but at my naked eyes the
> > > calculation implemented here looks a bit different than what is
> > > described in the comment.
> > > 
> > > Basically config_sub_second_increment(clk_ptp_rate, sub_second_inc)
> > > returns clk_ptp_rate period in nanoseconds or twice that period, or have it
> > > scaled up on 0.465. So we have one of the next formulae:
> > > X1 = NSEC_PER_SEC / clk_ptp_rate
> > > X2 = 2 * NSEC_PER_SEC / clk_ptp_rate
> > > X3 = X1 / 0.465
> > > X4 = X2 / 0.465
> > 
> 
> > X5 = PTP_SSIR_SSINC_MAX (0xFF) is a case as well to consider
> 
> I noticed that option too, but then I thought it must have been not
> that much probable to be considered as a real case seeing it's a
> boundary case. The clamping happens if
> if (X1 > 255 || X2 > 255 || X3 > 255 || X4 > 255)
> 	X5 = 255
> so in the worst case PTP-rate period in nanoseconds multiplied by 4.3
> must be greater than 255 which is equivalent to X1 >= 60. It means
> PTP clock rate must be greater than 16.6MHz to avoid the clamping. In
> the best case - 3.9MHz. I doubted that these limits are crossed in
> reality. But in anyways you are right saying that it still needs to be
> taken into account in case if the implemented algo would be a subject
> for optimizations.
> 
> > > 
> > > Then stmmac_init_tstamp_counter() handles the retrieved period in the
> > > next manner:
> > > temp = div_u64(NSEC_PER_SEC, sub_second_inc);     // Convert back to frequency
> > > temp = temp << 32;                                // multiply by 2^32
> > > addend = div_u64(temp, priv->plat->clk_ptp_rate); // Divide by clk_ptp_rate
> > > 
> > > The code above is equivalent:
> > > 
> > > addend = ((NSEC_PER_SEC / X) * 2^32 ) / clk_ptp_rate = 
> > >          (2^32 * NSEC_PER_SEC / X) / clk_ptp_rate = 
> > >          2^32 / (clk_ptp_rate / (NSEC_PER_SEC / X))
> > > 
> > > AFAICS this doesn't match to what is in the comment (X = sub_second_inc).
> > > freq_div_ratio gets to be inverted. Does it?
> > 
> 
> > You're right, my comment needs to be inverted to match all of the above
> > (which is a great recap, thank you!).
> 
> Good. Then an hour spent for decyphering of that stuff wasn't a waste
> of time after all.)
> 
> > 
> > > 
> > > Substituting X to the formulae above we'll have just four possible results:
> > > addend1 = 2^32
> > > addend2 = 2^32 / 2
> > > addend3 = 0.465 * 2^32
> > > addend4 = 0.465 * 2^32 / 2
> >
> > addend5 = 2^32 / (clk_ptp_rate / (NSEC_PER_SEC / 0xFF))
> > 
> > I think that would be the PTP_SSIR_SSINC_MAX case (X5) I inserted above
> > 
> > > 
> > > So basically clk_ptp_rate is irrelevant (neglecting all the
> > > integer divisions rounding). Is that what implied by the implemented
> > > algo?
> > > 
> > > Am I missing something? (it's quite possible since it's long past
> > > midnight already.)
> > 
> > I believe you've captured everything, minus the one conditional I added.
> > 
> > I think because of that conditional we can't just nicely code up some
> > contants here independent of sub_second_inc. Now I can blame the morning
> > and not enough coffee, do you see anything wrong with that thought
> 
> I am not that much aware of the PTP internals but it just seems weird
> to have clk_ptp_rate not affecting anything except the boundary case.
> Do you have a DW *MAC HW databook with the PTP-engine chapter
> describing the way the System Time Register Module works?

Unfortunately I do not have that documentation (or admittedly much
experience in the area).

> 
> > process? I'm all ears for suggestions for cleaning this up, especially
> > since others like Richard have indicated that it could use some love,
> 
> * I would have said more definitive - some _hard_ love.)
> 
> > but right now I'm hung up thinking the best I can do is fix the bad
> > comment in this patch.
> 
> Just at the first very swift glance:
> 1. See attached patch.
> 2. Exporting stmmac_init_tstamp_counter() isn't necessary. It doesn't
> seem like being utilized anywhere except in the stmmac_main.c module.
> 3. stmmac_hwtimestamp-based abstraction seems redundant since: just a
> single PTP implementation is provided; DW GMAC, DW XGMAC and DW QoS
> Eth PTP implementations don't seem like very much different (XGMAC and
> QoS Eth seems to have some additional features but the basics looks
> the same). Moreover developing a HW-abstraction without having all the
> IP-core databooks at hands and having at least two different engines
> description seems like a needless over-complication of the code. I
> have doubts it was possible to create a comprehensive enough
> sub-module to be suitable for the real and any other not yet known PTP
> engine.)
> 4. For the same reason as 2. splitting up the PTP support into two
> files seems redundant. stmmac_hwtstamp.c content can be moved to
> stmmac_ptp.c .
> 5. ...
> 
> 3 and 5 imply bulky and delicate work which I would have attempted
> only after much deeper PTP engine studying in all the DW *MAC IP-cores
> (I might have missed something) and only having a real PTP-charged
> device at hands.
> 

Thanks, this is a good list to brainstorm with. I agree 3 and 5 might
not be advisable for someone who doesn't have good mastery over the
hardware, etc.

