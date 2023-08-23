Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3687B785E75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbjHWRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjHWRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:20:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56375E6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:20:55 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id YrXFq32vGOQiUYrXFqJe0n; Wed, 23 Aug 2023 19:20:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692811253;
        bh=YilPLjsAWAxMFRuKLpbH+AIhWQZHyzpkkkrXHbp8NnU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=p1eGtxNYAJtWoXIYRNkuQU2TmowPauX7I20RNz9Q0sQNKAEiiYqVRh+uyxkR02v1P
         2hqB5ZgknXzE7eI1sOp75WRgi0oFbp3tTo5StkC2KiMY8hk60RvfuYCqI2HZ5+6Dly
         5IF7Axj20dlTXNj0OWWU69i6tZow0qvfoQf8a945gCIpq5TqqpTzFZBEpzBwIcHzZ3
         8T+Blv999CcFiX4vkhvamkGzrNf8q1Ngy7fLkp7f//eKw4G8YslB0sQi86F+VhyaNQ
         ZIPZjIsuaRBaA4TN+25zUcXsuEUCcVqiQY+Vu9gXN/w5y6Pjf5w4HeFBvvLg+NqRlU
         9fjuPnoj3lbuQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Aug 2023 19:20:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <ddc14926-45d8-9b20-9523-0fb6afa499b3@wanadoo.fr>
Date:   Wed, 23 Aug 2023 19:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: ac97: Fix possible error value of *rac97
Content-Language: fr
To:     Su Hui <suhui@nfschina.com>, perex@perex.cz, tiwai@suse.com
Cc:     arnd@arndb.de, robert.jarzmik@free.fr, yangyingliang@huawei.com,
        maciej.szmigiero@oracle.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20230823025212.1000961-1-suhui@nfschina.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230823025212.1000961-1-suhui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/08/2023 à 04:52, Su Hui a écrit :
> Before committing 79597c8bf64c, *rac97 always be NULL if there is
> an error. When error happens, make sure *rac97 is NULL is safer.
> 
> For examble, in snd_vortex_mixer():
> 	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
> 	vortex->isquad = ((vortex->codec == NULL) ?
> 		0 : (vortex->codec->ext_id&0x80));
> If error happened but vortex->codec isn't NULL, this may cause some
> problems.
> 
> Move the judgement order to be clearer and better.
> 
> Fixes: 79597c8bf64c ("ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   sound/pci/ac97/ac97_codec.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 80a65b8ad7b9..25f93e56cfc7 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2069,10 +2069,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
>   		.dev_disconnect =	snd_ac97_dev_disconnect,
>   	};
>   
> -	if (!rac97)
> -		return -EINVAL;
> -	if (snd_BUG_ON(!bus || !template))
> +	if (snd_BUG_ON(!bus || !template || !rac97))
>   		return -EINVAL;
> +	*rac97 = NULL;
>   	if (snd_BUG_ON(template->num >= 4))
>   		return -EINVAL;
>   	if (bus->codec[template->num])

FWIW,

Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

CJ
