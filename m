Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE2800602
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377814AbjLAIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLAIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:41:16 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B610D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:41:22 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94FC0FF803;
        Fri,  1 Dec 2023 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701420080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3amwn1NJ1mTvbaM/76zfWCSHxT3BcZtBq0Slk1BBD5E=;
        b=J7QCZVt+qjfwtn4lkc+mRKNeWj9I7dyMQkTqCg6x3AxFrGxn6riCQlAAga7XqY3H0z4dvu
        ci6RBDDq+M64+xHcIAs+E/WwFUr1GUd8Qxu/bemppUt4V/OsVaPTk0/hdKzS/zo+6W2pnC
        27mFsOf9kA8DYdEMd4Dc93UdyLYS+PBJKdMVWFceH4fBUGeZSjQu5k9kTiHCgZXnqJqgrd
        UrXofxxypUS8Cc8+DrGRBiQ9mSKLll4xZvTwLqG4qChEGQvL5xAWBn5ntVeSWnutUArT0v
        aO4tKPgmuoj8ar/84F+YLKMMChuXD7iPKna1YgaZglNaMO8yzRZGvrUA0m169w==
Date:   Fri, 1 Dec 2023 09:41:16 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Qiang Zhao" <qiang.zhao@nxp.com>, "Leo Li" <leoyang.li@nxp.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Shengjiu Wang" <shengjiu.wang@gmail.com>,
        "Xiubo Li" <Xiubo.Lee@gmail.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Nicolin Chen" <nicoleotsuka@gmail.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 15/17] soc: fsl: cpm1: qmc: Handle timeslot entries at
 channel start() and stop()
Message-ID: <20231201094116.65956f60@bootlin.com>
In-Reply-To: <46d0248d-c322-4856-8e9e-6468ac1b7a02@app.fastmail.com>
References: <20231128140818.261541-1-herve.codina@bootlin.com>
        <20231128140818.261541-16-herve.codina@bootlin.com>
        <46d0248d-c322-4856-8e9e-6468ac1b7a02@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 29 Nov 2023 15:03:02 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Nov 28, 2023, at 15:08, Herve Codina wrote:
> > @@ -272,6 +274,8 @@ int qmc_chan_get_info(struct qmc_chan *chan, struct 
> > qmc_chan_info *info)
> >  	if (ret)
> >  		return ret;
> > 
> > +	spin_lock_irqsave(&chan->ts_lock, flags);
> > +
> >  	info->mode = chan->mode;
> >  	info->rx_fs_rate = tsa_info.rx_fs_rate;
> >  	info->rx_bit_rate = tsa_info.rx_bit_rate;
> > @@ -280,6 +284,8 @@ int qmc_chan_get_info(struct qmc_chan *chan, struct 
> > qmc_chan_info *info)
> >  	info->tx_bit_rate = tsa_info.tx_bit_rate;
> >  	info->nb_rx_ts = hweight64(chan->rx_ts_mask);
> > 
> > +	spin_unlock_irqrestore(&chan->ts_lock, flags);
> > +
> >  	return 0;
> >  }  
> 
> I would normally use spin_lock_irq() instead of spin_lock_irqsave()
> in functions that are only called outside of atomic context.

I would prefer to keep spin_lock_irqsave() here.
This function is part of the API and so, its quite difficult to ensure
that all calls (current and future) will be done outside of an atomic
context.

> 
> > +static int qmc_chan_start_rx(struct qmc_chan *chan);
> > +
> >  int qmc_chan_stop(struct qmc_chan *chan, int direction)
> >  {  
> ... 
> > -static void qmc_chan_start_rx(struct qmc_chan *chan)
> > +static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan);
> > +
> > +static int qmc_chan_start_rx(struct qmc_chan *chan)
> >  {  
> 
> Can you reorder the static functions in a way that avoids the
> forward declarations?

Yes, sure.
I will do that in the next iteration.

Thanks for the review,

Best regards,
Hervé
