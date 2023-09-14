Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BEB7A0014
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjINJby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjINJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:31:52 -0400
Received: from out-222.mta0.migadu.com (out-222.mta0.migadu.com [IPv6:2001:41d0:1004:224b::de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B089CC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:31:48 -0700 (PDT)
Date:   Thu, 14 Sep 2023 19:27:03 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694683906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmPa+r4UrqSI4OyMQhsi2Wq5TKQmIhNTWv2ugXVReZk=;
        b=mqea8Dco5GkiVp3d+wmxmrg67/ao1nY64YhP2JCR+VosQ6HsA5pdF5EP+IMKNcOfvAkHDh
        JSbCKG24sH0K2Gbc1pwDeCvd2Y+kIS1DOdjSkSX3BkXvArTN36u1OTiDRr5KvQrz1def6i
        YoPsCEptgGxC/s4Ep7cAwC7qVtq3CTmGWiHLmEgmqzGAG08iJCsLq/ykteyK2nxamCfhwQ
        3xi4D3moJXUHTs7IGutAy/+oNofpaZjLQMsb8FBUKaMj4y+YeFpIbj5ZngStaPQgkavLma
        ayx+AH+lwFfUGuOZhiMtJtID6PAQIpVYb1FgRTtkA5/wvvd1pfvKrC55Awm/ng==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: wm8782: Handle maximum audio rate at runtime
Message-ID: <ZQLR50CAzr0VDpeh@titan>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-2-contact@jookia.org>
 <20230914092107.GR103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914092107.GR103419@ediswmail.ad.cirrus.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:21:07AM +0000, Charles Keepax wrote:
> On Thu, Sep 14, 2023 at 03:15:50AM +1000, John Watts wrote:
> > The wm8782 supports up to 192kHz audio when pins are set correctly.
> > Instead of hardcoding which rates are supported enable them all
> > then refer to a max_rate variable at runtime.
> > 
> > Signed-off-by: John Watts <contact@jookia.org>
> > ---
> > +static int wm8782_dai_hw_params(struct snd_pcm_substream *component,
> > +			    struct snd_pcm_hw_params *params,
> > +			    struct snd_soc_dai *dai)
> > +{
> > +	struct wm8782_priv *priv =
> > +		snd_soc_component_get_drvdata(dai->component);
> > +
> > +	if (params_rate(params) > priv->max_rate)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 
> We should be setting this as a constraint in startup, rather
> than returning an error in hw_params. That will let user-space
> know the supported rates and allow it to resample if necessary.

How do you do this? The struct with the rate is statically defined.

> 
> Thanks,
> Charles

John.
