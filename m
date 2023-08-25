Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FFB787F12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjHYEs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjHYEsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:48:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA6F1FD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:48:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc5acc627dso4875895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692938910; x=1693543710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8ouKIeZsF4CQh1QKiAPTQpg8xkLFzCcV0aBspspvEY=;
        b=J4TV5qyWZ9eAql7OM+JOw/wr2FDl/58esGcIN3NONQhT+E4cOBKu8Gylu00voXuya0
         nlGVC91PQ4bIOhwUIHpexuWUBANLsdFAsHcjBlw26kPVBYpxTdEr+dytZjw0L1gznkVJ
         IfKdwiy0Nhtqi+tbxzUCgzS/5AYjeDjr+bGP7WuqNUlN/jG7UWP+jOAlmBcxgC/QMtOP
         jJF04V4Z95n0CpqT0S/TOnPR0UIF9XPb7ybdFkEOLNlWnGpaOzLlgGA7v86dVrkVwTjk
         MmpDPSbNoxN3dBZ5T+1SdCQH71zxdhsun5l04FLXOHHORCSZXr9m1bKSOgKsBpbDSTm1
         6/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692938910; x=1693543710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8ouKIeZsF4CQh1QKiAPTQpg8xkLFzCcV0aBspspvEY=;
        b=NUhqlzdzXAn9mONrAUg0uzCLExONxMNAAjSlmJCFuS6vTBlv1EZGh/YDefOrMKpcSH
         Zy1t2Rngr25Pk5s+129OqUO44hZDby+MWKBzMW1WbNJSHj7JE0LRfXxEFRFH/9HvQM5A
         meSfL4qhcWg0RVoHyyt7d7j5MGEu8pMNHUj0Nqo3519FP7i8E7RQlodQAlYuij3JsPcm
         4eKcFRhfKMu6Ni/wrFQuclUJ4uYH+Nz0tRHFBpbGheHUhbqrS3dCX0oqkSFjLo9fHMgX
         ofdDx13LETkPlkjKKgNmwxjogllXPxUKOg7heFvi7O6INd9oxKuqmC8dXS5PS8BrBjGY
         KsGw==
X-Gm-Message-State: AOJu0YwQNlo8UP6uXy+SOwDQrBsYcLAN7M+f6NcoxH/upsI+Xfix6aMF
        l8EsE/Xrwql3qkfS6Q+vOaY=
X-Google-Smtp-Source: AGHT+IE3IZ6OOR3aU5OoMk3nWq2BZVPtg/yJcfzikMQ2cmvhw+3ig7EY55P+/knWblb0GKqP6lI2vg==
X-Received: by 2002:a17:902:da8b:b0:1bf:78d:5cde with SMTP id j11-20020a170902da8b00b001bf078d5cdemr16436578plx.59.1692938909948;
        Thu, 24 Aug 2023 21:48:29 -0700 (PDT)
Received: from nobara-desktop-pc.localnet (cpe-76-88-3-111.san.res.rr.com. [76.88.3.111])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709027c8b00b001b80d399730sm572063pll.242.2023.08.24.21.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 21:48:29 -0700 (PDT)
From:   Jonathan LoBue <jlobue10@gmail.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Luke Jones <luke@ljones.dev>
Cc:     'Takashi Iwai' <tiwai@suse.de>, tiwai@suse.com,
        james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda: cs35l41: Support ASUS 2023 laptops with missing DSD
Date:   Thu, 24 Aug 2023 21:48:27 -0700
Message-ID: <1883002.tdWV9SEqCh@nobara-desktop-pc>
In-Reply-To: <UB2VZR.B7HP6HUMGFA03@ljones.dev>
References: <20230823011008.13146-1-luke@ljones.dev>
 <000601d9d5b0$8d6817f0$a83847d0$@opensource.cirrus.com>
 <UB2VZR.B7HP6HUMGFA03@ljones.dev>
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

On Wednesday, August 23, 2023 1:31:06 PM PDT Luke Jones wrote:
> > The second member variable in cs35l41_prop_model_table is the SSID to
> > match against.
> > The Lenovo laptops in the initial patch didn't have different SSIDs so
> > the entry was set to NULL for those.
> > Future entries using CSC3551 MUST always have an accompanying SSID
> > with this entry.
> > Takashi was correct, the implementation is intended to also be used to
> > patch incorrect DSD.
> > 
> > We have a potential solution to workaround the SPI cs-gpios issue
> > inside here,
> > though the drawback for that is that it only works for laptops with 2
> > SPI amps.
> 
> Can you provide me this so I can test? I have laptops with SPI 2 and 4
> speaker setups.
> 
> > I also took a look at the function for applying DSD properties for the
> > 2023 ROG laptops.
> > Unfortunately the one-size-fits-all approach will not work, some of
> > these laptops are i2c
> > and some are SPI, meaning the GPIO indexes are different for different
> > laptops.
> 
> Do you mean "spk-id-gpios"? For all the laptops I know of this seems to
> be
> Package () { "spk-id-gpios", Package () {
>     SPK1, 0x02, Zero, Zero,
>     SPK1, 0x02, Zero, Zero
> } },
> 
> There is one laptop where it is One not 0x02 (the GA402N)
> 
> > Some of the laptops do no have Speaker IDs.
> > Also, no laptop other than the 2 I added already should ever use
> > CS35L41_EXT_BOOST_NO_VSPK_SWITCH (in fact I believe all these laptops
> > are internal
> > boost anyway).
> 
> Grazie.
> 
> > We are currently working internally on adding support for the 2023 ROG
> > laptops, so we
> > ask for you guys to hold off on trying to upstream support for these
> > laptops.
> 
> Ah great. Thank you. I apologise for trying to rush things, but I do
> have a discord server of over 4000 people, many of whom have laptops
> with cirrus amps.
> 
> For now I'm including a patch in my kernel builds with this mapping:
> 
> const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
> 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
> 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
> 	{ "CSC3551", "10431433", asus_rog_2023_no_acpi }, // ASUS GS650P - 
i2c
> 	{ "CSC3551", "10431463", asus_rog_2023_no_acpi }, // ASUS GA402X - 
i2c
> 	{ "CSC3551", "10431473", asus_rog_2023_no_acpi }, // ASUS GU604V - 
spi
> 	{ "CSC3551", "10431483", asus_rog_2023_no_acpi }, // ASUS GU603V - 
spi
> 	{ "CSC3551", "10431493", asus_rog_2023_no_acpi }, // ASUS GV601V - 
spi
> 	{ "CSC3551", "10431573", asus_rog_2023_no_acpi }, // ASUS GZ301V - 
spi
> 	{ "CSC3551", "104317F3", asus_rog_2023_no_acpi }, // ASUS ROG ALLY 
-
> i2c
> 	{ "CSC3551", "10431B93", asus_rog_2023_no_acpi }, // ASUS G614J - 
spi
> 	{ "CSC3551", "10431CAF", asus_rog_2023_no_acpi }, // ASUS G634J - 
spi
> 	{ "CSC3551", "10431C9F", asus_rog_2023_no_acpi }, // ASUS G614JI -
spi
> 	{ "CSC3551", "10431D1F", asus_rog_2023_no_acpi }, // ASUS G713P - 
i2c
> 	{ "CSC3551", "10431F1F", asus_rog_2023_no_acpi }, // ASUS H7604JV - 
spi
> 	{}
> };
> 
> These are the machines I have verified the gpios and such for.
> 
> Cheers,
> Luke.

Stefan,

Based on your comment, "in fact I believe all these laptops are internal boost 
anyway," that would imply that we want to update our temporary patches that we 
are using for kernel creation (and sharing via RPM or other means). Right now 
we had updated that line to hw_cfg->bst_type = CS35L41_EXT_BOOST; but it seems 
that it should actually be hw_cfg->bst_type = CS35L41_INT_BOOST. The external 
boost setting seems to work for the ASUS ROG ALLY in my own testing, but 
perhaps it is driving the amp harder than intended. Based on available 
documentation, the internal boost setting must be accompanied by the peak 
current, inductor and capacitor values of the boost circuit. It's possible 
that ASUS used some different values here for board components across different 
laptop models (and the ALLY). If you have the table with accurate values for 
the capacitance and inductance values (and for which models they apply), that 
would be very valuable information to share. As Luke pointed out, many people 
are wanting to use these patches now to avoid the need for DSD ACPI overrides 
to get audio working on their devices.

I'm most interested in the capacitance and inductance values for the ROG ALLY, 
so that I can fill in the values for hw_cfg->bst_ind and hw_cfg->bst_cap. Peak 
current seems to be okay to leave at 4,500mA as I can't imagine that Cirrus 
would allow an unsafe current value there, and in documentation it's listed as 
default anyways. We will wait for your upstream patch, but we would also very 
much appreciate if you could share this information if you have it and are 
able to share it. Thanks.

Best Regards,
Jon LoBue


