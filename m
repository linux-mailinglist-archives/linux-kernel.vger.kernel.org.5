Return-Path: <linux-kernel+bounces-57009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76D584D2D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169211C22852
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062E1272BE;
	Wed,  7 Feb 2024 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Q8BBWGyp"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290E126F11
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337322; cv=none; b=JNc4KLBohFBRP/GL4AfLezaNl0Fp2t4/C/PgX174WgGvaRW+ZGTUIvF4fZMKwBWQBGdgoNbMnjSxsTNQ1zw1mpgPHGqb1GrQuKHozRifLluAKhCdthwf5acRD0rWotEK2IG1+5JXCGncHHWIGokR1RWnn7xUGGYE33yr6Q0v5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337322; c=relaxed/simple;
	bh=i3XpBGDoD9F52CwY8m+nZ5lY1uCjGSkm+bBzMFeSARQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sic38/8MJPJGM2AK5YcXYRpUiKbuIRjbHBSQDfM8H8mnl7IjT7yqB1xcG7fTbfdnmYApOl2h4Ccqb6UFG2pWIyrCB9AbKtZ7O4Hz66GYW048fjaPVZn24jXGOtJZVPEU3gj3+UTo3o5bxNxF1lB06V5U4BdNk6kY1gDR8JKrXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Q8BBWGyp; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TVWjv1R76zDr0R
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1707337315; bh=i3XpBGDoD9F52CwY8m+nZ5lY1uCjGSkm+bBzMFeSARQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q8BBWGyptFpwjRCPSgTyn8Q/Mp4rL6jMFAxDwTT4zBFhdss7cWQ1c1wMH5V/Uinsq
	 vq4BZS7JthW5EY4DQvd78kmrDAPpmE+tyoS6E+Qf0LRkGnXOalQpjZVu8sDD8AOmMA
	 Nai8VNjCTPOq7xDXfcKjp9+GPkhFIVGXS0BzRZaY=
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4TVWjn272Rz9wpF;
	Wed,  7 Feb 2024 20:21:49 +0000 (UTC)
X-Riseup-User-ID: A119657D52AA30ACBA852831A1D54514D8C49CF4D1DBA5B0DA7DE26AB620A038
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4TVWjh1VkdzFwY8;
	Wed,  7 Feb 2024 20:21:43 +0000 (UTC)
Message-ID: <902e30af-b917-4cd7-a6bf-2ba13e5cc9ac@riseup.net>
Date: Wed, 7 Feb 2024 17:21:41 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
 Maxime Ripard <mripard@kernel.org>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 marcheu@google.com, seanpaul@google.com, nicolejadeyee@google.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20240201-yuv-v1-2-3ca376f27632@bootlin.com>
 <20240202105522.43128e19@eldfell> <20240202102601.70b6d49c@xps-13>
 <3nofkwzgnf4yva2wfogdbii47ohpi2wm5vp6aijtg3emxyoowt@twyreqz7ai3g>
 <20240202131322.5471e184@xps-13> <20240202174913.789a9db9@eldfell>
 <20240202170734.3176dfe4@xps-13> <20240202214527.1d97c881@ferris.localdomain>
 <d258c8dc-78e9-4509-9037-a98f7f33b3a3@riseup.net>
 <20240207104407.7b06bac2@eldfell> <ZcOpzszyR49_MlqB@localhost.localdomain>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <ZcOpzszyR49_MlqB@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/02/24 13:03, Louis Chauvet wrote:
> Hello Pekka, Arthur,
> 
> [...]
> 
>>>> Would it be possible to have a standardised benchmark specifically
>>>> for performance rather than correctness, in IGT or where-ever it
>>>> would make sense? Then it would be simple to tell contributors to
>>>> run this and report the numbers before and after.
>>>>
>>>> I would propose this kind of KMS layout:
>>>>
>>>> - CRTC size 3841 x 2161
>>>> - primary plane, XRGB8888, 3639 x 2161 @ 101,0
>>>> - overlay A, XBGR2101010, 3033 x 1777 @ 201,199
>>>> - overlay B, ARGB8888, 1507 x 1400 @ 1800,250
>>>>
>>>> The sizes and positions are deliberately odd to try to avoid happy
>>>> alignment accidents. The planes are big, which should let the pixel
>>>> operations easily dominate performance measurement. There are
>>>> different pixel formats, both opaque and semi-transparent. There is
>>>> lots of plane overlap. The planes also do not cover the whole CRTC
>>>> leaving the background visible a bit.
>>>>
>>>> There should be two FBs per each plane, flipped alternatingly each
>>>> frame. Writeback should be active. Run this a number of frames, say,
>>>> 100, and measure the kernel CPU time taken. It's supposed to take at
>>>> least several seconds in total.
>>>>
>>>> I think something like this should be the base benchmark. One can
>>>> add more to it, like rotated planes, YUV planes, etc. or switch
>>>> settings on the existing planes. Maybe even FB_DAMAGE_CLIPS. Maybe
>>>> one more overlay that is very tall and thin.
>>>>
>>>> Just an idea, what do you all think?  
>>>
>>> Hi Pekka,
>>>
>>> I just finished writing this proposal using IGT.
>>>
>>> I got pretty interesting results:
>>>
>>> The mentioned commit 8356b97906503a02125c8d03c9b88a61ea46a05a took
>>> around 13 seconds. While drm-misc/drm-misc-next took 36 seconds.
>>>
>>> I'm currently bisecting to be certain that the change to the
>>> pixel-by-pixel is the culprit, but I don't see why it wouldn't be.
>>>
>>> I just need to do some final touches on the benchmark code and it
>>> will be ready for revision.
>>
>> Awesome, thank you very much for doing that!
>> pq
> 
> I also think it's a good benchmarks for classic configurations. The odd 
> size is a very nice idea to verify the corner cases of line-by-line 
> algorithms.
> 
> When this is ready, please share the test, so I can check if my patch is 
> as performant as before.
> 
> Thank you for this work.
> 
> Have a nice day,
> Louis Chauvet
> 

Just sent the benchmark for revision:
https://lore.kernel.org/r/20240207-bench-v1-1-7135ad426860@riseup.net

