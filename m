Return-Path: <linux-kernel+bounces-138254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527689EED4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06C41F21559
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB4158DB7;
	Wed, 10 Apr 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T9qHz4n4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E41553B3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741357; cv=none; b=h8Wce+QjXn1obsDWqZ6Xe3ymIyedYZja8qzizGDJgc9wBR1TXBf1fmPCvVZ4Ss8C+r8n/4Cbj5PIb3aXkBhJZd+PQqXkVv9BmLjum3+iFJyIn81R8VgdjDZ/iNRBdkQwA4IJYWUuIObBRM7bkG/GNnr67erdJJfNDSb8lJf7lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741357; c=relaxed/simple;
	bh=6BEZbI7KV8B3eszDr0HfCNB0Z0sn1CHOU8k8kIi+hgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDA86qZVlt/IjRuL3zwPAztjf54dl5FVv9IlHqdj7K1g7Ty4Njdlzt5KPLCD7AvL+0AuzhLxq9DPFNImdZpBA4ta1HHLX38R7z6UQQTFYIsZ06FhU3yqd2yBL5XdLyE0QFQ4loanqnHZ421Ft05v93IFdBzCw6Td086EVdnrzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T9qHz4n4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41739e4f8caso1624985e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712741353; x=1713346153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4kwkorErv8tb8SzoHtazPQP+BQoahujJfqdWOv/amk=;
        b=T9qHz4n4Foc7hRwTv8yZWgRFWk8UMS0PDxgLT9anc4rF9s/kddxFrngEaQhDamPwRA
         97hEFJnVUD1GXCXBSb6oHYIcJ6gWwwEuVNzi1Qbtu5ExUEJOWn70tcc6mgeONlj52Jv0
         +mmwolViO+G6iB/W1UfuAMYsaNmugR1WGg2YB/mUhJisDcFsAHD0I1OJvHRZRxCVX1G/
         5aoU4oM6iXnxteFTnD0U3KSWukMYd+0Upr4tnLYacRqGqwUdikSfPT4qrob7RpoZqj3d
         WS1KOIGsq1B1P5xiqfcd/2CrdYPfZxe+TWX9bBRMayTMp4PO6aGCyIF5PDKaBoNEEC/7
         /bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741353; x=1713346153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4kwkorErv8tb8SzoHtazPQP+BQoahujJfqdWOv/amk=;
        b=uU7m4HBongkp5aFOP4Lv3rE+Ak9XU58pwcr9YH2ngwgXenJQQ9p3P7ARz96QYEetR6
         slY48ltd6R/cNnIfRQCAL2HZNJVzp0ldSfoi7ffpNjOxcSH8YuBO0ajFXRmDBQvQhpXu
         TKjpsMYC95U4XuWgd5CUKDtb6ltCAS/FmRhzE89jO4nWIBs4YUyIB8U0+PeEMXaGXMbD
         StfJN76fP0zgTLx71Zm8Q63nfEnzNdoeG4is1g4pajHA03a+SkkWNpLxP5fbZIn+/SRC
         uhi+f6qUMZUC9kXqPIGmWuXp4/oZqfVHyqgAACrl0bZYF1FQ8UjwfWDtp4EYQ+vEb1ix
         C5uw==
X-Forwarded-Encrypted: i=1; AJvYcCWaqyelUc4fo0djUOh5YdKyjm5kQFFI0A/S+krEKmclM4xjpnfTSyE1J18Pi4WyIey/xCCZM2EddMdsYf9rq3DC9gNT9dm6gqVOpb6q
X-Gm-Message-State: AOJu0YyJGSoEvGSKNEDDnupVIkB9lf+zR2klfsDhN354u2YFG9UoGT2m
	n85qI1gUTHS92PtsSUWsRIeojgl62OBJcy+kW6KrqyuOlc61DicESh62gW9b8yM=
X-Google-Smtp-Source: AGHT+IFvXyauqU6yE1hhXxe+82hSR7xjimh79oxs60By+238847k+6MrB7Ys5sLNSFw6IjHtaU72FA==
X-Received: by 2002:a05:600c:5252:b0:416:643c:8946 with SMTP id fc18-20020a05600c525200b00416643c8946mr1274626wmb.17.1712741353432;
        Wed, 10 Apr 2024 02:29:13 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b004168efc77d1sm1698186wmq.39.2024.04.10.02.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:29:13 -0700 (PDT)
Message-ID: <9ecf2158-10d1-47b3-a02f-54a4cddbf426@baylibre.com>
Date: Wed, 10 Apr 2024 11:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/18] ASoC: dt-bindings: mediatek,mt8365-afe: Add
 audio afe document
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
 <20240226-audio-i350-v3-1-16bb2c974c55@baylibre.com>
 <e0b48da7-b33c-45e4-b3f3-a6d71bb0afe2@linaro.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <e0b48da7-b33c-45e4-b3f3-a6d71bb0afe2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 17:46, Krzysztof Kozlowski wrote:
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        afe@11220000 {
> Did you implement the comment or decided to keep afe?
> 

Though it was clear according to [1]:
"
Audio Front End, this is the same name used for other MTK SoC, to be
consistent.

Cook a new patch serie to change "afe" by "audio-controller" for all MTK
SoC would be great.
"

I want to keep it and fix it later with ALL other MTK SoC.
You didn't answer after that, I though it was ok for you...
So if you don't agree with that, just tell me to change it instead of 
let me think I've the choice.


> BTW, whatever "consistency" you have in mind, it does not really matter
> that much for that example. And for sure do not add incorrect code
> intentionally just to fix it in next patch.

I don't get your point.
What do you mean by "do not add incorrect code intentionally" please ???


My PoV: I implement my bindings aligned to ALL other MTK SoC, which have 
been validated by you in the past. I can understand the copied code is 
wrong, but I've suggested a solution and you didn't NACK it.

I fell like you bully me. Are you ok to stop insinuating bad things 
please and tell me directly if a fix is mandatory and if you are waiting 
for a specific one, tell me directly to avoid this kind of unpleasant 
talk and waste of time, I know maintainers are busy persons.

Beside that, thanks for your reviews.

[1]: 
https://lore.kernel.org/all/eeb3329b-0558-4237-8343-4e11f65a6a35@baylibre.com/

-- 
Regards,
Alexandre

