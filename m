Return-Path: <linux-kernel+bounces-149840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E438A9697
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A445BB21EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE740125D6;
	Thu, 18 Apr 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yEVy/iks"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0E15AD8E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433579; cv=none; b=GQistoQx1V1IoahLSCSnCC3sulE8wRZxEGduQmrL4w07TILTpdw7R6bvtDHSTRDA0M64DhsTwBGDgSJXdnchLTULvnOS8mcXg4ECGobZ8P/DYtNFwgi/Co06U0pXXleIgbPQjVgP6pna7SFPpogWJ7I7ZqYtwW0lZF2fxi/78vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433579; c=relaxed/simple;
	bh=QR450DPU8OzcEkmYkgjgRjPQF6842rrOEaOvoQ0x5nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIBbWzSlkpZREoa/WDULjJDVe1ZjOVmiWdofrmhp/750iBWdd4cKDkAbXYy7DUTQtduq975BGHUTIXc0PgRXbQ5qjrtPSEEoyC1AwzOsb3w9xdcYj5g1mjrjbf8oFSaU1ojr5aT2t4RuxrQ0XUdbAyqhXb3pDny0SFymqNRa78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yEVy/iks; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso981491e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713433574; x=1714038374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHTQNdaixaJmXmKKuqa6bURMHudpKto3SJOTxQWsB1k=;
        b=yEVy/ikscqdcdfnXKXgDJCcl8t3X4rgcVC9+vfcL4CicX4qkrUshxt7RhSJdVyBCPi
         AmNz3YwTivc0vAO4OU5EMDYg3XuWmOhtQFgGqNIudn+YXYkUuX/nXr4e024bTJGAOfO9
         762mJdUbQ1YQiEGyPqygp2Q02Ktsv/NfTrae729jB+6D0EJhvRhEOCISN/gT9i9mX/s2
         7VSw5sLjRX7gzTyWW5eUwvmrlXGUBeKuXlXrCD6Gdnu9ofp8+1YqiFlVcqLUN+zft0ec
         hDqfg/WHq/bUcl5i+oBBqLpiwE4zC+ZCppJb3W/cD5Sv3Hz5EYpB+ZoCKK80sShyQTA0
         w5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433574; x=1714038374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHTQNdaixaJmXmKKuqa6bURMHudpKto3SJOTxQWsB1k=;
        b=BacrPSDK65h1rczBiwahQDy43vdNr9JGus5BFFAt/YK2ITMedsq8BL3aSLi5i3t3JQ
         aqjx0oBl+j9Fn9wnvvydJzMyvz5bUVXzBjmM7t1AnNf7BeKSb5WyX+qS8LMQfPmfixoD
         0EYxvouLQdp9ozpVFBMzQZipg/Xyuj3MmtVdGnb+KBrFV1y22fmjm820H7e80RdDGbum
         RK4HA5k0xb7g15e2jPsOyTD7sd9+sCztGH3asDm7RhiOxT2pXmwauVua0dvLE4kFynRQ
         yRCjkMUv4oVLa3b1/CB8X5j/sPIGApSk20YxOUwUIhgUQp21gpeLFXDLZpZAhNbYlRQ6
         sPtw==
X-Forwarded-Encrypted: i=1; AJvYcCUAQtm6Hii3kwxq1V6Roq9mT5NGDix2k9E97QfiI6MZiF4TvldNPOTiZCE2cTh5zNDA+OxX7OCqPxJMEo2nnVYuN6bLiXnA//4uYEYe
X-Gm-Message-State: AOJu0YxqCeODfdTnUmM3gF/h5g+HoxuNY+I9qSfPbgPmo/ZKoylDEHKz
	6o0xrqfgPMWtoMJQyzefMHnveZnwRdMrSYZpo4ZXtlV0Fuq62F3rxGQ8cFn3VRs=
X-Google-Smtp-Source: AGHT+IFKKdpyMPlE5wECrwePw/LL4UVvAqkEhlLOtaK+0nLQSsDUk8IMg3W91iM2KaJpK31eRkk28Q==
X-Received: by 2002:a05:6512:ea5:b0:518:e7ed:3c7c with SMTP id bi37-20020a0565120ea500b00518e7ed3c7cmr1799688lfb.14.1713433573769;
        Thu, 18 Apr 2024 02:46:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906388a00b00a46aba003eesm647759ejd.215.2024.04.18.02.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:46:13 -0700 (PDT)
Message-ID: <286945bc-f207-4373-9589-0a9b62df1b36@baylibre.com>
Date: Thu, 18 Apr 2024 11:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
 <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <vasuzy7cf5x6p5rnrmdrk5z54oncu2yuutupf25h5fgd5y6fpl@mnkf67agw64g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe

On 17/04/2024 10:06, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 16, 2024 at 05:53:13PM +0200, Alexandre Mergnat wrote:
>> Add a compatible string for MediaTek Genio 350 MT8365's display PWM
>> block: this is the same as MT8183.
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> I already asked in reply to v1 what the merge plan is here. There are
> changes in my pwm tree to the mediatek,pwm-disp binding already. I don't
> think they conflict with this patch, but maybe it's still easier to take
> this via pwm?!

Sorry, I though the merge strategy wasn't addressed to me because I'm not a maintainer.
It's fine for me to merge it in the PWM tree.
IMO, this change [1] shouldn't conflict with this patch.

Can you add the "Acked-by: Rob Herring (Arm) <robh@kernel.org>" please if you merge this version ?

Thanks for the review and help.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/commit/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml?h=pwm/for-next&id=fb7c3d8ba039df877886fd457538d8b24ca9c84b

-- 
Regards,
Alexandre

