Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADB78C730
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjH2ORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjH2OQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:16:58 -0400
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 07:16:54 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D1D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:16:54 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CF5A711D9;
        Tue, 29 Aug 2023 16:10:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CF5A711D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1693318228; bh=VFizFasrmps0pK8Vm4GD/TVsSeVHbnbNGk46FkUfXyU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=SlcKdjZHvSJuQ5tOF5JHfz3uL4SgWS5GqyKpTsLtlHxZF/8KmjceLfG8zOxdF+ULh
         U43J0A2sLxkOWVY9Hh6W3te/cZKYSwXFrBF1JKGuzPa6KoK9XV6KTc6fk8LobiGeAb
         dqlt6xSIeE9+wjRBGhaAew2MQJXFc0CUreCdZBes=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 29 Aug 2023 16:10:24 +0200 (CEST)
Message-ID: <9b71579b-3c2c-aafc-64d0-ae16603de82b@perex.cz>
Date:   Tue, 29 Aug 2023 16:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>
References: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v1 1/1] ALSA: control: Use list_for_each_entry_safe()
In-Reply-To: <20230829135252.3915124-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 08. 23 15:52, Andy Shevchenko wrote:
> Instead of reiterating the list, use list_for_each_entry_safe()
> that allows to continue without starting over.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Takashi, if you have anybody or want yourself to spend some time,
> I believe you can simplify a lot the parser in this file with
> the help of lib/cmdline.c APIs.

You probably mean next_arg() function. Unfortunately, it does not handle all 
cases we need to parse. The control IDs are a bit different than standard 
arguments.

>   sound/core/control_led.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index a78eb48927c7..afc9ffc388e3 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -297,16 +297,13 @@ static void snd_ctl_led_clean(struct snd_card *card)
>   {
>   	unsigned int group;
>   	struct snd_ctl_led *led;
> -	struct snd_ctl_led_ctl *lctl;
> +	struct snd_ctl_led_ctl *lctl, _lctl;
>   
>   	for (group = 0; group < MAX_LED; group++) {
>   		led = &snd_ctl_leds[group];
> -repeat:
> -		list_for_each_entry(lctl, &led->controls, list)
> -			if (!card || lctl->card == card) {
> +		list_for_each_entry_safe(lctl, _lctl, &led->controls, list)
> +			if (!card || lctl->card == card)
>   				snd_ctl_led_ctl_destroy(lctl);
> -				goto repeat;
> -			}
>   	}
>   }
>   
> @@ -314,7 +311,7 @@ static int snd_ctl_led_reset(int card_number, unsigned int group)
>   {
>   	struct snd_card *card;
>   	struct snd_ctl_led *led;
> -	struct snd_ctl_led_ctl *lctl;
> +	struct snd_ctl_led_ctl *lctl, _lctl;
>   	struct snd_kcontrol_volatile *vd;
>   	bool change = false;
>   
> @@ -329,14 +326,12 @@ static int snd_ctl_led_reset(int card_number, unsigned int group)
>   		return -ENXIO;
>   	}
>   	led = &snd_ctl_leds[group];
> -repeat:
> -	list_for_each_entry(lctl, &led->controls, list)
> +	list_for_each_entry(lctl, _lctl, &led->controls, list)

The list_for_each_entry_safe() should be used here, too.

With the fix:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

						Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

