Return-Path: <linux-kernel+bounces-133578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459E89A5EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6DF283601
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC86C174EF7;
	Fri,  5 Apr 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPRVBOZo"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31C174ECB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351277; cv=none; b=E1WRpDflBvYlyFCfbkYBL+nybHoYHVB9rMm/ZDKJiI6nP0ktIWI4BNmk1nfPMNZxSC5mfWxYixQM1Gh43n/A1R1tjzZrdUiJ1YZbygIz1go8hpT/62Axb9BauJqYk3NTOzQl+Tm6x99gB80rMF/+EdkBqJ0SPyWF8TSCt485Jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351277; c=relaxed/simple;
	bh=7qfhjtYFkM6G6ZDJn3ZynqgAg7omtB8AHzvP+GXhTgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsXhf9x2XilNyk+BOPMDjIXK/t58nX6T3I6e9zzg+Vj+nSy1g35hxvXPS5eHRU6CesUYo6xZpKwnyLTEOp3pFS2AdIJ9kQZLBAmbcbcbt+oU1b8MFO5FzucVieltj7JrTjWrB28zcah4uylcFSxlRt2fZuzxdmK9IVVch4L5Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPRVBOZo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a125869ddso1101035ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712351274; x=1712956074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tFcMER8j7g+Kousn29UjGQVOvnMnxSE38Y7ZswRMOA=;
        b=XPRVBOZo9/KZqJNuT+uMaXeWmQcjeLORQJjde4wakAiBQUb43i+3t5eKkk0Lx75eP1
         UVS3p8oFawC9YFMbUuu/T8kjrbzVoZIPMutyRkIQiN3LAvd9XjTgPj0oDhZuyQT9T6Cn
         DknbnaZHIHjVAE1HTyYZAZOfC9FFXACEWDbXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351274; x=1712956074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tFcMER8j7g+Kousn29UjGQVOvnMnxSE38Y7ZswRMOA=;
        b=AwA/d5n+2q6PugEqBw5QTaOeY+Rn5K2mGVZ2/e26oASWBlcvpH6FK3o5zP2faXMTw9
         /WGXE05fYOaE4BCigGmwsiBjC8/yaMpQyvIpfpocRZc2iQd0hZtdmuuQ1yOD1ELbkqw/
         9jL4J6E8VdSTIf9VEjw6hRw9I36MDfCtjaQkB01jx/wTGS/in3FSPYo3AfW5jeQmKDsW
         i9/EONoeZoOc3u3vPa+u3etZZcPgBRV7nNJla4P2Ai5cKXtGO4HHbPvB1nO0GmJr6JkA
         ICBJns5/f93sZADshtuwCrmtjqfAdM5R/1lrbp3k1MWlWNCRlZzaaG3K3aYqtO9wdakl
         Tuyw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGhpYYjTOHVh+TphPP8GYKrj83ZOf+j12mBVDLo80b5PKP1RFr39yKtThbgV/4/rgIdnoXTIuasdcEK/MNaDrPyMMo1Zh5qFE3B2L
X-Gm-Message-State: AOJu0Yzn6jIc6t6Dl3tAGj3DSeaGUnefcqSKE/YDqjeZ0cDzV9iWfLY5
	wEZkw3v3VWwZ0gRp7Ymyy8hI0bGuO/3FrwyR24ljyMsQw/lEUL1BssgJCyLNK08=
X-Google-Smtp-Source: AGHT+IFpUdTjNiUrmIGtr3vJSUg8kWEja0OcCt+9TF/CDdmE4VJ6Ro4tdKiAzi9GtH7u4JkONeQpNQ==
X-Received: by 2002:a6b:ec05:0:b0:7d5:bfd3:7237 with SMTP id c5-20020a6bec05000000b007d5bfd37237mr2616439ioh.0.1712351274500;
        Fri, 05 Apr 2024 14:07:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l2-20020a056638144200b0047efdf3a882sm784394jad.177.2024.04.05.14.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 14:07:53 -0700 (PDT)
Message-ID: <244a65f0-4f9c-444c-b150-ef3b18cfbaa7@linuxfoundation.org>
Date: Fri, 5 Apr 2024 15:07:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
 <SA3PR13MB6372E672EA40B403EBE588EDFD032@SA3PR13MB6372.namprd13.prod.outlook.com>
 <d103fdc2-e7a1-4658-88ab-22929ae48a06@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d103fdc2-e7a1-4658-88ab-22929ae48a06@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 14:38, Muhammad Usama Anjum wrote:
> Hi Tim,
> 
> On 4/6/24 12:36 AM, Bird, Tim wrote:
>> Sorry I didn't catch this on the original submission.
>>
>>> -----Original Message-----
>>> From: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> On 4/5/24 07: 17, Muhammad Usama Anjum wrote: > "Bail out! " is not descriptive. It rather should be: "Failed: " and > then this added prefix
>>> doesn't need to be added everywhere. Usually in > the logs, we are searching for "Failed"
>>> ZjQcmQRYFpfptBannerStart
>>> Caution : This email originated from outside of Sony.
>>> Do not click links or open any attachments unless you recognize the sender and know the content is safe. Please report phishing if unsure.
>>>
>>> ZjQcmQRYFpfptBannerEnd
>>> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
>>>> "Bail out! " is not descriptive. It rather should be: "Failed: " and
>>>> then this added prefix doesn't need to be added everywhere. Usually in
>>>> the logs, we are searching for "Failed" or "Error" instead of "Bail
>>>> out" so it must be replace.
>>
>> Bail out! is the wording in the original TAP spec.  We should not change
>> it unless we plan to abandon compatibility with that spec. (which I
>> would advise against).
>>
>> See https://testanything.org/tap-specification.html
> I didn't know that exact words are coming from TAP. Thank you for catching
> it. We don't intend to move away from the spec.
> 
>>
>> The reason "Bail out!" is preferred (IMO) is that it is less likely to be emitted
>> in other test output, and is more 'grepable'.
> Makes sense.
> 
>>
>> This would get a NAK from me.
> Let's drop this series.
> 

Thank you. Dropped now.

thanks,
-- Shuah


