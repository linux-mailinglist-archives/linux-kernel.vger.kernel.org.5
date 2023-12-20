Return-Path: <linux-kernel+bounces-7378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB65A81A6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A0E1F241B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8440C04;
	Wed, 20 Dec 2023 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Cxv7yV7G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279CB482D8;
	Wed, 20 Dec 2023 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id G1W8rNFQK2jhsG1W9r1NFu; Wed, 20 Dec 2023 19:42:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703097731;
	bh=1aXf5U5FDe/0i5BeeyH6/HI/O9yNNtu8EhsKznoQIpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cxv7yV7GcM2zJHWoh7iPmri0WsQP4Aic7YyNEp5OlKaRy8rS5NxQNobFKndYdNIBK
	 jNgpJiNI543DfnT5miu9eEGeEjURVd/YLgBUCExYDvolVXxK6I9iCjves9U+E5sPsA
	 NUkZA8FUt6AN4APbcE3FjkWW4sn59jGWtmPlQbn2yy9YF4c0BFLy7284mtPm56c8F2
	 EpphfvKCcmu23K1+gcRSrOea5Ybj3f6YtZE3PM4hDboIZ7qbqwZsvx3I6cbWC7qdzf
	 jl9B6sEIByvLrFijxMbG6O7MhkhyXEygDC0A9LGiYdHbR+QA9ttJHSl8ClXGLZ89Fm
	 +OWOZrTyfZZLw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 20 Dec 2023 19:42:11 +0100
X-ME-IP: 92.140.202.140
Message-ID: <1c9ec8e6-136f-4b69-a1ec-b1c24d85d80a@wanadoo.fr>
Date: Wed, 20 Dec 2023 19:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] ASoC: soc-topology: Switch to use
 dev_err_probe() helper
To: yang.guang5@zte.com.cn, lgirdwood@gmail.com
Cc: jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202312201057082362118@zte.com.cn>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202312201057082362118@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/12/2023 à 03:57, yang.guang5@zte.com.cn a écrit :
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> dev_err() can be replace with dev_err_probe() which will
> check if error code is -EPROBE_DEFER.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>   sound/soc/soc-topology.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index ba4890991f0d..c0d40162aff2 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1736,8 +1736,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
> 
>   	ret = snd_soc_add_pcm_runtimes(tplg->comp->card, link, 1);
>   	if (ret < 0) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(tplg->dev, "ASoC: adding FE link failed\n");
> +		dev_err_probe(tplg->dev, ret, "ASoC: adding FE link failed\n");
>   		goto err;
>   	}
> 
Hi,

apparently, err: is
err:
	return ret;
}

So, you could probably, directly use return dev_err_probe(...); and also 
save some { }.

CJ

