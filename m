Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118180B1E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjLIDTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:19:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92360ED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 19:19:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96368C433C8;
        Sat,  9 Dec 2023 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702091957;
        bh=SLaF6IE1Yn5LfSEved29p+6U9oFQ5UxNbVEWHYgWroI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWGblCDCoYH1Yt3S514ZcwZfMnwlKoOox75g1Hwe0D9a05eO3Ij375MDOVH00cfB7
         F9GSmpPY0qsgPlVdlD+BztWy3UrErQrwLV7Sb+RamBia2AZhc5BoMS3LNzqHt2P/oj
         zdRy6OVi6ZQLYJ9S3OH7WBv5qbbhhkJLpH87zkVHCovy+4WW29Q1kmcr0oeSSAD8kh
         R0r3cCDTMx5MIjBaE/M3V39vUVWRV+ZrpCvEI+oUa32tAIt75g7dGNp7pJ+e3gIvZl
         YXnTMSVQhTMGzNCy5T39kX9AbHITYWHzuNle2XYqjG/zcD6+arijgJs+bJSEyf91Ho
         MqaSQYU20KGfQ==
Date:   Fri, 8 Dec 2023 19:23:51 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Bjorn Andersson' <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] soc: qcom: stats: Fix division issue on 32-bit platforms
Message-ID: <i6umadq3losoudlpdpj3pst2gizevwlvqgohcewcaanvu2svow@ojionieh722v>
References: <20231205-qcom_stats-aeabi_uldivmod-fix-v1-1-f94ecec5e894@quicinc.com>
 <e59bb661054945f7a77b2f67c70d30f7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e59bb661054945f7a77b2f67c70d30f7@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 02:07:16PM +0000, David Laight wrote:
> From: Bjorn Andersson
> > Sent: 06 December 2023 00:44
> > 
> > commit 'e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")' made it
> > in with a mult_frac() which causes link errors on Arm and PowerPC
> > builds:
> > 
> >   ERROR: modpost: "__aeabi_uldivmod" [drivers/soc/qcom/qcom_stats.ko] undefined!
> > 
> > Expand the mult_frac() to avoid this problem.
> > 
> > Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  drivers/soc/qcom/qcom_stats.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> > index 4763d62a8cb0..5ba61232313e 100644
> > --- a/drivers/soc/qcom/qcom_stats.c
> > +++ b/drivers/soc/qcom/qcom_stats.c
> > @@ -221,7 +221,8 @@ static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
> > 
> >  	for (i = 0; i < ddr.entry_count; i++) {
> >  		/* Convert the period to ms */
> > -		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
> > +		entry[i].dur *= MSEC_PER_SEC;
> > +		entry[i].dur = div_u64(entry[i].dur, ARCH_TIMER_FREQ);
> 
> Is that right?
> At a guess mult_frac(a, b, c) is doing a 32x32 multiply and then a 64x32
> divide to generate a 32bit result.
> So I'd guess entry[i].dur is 32bit? (this code isn't in -rc4 ...).
> Which means you are now discarding the high bits.
> 

entry[i].dur is 64 bit, so this should work just fine.

Arnd proposed that as ARCH_TIMER_FREQ is evenly divisible by
MSEC_PER_SEC we just div_u64(dur, ARCH_TIMER_FREQ / MSEC_PER_SEC), and I
picked that patch instead.

> You've also added a very slow 64bit divide.

Without checking the generated code, I'd expect this to be a slow 64-bit
division already. But this is a debug function, so it should be fine to
take that penalty.

> A multiple by reciprocal calculation will be much better.
> Since absolute accuracy almost certainly doesn't matter here convert:
> 	dur * 1000 / FREQ
> to
> 	(dur * (u32)(1000ull << 32 / FREQ)) >> 32
> which will be fine provided FREQ >= 1000
> 

I'm quite sure you're right regarding the accuracy. I think as this
isn't in a hot path, the more readable div_u64() feels like a reasonable
choice.

Thank you for your input and suggestion though!

Regards,
Bjorn

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
