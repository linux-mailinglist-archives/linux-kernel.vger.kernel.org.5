Return-Path: <linux-kernel+bounces-131969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB2898E12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0728AA27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05E1339A6;
	Thu,  4 Apr 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7L031P6"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8C1327FD;
	Thu,  4 Apr 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255769; cv=none; b=ZenDZ3iCOwRTI/9mDUEvVtkRfdzBadJLomw1ZgjcToda5eYfKqd0GCkH+1dA5aZf7eAV2IxPCpC7B3GGoMASETvUM9q+fL56KxLoevZWEug17AvBUJHd/pZEurRqjGC9bWs7HZVHw9z5ZthybQZ0PibN5K4hyDJR0x7qBq8pwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255769; c=relaxed/simple;
	bh=Z/1fyCo41lS+AmGEgJmU2z5lD/1fcc9M1Qe0AELx5Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO5s79QjxK3rnkCDGvu1Oa6imfQiIQlOkzFoVlyvSM8gzPcmF5R+O0Utmkthd0TjRrWfJY42HEkmdnn1L+mv6egFKNK07WYM5RHczQDj9d4n2oUBivdLrXjigul+Wo3vDeeX8zKDktdL+fT8pUnJ/3L/sGmD0NHVxJSy0H7joVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7L031P6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d848973b57so16894491fa.3;
        Thu, 04 Apr 2024 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255766; x=1712860566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKZ76EB+xPDP2hiO+m9b6JZfXv6mCVaRqGHumTmPatc=;
        b=Q7L031P63FNKJuYlQvrDosH2d2tin3HU3bykLuvrbAbaWyh7TzOX5s6hRWHRtHQ10o
         /g1bxJ+vnoDOgG/gFsQf34960vCfQFH6hwnQP7oda2H8Dl7jh8B5+YeO//EyXNAvOd2O
         4eIM32E+OHHlQDcw/GHUHck9rRMg0zCZcliQXs32zeamG75JlIC3wyYFxPhO3sjMLATU
         xlkoueKIsiEjrrciX3Nmv7BOT6rnfhb1Svf/3dsElZwSEX2fHEg44d++4MvUDy72mTgB
         ByGi/iFttwNXdLbJnn98/54adBmVVsebSkSbfEmilmOrByRUdY3EtdzOCupD/dkY6pJH
         Jrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255766; x=1712860566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKZ76EB+xPDP2hiO+m9b6JZfXv6mCVaRqGHumTmPatc=;
        b=GZFr8dJU+ploJvdP5JSVBkMVtioCajx1aluMwqQ+yIlCBxng9eYP9m3kQmcl4hzyHw
         267m+nPG6jD0qPZm9Lbk9O4/VAFmjDwaTw3ialkKTVwopF8y2z0rVRqSy1gKNyMYX8Xm
         311CBnVw39fTMyaCgsiOfMbXLFam/XsTiAeNiEAkqSg94cVWrzKJNC7hL0r0JoqkQqRK
         yQuYxgnSeq8EwAlsg2B7uDlTOnLSeowuUNYm8ZYnDSECHuBHrwHizH450S1zA+5bp2F3
         4SXXqX7zhcgjuuL1MSuEm4V4YpMh2JckCcShjZD+4MlEccuf4GwZzIG+ZocqcWrm2rT7
         Wz+g==
X-Forwarded-Encrypted: i=1; AJvYcCVtWeSvuwoOmGAl+BHSAn5Zhb6dK+5T4lky+S2rWEERYC1DIEZxqCPcy2myWy5/sg3jBIJXJ45ukVpa9Pa3xoDEGEW4Bzeg9WYaFz+qT0jOgMbkKyy9+T548gfkCwSghXD6Y3EOecmhjQYXZg==
X-Gm-Message-State: AOJu0YyFHhl+DT3eYuZ44j33uGqGxOCnldXGNNiicJgyGDzoHdGTBvjc
	qBAbYPY97jiUr8DOp9Ph58CoKZ4iqniGVT3QvydAlEHOzaK+3moN
X-Google-Smtp-Source: AGHT+IE/Wl5iSbtcMQFWal73QrjHMBwx0DdZaNcB5xfFxkIGw/3mHZMxEE+pltw6x0M1If4KVg51tA==
X-Received: by 2002:a2e:9141:0:b0:2d7:10a1:481e with SMTP id q1-20020a2e9141000000b002d710a1481emr2536459ljg.31.1712255765826;
        Thu, 04 Apr 2024 11:36:05 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id hn3-20020a05600ca38300b004162b578d8bsm67368wmb.1.2024.04.04.11.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:36:05 -0700 (PDT)
Message-ID: <f90b41e8-577b-439a-ba50-6ca7ffb66f46@gmail.com>
Date: Thu, 4 Apr 2024 20:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325100359.17001-1-brgl@bgdev.pl>
 <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
 <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
 <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
 <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com>
 <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
 <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com>
 <CAMRc=Me9x1OXKXXxyhzZ6mxffmaoq=4QhMXCL6L71_xso2epWA@mail.gmail.com>
 <CAMRc=Me0MamtJoPtQnucKyZx9pfkEPDAAZqWFWRU0CBcj+P50A@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=Me0MamtJoPtQnucKyZx9pfkEPDAAZqWFWRU0CBcj+P50A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/2/24 10:44 AM, Bartosz Golaszewski wrote:
> On Sat, Mar 30, 2024 at 8:16 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Fri, 29 Mar 2024 20:57:52 +0100, Maximilian Luz <luzmaximilian@gmail.com> said:
>>> On 3/29/24 8:46 PM, Bartosz Golaszewski wrote:
>>>> On Fri, 29 Mar 2024 at 20:39, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>
>>>>> On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
>>>>>> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>>>
>>>>>>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
>>>>>>>>
>>>>>>>> Both with and without SHM bridge?
>>>>>>>
>>>>>>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
>>>>>>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
>>>>>>> still get stuck at boot (regardless of the fix). I think that's
>>>>>>> happening even before anything efivar related should come up.
>>>>>>>
>>>>>>
>>>>>> This is on X13s? I will get one in 3 weeks. Can you get the bootlog
>>>>>> somehow? Does the laptop have any serial console?
>>>>>
>>>>> Surface Pro X (sc8180x), but it should be similar enough to the X13s in
>>>>> that regard. At least from what people with access to the X13s told me,
>>>>> the qseecom stuff seems to behave the same.
>>>>>
>>>>> Unfortunately I don't have a direct serial console. Best I have is
>>>>> USB-serial, but it's not even getting there. I'll have to try and see if
>>>>> I can get some more info on the screen.
>>>>>
>>>>
>>>> I have access to a sc8180x-primus board, does it make sense to test
>>>> with this one? If so, could you give me instructions on how to do it?
>>>
>>> I guess it's worth a shot.
>>>
>>>   From what I can tell, there shouldn't be any patches in my tree that
>>> would conflict with it. So I guess it should just be building it with
>>> CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y and booting.
>>>
>>> I am currently testing it on top of a patched v6.8 tree though (but that
>>> should just contain patches to get the Pro X running). You can find the
>>> full tree at
>>>
>>>       https://github.com/linux-surface/kernel/tree/spx/v6.8
>>>
>>> The last commit is the fix I mentioned, so you might want to revert
>>> that, since the shmem issue triggers regardless of that and it prevents
>>> your series from applying cleanly.
>>>
>>> Best regards,
>>> Max
>>>
>>
>> sc8180x-primus' support upstream is quite flaky. The board boots 50% of time.
>> However it's true that with SHM bridge it gets to:
>>
>> mount: mounting efivarfs on /sys/firmware/efi/efivars failed: Operation not supported
>>
>> and stops 100% of the time. Without SHM bridge I cannot boot it either because
>> I suppose I need the patch you sent yesterday. I haven't had the time to
>> rebase it yet, it's quite intrusive to my series.
>>
>> I can confirm that with that patch the board still boots but still 50% of the
>> time.
>>
>> Bart
> 
> Hi!
> 
> I was under the impression that until v8, the series worked on sc8180x
> but I'm seeing that even v7 has the same issue with SHM Bridge on
> sc8180x-primus. Could you confirm? Because I'm not sure if I should
> track the differences or the whole thing was broken for this platform
> from the beginning.

Hi, sorry for the delay.

Unfortunately I haven't had the time to test anything since v3. I don't
remember all the details, but based on what I wrote back then, enabling
the SHM bridge option did not lead to this result.

I can try to test v7 (and others) on the weekend.

Best regards,
Max

