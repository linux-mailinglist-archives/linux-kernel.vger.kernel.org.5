Return-Path: <linux-kernel+bounces-104576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E187D042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFF3B20D45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF03FB09;
	Fri, 15 Mar 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDUH/F58"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A233EA77
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516505; cv=none; b=HLFcCBkMhLJd9hdJbz9c6AW4RKKbQRgDjsZoMWO4CZb2Os0X+31lXfCADnLeLekq8nO91CYoKajCcgcnwBbgfttdimhFuQFRnBIWoi7RoMdzvQ6/qpfqEJpWQE2AjiXWWSDen/r9YgS56TZYN2I0sOoYSK6Qo03BNS3GFXfHA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516505; c=relaxed/simple;
	bh=nXV5CjRW8BJxdHttD1h3qTKVpNuVLPLzdexACQdeKv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVO9ggQaYeFE+gH/9RX9jUhhJNtJwebLmhx1owhkqkjgQBKUBSHZgX366v1CmvymyI9BVQyOo8Z4gDpgCH0viqcYMVgVvczylHq4zAHuoMH1yS7pgio6kAjn2wSspks6l0piOkh+lUrB8i4SPYuStPnLIk4QHvZYJgzbC4ufrHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDUH/F58; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d23114b19dso26189511fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710516501; x=1711121301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8mkoyNdDIbEjZYoeFWO0a66QImPA2CQk2NlxXrdT8=;
        b=RDUH/F58IzmZGR1XsoS9cCPO8DVtt7YCQurAjajcjlgtmBK5eTt0YvCt5lTcFxUkzY
         XMdtGRmrRgb6aa3jMGFShWUwnUFYaWBHSzSpaS+BvOuCyFX0j6Rqr8bI0PDrWT9q4Q8z
         1uW+GVMIoiO54fIz+qicUm4aeilZKeQOr0/qHC5Zabw0I6jKga4Je69l1jXzeIu5U9Ql
         tN3NqVixoHv3Wr0kflgtKTDLtTgqCOG6wSzSfpv9uFadFNdtLzI1pC+FXggOL+uZDSaa
         AqguPu454kElSVhcwURQe0jrbXcZ0Jc/+QOFgmrNXKdzAQSyXJSYVbHbbKsm0c4lEZeB
         7r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710516501; x=1711121301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8mkoyNdDIbEjZYoeFWO0a66QImPA2CQk2NlxXrdT8=;
        b=MEPJvsqo22CoCLnXGIn7ICcQPzuCS8CV1FYa06WzuAbgaEgzJtrPMzSWvTqTSl/8Pu
         dq8IaVhcbPKgMELiYO+J+8dr802iaoOV7uv3lxQfZQ1Bd9qxOyHSvTTGI3/JyakOIbp1
         6s87xjm4TLPWtyRqeiBnSV1WuCdMmoC+c9uMHq7WE3eDu8oRtuC+4mEsCDTZWEmyAiNi
         dG71tWPb4KR/Y24DlrFVuPqVLX/3zR7dJEwuSrdvz61XrKjPk1RtiWViOUsKf7myGe88
         zUD1MeprJfsmpRlLedrfv1wx9XSSkbmREFvZPAX6cfeiS3sennp5QZBKYcAyFCUBWcMd
         EP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcPRjxR8oeD8WN6JgxhnNNUh9rK4kraepDumM6bb/9VYpzwLcp4gK8F+/H5yBjzGUlKHFlJEnNkqWOHCqVHRIaKn5ML/MZcLtzT8Bx
X-Gm-Message-State: AOJu0YzgMq4Cx8mra42NwU5lWmG7/fPG24es4RLahos7ROSE+yzotVVt
	ChUhx6PSMkq6vmZ9pNbdAJnZM9VXHuAkUYDB8ulCNotdA4AUturO5e2X0Rgcxw4=
X-Google-Smtp-Source: AGHT+IEv4KiX0VUKEaEam0pND8+D1J+qGZNRSiefb3SsE1hMQAKXvSamp9kPr2MXTXqoHfBaWZW3RA==
X-Received: by 2002:a2e:a68d:0:b0:2d4:57c5:886c with SMTP id q13-20020a2ea68d000000b002d457c5886cmr2953623lje.13.1710516501469;
        Fri, 15 Mar 2024 08:28:21 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c751000000b00568b43fffb0sm527149eds.96.2024.03.15.08.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 08:28:20 -0700 (PDT)
Message-ID: <65cf39ab-6813-4412-9e45-30c26ab27cd6@baylibre.com>
Date: Fri, 15 Mar 2024 16:28:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Add audio support for the MediaTek Genio 350-evk
 board
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>, Fabien Parent <fparent@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <4ffde184-cf68-4b71-b81d-9b5894529926@sirena.org.uk>
 <7ddad394-e880-4ef8-8591-cb803a2086ae@baylibre.com>
 <bf418207-7f13-4ced-8c21-2824dd07fab5@sirena.org.uk>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <bf418207-7f13-4ced-8c21-2824dd07fab5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/03/2024 15:38, Mark Brown wrote:
> On Tue, Mar 12, 2024 at 09:58:05AM +0100, Alexandre Mergnat wrote:
> 
>> I'm a bit lost for mixer-test and pcm-test.
>> Currently, I cross-compile the alsa lib project to be able to build the
>> tests and put it on my board.
> 
>> I can execute it, but I still have 2 issues:
> 
>> 1) I've a lot of missing module in my environment (Encode.so, Encode.pm,
>> Symbol.pm, IO/Handle.pm, ...). AFAII, I've to cross compile the missing perl
>> modules and install them in the rootfs
> 
> These tests are both simple C programs...
> 
>> 2) I don't know how to configure pcm-test.conf &
>> Lenovo_ThinkPad_P1_Gen2.conf (or new file to match with my board).
> 
> The configuration is optional.
> 
>> My test cmd:
>> ./run_kselftest.sh -c alsa
> 
> Just run the programs directly.  I'm only asking for the output from two
> of them anyway.

ok

-- 
Regards,
Alexandre

