Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C27F450D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbjKVLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbjKVLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:44:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279681A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:44:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA249C433C8;
        Wed, 22 Nov 2023 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653479;
        bh=7SCLZMf84i/qdLRLpb12nwODAA5V91JB6qPLNeOI4r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeWAAWB2FZYRKX72WUi+YzRnAWVj0km31wIJTRJ2a6Qo8HKK6/560QJjqhLYlLWTt
         14N/F4CcIe6hhXj8L2cB+SM5EDF6OQnerLOdVfj1Mlz2BWXaOzAzbmsTghFQLFPVXD
         oMAWM1p78QSfttqadhHzOV3OUnHeHi4NmgXuVJXbp8rBllrkoa/a58F9ylxGE78mol
         RKm/dKV/eBH1CShSSsFbbVxQycuLkVNmMxyL4GpPrcib2Zzyej5PPcFnnNGcr6PoP5
         YOQhtlROB1mGhvbVPEzNQ3oehlvNPrq78Ph52N8ZSWeo6xIVUgpMRpudfMl4QHmNkJ
         nLrvbW5AboP/w==
Date:   Wed, 22 Nov 2023 11:44:34 +0000
From:   Lee Jones <lee@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Johannes =?iso-8859-1?Q?Pen=DFel?= <johannes.penssel@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] Revert "leds: class: Store the color index in struct
 led_classdev"
Message-ID: <20231122114434.GI173820@google.com>
References: <20231121142629.27083-1-tiwai@suse.de>
 <170057941222.880794.5199112193553712244.b4-ty@kernel.org>
 <87v89v9j9t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v89v9j9t.wl-tiwai@suse.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Takashi Iwai wrote:

> On Tue, 21 Nov 2023 16:10:12 +0100,
> Lee Jones wrote:
> > 
> > On Tue, 21 Nov 2023 15:26:29 +0100, Takashi Iwai wrote:
> > > This reverts commit c7d80059b086c4986cd994a1973ec7a5d75f8eea.
> > > 
> > > The commit caused regressions to a few drivers (such as Logitech
> > > keyboard or System76 ACPI) that already had "color" leds sysfs entry;
> > > now they conflict with the commonly created sysfs of led class.
> > > 
> > > For addressing the regression, we revert the commit, so that the
> > > conflicting "color" sysfs entry is removed.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] Revert "leds: class: Store the color index in struct led_classdev"
> >       commit: 17e1ad377bb1d39260e0594ee284d8e03f64fdfb
> 
> It turned out that drivers/leds/rgb/leds-group-multicolor.c
> initializes the cdev->color, and this revert breaks it.

Indeed:

linux/leds-fixes/drivers/leds/rgb/leds-group-multicolor.c: In function ‘leds_gmc_probe’:
linux/leds-fixes/drivers/leds/rgb/leds-group-multicolor.c:109:49: error: ‘struct led_classdev’ has no member named ‘color’
linux/leds-fixes/drivers/leds/rgb/leds-group-multicolor.c:120:13: error: ‘struct led_classdev’ has no member named ‘color’

> So please scratch my previous revert patch.
> I'm going to submit a partial revert instead.

Sure.

-- 
Lee Jones [李琼斯]
