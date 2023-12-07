Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA213809328
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443946AbjLGVMO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 16:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:12:12 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204AFE9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:12:18 -0800 (PST)
Received: from [192.168.2.4] (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000718A4.000000006572352F.0011AF64; Thu, 07 Dec 2023 22:12:15 +0100
Message-ID: <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
From:   Gergo Koteles <soyer@irl.hu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Thu, 07 Dec 2023 22:12:13 +0100
In-Reply-To: <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
         <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
         <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
         <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
         <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
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

On Thu, 2023-12-07 at 20:36 +0000, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 09:19:34PM +0100, Gergo Koteles wrote:
> > On Thu, 2023-12-07 at 18:20 +0000, Mark Brown wrote:
> > > On Thu, Dec 07, 2023 at 12:59:44AM +0100, Gergo Koteles wrote:
> 
> > > > The amp has 3 level addressing (BOOK, PAGE, REG).
> > > > The regcache couldn't handle it.
> 
> > > So the books aren't currently used so the driver actually works?
> 
> > It writes to the book 0 and 8c. The initialization works with regcache,
> > because it writes also the i2c devices.
> 
> I can't see any references to 0x8c in the driver?

The firmware has different programs. The programs have blocks, that the
driver writes to the amplifier. The address comes from the blocks.

> 
> > > >  static int tas2781_system_suspend(struct device *dev)
> > > > @@ -770,10 +758,7 @@ static int tas2781_system_suspend(struct device *dev)
> > > >  		return ret;
> > > >  
> > > >  	/* Shutdown chip before system suspend */
> > > > -	regcache_cache_only(tas_priv->regmap, false);
> > > >  	tasdevice_tuning_switch(tas_priv, 1);
> > > > -	regcache_cache_only(tas_priv->regmap, true);
> > > > -	regcache_mark_dirty(tas_priv->regmap);
> 
> > > How can this work over system suspend?  This just removes the cache with
> > > no replacement so if the device looses power over suspend (which seems
> > > likely) then all the register state will be lost.  A similar issue may
> > > potentially exist over runtime suspend on an ACPI system with
> > > sufficiently heavily optimised power management.
> 
> > In runtime_resume, only one of the two amplifiers goes back.
> > The runtime_suspend sets the current book/prog/conf to -1 on all
> > devices, and tas2781_hda_playback_hook will restore the
> > program/configuration/profile with tasdevice_tuning_switch.
> 
> What does "go back" mean?  

Sorry for imprecise wording. The speaker is silent, I didn't checked
why, maybe the amp is in error state or something.

> 
> > And only one, because tasdevice_change_chn_book directly changes the
> > address of i2c_client, so the unlucky one gets invalid values in its
> > actual book from regcache_sync.
> 
> The code creates the impression that writing to one tas2781 writes to
> all of them, is that not the case?
> 
Yes, the tasdevice_* functions, but the regcache_sync doesn't know
this.

> > system_restore doesn't work at all, because regcache_cache_only stays
> > true since system_suspend.
> 
> Presumably the next runtime resume would make the device writable again?
> 
Yes, then one of the speakers works.

> > It works without the regcache functions.
> 
> How would the devices get their configuration restored?
> 
tasdevice_tuning_switch calls tasdevice_select_tuningprm_cfg which
checks whether the devices needs a new program or configuration.

the runtime_suspend and system resume set the devices cur_prog,
cur_conf to -1.

for (i = 0; i < tas_hda->priv->ndev; i++) {
	tas_hda->priv->tasdevice[i].cur_book = -1;
	tas_hda->priv->tasdevice[i].cur_prog = -1;
	tas_hda->priv->tasdevice[i].cur_conf = -1;
}

And the tasdevice_select_tuningprm_cfg checks with 
if (tas_priv->tasdevice[i].cur_prog != prm_no ...

If needed, it writes the new program/configuration to the device.

The tas2781_hda_playback_hook calls the tasdevice_tuning_switch


> This sounds very much like a case of something working for your specific
> system in your specific test through some external factor rather than
> working by design, whatever problems might exist it seems fairly obvious
> to inspection that this patch would make things worse for other systems.
> 
> At a minimum this patch needs a much clearer changelog (all the patches
> I looked at could use clearer changelogs) which explains what's going on
> here, I would really expect to see something that replaces the use of
> the cache sync to restore the device state for example.

