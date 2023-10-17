Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5887CCBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbjJQTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJQTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:15:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B9ED;
        Tue, 17 Oct 2023 12:15:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67603C433CB;
        Tue, 17 Oct 2023 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697570115;
        bh=1FH2NiT0/UIAW9o7PfkE2WEJ0KQQ/92RAQnCv8fQwU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GP6aDR68d48jUNYRKmDRMWXr5sPPdyOqLEW+eRRXOP4EspT4tJvRHdvqYo2a05LKk
         w83cFu2uDn+3f3MiB3xgZT6fJEmbYr38RksEcy8/MPlYbQ2k91pdLYWNChkMr55KaV
         RAVBci/zZS7ToXiZh5Ydphq0gsKZDxXvnnEr3Byg/HNoQeQ4ZrPxegnwcP+kAbSybZ
         a8rtWGQivfZ6h0lc1H8Mih40VDdqxkaW36nT+g69xcVD7qZAEVlHOd77Q8czePIIju
         GCR6AJvfasZijj2KwMpZ4SCfTJ0W16yZtjefzYc+CsxKdTfWPHci5zTHw718OCaICl
         uTVnaRiLHbjig==
Date:   Tue, 17 Oct 2023 20:15:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin.Lai@quantatw.com, patrickw3@meta.com
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Message-ID: <20231017201346.2f4f6b01@jic23-huawei>
In-Reply-To: <SG2PR06MB33657B698EDFC3D6937997938BD6A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
        <20230930174501.039095da@jic23-huawei>
        <SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
        <20231002103940.00001dbd@Huawei.com>
        <SG2PR06MB336557EDAAE2950D192E40838BCBA@SG2PR06MB3365.apcprd06.prod.outlook.com>
        <20231005150753.38e79c20@jic23-huawei>
        <SG2PR06MB33657B698EDFC3D6937997938BD6A@SG2PR06MB3365.apcprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 11:10:54 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> > > > > > > Create event sysfs for applying the deglitch condition. When
> > > > > > > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
> > > > > > > the driver will use the in_voltageY_thresh_rising_value and
> > > > > > > in_voltageY_thresh_falling_value as threshold values. If the ADC value
> > > > > > > falls outside this threshold, the driver will wait for the ADC sampling
> > > > > > > period and perform an additional read once to achieve the deglitching
> > > > > > > purpose.
> > > > > > >
> > > > > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> > > > >  
> > > > > > Hi Billy  
> > > > >  
> > > > > > This is pushing the meaning of the events interface too far.
> > > > > > You can't use it to hide a value you don't like from userspace.  
> > > > >  
> > > > > > If you can explain what the condition is that you are seeing
> > > > > > and what you need to prevent happening if it is seen that would help
> > > > > > us figure out if there is another way to do this.  
> > > > >  
> > > > > > Jonathan  
> > > > >
> > > > > Hi Jonathan,
> > > > >
> > > > > Currently, we are experiencing some voltage glitches while reading from our
> > > > > controller, but we do not wish to report these false alarms to the user space.
> > > > > Instead, we want to retry the operation as soon as possible. This is why the
> > > > > driver requires this patch to handle retries internally, rather than relying on user
> > > > > space which could introduce unpredictable timing for retrying the reading process.
> > > > > This software approach aims to minimize the possibility of false alarms as much as possible.  
> > >  
> > > > Thanks for the extra detail. Perhaps share more of that in the cover letter for v2.  
> > >
> > > Okay, I will incorporate more details into my commit message for v2.
> > >  
> > > > >
> > > > > If you have any suggestions or recommendations regarding this situation, please feel free to
> > > > > share them with me.  
> > >  
> > > > Why do you need userspace control for the thresholds?
> > > > Perhaps this is something that belongs in DT for a particular board design?  
> > >
> > > If the input voltage remains constant, these settings can be incorporated into the DTS properties for configuring the threshold. However, if the input voltage is subject to change, adding user-space control may offer more flexibility.  
> 
> > My concern is that it's an interface userspace probably won't know how to use, or
> > will misuse given this seems to be papering over bad hardware.  
> 
> > If there is a 'safe' value to put in DT I'd prefer to see that. I guess it might be per
> > channel thing to adjust for different expected voltage ranges?  
> 
> Yes, the voltage ranges should be adjusted based on each individual channel.
> I'm not entirely sure what you mean by the term 'safe' value. 
> Are you suggesting that a DTS property should be used to constrain the threshold ranges? Or someting else?
> From my point of view, I think misusing this feature will only increase the sampling period of the ADC values and decrease the sensitivity.
> As the name of this feature , it is primarily used to eliminate or mitigate glitches in readings.
> 
Note a good choice of wording from me.  I meant, for a given design (and hence DTS)
is there a reasonable value that will work for all instances of that design?

If there is it is a characteristic of the board design and should be in DT.
If there isn't, how do you calibrate it for individual devices?

Jonathan

> Thanks
> 
> 
> 

