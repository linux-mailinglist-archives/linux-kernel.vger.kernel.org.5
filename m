Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B1790DCA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjICTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjICTnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:43:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA38D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:43:00 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id csznqEPtQewmQcsznq9Uxm; Sun, 03 Sep 2023 21:42:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693770178;
        bh=GE0Tfzjpz86rKqx1XQM/i0q6J5a2RTGmwR3F95mdOYI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IwniJbf3qMuGb2ARD6r1f7GT0OL6OG8OZ05zadRj8NGirUDd/LVZKeZaYIvY2ZyWn
         G7ojOq6ps7KJuSVuuAt36R9tz1riTb4ICbEn06SjSRDsB7KgDETBOJUlqzffkWVgPn
         28tsZdlhscrsWqNmRV83IRqjBCCgNdsqCYPnrrd3fLVZnkKm67qO6NYCpv2SJKdNyN
         +gk1X8g/OTCsNvV5fOn3fPftCVAGAPnZhllEq9LWMmxLwScCLHtRA5HjtZJDJzjtUq
         Z4nTBiLpIa4cqUQk9AjmRu253i7OJd4rtqunF5v0czGxh/LEiEFyZrsr/PaFGJFS0L
         bekWIOkJ1FTBg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 21:42:58 +0200
X-ME-IP: 86.243.2.178
Message-ID: <a0387d53-a08f-5e0c-c3a5-681ab5545150@wanadoo.fr>
Date:   Sun, 3 Sep 2023 21:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: usb-audio: Fix a potential memory leak in
 scarlett2_init_notify()
Content-Language: fr, en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr>
 <871qffmj2d.wl-tiwai@suse.de>
 <8cde2320-517f-3a38-8c3f-f807791c6c52@wanadoo.fr>
 <87sf7vkybk.wl-tiwai@suse.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <87sf7vkybk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/09/2023 à 18:37, Takashi Iwai a écrit :
> On Sun, 03 Sep 2023 17:04:47 +0200,
...

> Indeed.  The fix would be rather a oneliner like below, though:

Looks much better than mine :)

I let you send the patch, it is your solution.



Just for my understanding, how is snd_ump_ops used, especially .open?
I've not been able to figure out where it was called.

In alloc_midi_urbs(), if usb_alloc_coherent() fails, then 
ctx->urb->transfer_buffer could be anything because usb_fill_xxx_urb() 
is not called.
So there could be an edge case where your fix could still be incomplete.

For the start_input_streams() caller, this is fine, because the 
corresponding memory is kzalloc()'ed in start_input_streams() at some 
point, but I've not been able to check for snd_usb_midi_v2_open().

CJ

> 
> --- a/sound/usb/midi2.c
> +++ b/sound/usb/midi2.c
> @@ -265,7 +265,7 @@ static void free_midi_urbs(struct snd_usb_midi2_endpoint *ep)
>   
>   	if (!ep)
>   		return;
> -	for (i = 0; i < ep->num_urbs; ++i) {
> +	for (i = 0; i < NUM_URBS; ++i) {
>   		ctx = &ep->urbs[i];
>   		if (!ctx->urb)
>   			break;
> 
> That was the intended behavior of free_midi_urbs().
> 
> 
> Takashi
> 

