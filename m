Return-Path: <linux-kernel+bounces-15395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11179822B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA0B21CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7928418C0A;
	Wed,  3 Jan 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apu9sLgz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50371805D;
	Wed,  3 Jan 2024 10:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79CC433C8;
	Wed,  3 Jan 2024 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704277988;
	bh=1BgUTpkdDldXnjMo4DLuL4PLeUJaaO/B1orsSOzYVL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apu9sLgzA6jGCkWi2oekCvCh3kuD04KzQY7+RZQxg6q8J/73xyTbESvy3qn94tLNv
	 vVN9LZ2M2JYrhT7egPmWBgTcy6zNEWQfcGrXI/wCJXRDwIoSa9gHUeoSPd0E5iRe73
	 hoIDVKcmKu+XGI1Y68Fnc0dYXOn5l/HVbEhCBdBI=
Date: Wed, 3 Jan 2024 11:33:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, Yu Liao <liaoyu15@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: ac97: fix build regression
Message-ID: <2024010332-sermon-snowy-cf47@gregkh>
References: <20240103102544.3715055-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103102544.3715055-1-arnd@kernel.org>

On Wed, Jan 03, 2024 at 11:25:38AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ac97_bus_type structure is no longer declared in this file:
> 
> sound/ac97/bus.c: In function 'ac97_codec_add':
> sound/ac97/bus.c:112:27: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
>   112 |         codec->dev.bus = &ac97_bus_type;
>       |                           ^~~~~~~~~~~~~
>       |                           bus_type
> sound/ac97/bus.c:112:27: note: each undeclared identifier is reported only once for each function it appears in
> sound/ac97/bus.c: In function 'snd_ac97_codec_driver_register':
> sound/ac97/bus.c:191:28: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'ac97_bus_reset'?
>   191 |         drv->driver.bus = &ac97_bus_type;
> 
> Include the header that contains the declaration and make sure the definition
> is const but not static.
> 
> Fixes: 66e82d219924 ("ALSA: mark all struct bus_type as const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/ac97/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Ick, sorry about that, this didn't trigger in all of my build testing,
nor for 0-day, odd.

Anyway, thanks for the fix it is obviously correct:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

