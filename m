Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5C7B00D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjI0JrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:47:07 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82987C0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:47:04 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978120:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 27 Sep 2023 17:46:38 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 27 Sep
 2023 17:46:37 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 27 Sep 2023 17:46:37 +0800
Date:   Wed, 27 Sep 2023 17:46:37 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs: rtq9128: Add TDM data source selection
Message-ID: <20230927094637.GA25905@linuxcarl2.richtek.com>
References: <1695780376-32301-1-git-send-email-cy_huang@richtek.com>
 <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRPyMolOIjLBWXPC@finisterre.sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:13:22AM +0200, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 10:06:16AM +0800, cy_huang@richtek.com wrote:
> 
> > Since rtq9128 can support 4 channel I2S mode audio data, there are two
> > dedicated data input pins for CH12 and CH34.  But in TDM mode, input
> > source was already drived on one data pin for multiple data slots. In
> > this case, only one input source is needed for TDM mode.
> > 
> > This patch is to add the data source pin selection for CH12 and CH34.
> 
> > +	SOC_ENUM("CH12 TDM Data Select", rtq9128_ch12_tdm_data_select_enum),
> > +	SOC_ENUM("CH34 TDM Data Select", rtq9128_ch34_tdm_data_select_enum),
> 
> Is this something that's going to be changing dynamically at runtime or
> should this be a device property that's set either by firmware or when
> we're doing the TDM setup?  This sounds like something I'd expect to be
> fixed by the board design.

I may think one case if ASoC platform support multiple data source outputs
that share the same bck/lcrk on different data pin. If it can be dynamically
adjusted for the scenarios, this will keep the flexibility for the differet
platform design.

Like as in most codecs, there could be mux design that can use to choose the 
dedicated data input. If we fixed in device property, the flexibility will be
missing. It's our original thought to have the control for the data select
mutiplexer.
