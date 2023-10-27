Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821E87D9A55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbjJ0NrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0NrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:47:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E0A9D;
        Fri, 27 Oct 2023 06:47:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EECC433C9;
        Fri, 27 Oct 2023 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698414425;
        bh=PDM2diCGxCnhLmpepTocuodFEgpq+efi5FyxfOqLlW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ILaqQ5REhAvAcZ/orSI/QjL66UWXtUG1zWKgw1N0/oszAW0XiPQ0iMLP3pxQISF1F
         Zpp7EymGwHkfciz+HE4AMLusqZqIW3IUmTHtf2oX745uC5rK3AghcJgJ11vLSDxdsg
         Rgiti8ozzeL7LMEzFTc9g4up+vExyQPx7Get3sSUhkwXpXb6orDLqOe+O/SEDMwqyD
         diawqTyvMWwFpxQXfiC8dsE12MjL58AQcZbJ1kEshcKetZqRrCc0C3Ch6QnCI75vTW
         Y6ju76hbVDBCyoAxwngQUfx6gneLqi+HsikcLuLX4oiAiyolSxNB1eKY6Wn/3xmtQs
         mogEUvtb6bG6g==
Date:   Fri, 27 Oct 2023 14:46:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/5] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
Message-ID: <20231027144625.36cc694c@jic23-huawei>
In-Reply-To: <20231027144234.0ad6c7b6@jic23-huawei>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
        <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
        <ZTZYNjq/1X95ijXh@smile.fi.intel.com>
        <20231027144234.0ad6c7b6@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 14:42:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 23 Oct 2023 14:25:42 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Sun, Oct 22, 2023 at 07:22:20PM +0200, Angel Iglesias wrote:  
> > > Improve device detection in certain chip families known to have various
> > > chip ids.
> > > When no known ids match, gives a warning but follows along what device
> > > said on the firmware and tries to configure it.    
> > 
> > I would rephrase it a bit:
> > 
> > "Improve device detection in certain chip families known to have
> > various chip IDs. When no ID matches, give a warning but follow
> > along what device said on the firmware side and try to configure
> > it."
> > 
> > ...
> >   
> > > +	for (i = 0; i < data->chip_info->num_chip_id; i++) {
> > > +		if (chip_id == data->chip_info->chip_id[i]) {
> > > +			dev_info(dev, "0x%x is a known chip id for %s\n", chip_id, name);
> > > +			break;
> > > +		}    
> >   
> > > +		dev_warn(dev, "chip id 0x%x does not match known id 0x%x\n",
> > > +			 chip_id, data->chip_info->chip_id[i]);    
> > 
> > If the matching ID is not the first one, user will have an unneeded warning here.  
> 
> Could be a dev_dbg() but I'd just drop it entirely.
> 
Given that was all that came up, I've hopefully saved us all time by
dropping the bring and changing the patch description as Andy suggested.

With that done, applied.

Jonathan

> 
> >   
> > >  	}    
> >   
> 

