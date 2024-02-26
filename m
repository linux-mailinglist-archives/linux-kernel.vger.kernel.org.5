Return-Path: <linux-kernel+bounces-81998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A5867D89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B753D2963B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D3131724;
	Mon, 26 Feb 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ5DF7Jo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5612C53E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966629; cv=none; b=DVrgPxxszkjj1Hq82ipq6v3Vhc7xPgKOqw6//EBBgTe0Hd/CCfvI3jc/Ufd4PcGeMYOqdtLYSTQvpUBM206zGLPsMXjPXe2Onuteb/dZrg6SBnWAXPbMI5JgcTM0XCW0eykfTiz+VCm6t57pAjzC5ybdka3ZjE1qPbETJ0xmUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966629; c=relaxed/simple;
	bh=eacWoILJZ5o5Viqax6eA9ePbWI2MSS3L3kVbV7kHxlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVVamYV0W1EIgF3Kn/GJAvnXFO/PFoy2oQl0/6GFzrYjnHd4ti56scoiwCl7bH+GD4we5ZfbGtxWtvCjleWwniA3UGRbQA/JUTHhZEroZweQLTHkSzkuTgfeucixExvZOJGaRec4mEzrFS7MSfqixbDv1UzTVA7I8WIhRMT3KhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZ5DF7Jo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8c+aIKxEaZpezL+jzlJ7u2FhDbslxiLJ7vzY5ObQAVg=;
	b=TZ5DF7JoX3Yq5fcIdiBqTkqQ1bL/CLPxv9oILjlqvhzm5DeD0L1IpDWR3d+3l8RoNSdQG+
	xMkybzbNz7sm5CEpGPRJvzAj7le4YOM1g6lFuUJOGRVvLEmIakq0dB674wnpctwz7MV+C0
	RzbM8FtgLqQB4dMSMSbQAmsPYu/tWFQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-h0c-I3LfPCKXYNEKg9_M3Q-1; Mon, 26 Feb 2024 11:57:05 -0500
X-MC-Unique: h0c-I3LfPCKXYNEKg9_M3Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d22b3462a0so24526851fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966623; x=1709571423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c+aIKxEaZpezL+jzlJ7u2FhDbslxiLJ7vzY5ObQAVg=;
        b=LgNwqM6qlys3+OBzlp5XG+Dqz/MFPkf67B0Wsvff0c/C+LCcKS1h11BeS4IxBF+F/+
         CotzQHPmoIcCfTsQcgOZcVKYV2aajOmgYvvViDuirVRAEJQT4tLPpeEXTw3KFAAiLbSp
         WuH1k4A7vfe+5Ajdwt2Yeg8Qh8hTYRdxF9hCOXbXQk5Z7QfGJ30Wk/qOu9SPTUnTYynJ
         RNsnduoaGaIvvs7/+XT/pHnKtSSk1Yr/ICxLfLeRUystwfYmx7h6w9WTHTihwWBgcr9C
         We4PUaXF2rTIARllA/F1vOj8GpdLD0arrGGbEBsWPTQIYSfePjoVheEQEjGg4XNud4az
         my9A==
X-Forwarded-Encrypted: i=1; AJvYcCUK3rGTx9n48j4MGwUfSBSPEH0Odo6iBY6PbCAa4SmOlyKvoqkt6FB9HV8utyHShYkR3Nm3uCubGqpIq2wLgSRfMFQ1sgiFhQZ1uXMG
X-Gm-Message-State: AOJu0YwuNFpsAPryI5DMBLUIakHe+SkYUsXRhlTWHjQgMJsR8+BJEq7g
	m5Yt95UOdWmupzlWRoOc7jCHW2Br8A0Inr9Us8mcw9tXMJLD7C19Li3iiCbiWkTXczq+g4nlgMl
	4Y58DjPjshefDssQTylCOWVzEFTCbiAWGKk/gdKZesHBHXaawi0Ga2m22V+xH5BQZXcqfzg==
X-Received: by 2002:ac2:4288:0:b0:512:fdb3:7a9e with SMTP id m8-20020ac24288000000b00512fdb37a9emr1819839lfh.31.1708966623623;
        Mon, 26 Feb 2024 08:57:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErYMtJMKxyV17XeAD60DbKw+SYc8okTK2r7tU7czsIcdBFoyqpwalN4Y46LherjciMy/pCzA==
X-Received: by 2002:ac2:4288:0:b0:512:fdb3:7a9e with SMTP id m8-20020ac24288000000b00512fdb37a9emr1819819lfh.31.1708966623192;
        Mon, 26 Feb 2024 08:57:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a42ea030a6esm2534364ejc.82.2024.02.26.08.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:57:02 -0800 (PST)
Message-ID: <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
Date: Mon, 26 Feb 2024 17:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
To: Luiz Capitulino <luizcap@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com,
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
References: <cover.1708635408.git.luizcap@redhat.com>
 <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
 <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
 <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
 <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 2/26/24 17:10, Luiz Capitulino wrote:
> On 2024-02-26 11:04, Ilpo Järvinen wrote:
>> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
>>
>>> On 2024-02-26 08:27, Ilpo Järvinen wrote:
>>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
>>>>
>>>>> The mlxbf-pmc driver fails to load when the firmware reports a new but not
>>>>> yet implemented performance block. I can reproduce this today with a
>>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
>>>>> reports the new clock_measure performance block.
>>>>>
>>>>> This[1] patch from Shravan implements the clock_measure support and will
>>>>> solve the issue. But this series avoids the situation by ignoring and
>>>>> logging unsupported performance blocks.
>>>>>
>>>>> [...]
>>>>
>>>>
>>>> Thank you for your contribution, it has been applied to my local
>>>> review-ilpo branch. Note it will show up in the public
>>>> platform-drivers-x86/review-ilpo branch only once I've pushed my
>>>> local branch there, which might take a while.
>>>
>>> Thank you Ilpo and thanks Hans for the review.
>>>
>>> The only detail is that we probably want this merged for 6.8 since
>>> the driver doesn't currently load with the configuration mentioned above.
>>
>> Oh, sorry, I missed the mention in the coverletter.
>>
>> So you'd want I drop these from review-ilpo branch as there they end
>> up into for-next branch, and they should go through Hans instead who
>> handles fixes branch for this cycle?
> 
> If that's the path to get this series merged for this cycle then yes,
> but let's see if Hans agrees (sorry that I didn't know this before
> posting).

Hmm, new hw enablement typically goes through -next and not to
the current fixes branch. And AFAICT this is new hw enablement,
not a regression / bug-fix.

Is there any special reason why this needs to be in 6.8 ?

For RHEL kernels you can cherry-pick patches from -next
as necessary.

> One additional detail is that this series is on top of linux-next, which
> has two additional mlxbf-pmc changes:
> 
> * https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.com/
> * https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.1707808180.git.shravankr@nvidia.com/

Hmm, those are not small patches, any other reason
why this really should go to -next IMHO.

Regards,

Hans



