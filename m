Return-Path: <linux-kernel+bounces-131504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E88988CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E8928ECB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2591127B45;
	Thu,  4 Apr 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ba7UF+8J"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA8433A8;
	Thu,  4 Apr 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237434; cv=none; b=YNG99r75NItcgBpYnwlOc5n/yA1jPh6G8pn4ErlJL5QG0Vj6kY3HemzeB4yRh2764cEJy+oKzNgu2HnwXtqo4OzVs4Ekh2qHnfMsTKN/ifw+FDmZfnOkuAd5MBGisviXepiExlLhzqyjXEqoWP3VnUsc+Xuhq0g0MX0wZ74PwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237434; c=relaxed/simple;
	bh=V05vvnqU1BcexcFjfW4W3SDJUB2OtOy3KSr5NabUMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeOX0frf6BhgPIHOsQsyuciMzYh5z3Kc3FEgHL8h9ONAQmY3RlnX+DKEIp90ZeyuMs4y/XozzUCTM9tzTKDYxamqhKeJc3LNl8hI/iE37gaXin58CvbJm/hV7pADgT96nVs3A/IoCf7nvfvyZpB9e6qcd91xVmFyQaaw0f2FGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ba7UF+8J; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01761E0007;
	Thu,  4 Apr 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712237428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EXfWN8P5VuDS2tBKaeYIlzaBwuTnbSXHh8enyfbC6U=;
	b=ba7UF+8JV+FUxeINhwDSQnK1ILQ48DdDGJ5chAH1bbH0a9rSIAGu+dlfF6S3nEONdeOMDM
	FQFWH8doHp71yQhqmce2cqPN3JBMWdAB0DTw+a5DdLjysOuFskJIfTV22wc124gbZur2d4
	rM+ClKUdebYrTTLGCFb7Z1o9P7tB2CWAaG/zY957p3b1fnfIjitn8UsrMllSmeibvNs/bn
	3r2z2MFlSWnY7Rbxt8zhghje8vK5U1dHp44F84Ex2hcrrFFEkRul09F6O1OLT80RhP23w8
	DC2OFAbhtwcyrSqe1XNEUF0CHlQBBddet1uNmyYYR4KdAJ0AG2L+xJqIZbDYvw==
Date: Thu, 4 Apr 2024 15:30:26 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rk3308: fix building without CONFIG_OF
Message-ID: <20240404153026.2aaa3797@booty>
In-Reply-To: <20240404095755.650364-1-arnd@kernel.org>
References: <20240404095755.650364-1-arnd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Arnd,

On Thu,  4 Apr 2024 11:57:34 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added codec has an extraneous of_match_ptr() annotation for
> the ID table:
> 
> sound/soc/codecs/rk3308_codec.c:956:34: error: 'rk3308_codec_of_match' defined but not used [-Werror=unused-const-variable=]
>   956 | static const struct of_device_id rk3308_codec_of_match[] = {
> 
> Remove it to avoid introducing a warning when -Wunused-const-variable
> gets enabled by default:
> 
> Fixes: 4ed0915f5bc4 ("ASoC: codecs: Add RK3308 internal audio codec driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/codecs/rk3308_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
> index 9d3e4691a7b5..6b1cb92997b4 100644
> --- a/sound/soc/codecs/rk3308_codec.c
> +++ b/sound/soc/codecs/rk3308_codec.c
> @@ -962,7 +962,7 @@ MODULE_DEVICE_TABLE(of, rk3308_codec_of_match);
>  static struct platform_driver rk3308_codec_driver = {
>  	.driver = {
>  		.name = "rk3308-acodec",
> -		.of_match_table = of_match_ptr(rk3308_codec_of_match),
> +		.of_match_table = rk3308_codec_of_match,

Thanks for your report!

The warning has already been reported by the kernel test robot
<lkp@intel.com> and I have sent a patch to fix it:
https://lore.kernel.org/linux-sound/20240403-rk3308-audio-codec-fix-warning-v2-1-816bae4c1dc5@bootlin.com/

The approach I took is different though: I have added __maybe_unused
instead, which has the advantage of not adding a struct of_device_id
array to kernel built without CONFIG_OF.

My patch has already been taken by Mark. I hope this is fine as well for
you.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

