Return-Path: <linux-kernel+bounces-133486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691189A46C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1C9284441
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863817278F;
	Fri,  5 Apr 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgof5Yl/"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AAD172776
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343042; cv=none; b=UQjrgTllharaDCjegYjDyLIn0AKfZD5PEBoiKVNS2gWQAnYPrJDJn6cnUiWIBjf9473J4JfGyU1WXDRsE5k+CAyvX95jJ+mgdHH+NRL/3jwEzvcEUsfpCJ3OEsktT0rNrro4TxBm5VZSVyo6vypM5sdy3MLZcXF33ngGYX9zU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343042; c=relaxed/simple;
	bh=m7oG2Qmos7+pA78FFQa0mcED9SbBpSit9bDHeJjmzQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaB64m/zxTPM6F/fHu5Qa/VOAofoIhDboTE75zu+BzfxDhhi3Iaw0+9XkdHkTM0EXyf2AZsk/xKpOYqd/zYLaID+V5VTZJB/NokGq+Bo72Co6QD+H2lpC5biqVPb72M9lXF4X4Uck/wNVQD3B3h4tJ5ST8jw59p8tQyXqWxHktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgof5Yl/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a125869ddso891545ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712343038; x=1712947838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vp44i9Xlfeu0O10COsw98V/v7e0jo8kvUbsVGI+1kuo=;
        b=bgof5Yl/PgEbGbIwPck+Do3VgBLbEy9ZQK+apV9dCcrJbJ7p9PgazTqrOZxooPIKgh
         8EqAtlBS4St3/mGXMYyXNpzAHsUBx5mn3qubOdCirKuA1le+BRhjuDixJBPI8Bakitz1
         +g+J1OTUVE+T17HMXMDxo/xkNInNH9ArdJop4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712343038; x=1712947838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp44i9Xlfeu0O10COsw98V/v7e0jo8kvUbsVGI+1kuo=;
        b=MV6NJv4JN4+MVAdD1BvNUsFPlzAPp7/VnieUdpwIb7mnUvNwYwcr0B8Sa7rFXjYddS
         7B/eD7w8g8xlTbSxisl/NIG96iBosLeIXOLRaPfPWIC5HxfQOcdron/mQoPK61m5cEN4
         nlwEH/9y9ndM+S35bZfBjRobvtsc+XCeGHOTBywnXQ1jRGxXZl6TInDt41MSe1TSg5s3
         eoSnXCBgN/Fq1DhOaN1uxKn2KVPoqXP0zHauVimydGpP5UDr2NI9rKfySGEZNlVBQiFt
         POVKzWVBn205z+N9e+6XMkIrmKjnp/jyrStBqfPsI7pGebAnME8AgpA7ej3YQvTN52kq
         sNvg==
X-Forwarded-Encrypted: i=1; AJvYcCWiGrEYcQCVoBdbUO9hrunfNBQQDlsHrKIL2l+x5veZiihcz6gxUeUwIUboGwX3h0fMWz+svLcxx7xDYNEnAMzXxOkbSqkMWxNKVWVV
X-Gm-Message-State: AOJu0YwtH1q6JLgPC7Sy5FsH8SDEchqBPHpTeKNIPXJVzAnARCDWqWVM
	PUZQRq2p9abQ95OqKYIUYzx6Civi8CZ0CHZAIhKP0wBPhwT8HVEfVBRgDIVQDpQ=
X-Google-Smtp-Source: AGHT+IGnMS2NKy+1HVwAPdxdmucJAIWJJEZlmMEtziDgLQxVglpyFfMG5GBRQy0N2McwE23OjduKXA==
X-Received: by 2002:a6b:ec05:0:b0:7d5:bfd3:7237 with SMTP id c5-20020a6bec05000000b007d5bfd37237mr2288245ioh.0.1712343038341;
        Fri, 05 Apr 2024 11:50:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x26-20020a02971a000000b0047ec2b62deasm724949jai.91.2024.04.05.11.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:50:37 -0700 (PDT)
Message-ID: <84acaa6b-44b6-495a-939f-4a6e49e162c9@linuxfoundation.org>
Date: Fri, 5 Apr 2024 12:50:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: Kees Cook <keescook@chromium.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
 <202404050832.187F972C@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202404050832.187F972C@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 09:32, Kees Cook wrote:
> On Fri, Apr 05, 2024 at 08:56:31AM -0600, Shuah Khan wrote:
>> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
>>> "Bail out! " is not descriptive. It rather should be: "Failed: " and
>>> then this added prefix doesn't need to be added everywhere. Usually in
>>> the logs, we are searching for "Failed" or "Error" instead of "Bail
>>> out" so it must be replace.
>>>
>>> Remove Error/Failed prefixes from all usages as well.
>>>
>>> Muhammad Usama Anjum (2):
>>>     selftests: Replace "Bail out" with "Error"
>>>     selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
>>>
>>>    tools/testing/selftests/exec/load_address.c   |   8 +-
>>>    .../testing/selftests/exec/recursion-depth.c  |  10 +-
>>>    tools/testing/selftests/kselftest.h           |   2 +-
>>>    .../selftests/mm/map_fixed_noreplace.c        |  24 +--
>>>    tools/testing/selftests/mm/map_populate.c     |   2 +-
>>>    tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
>>>    tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
>>>    .../selftests/mm/split_huge_page_test.c       |   2 +-
>>>    8 files changed, 108 insertions(+), 108 deletions(-)
>>>
>>

Usama,

Please generate separate patches for each test (one for exec and
one for mm) when you do this kind of work across tests in the
future. I applied them this time.

>> Andrew, Kees,
>>
>> I will apply these to linux-kselftest next as a series since these
>> changes depend on change to tools/testing/selftests/kselftest.h
>> and need to go together.
>>
>> Are you okay with that?
> 
> Sounds good!
> 

Thank you. Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


