Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2B8036C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjLDObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjLDObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:31:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0481BF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:30:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050E9C433C9;
        Mon,  4 Dec 2023 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701700213;
        bh=HepIBbswm0o0MnzZYI6lwCIFtvyrLOz9z11GZNHwKRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAlH3FzsUajB717UJjf9ABVSjhXzI+8b2KEodA0K2Rb/EojIbi9e7YjJI50Z/aF1j
         TwaX+N9z/rHshQgTibQeCoYMSlzrsodnl9U4sR4UashJPKtZGXSRN/CXnHv0TOmFmi
         2UGkh73v/n230yIbqb68kvx49oW2KatoUvveoNF/or3FTG3kNUe4pTtMxn9z07HrjG
         cQZwlqvH2gtaoYAPfwge512bF6AZLE+cioKMbQYhJnCeh5RPkA5fng2regUjCFUoQm
         25H2G4qaKTGutrkcILlblUyJoYRjl1ChUsenV+fF2PFnyTwEcwDyQGVuyFhNxkbp9H
         uz0HQLRkV9xEQ==
Date:   Mon, 4 Dec 2023 14:30:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
Message-ID: <20231204143005.7a564326@jic23-huawei>
In-Reply-To: <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
        <20231126172607.379c9d79@jic23-huawei>
        <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 09:48:08 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 11/26/23 19:26, Jonathan Cameron wrote:
> > On Tue, 31 Oct 2023 11:50:46 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The GTS helpers do flooring of scale when calculating available scales.
> >> This results available-scales to be reported smaller than they should
> >> when the division in scale computation resulted remainder greater than
> >> half of the divider. (decimal part of result > 0.5)
> >>
> >> Furthermore, when gains are computed based on scale, the gain resulting
> >> from the scale computation is also floored. As a consequence the
> >> floored scales reported by available scales may not match the gains that
> >> can be set.
> >>
> >> The related discussion can be found from:
> >> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
> >>
> >> Do rounding when computing scales and gains.
> >>
> >> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Hi Matti,
> > 
> > A few questions inline about the maths.  
> 
> I appreciate the questions :) Thanks!

I found some emails hiding so late replies...
> >   
> >>
> >> ---
> >> Subjahit, is there any chance you test this patch with your driver? Can
> >> you drop the:
> >> 	if (val2 % 10)
> >> 		val2 += 1;
> >> from scale setting and do you see written and read scales matching?
> >>
> >> I did run a few Kunit tests on this change - but I'm still a bit jumpy
> >> on it... Reviewing/testing is highly appreciated!
> >>
> >> Just in case someone is interested in seeing the Kunit tests, they're
> >> somewhat unpolished & crude and can emit noisy debug prints - but can
> >> anyways be found from:
> >> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
> >>
> >> ---
> >>   drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
> >>   1 file changed, 50 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> >> index 7653261d2dc2..7dc144ac10c8 100644
> >> --- a/drivers/iio/industrialio-gts-helper.c
> >> +++ b/drivers/iio/industrialio-gts-helper.c
> >> @@ -18,6 +18,32 @@
> >>   #include <linux/iio/iio-gts-helper.h>
> >>   #include <linux/iio/types.h>
> >>   
> >> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
> >> +{
> >> +	unsigned int full32 = (unsigned int) full;
> >> +	unsigned int rem;
> >> +	int result;
> >> +
> >> +	if (full == (u64)full32) {
> >> +		unsigned int rem;
> >> +
> >> +		result = full32 / scale;
> >> +		rem = full32 - scale * result;
> >> +		if (rem >= scale / 2)
> >> +			result++;
> >> +
> >> +		return result;
> >> +	}
> >> +
> >> +	rem = do_div(full, scale);  
> > 
> > As below, can we just add scale/2 to full in the do_div?  
> 
> The rationale for doing is it in this way is to prevent (theoretical?) 
> overflow when adding scale/2 to full. Maybe this warrants adding a comment?

Hmm. Chances are very low of hitting that.  I'd just go with adding scale/2
before the div.  If you really want to worry about being right at the edge
of available precision, then add a check for that.


> 
> >   
> >> +	if ((u64)rem >= scale / 2)
> >> +		result = full + 1;
> >> +	else
> >> +		result = full;
> >> +
> >> +	return result;
> >> +}
> >> +
> >>   /**
> >>    * iio_gts_get_gain - Convert scale to total gain
> >>    *
> >> @@ -28,30 +54,42 @@
> >>    *		scale is 64 100 000 000.
> >>    * @scale:	Linearized scale to compute the gain for.
> >>    *
> >> - * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
> >> + * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
> >>    *		is invalid.
> >>    */
> >>   static int iio_gts_get_gain(const u64 max, const u64 scale)
> >>   {
> >> -	u64 full = max;
> >> +	u64 full = max, half_div;
> >> +	unsigned int scale32 = (unsigned int) scale;
> >>   	int tmp = 1;
> >>   
> >> -	if (scale > full || !scale)
> >> +	if (scale / 2 > full || !scale)  
> > 
> > Seems odd. Why are we checking scale / 2 here?  
> 
> I am pretty sure I have been thinking of rounding 0.5 to 1.

Not sure I follow - but maybe it'll be clear in v2.

> >   
> >> +
> >> +	while (full + half_div >= scale * (u64)tmp)
> >>   		tmp++;
> >>   
> >> -	return tmp;
> >> +	return tmp - 1;
> >>   }
> >>   
> >>   /**
> >> @@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale_nano,
> >>    * Convert the total gain value to scale. NOTE: This does not separate gain
> >>    * generated by HW-gain or integration time. It is up to caller to decide what
> >>    * part of the total gain is due to integration time and what due to HW-gain.
> >> + * Computed gain is rounded to nearest integer.
> >>    *
> >>    * Return: 0 on success. Negative errno on failure.
> >>    */
> >> @@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
> >>   				int *scale_int, int *scale_nano)
> >>   {
> >>   	u64 tmp;
> >> +	int rem;
> >>   
> >>   	tmp = gts->max_scale;
> >>   
> >> -	do_div(tmp, total_gain);
> >> +	rem = do_div(tmp, total_gain);  
> > 
> > can we do usual trick of
> > do_div(tmp + total_gain/2, total_gain)
> > to get the same rounding effect?  
> 
> Only if we don't care about the case where tmp + total_gain/2 overflows.

As above. The cases where that happens are pretty narrow.  I'd not worry about it
or I'd check for that overflow.

> 
> >   
> >> +	if (total_gain > 1 && rem >= total_gain / 2)
> >> +		tmp += 1ULL;
> >>   
> >>   	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
> >>   }
> >> @@ -192,7 +234,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> >>   		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
> >>   		     NULL);
> >>   
> >> -		/* Convert gains to scales */
> >> +		/* Convert gains to scales. */  
> > 
> > Grumble - unrelated change.  
> 
> Yes. I'll drop this.
> 
> >   
> >>   		for (j = 0; j < gts->num_hwgain; j++) {
> >>   			ret = iio_gts_total_gain_to_scale(gts, gains[i][j],
> >>   							  &scales[i][2 * j],
> >>
> >> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa  
> 
> All in all, I am still not 100% sure if rounding is the right ambition. 
> Do we cause hidden accuracy issues by doing the rounding under the hood? 
> I feel I need bigger brains :)
Don't we all!

Jonathan

> 
> Yours,
> 	-- Matti
> 
> 

