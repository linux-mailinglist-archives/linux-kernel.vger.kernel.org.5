Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7219805B85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjLEQ7v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 11:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLEQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:59:49 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1CB83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:59:55 -0800 (PST)
Received: from [192.168.2.4] (51b68398.dsl.pool.telekom.hu [::ffff:81.182.131.152])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071509.00000000656F5709.00116505; Tue, 05 Dec 2023 17:59:52 +0100
Message-ID: <9c3846ae0da417c0fe5d4fa2d9d4134143184dda.camel@irl.hu>
Subject: Re: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
From:   Gergo Koteles <soyer@irl.hu>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Tue, 05 Dec 2023 17:59:52 +0100
In-Reply-To: <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
References: <cover.1701733441.git.soyer@irl.hu>
         <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
         <90765ee0-a814-4852-9b2a-020cda98d930@linux.intel.com>
         <974d41f6c703d9b65ebcd75a2c659cecf13bd877.camel@irl.hu>
         <a530e70a-2491-4270-b582-cd493d1512b1@linux.intel.com>
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

On Tue, 2023-12-05 at 10:01 -0600, Pierre-Louis Bossart wrote:
> > > > +
> > > > +static void tas2563_fixup_i2c(struct hda_codec *cdc,
> > > > +	const struct hda_fixup *fix, int action)
> > > > +{
> > > > +	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
> > > 
> > > Any specific reason to use an Intel ACPI identifier? Why not use
> > > "TIAS2563" ?
> > > 
> > INT8866 is in the ACPI.
> > I don't know why Lenovo uses this name.
> > I think it's more internal than intel.
> > 
> >    Scope (_SB.I2CD)
> >     {
> >         Device (TAS)
> >         {
> >             Name (_HID, "INT8866")  // _HID: Hardware ID
> 
> Ouch, I hope they checked with Intel that this isn't an HID already in
> use...
> 
It looks the INT prefix is not reserved. (yet)
https://uefi.org/ACPI_ID_List?acpi_search=INT

> > 
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct dev_pm_ops tas2563_hda_pm_ops = {
> > > > +	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
> > > 
> > > where's the pm_runtime stuff?
> > > 
> > 
> > The amp stores its state in software shutdown mode.
> > The tas2563_hda_playback_hook wakes/shutdowns the amp, not the
> > pm_runtime.
> 
> My point was that you have all these pm_runtime_ calls in the code, but
> nothing that provides pm_runtime suspend-resume functions so not sure
> what exactly the result is?
> 
> 
I think nothing. I haven't experienced anything unusual recently.



