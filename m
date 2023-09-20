Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCD37A72CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjITGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:34:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4FD99D;
        Tue, 19 Sep 2023 23:33:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0E52680E0;
        Wed, 20 Sep 2023 06:33:55 +0000 (UTC)
Date:   Wed, 20 Sep 2023 09:33:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Message-ID: <20230920063353.GQ5285@atomide.com>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Péter Ujfalusi <peter.ujfalusi@gmail.com> [230919 18:25]:
> 
> 
> On 7/5/23 22:03, Andreas Kemnade wrote:
> > Commit 349355ce3a05 ("ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp")
> > dropped prcm_fck for omap4,

The prcm_fck should be there in the dts for each mcbsp interconnect targe
module as "fck" alias and get's enabled/disabled when the mcbsp driver
calls runtime PM.

So maybe the description should explain that things broke as the aliases
for prcm_fck and pad_ck no longer get added.

> it also dropped the pad_fck for that matter.

OK so an alias is needed for that too.

That's the MCPDM_CLKCTRL pad_clks_ck alias, right? Seems like the
pad_clks_ck should be claimed by the mcpdm and mcbsp drivers if they are
used? I guess it would be for some external device use case?

> > so the clk_src might not be >available making the
> > clk_get(src) fail.
> 
> Wow, so OMAP4 audio is pretty broken if would ever need to select FCLK?
> By default we don't on OMAP4, but this is astonishing.

So sounds like we just got lucky because of -ENOSUCHUSERS? The mcbsp works
for me, not sure how come I'm not seeing this issue, does it now only work
for the default clock source?

Do we have some other examples for devices using other type of clocking?

> > In such cases, rely on the devicetree to assign
> > the correct parent.
> 
> You cannot rely on DT to dynamically select the FCLK parent for
> different use cases.
> The dai_set_dai_sysclk() cannot select between internal or external
> source of the reference clock and DT cannot handle this.
> If one sampling frequency is available with pad_fck while other is only
> possible with internal clock then this is no longer possible.

If the functional clock source needs to be changed, seems things
should work. The parent interconnect target module driver does not care
about the fck rate. Not sure if the clock usage count causes issues
though with reparenting, if so, sounds like reparenting needs to be
done in runtime PM suspended state to do the switch.

> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  sound/soc/ti/omap-mcbsp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> > index 21fa7b9787997..f9fe96b61852b 100644
> > --- a/sound/soc/ti/omap-mcbsp.c
> > +++ b/sound/soc/ti/omap-mcbsp.c
> > @@ -70,8 +70,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
> >  
> >  	fck_src = clk_get(mcbsp->dev, src);
> >  	if (IS_ERR(fck_src)) {
> > -		dev_err(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
> > -		return -EINVAL;
> > +		dev_info(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
> > +		return 0;
> 
> I would rather have some clock alias for OMAP4/5 to provide the clocks
> that we need for the fclk.
> If we did not got the clock we needed to select we cannot say that all
> is good, carry on.
> Normally the machine driver does this and it thinks that we switched
> clocks while we did not and the clocking is all wrong now.

How about someting like below to deal with getting the fck in a bit more
future proof way:

fck_src = clk_get(mcbsp->dev, src);
if (IS_ERR(fck_src)) {
	fck_src = clk_get(mcbsp->dev->parent, "fck):
	...
}

Also sounds like we should also add the missing the aliases too like Peter
pointed out if mcbsp driver needs to reparent. But just adding the alias
will possibly cause trouble for anybody adding mcbsp support for some other
SoC variant.

To me it seems in the long run the mcbsp configurations using pad_fck
should configure it in the dts for the interconnect target module node
instead as the default clock. Then mcbsp can still look up the fck
of the parent device, and change it dynamically as needed.

Regards,

Tony
