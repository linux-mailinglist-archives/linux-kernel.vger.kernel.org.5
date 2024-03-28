Return-Path: <linux-kernel+bounces-122747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E388FC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28E51F2687B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE77CF3E;
	Thu, 28 Mar 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2FiZjsn4"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EF7C6E9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620578; cv=none; b=qQYCLixqg0Aj+68Ze8Zl6yOFR5KNi9PpQMyP7H7MNJ0oeO7BYTLFIQOX1f4BH1YfXfZ2QkYuDCPrS1MkAzM3FeT6az9PVtyulmt05NLkXEHzGhAO5mAQMZi6mtKtsM6KTlufYatHUv+IUhn6+ApzPPMb4Lz8yBZ+z4jam9TfdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620578; c=relaxed/simple;
	bh=FrsEbllgu5nSWbKKPqP082m+wmXkceS/8bSVAZaHeLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccNIgj5OV2eiyupAOWR3SlBs6RhaOaIVRWLZiSTP6LHK5K/TwGYDAqViOlYg4GFQ2bhF/sHeHmGTEbzax3MBdkqxIfMQ7zTPDRjG5zcAmuuq867F/PSYSfbgQLQ+7LU8xk7epXoPiY59V40cy98xDBLBAUYu+aux9npvrOlT1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2FiZjsn4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34175878e3cso532368f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711620574; x=1712225374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5wMiw22c5vII85IvPgCG/zbOc7PIefhra+kZ3K8oIE=;
        b=2FiZjsn4MJ87jzjepIbZmu/mDB5NHlpk2J0DU7pHikoV+lccS1VkhpjkI7om9XLyNb
         ABJXpsAVquGp8pePCVL+OmGITO7+Pb67E8pbxLMronhgcKIW3e0SBiSDI36C8Je9twMI
         ZPPX/zuSakN1NlvEciPnMHdTqgLNJCzosn7ed1AJtyfloX8ITMOz46QgePwTbwxHBLfT
         7T2ccdCx9Ep0WUoIA3vLBoAhN326whA11b5MnqZkKh/saq/tSI8P93myCbqimgXb5BAj
         1UbBM3Ox4gjLZoOBG3ZJtIfwg8WcDRtg8HyYKjA6zh1kHdfbQAF4+eBL/PFHIe5Qtk0p
         e1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620574; x=1712225374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5wMiw22c5vII85IvPgCG/zbOc7PIefhra+kZ3K8oIE=;
        b=A1/6y6fC4zko0Mbvn/yq52TFTEPoNcHxncmEtLX5IDCh7LOcrZmQp70xWxzoMb7fi5
         g1pC3Q7VB1Ltg5fg4k3Z8CG+YqzuDH1fgEYZ7R2QXseoPDlwACQYZ6O4x/b6TeVs4UMu
         gwUly1d6fx7nOcPytQif11E0ZRBh6r/6jxc8X44ZRaDK0mf4qhCJNvEASo+VUnJT4R9X
         uyPxS/Q2TijW7f1jgFaJnX/sbC2vwKj7AuTT8YFmlwt1Sk7pRjQU1HPkQ+2xPoWDtXmd
         6RnSQRCA8b/uDSwpC5WR3U1e2jewYrMWgtnIXFucKW0zSh5PH5GBhzuSR2hUstOP1TDQ
         AAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU9R4pSsAEYc8s+L669636W/BDhVxuyVgwLhl6sFskg1H5huo1L8xMIlwTULyNaYUrzzn293NoTXm1W72JWUGnvT50xCTEX6XZqsX/
X-Gm-Message-State: AOJu0YzhOGtsS24NDC5IvMcu632E43+WLPQjgV1wRQADTkQbhauvpXbz
	VHOIhN3MDa7qSDcmx6D5fhXqxg5ODuXIZk9Tq/Twwy6nMjI96DFXBAef8vyVnRc=
X-Google-Smtp-Source: AGHT+IFGHWYadDJCgABhwjbgmr/G/9ahD5CWJZRFUjAkHe014xq2ZOOYv0q270M74EFrQt4il5g9rw==
X-Received: by 2002:a5d:6d82:0:b0:33e:9292:b194 with SMTP id l2-20020a5d6d82000000b0033e9292b194mr2493550wrs.14.1711620574475;
        Thu, 28 Mar 2024 03:09:34 -0700 (PDT)
Received: from [10.1.5.127] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ea2-20020a0560000ec200b003432d79876esm1316197wrb.97.2024.03.28.03.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 03:09:34 -0700 (PDT)
Message-ID: <4dba5a65-d1dc-4a80-bcaa-fe9ba02c5082@baylibre.com>
Date: Thu, 28 Mar 2024 11:09:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Add audio support for the MediaTek Genio 350-evk
 board
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley
 <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Flora Fu <flora.fu@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>, Fabien Parent <fparent@baylibre.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <53671deb-9c11-43c1-8deb-93fe4708651a@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <53671deb-9c11-43c1-8deb-93fe4708651a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Angelo

On 26/02/2024 15:54, AngeloGioacchino Del Regno wrote:
> Il 26/02/24 15:01, Alexandre Mergnat ha scritto:
>> This serie aim to add the following audio support for the Genio 350-evk:
>> - Playback
>>    - 2ch Headset Jack (Earphone)
>>    - 1ch Line-out Jack (Speaker)
>>    - 8ch HDMI Tx
>> - Capture
>>    - 1ch DMIC (On-board Digital Microphone)
>>    - 1ch AMIC (On-board Analogic Microphone)
>>    - 1ch Headset Jack (External Analogic Microphone)
>>
>> Of course, HDMI playback need the MT8365 display patches [1] and a DTS
>> change documented in "mediatek,mt8365-mt6357.yaml".
>>
>> [1]: 
>> https://lore.kernel.org/all/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com/
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> Actually, I am cooking a series (I'm finishing the testing....) that 
> brings quite
> a bit of cleanups in MTK ASoC, including the commonization of the 
> machine driver
> probe, with the dai-link DT nodes, and which also modernizes most of the 
> existing
> drivers to use that instead.
> 
> If you wait for a day or two, your mt8365-mt6357.c driver's probe 
> function can be
> shrunk to ~3 lines or something like that.. very easily :-)

Just to inform you. I'm aware of your serie. Currently, I've fixed my 
patches according to the comments. The next step will be to rebase my 
serie over yours and do the changes to be aligned with your new 
implementation.

I've planned to review your serie during my last task, but it seems 
already approved and already (partially) merged into linux-next, sorry.


-- 
Regards,
Alexandre

