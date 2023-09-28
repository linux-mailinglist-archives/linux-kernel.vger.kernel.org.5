Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715167B108F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjI1CDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjI1CDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:03:45 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11076102
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:03:42 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978092:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 28 Sep 2023 10:03:00 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 28 Sep
 2023 10:03:00 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 28 Sep 2023 10:03:00 +0800
Date:   Thu, 28 Sep 2023 10:03:00 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <20230928020300.GA18024@linuxcarl2.richtek.com>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
 <20230927094637.GA25905@linuxcarl2.richtek.com>
 <ZRP9Aw904ynL5Se/@finisterre.sirena.org.uk>
 <20230927101948.GA27975@linuxcarl2.richtek.com>
 <ZRQDzZG7PPovUIsf@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRQDzZG7PPovUIsf@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:28:29PM +0200, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 06:19:48PM +0800, ChiYuan Huang wrote:
> > On Wed, Sep 27, 2023 at 11:59:31AM +0200, Mark Brown wrote:
> 
> > > Sure, but is that actually a practical design - or if someone is doing
> > > this shouldn't it be joined up with the TDM configuration since with
> > > just the control it'd only be possible to switch the pins but not change
> > > the TDM layout?  I'm not sure that this control works as a standalone
> > > thing.
> 
> > I think if two data source input for different scenarios, then the data source
> > switch will become practical. For the standalone usage, keep a device property
> > to decide this may be enough. But consider the future application, to keep this
> > in general mixer control is still usable to meet the complex design.
> 
> My concern is that the control might not actually be usable without also
> changing the TDM mode so we might need the machine driver to add a
> control which flips the input and also changes the TDM mode - it feels
> likley that if there are two inputs they won't have identical formats.

Yap, your concern may be correct. This change is really becuase our default register
is badly defined. it choose TDM CH12 from 'DATA1' and CH34 from 'DATA2'. If it can
choose both default to either one, this doesn't make it confused. Also, there's the
another option is 'to tell user if TDM will be used, plase connect 'DATA1' and 'DATA2'
together'. But our datasheet did not directly define this.

I'll prepare another patch to define a device property, parsing at probe function and
configure this input source source directly in 'set_tdm_slot' API when TDM is chosen
to use.

Thanks for all the comment.
