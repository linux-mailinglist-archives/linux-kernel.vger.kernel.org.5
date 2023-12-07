Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1680922B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443897AbjLGUTe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 15:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:19:33 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD41717
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:19:39 -0800 (PST)
Received: from [192.168.2.4] (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070A5A.00000000657228D7.0011AE34; Thu, 07 Dec 2023 21:19:35 +0100
Message-ID: <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
From:   Gergo Koteles <soyer@irl.hu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Thu, 07 Dec 2023 21:19:34 +0100
In-Reply-To: <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
         <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
         <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-07 at 18:20 +0000, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 12:59:44AM +0100, Gergo Koteles wrote:
> 
> > The amp has 3 level addressing (BOOK, PAGE, REG).
> > The regcache couldn't handle it.
> 
> So the books aren't currently used so the driver actually works?
> 
It writes to the book 0 and 8c. The initialization works with regcache,
because it writes also the i2c devices.

> >  static int tas2781_system_suspend(struct device *dev)
> > @@ -770,10 +758,7 @@ static int tas2781_system_suspend(struct device *dev)
> >  		return ret;
> >  
> >  	/* Shutdown chip before system suspend */
> > -	regcache_cache_only(tas_priv->regmap, false);
> >  	tasdevice_tuning_switch(tas_priv, 1);
> > -	regcache_cache_only(tas_priv->regmap, true);
> > -	regcache_mark_dirty(tas_priv->regmap);
> >  
> >  	/*
> >  	 * Reset GPIO may be shared, so cannot reset here.
> 
> How can this work over system suspend?  This just removes the cache with
> no replacement so if the device looses power over suspend (which seems
> likely) then all the register state will be lost.  A similar issue may
> potentially exist over runtime suspend on an ACPI system with
> sufficiently heavily optimised power management.

In runtime_resume, only one of the two amplifiers goes back.
The runtime_suspend sets the current book/prog/conf to -1 on all
devices, and tas2781_hda_playback_hook will restore the
program/configuration/profile with tasdevice_tuning_switch.

And only one, because tasdevice_change_chn_book directly changes the
address of i2c_client, so the unlucky one gets invalid values in its
actual book from regcache_sync.

system_restore doesn't work at all, because regcache_cache_only stays
true since system_suspend.

It works without the regcache functions.


