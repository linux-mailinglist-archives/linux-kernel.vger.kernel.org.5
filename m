Return-Path: <linux-kernel+bounces-35833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F74839720
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D0D1C27806
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842481AB9;
	Tue, 23 Jan 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSyyzlYs"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF281218
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032823; cv=none; b=k+x0Sp7rYfsOmrm4SKQCrxyaheC2eEuApQJYODGh2+6UXWgod46Ucnnk1g2D/3iZ98j76FNRjESYwR3ps/1gGr7x8TK7A4ObPA9GfdTw0uU9CTyFrIbKu+OtotYfOnj0RtzyQleVo5/DOpTzUEwSOjYtfujDsQV72NgbOxIZxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032823; c=relaxed/simple;
	bh=MtJ/HqiEUxScIQTHutFj2dKX6h9i2hpJKWEAmQsLjIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4pvI0Hjy41Gc1jhyqf2zeN2MNMEBQ2aZ/UmfkP5FrdGKe0exC//oEbopREusF7Ybq2/bf1ShTbAlRyZQArkbnYNCMMHMhv0tzawaVVPmnbiqhEJkYqvCUR28fV1RlxJHzlZKh+DywdQlf3YKhqbIVqVlhw3p81IzerrzdX/pIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSyyzlYs; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf15eea3c1so7672271fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706032820; x=1706637620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnoRqNG9BylPXm1qN1DFm/eBxnmuuTJ523N0hc6cFDs=;
        b=WSyyzlYsQvy0asmn23QNx/AhxlktRfpIZ4/nyEWv9tmccquD7/I/t3vVyG4qzGeZ84
         Vi4Vg5hT+E6fwgoNZaEBS/HTqI0HykXm7dHJkFdp5kqdAZmvBk28ECHqZZh6zHYomLew
         l6QLYPLkWfNAvj233fq5BjNKDg9p3Bt8FW2uLytHAD3Fffw/3MD7wNqpTpB/JkenPWqs
         th6hJkuNv2douaf0kSGZhIAOsHBH6O6wV15sO26P0K6u8tB+ygqj1DUV3/qiFJ3VZj3Y
         EKlDrfJ/ntqsFoMwO/SW+xHeU3QEzSF5pGlB7gFZ7RUIUb6s73qQD4C2p+4BlSzj7Qk6
         wMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032820; x=1706637620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnoRqNG9BylPXm1qN1DFm/eBxnmuuTJ523N0hc6cFDs=;
        b=uV/qJQy1vk8HGY52zl99ivRTMXiyupLxk/xoVsCAt5CkN6vCx8nlsftM1n5TT2XRpd
         YZaKwtqfBvBp0uRFo1Fkiomkj7FxB3YimBW1aEeFjgKOYuh32qLLhGHH/JiS5TDuE5EH
         RQMH90+NwvNSdILHO+fdBS0kYSHe2ewbnS8YNq7Z9p5kYiQzRT2IA2AtOHfZb97bwhkl
         1u/DramZj3uwKeJCpBV4eXC01Sh1FeqTfHBToaVtlNnXX7emIlkl45ZmWWEUj7vkQsq7
         LsB33zffLyieGv6EEpNJJQOBATmEF9Xii5NGWv6gx4TAySfx20DixGJZFmcyAMMwRp49
         6ogQ==
X-Gm-Message-State: AOJu0YwMXZnkA46BhucYr8ueCo53MAvXPGTSGjsvJvNTB2bx4CvuL+v7
	JTysLBrDIZTqzTyfP8KjE01y15mWg7WdYUUsTrmbBDPZ80K4Zm8LBng0DO/g2dM=
X-Google-Smtp-Source: AGHT+IFnEfC3oawTRwTitOxgaBUV+CKV0/WT2dwdHRRdkvC9cRcn6wvyopZjVpQbq/DqeMFnxofbKg==
X-Received: by 2002:a05:651c:8e:b0:2cd:285f:7d39 with SMTP id 14-20020a05651c008e00b002cd285f7d39mr115795ljq.15.1706032820038;
        Tue, 23 Jan 2024 10:00:20 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651c03d100b002cdfc29b46dsm1514699ljp.88.2024.01.23.10.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:00:19 -0800 (PST)
Message-ID: <0069beea-72d6-4a31-8f8b-282dbdd4bf94@linaro.org>
Date: Tue, 23 Jan 2024 19:00:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Remove QDF2xxx pinctrl drivers
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
 <8c9b157b-4698-70a3-57b7-c588998eeda7@quicinc.com>
 <CAA8EJprDk=HnqWJ_F5zdUKMPFPpx1RD9KN-KQP9yopP6LMh_fw@mail.gmail.com>
 <52479377-ff61-7537-e4aa-064ab4a77c03@quicinc.com>
 <CAA8EJpr2g=b8+M9r20KJoK+VVTabgctvB9eLmwivmi5qgBddFQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpr2g=b8+M9r20KJoK+VVTabgctvB9eLmwivmi5qgBddFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/22/24 20:23, Dmitry Baryshkov wrote:
> On Mon, 22 Jan 2024 at 20:44, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>>
>> On 1/22/2024 10:56 AM, Dmitry Baryshkov wrote:
>>> On Mon, 22 Jan 2024 at 19:43, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>>>>
>>>> On 1/22/2024 4:57 AM, Konrad Dybcio wrote:
>>>>> The SoC line was never productized, remove the maintenance burden.
>>>>>
>>>>> Compile-tested only.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>> Konrad Dybcio (2):
>>>>>          pinctrl: qcom: Remove QDF2xxx support
>>>>>          arm64: defconfig: Remove QDF24XX pinctrl
>>>>>
>>>>>     arch/arm64/configs/defconfig           |   1 -
>>>>>     drivers/pinctrl/qcom/Kconfig.msm       |   7 --
>>>>>     drivers/pinctrl/qcom/Makefile          |   1 -
>>>>>     drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 164 ---------------------------------
>>>>>     4 files changed, 173 deletions(-)
>>>>> ---
>>>>> base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
>>>>> change-id: 20240122-topic-qdf_cleanup_pinctrl-98e17cdb375b
>>>>>
>>>>> Best regards,
>>>>
>>>> NACK.
>>>>
>>>> This was productized, there are some out in the wild, and the platform
>>>> is still in (limited) use.
>>>>
>>>> I'd like to see support hang around for a few more years yet.
>>>
>>> The problem is that... its support is pretty strange. I can see
>>> pinctrl, ethernet and quirks for the platform in GIC-ITS and PL011
>>> drivers. Is this enough to get the platform into the useful state? I
>>> can imagine that "QCOM2430" ACPI handle was used for USB hosts on that
>>> platform, but I don't remember when we last tested DWC3 with the ACPI.
>>>
>>> So, all this boils down to the question whether mainline (or something
>>> close by, LTS for example) is actually used and tested on these
>>> devices?
>>
>> Its an ACPI system, so you won't see all of the fun DTisms of a MSM chip.
>>
>> The platform was fully functional upstream, and had an Ubuntu
>> certification.  I run Ubuntu on the two that I have in my office.  I
>> haven't strictly checked out mainline in a while, but I could.  I still
>> have access to the documentation.
>>
>> There is a small, but active set of users including myself.  From what
>> I've seen, they've been happy with things.
> 
> Thanks for the information! It looks like it has a small but stable
> user base. I think we should keep it, maybe ensuring that we are able
> to test the kernel.

Alright, please make sure it still boots etc. then!

Konrad

