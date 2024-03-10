Return-Path: <linux-kernel+bounces-98354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC708778C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887371F21658
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDB3B79F;
	Sun, 10 Mar 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xnux.eu header.i=@xnux.eu header.b="GTkGpEn3"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E73B78D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109768; cv=none; b=W0YWEVn2Try9zFvql1nMy2Xwy4atjFMBZQvLkqXq/Ufv/dta9361vwEXidpso4ijL1qIbJvOi9Ahlebl+BrLkuUdAdwUvfj+qwpTYctdFLhvDbR+XJm2cHE+hrFB86VQiMFRhptHSlTm5/JD4pq23esAD68kvX9iTtu8Ymp7r8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109768; c=relaxed/simple;
	bh=0dh7I6BWcg7FvSd5QFiZfq+RVCTqyfeXWc/UPHa5atk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLzQTbIBlyn7brcK38JjFr8pLroDjwWT5p7Xb0rB8pyPD3wmUasD/x0WbQp4rf2oRZtjp0hkpz69Yj0CZTKU6v3/nBk16I8usLMCw5rQLCCJAAkII6xXpCWDDw9izyLCCZoQK9nUinL6cOO/ygokGxd1j8D/9NpFTFEfbMF5oZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xnux.eu; spf=pass smtp.mailfrom=xnux.eu; dkim=pass (1024-bit key) header.d=xnux.eu header.i=@xnux.eu header.b=GTkGpEn3; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xnux.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xnux.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xnux.eu; s=mail;
	t=1710109441; bh=0dh7I6BWcg7FvSd5QFiZfq+RVCTqyfeXWc/UPHa5atk=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=GTkGpEn3N5HcVUAR98jLSZy17qzKnKu8TgBB3cjtDGJQwkOzKb2yJp+bqFI3joH8J
	 uxgzo2F5cx7Ie2uyLtEtjQHwljMVm3T9ziyfDh8cfCjn0rjENGS4QXMOWjo56VdoDY
	 MuQU5vWCEQULn3w6drNgNV6COrsqnjUR85xMS+IE=
Date: Sun, 10 Mar 2024 23:23:57 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <x@xnux.eu>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Icenowy Zheng <uwu@icenowy.me>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: tcon: Support keeping dclk rate upon ancestor
 clock changes
Message-ID: <s3iqqnqiqnlujncbb6vnip7hvofgbom54on7fx4hxmyfsk2v2w@gbvpkptsa5g3>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <x@xnux.eu>, 
	Frank Oltmanns <frank@oltmanns.dev>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Icenowy Zheng <uwu@icenowy.me>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>

Hello Frank,

On Sun, Mar 10, 2024 at 02:32:29PM +0100, Frank Oltmanns wrote:
> +static int sun4i_rate_reset_notifier_cb(struct notifier_block *nb,
> +				      unsigned long event, void *data)
> +{
> +	struct sun4i_rate_reset_nb *rate_reset = to_sun4i_rate_reset_nb(nb);
> +
> +	if (event == POST_RATE_CHANGE)
> +		schedule_delayed_work(&rate_reset->reset_rate_work, msecs_to_jiffies(100));

If you get multiple reset notifier calls within 100ms of the first one,
the delay from the last one will not be 100ms, so this may violate expectations
you're describing in the commit message.

schedule_delayed_work doesn't re-schedule the work if it's already pending.

Kind regards,
	o.

