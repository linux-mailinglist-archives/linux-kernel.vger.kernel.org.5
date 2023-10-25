Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76A7D60DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJYE0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjJYE0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:26:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC1128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:26:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso4125589a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 21:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698207961; x=1698812761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za7DSIsf0XenCFTrSCDflHfGP3tAJPbntu3DLdDZiWE=;
        b=CWVeB3cb7MrJ5VmJJSI1XyH4LK3b19ZBPkVyG7g7vAjpfSm6bFTaH96NkccB3EAPNk
         NZwKA5pOe0W5q6aMrql8WOGBljOI5CBNPlFQ+yTNnj4YwUcVdsu3CLh+advoAqqj9vbj
         eHGMnitoNy9RqKSaXSs9JD0FWIEXuelGgcT7oEHeC4gsRxNn34gfefOgTrEb+VY9vYz4
         wI+nJ3ryxEvVvA9jqyjiWxynSogq2V3GuRqQ7ILSTZKXtOEGROmh5hNXJPQMzgvxhP5j
         BNGs/KPmaCunzLySL3V5vqP++BsRrGaNDDyZUcbwo5XhOyjPIf0beynf9P8Ft7TW36cf
         jyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207961; x=1698812761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za7DSIsf0XenCFTrSCDflHfGP3tAJPbntu3DLdDZiWE=;
        b=ftr/u28b0H65LjlxiV6uLSczoSXx3sK8NO18aU92IsLhdIdXvycS9qFRNFh2YeeAUc
         47KTcueGPblKBFhEz8J3ZrMXlk1tiNsOBp8q9UqoA10V+G9AY2m2PwdYZLRpoTdmt/dJ
         D/SsPf6xqCWFVfWUsp+sS3+KXWJFPHUDpaYHR+xvVkS2rGSzjp9j95XwEbl4INkOeZu4
         B4MbJSYTAx231sDOCbV0vWbgD6yDoHfqD77APNMQWaQu4/h7NGCN/O9DmsvEaa2WTKVN
         xIPe1HaO9EuKUxmJCQn4kU4CcgFU2xGk+58mQeRCNpx/cgELBq7CkIGwbPbDPRxpM5Is
         RcGg==
X-Gm-Message-State: AOJu0Yy5k4GOgnjLzlhfPplEQDKcrpbhK9YRBZIsvNgimqGkae9LrGbG
        FnUHwKP0CTD8YgUStOWVnJY=
X-Google-Smtp-Source: AGHT+IHelwnQj0mBeQoq7MVF+0C7r26OR3aEnrp32H2XxDbIkv5daTveTqZ63X0hn4/goIYVqGjrVw==
X-Received: by 2002:a05:6a20:1007:b0:173:e36c:6d03 with SMTP id gs7-20020a056a20100700b00173e36c6d03mr4192266pzc.22.1698207960764;
        Tue, 24 Oct 2023 21:26:00 -0700 (PDT)
Received: from nobara-desktop-pc.localnet (cpe-76-88-3-111.san.res.rr.com. [76.88.3.111])
        by smtp.gmail.com with ESMTPSA id r25-20020aa79639000000b00694f14a784bsm8387098pfg.52.2023.10.24.21.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 21:26:00 -0700 (PDT)
From:   Jonathan LoBue <jlobue10@gmail.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Huayu Zhang <leviz.kernel.dev@gmail.com>
Cc:     Luke Jones <luke@ljones.dev>, Takashi Iwai <tiwai@suse.de>,
        tiwai@suse.com, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with missing DSD
Date:   Tue, 24 Oct 2023 21:25:59 -0700
Message-ID: <5984729.lOV4Wx5bFT@nobara-desktop-pc>
In-Reply-To: <3261329.aeNJFYEL58@nobara-desktop-pc>
References: <20230823011008.13146-1-luke@ljones.dev>
 <2165924.irdbgypaU6@nobara-desktop-pc> <3261329.aeNJFYEL58@nobara-desktop-pc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 23, 2023 9:35:55 AM PDT Jonathan LoBue wrote:
> On Monday, October 23, 2023 12:38:42 AM PDT Jonathan LoBue wrote:
> > On Sunday, October 8, 2023 10:19:18 AM PDT Huayu Zhang wrote:
> > > Hi Stefan and all,
> > > 
> > > Thanks for examine my email. I'm just interesting in Linux kernel
> > > development and met sound issue with my `21J8 Lenovo ThinkBook 16p Gen
> > > 4`.
> > > Sorry for not familiar with the email process if any.
> > > 
> > > I wrote following changes based on some discovery and the downside
> > > speakers (bass) seems begin to work. But the volumn keys actually
> > > adjusting the frequence (I suppose). (Louder for high freq, and lower
> > > volumn for low freq)
> > > 
> > > Wondering if any suggestions on the patch or any plan for officially
> > > supporting of Lenovo ThinkBook 16p Gen 4. ^_^
> > > I'll also provide the alsa-info and dmesg output below. Thanks a lot~
> > > 
> > > Patch:
> > > 
> > > From 124161547483109cbb491a8e39d1b5ef0973cd80 Mon Sep 17 00:00:00 2001
> > > From: Huayu Zhang <zhanghuayu.dev@gmail.com>
> > > Date: Mon, 9 Oct 2023 00:59:56 +0800
> > > Subject: [PATCH] thinkbook 16p gen4 sound fix
> > > 
> > > ---
> > > sound/pci/hda/cs35l41_hda_property.c | 41 ++++++++++++++++++++++++++++
> > > sound/pci/hda/patch_realtek.c | 1 +
> > > 2 files changed, 42 insertions(+)
> > > 
> > > diff --git a/sound/pci/hda/cs35l41_hda_property.c
> > > b/sound/pci/hda/cs35l41_hda_property.c
> > > index b62a4e6968e2..af359fbeb671 100644
> > > --- a/sound/pci/hda/cs35l41_hda_property.c
> > > +++ b/sound/pci/hda/cs35l41_hda_property.c
> > > @@ -74,6 +74,46 @@ static int hp_vision_acpi_fix(struct cs35l41_hda
> > > *cs35l41, struct device *physde
> > > return 0;
> > > }
> > > +static int lenovo_thinkbook16pgen4_no_acpi(struct cs35l41_hda
> > > *cs35l41, struct device *physdev, int id,
> > > + const char *hid)
> > > +{
> > > + struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
> > > +
> > > + dev_info(cs35l41->dev, "Adding DSD properties for %s\n",
> > > cs35l41->acpi_subsystem_id);
> > > +
> > > + printk("CSC3551: id == 0x%x\n", id);
> > > +
> > > + // cirrus,dev-index
> > > + cs35l41->index = id == 0x40 ? 0 : 1;
> > > + cs35l41->channel_index = 0;
> > > +
> > > + // cs35l41->reset_gpio = gpiod_get_index(physdev, NULL,
> > > cs35l41->index, GPIOD_OUT_LOW);
> > > + cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0,
> > > GPIOD_OUT_HIGH);
> > > + printk("CS3551: reset_gpio == 0x%x\n", cs35l41->reset_gpio);
> > > +
> > > + // cs35l41->speaker_id = cs35l41_get_speaker_id(physdev,
> > > cs35l41->index, nval, -1);
> > > + cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
> > > +
> > > + // cirrus,speaker-position
> > > + hw_cfg->spk_pos = cs35l41->index;
> > > +
> > > + // cirrus,gpio1-func
> > > + hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
> > > + hw_cfg->gpio1.valid = true;
> > > +
> > > + // cirrus,gpio2-func
> > > + hw_cfg->gpio2.func = CS35L41_INTERRUPT;
> > > + hw_cfg->gpio2.valid = true;
> > > +
> > > + hw_cfg->bst_type = CS35L41_EXT_BOOST;
> > > + hw_cfg->valid = true;
> > > +
> > > + put_device(physdev);
> > > + printk("CSC3551: Done.\n");
> > > +
> > > + return 0;
> > > +}
> > > +
> > > struct cs35l41_prop_model {
> > > const char *hid;
> > > const char *ssid;
> > > @@ -85,6 +125,7 @@ static const struct cs35l41_prop_model
> > > cs35l41_prop_model_table[] = {
> > > { "CLSA0100", NULL, lenovo_legion_no_acpi },
> > > { "CLSA0101", NULL, lenovo_legion_no_acpi },
> > > { "CSC3551", "103C89C6", hp_vision_acpi_fix },
> > > + { "CSC3551", "17AA38A9", lenovo_thinkbook16pgen4_no_acpi },
> > > {}
> > > };
> > > diff --git a/sound/pci/hda/patch_realtek.c
> > > b/sound/pci/hda/patch_realtek.c
> > > index 751783f3a15c..fc884fdcec5f 100644
> > > --- a/sound/pci/hda/patch_realtek.c
> > > +++ b/sound/pci/hda/patch_realtek.c
> > > @@ -10031,6 +10031,7 @@ static const struct snd_pci_quirk
> > > alc269_fixup_tbl[] = { SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL",
> > > ALC287_FIXUP_TAS2781_I2C), SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG
> > > dual", ALC287_FIXUP_TAS2781_I2C), SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P
> > > AMD
> > > VECO dual", ALC287_FIXUP_TAS2781_I2C), + SND_PCI_QUIRK(0x17aa, 0x38a9,
> > > "Lenovo ThinkBook 16p Gen 4",
> > > ALC287_FIXUP_CS35L41_I2C_2),
> > > SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC",
> > > ALC287_FIXUP_TAS2781_I2C),
> > > SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC",
> > > ALC287_FIXUP_TAS2781_I2C),
> > > SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual",
> > > ALC287_FIXUP_TAS2781_I2C),
> > > 
> > > > On 03/10/2023 15:45, Luke Jones wrote:
> > > > > On Thu, Aug 24 2023 at 08:31:06 AM +12:00:00, Luke Jones
> > > > > 
> > > > > <luke@ljones.dev> wrote:
> > > > >>> The second member variable in cs35l41_prop_model_table is the SSID
> > > > >>> to
> > > > >>> match against.
> > > > >>> The Lenovo laptops in the initial patch didn't have different
> > > > >>> SSIDs
> > > > >>> so
> > > > >>> the entry was set to NULL for those.
> > > > >>> Future entries using CSC3551 MUST always have an accompanying SSID
> > > > >>> with this entry.
> > > > >>> Takashi was correct, the implementation is intended to also be
> > > > >>> used
> > > > >>> to
> > > > >>> patch incorrect DSD.
> > > > >>> 
> > > > >>> We have a potential solution to workaround the SPI cs-gpios issue
> > > > >>> inside here,
> > > > >>> though the drawback for that is that it only works for laptops
> > > > >>> with
> > > > >>> 2
> > > > >>> SPI amps.
> > > > >> 
> > > > >> Can you provide me this so I can test? I have laptops with SPI 2
> > > > >> and
> > > > >> 4 speaker setups.
> > > > > 
> > > > > Hi Stefan,
> > > > > 
> > > > > Do you have any further information about the status of this in
> > > > > regards to the 2023 laptops?
> > > > 
> > > > Hi,
> > > > 
> > > > We are currently working on adding support for 2023 ASUS laptops
> > > > without
> > > > _DSD.
> > > > 
> > > > >>> I also took a look at the function for applying DSD properties for
> > > > >>> the
> > > > >>> 2023 ROG laptops.
> > > > >>> Unfortunately the one-size-fits-all approach will not work, some
> > > > >>> of
> > > > >>> these laptops are i2c
> > > > >>> and some are SPI, meaning the GPIO indexes are different for
> > > > >>> different
> > > > >>> laptops.
> > > > >> 
> > > > >> Do you mean "spk-id-gpios"? For all the laptops I know of this
> > > > >> seems
> > > > >> to be
> > > > >> Package () { "spk-id-gpios", Package () {
> > > > >> 
> > > > >>    SPK1, 0x02, Zero, Zero,
> > > > >>    SPK1, 0x02, Zero, Zero
> > > > >> 
> > > > >> } },
> > > > >> 
> > > > >> There is one laptop where it is One not 0x02 (the GA402N)
> > > > >> 
> > > > >>> Some of the laptops do no have Speaker IDs.
> > > > >>> Also, no laptop other than the 2 I added already should ever use
> > > > >>> CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these
> > > > >>> laptops
> > > > >>> are internal
> > > > >>> boost anyway).
> > > > >> 
> > > > >> Grazie.
> > > > >> 
> > > > >>> We are currently working internally on adding support for the 2023
> > > > >>> ROG
> > > > >>> laptops, so we
> > > > >>> ask for you guys to hold off on trying to upstream support for
> > > > >>> these
> > > > >>> laptops.
> > > > >> 
> > > > >> Ah great. Thank you. I apologise for trying to rush things, but I
> > > > >> do
> > > > >> have a discord server of over 4000 people, many of whom have
> > > > >> laptops
> > > > >> with cirrus amps.
> > > > >> 
> > > > >> For now I'm including a patch in my kernel builds with this
> > > > >> mapping:
> > > > >> 
> > > > >> const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
> > > > >> 
> > > > >>     { "CLSA0100", NULL, lenovo_legion_no_acpi },
> > > > >>     { "CLSA0101", NULL, lenovo_legion_no_acpi },
> > > > >>     { "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GS650P
> > > > >> 
> > > > >> - i2c
> > > > >> 
> > > > >>     { "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GA402X
> > > > >> 
> > > > >> - i2c
> > > > >> 
> > > > >>     { "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GU604V
> > > > >> 
> > > > >> - spi
> > > > >> 
> > > > >>     { "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GU603V
> > > > >> 
> > > > >> - spi
> > > > >> 
> > > > >>     { "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GV601V
> > > > >> 
> > > > >> - spi
> > > > >> 
> > > > >>     { "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     GZ301V
> > > > >> 
> > > > >> - spi
> > > > >> 
> > > > >>     { "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG
> > > > >> 
> > > > >> ALLY - i2c
> > > > >> 
> > > > >>     { "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J
> > > > >>     -
> > > > >> 
> > > > >> spi
> > > > >> 
> > > > >>     { "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J
> > > > >>     -
> > > > >> 
> > > > >> spi
> > > > >> 
> > > > >>     { "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     G614JI
> > > > >> 
> > > > >> -spi
> > > > >> 
> > > > >>     { "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P
> > > > >>     -
> > > > >> 
> > > > >> i2c
> > > > >> 
> > > > >>     { "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS
> > > > >>     H7604JV
> > > > >> 
> > > > >> - spi
> > > > >> 
> > > > >>     {}
> > > > >> 
> > > > >> };
> > > > >> 
> > > > >> These are the machines I have verified the gpios and such for.
> > > > > 
> > > > > I have a new version of this patch with all listed models confirmed
> > > > > as
> > > > > working, and with slightly different settings for some. The only
> > > > > thing
> > > > > missing in a solution to the gpio-cs issue.
> > > > > 
> > > > > Can you please provide an update on where you are with ASUS support
> > > > > in
> > > > > particular so that I may consider if it is worth my time submitting
> > > > > the updated patch.
> > > > 
> > > > We would prefer for you to wait, as we are looking to push up this
> > > > support in the coming weeks.
> > > > 
> > > > >> Cheers,
> > > > >> Luke.
> > 
> > Stefan and all,
> > 
> > Thanks for the hard work getting the DSD properties sorted and installed
> > on
> > various BIOSes. The one that I'm most concerned with and what got me
> > interested in this patching mechanism in the first place is the ASUS ROG
> > ALLY. From a DSD dump, it's clear that the latest ROG ALLY BIOS (330) has
> > the proper audio DSD properties. Unfortunately, certain things on many
> > people's setups across numerous ROG ALLYs (using various Linux distros)
> > have broken with the 330 BIOS. This led many of us to revert back to the
> > previous BIOS, 323. Knowing the proper internal boost corresponding values
> > now (cap, inductor, and peak current), it's ideal to push these properties
> > out for those people who prefer to stay on an older BIOS for the ROG ALLY.
> > I've developed a small patch that I've used on a custom 6.5.8 Nobara
> > kernel. Line numbers and whatnot may be different according to latest on
> > official Linux git, but I'd still like to share what I have. I think it is
> > a good addition. There's basically a small logic check versus BIOS number.
> > If the BIOS is 330 or greater, then the function to override DSD
> > properties
> > is exited. If the BIOS has a smaller number than 330, then the DSD
> > overrides are applied. Here is my patch.
> > 
> > diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/
> > cs35l41_hda_property.c
> > index b39f944..b67c636 100644
> > --- a/sound/pci/hda/cs35l41_hda_property.c
> > +++ b/sound/pci/hda/cs35l41_hda_property.c
> > @@ -6,7 +6,9 @@
> > 
> >  //
> >  // Author: Stefan Binding <sbinding@opensource.cirrus.com>
> > 
> > +#include <linux/dmi.h>
> > 
> >  #include <linux/gpio/consumer.h>
> > 
> > +#include <linux/kernel.h>
> > 
> >  #include <linux/string.h>
> >  #include "cs35l41_hda_property.h"
> > 
> > @@ -78,6 +80,40 @@ static int asus_rog_2023_spkr_id2(struct cs35l41_hda
> > *cs35l41, struct device *ph
> > 
> >  	return 0;
> >  
> >  }
> > 
> > +static int asus_rog_2023_ally_fix(struct cs35l41_hda *cs35l41, struct
> > device *physdev, int id,
> > +				const char *hid)
> > +{
> > +	const char *rog_ally_bios_ver =
> > dmi_get_system_info(DMI_BIOS_VERSION);
> > +	const char *rog_ally_bios_num = rog_ally_bios_ver + 6; // Dropping
> > the RC71L. part before the number
> > +	int rog_ally_bios_int;
> > +	kstrtoint(rog_ally_bios_num, 10, &rog_ally_bios_int);
> > +	if(rog_ally_bios_int >= 330){
> > +		printk(KERN_INFO "DSD properties exist in the %d
> > BIOS\n", rog_ally_bios_int);
> > +		return -ENOENT;
> > +	}
> > +
> > +	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
> > +
> > +	dev_info(cs35l41->dev, "Adding DSD properties for %s\n", cs35l41-
> > 
> > >acpi_subsystem_id);
> > 
> > +
> > +	cs35l41->index = id == 0x40 ? 0 : 1;
> > +	cs35l41->channel_index = 0;
> > +	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0,
> > GPIOD_OUT_HIGH);
> > +	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
> > +	hw_cfg->spk_pos = cs35l41->index;
> > +	hw_cfg->gpio1.func = CS35L41_NOT_USED;
> > +	hw_cfg->gpio1.valid = true;
> > +	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
> > +	hw_cfg->gpio2.valid = true;
> > +	hw_cfg->bst_type = CS35L41_INT_BOOST;
> > +	hw_cfg->bst_ind = 1000; /* 1,000nH Inductance value */
> > +	hw_cfg->bst_ipk = 4500; /* 4,500mA peak current */
> > +	hw_cfg->bst_cap = 24; /* 24 microFarad cap value */
> > +	hw_cfg->valid = true;
> > +
> > +	return 0;
> > +}
> > +
> > 
> >  struct cs35l41_prop_model {
> >  
> >  	const char *hid;
> >  	const char *ssid;
> > 
> > @@ -94,7 +130,7 @@ const struct cs35l41_prop_model
> > cs35l41_prop_model_table[] = {
> > 
> >  	{ "CSC3551", "10431483", asus_rog_2023_spkr_id2 }, // ASUS GU603V
> 
> -
> 
> > spi, reset gpio 1
> > 
> >  	{ "CSC3551", "10431493", asus_rog_2023_spkr_id2 }, // ASUS GV601V
> 
> -
> 
> > spi, reset gpio 1
> > 
> >  	{ "CSC3551", "10431573", asus_rog_2023_spkr_id2 }, // ASUS GZ301V
> 
> -
> 
> > spi, reset gpio 0
> > -	{ "CSC3551", "104317F3", asus_rog_2023_spkr_id2 }, // ASUS ROG
> 
> ALLY
> 
> > - i2c
> > +	{ "CSC3551", "104317F3", asus_rog_2023_ally_fix }, // ASUS ROG ALLY
> > - i2c
> > 
> >  	{ "CSC3551", "10431B93", asus_rog_2023_spkr_id2 }, // ASUS G614J -
> > 
> > spi, reset gpio 0
> > 
> >  	{ "CSC3551", "10431CAF", asus_rog_2023_spkr_id2 }, // ASUS G634J -
> > 
> > spi, reset gpio 0
> > 
> >  	{ "CSC3551", "10431C9F", asus_rog_2023_spkr_id2 }, // ASUS G614JI
> 
> -
> 
> > spi, reset gpio 0
> > 
> > This patch is what my changes are after unpacking the kernel source RPM
> > for
> > a Nobara kernel and applying a version of Luke's patches.
> > 
> > I think a similar BIOS version checking logic may come in handy again in
> > the future. Thanks.
> > 
> > Best Regards,
> > Jon LoBue
> 
> One more minor change to my proposed patch is to replace the "return
> -ENOENT;" line in the patch routine not applying and exiting to "return 0;
> //Patch not applicable. Exiting successfully" since it's actually a
> successful exit if the BIOS version is detected as 330 or greater and no
> patch is applied. Thanks.
> 
> 
> Best Regards,
> Jon LoBue

Replying again here to clarify that the exit code for the DSD override patch 
not being necessary and therefore exiting the patching process for BIOSes 
equal to or greater than 330 (on ROG ALLY) should in fact be "return -
ENOENT;". This was confirmed in testing by me today for ChimeraOS. Changing 
that line to "return 0;" actually causes the code logic to take an incorrect 
branch and subsequently audio ends up not working with that compiled module. 
This reply is mainly for educational and informational purposes. I don't 
expect this patch to be merged. Fortunately, the new 331 BIOS that came out 
today for ASUS ROG ALLY fixes all my known issues that I had with the 330 BIOS 
on Nobara, and is actually usable for me. Thanks.

Best Regards,
Jon LoBue


