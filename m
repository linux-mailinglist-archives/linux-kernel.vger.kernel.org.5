Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2A7D9761
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbjJ0MLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345814AbjJ0MLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:11:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D21A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:11:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A3DC433C8;
        Fri, 27 Oct 2023 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698408702;
        bh=GufLd68JrWWCWbA9FffHZI8Ui49NvQRStWT72Nq8TtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLMivdtaqZC7ceLgIAqQWKilUrU612Jp4J85/xgMihgp4sM9mah4DWNw6XMSZL468
         8pPHx/xKmOedmJknI6rFWgAOquFzrfH7YvR0e0aAG8iDayO4TM9vXqAIKh8DLCiKMO
         a4bJ3V86lzAMNnBv1EZNS4Xm3dti8iksEJi6Pu6Z4kJ4lAiBcgVLQVSt7yaWL8NMqR
         Z3umw/STegj1sfLdR87es900k1S7FPMfju32aNHxNkXJZ76tzn1KoT4DicPighgqB0
         0zcahF/Om7LUGByaNc8KZSqOoJrTrxi8eR2H1fDX7lmYKNREJ+hfExU/T6nFur3uFl
         qW4JZfnNMq8BA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qwLhA-0007So-0P;
        Fri, 27 Oct 2023 14:12:08 +0200
Date:   Fri, 27 Oct 2023 14:12:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZTupGPUQg0j1aGjW@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <54c44548-c2e4-466d-bfe4-b48db9e5d20c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c44548-c2e4-466d-bfe4-b48db9e5d20c@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:00:13PM +0200, Amadeusz Sławiński wrote:

> Have you tried something like:
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index e40d583a1ce6..f02362cf95dc 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -1229,6 +1229,8 @@ static int wsa883x_spkr_event(struct 
> snd_soc_dapm_widget *w,
>                  snd_soc_component_write_field(component, 
> WSA883X_VBAT_ADC_FLT_CTL,
>  
> WSA883X_VBAT_ADC_COEF_SEL_MASK,
>  
> WSA883X_VBAT_ADC_COEF_F_1DIV2);
> +               snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
> +                                             WSA883X_DRE_GAIN_EN_MASK, 0);
>                  snd_soc_component_write_field(component, 
> WSA883X_PA_FSM_CTL,
>  
> WSA883X_GLOBAL_PA_EN_MASK, 0);
>                  snd_soc_component_write_field(component, 
> WSA883X_PDM_WD_CTL,
> 
> 
> As it is one thing from wsa883x_digital_mute() which seems missing in 
> SND_SOC_DAPM_PRE_PMD switch case, so it seems to leave GAIN always enabled?

Since I had the test setup ready, I tried the above quickly but it
doesn't seem to make any difference.

Johan
