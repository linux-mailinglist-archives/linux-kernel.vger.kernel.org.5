Return-Path: <linux-kernel+bounces-121621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF488EBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CACDB254E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297712F5BE;
	Wed, 27 Mar 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTOccIel"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CE12F399
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556320; cv=none; b=OwOl8+nTi28y/CE5R3Z29UVvNJNLMDVVEeIYiQBlo7QtpTu8Iaj1msexMVr6l+jg/8d2gi/DxQW5+ZtcpW7FvcmK7sux4gxR+tH81QFSV7BjTUZXAQKkW8KL1+1PnngK+IwdRKsi5upzdHj3fY7ldVpYshsQ2XntRFooO1K0cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556320; c=relaxed/simple;
	bh=2mlVydQJmeDZD0C210CqOG3B6PFVjqqc5l12YwGy1jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SET2BHihU5QuoB8Jm6ig9aJvR8Jz36mo9KdAbtD14Unds5tf0gzNGY1crK+FhMuj9TNZHepTCznl+47X/5i1dLXvbwgyGp4KQBbD7WF3s0XA/ugYAtYwAl1n7AIrMP51K+W55o5V6BiiNP6jxOREy9oYPoZFiB2pJs+xapWK4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTOccIel; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3685acaa878so3940945ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711556318; x=1712161118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3n7vo3IDDksA0EyXBWwDk90r432Y6GahhgJq9RLXhk=;
        b=eTOccIel0gv9NCDLPwZ8ZF+n5k5rog3msuprLfq0mjf5DwNRx5m3093ma07/lj+gNC
         BdQ6Gj7vdVRX/UG2oxGynqxknYkMKWMN3RM/oHADMijOyePGgUtnhKmsAcaVTYHJe7Xz
         3/MTTz4P6py7av2PwKjJ8uxU7OZoRyXBlkrKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556318; x=1712161118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3n7vo3IDDksA0EyXBWwDk90r432Y6GahhgJq9RLXhk=;
        b=YDmzpXrTZYLSNIjjG+xFEUxVpKGi4fhyQNV8xRaJJ+tey9xCGgJ9lIKjVZcoWRA0ZG
         zfeRa8cCGDi7FKz95E3/tGxLFFQMIJ/z99IHwoltHiw5pfTw7E4dbCyZP4b+JLJjD3wI
         YwWHJyeb0U/vZwb0z/5xKjuco5Jrjd+0VLJTZj5omuOVXyNGVquushD09J4zM9gopkVq
         wqTdSroL3kD3mFvFOugG0SXMKEDOxbIhoS8ONyB5rMsdEExdX5c1b0FcyhjO0wzAPOXf
         QJ4JMl3S01yFR3FEOf/D5XEBBRp+dMwa8Uq9doTy99v4C2eMDzn9U08aq3p6LZwFM2s0
         8uLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJijkp5j12yPxRTFA2/11PIK/NJ7U7dJ65yUp3lxF246s8COBf441mbZottiN+VfRkvKQFA6Gzq0A8ASiYMJZOK9HofxTc3cA/DiNG
X-Gm-Message-State: AOJu0YyBhmR3krj3D8OvGKiOgaVYNnyiXr17GQK4uVpwT7NrB8F1exV1
	Dh45LrGj43esuBaWwwULafUiMslLbCMbaafoRaRGrmWDw8fBUvF6RkB3nDGtpR8=
X-Google-Smtp-Source: AGHT+IF7yIh3uN51oX9Uv2Qm743DenbAnFk7aOHkg5zmiVoM2zf/D2qzzwRJyzdHl8poXARbs/VXTg==
X-Received: by 2002:a5e:8c15:0:b0:7d0:6728:66eb with SMTP id n21-20020a5e8c15000000b007d0672866ebmr609391ioj.1.1711556317589;
        Wed, 27 Mar 2024 09:18:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r23-20020a5e9517000000b007cf05417adbsm3598725ioj.22.2024.03.27.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:18:37 -0700 (PDT)
Message-ID: <646effc4-c67d-4248-8e69-4279a3d7ec28@linuxfoundation.org>
Date: Wed, 27 Mar 2024 10:18:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
 <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
 <a2b8e7b3-2f38-40a7-9e3e-c2cfa2ba8892@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a2b8e7b3-2f38-40a7-9e3e-c2cfa2ba8892@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 15:20, Chang S. Bae wrote:
> On 3/26/2024 1:51 PM, Shuah Khan wrote:
>>
>> show that there are bo backwards compatibility issues
> In older kernels lacking AMX support [1], arch_prctl() returns EINVAL. With AMX support, the kernel will properly set 'features'.
> 
> It is also worth noting that this simplification was previously acknowledged [2], albeit some time ago.
> 
> Thanks,
> Chang
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3
> [2] https://lore.kernel.org/lkml/de61ffdb-638a-ca84-31b5-55f6a8616597@linuxfoundation.org/
> 
> 

Thanks. This can be included in the change log so it is
clear.

thanks,
-- Shuah

