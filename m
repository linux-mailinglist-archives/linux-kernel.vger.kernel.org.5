Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0A77FF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355184AbjHQVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355195AbjHQVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:09:28 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21E3594
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:09:24 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 704B016C0048;
        Fri, 18 Aug 2023 00:09:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ppT7QGoPTKLu; Fri, 18 Aug 2023 00:09:21 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1692306561; bh=NVXwTpTC1CjboR6SCktJMnp2EJB2bG5MH4brewxq8wQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UmXyllAJYrJCA2Og0Z6DlTw203aSXWQtvDgzJPxuCx3UZdCpNCrv8aUhxKWv7TOO4
         RETmq1tar2+WpOvHGLjziCOQeBHLkEyxnqkfUjHnH7LM36S/gOXZu/7N2ZvUrqOCKN
         tFnOE3BnxOEZ2X8MrYS36h97ftKoCpNdb0WmcAa0=
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?B?5rKI5LiA6LaF?= <zhuning0077@gmail.com>,
        yangxiaohua <yangxiaohua@everest-semi.com>,
        Zhu Ning <zhuning@everest-semi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
In-Reply-To: <ZCRCqJ7oG6oefo9g@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one> <ZBr9rJn50ovG1w9W@sirena.org.uk>
 <87ttycjyw3.fsf@mutex.one> <ZBty1CdPaWm0IcRi@sirena.org.uk>
 <87r0t9uc08.fsf@mutex.one> <ZCRCqJ7oG6oefo9g@sirena.org.uk>
Date:   Fri, 18 Aug 2023 00:09:19 +0300
Message-ID: <87zg2pxtog.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for taking so long to look into this.
I think I understand why sound doesn't work if suspending with
headphones inserted.
When the jack is inserted, function
es8316_enable_micbias_for_mic_gnd_short_detect() is called and 3 pins
are enabled: Bias, Analog power, Mic Bias.

Since these 3 are supplies, the loop for_each_card_widgets() in
dapm_power_widgets() will always force the target_bias_level to be
SND_SOC_BIAS_STANDBY. So the codec component will never enter
SND_SOC_BIAS_OFF bias level.

When a suspend happens (with the headphones inserted) in
snd_soc_suspend(), in the for_each_rtd_components() loop, since the
bias level is SND_SOC_BIAS_STANDBY and dapm->idle_bias_off is true the
codec's suspend/resume functions are not called. Because of this the
codec stops running correctly.

Now I'm not sure what a proper fix would be. Enabling idle_bias_on in
struct snd_soc_component_driver fixes this issue. Would enabling
this option have any unwanted side effects?
