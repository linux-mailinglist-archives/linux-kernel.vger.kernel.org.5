Return-Path: <linux-kernel+bounces-43572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B618415A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F35289BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F92C6B0;
	Mon, 29 Jan 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaNFIW0Q"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA39FC1E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567523; cv=none; b=b9olkyPLsEi5Uft7k8GERFD66w1VnrzWGxtcFiqiHRGIwI/9w7cykLqOwmSba7MgRLxfnGnAWvcy9ubTHKQar1jGB4//3Xd4JPzSsZMXPjrD/TO/LHjNgCwQM4rl5QbEMuLLXXvVzoLw6AuBEBS7rB6pOMkT17hcB2PoseceuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567523; c=relaxed/simple;
	bh=09sjdlAizD69aCiRwuQ86Wqs+zPDWC5uDnJ+TmJv+K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq/8/KJVRmtEGFn3w7IKVae0p5IIjkFl/H/L8fjGBsSFX5k5BPoXuBGcfGP2m3//OgqhPhXAknTZm7TyG92b1sqEOqmAbBpUcIqPwcR3eJBwuvvonucMQjJxze6x5NTj+EZbmR5Q+DqAqeH3w7RTk3zZc0QLdFSrvaujW13OFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaNFIW0Q; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so51039539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706567521; x=1707172321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/TrL0zAkhRCOL6hP/WUS/KTp52244uNPAxUiRxs5zs=;
        b=LaNFIW0QFQsTkWr+TpM070TplL7w10ddzfs/heTUBtmWKp2P0WtJs+S44JKT3hUpZr
         1U8CqjDnbz8Tu9iKRFuqHbMDCcxlpHCeJgTcbRnd0hW5B2KRVYXKEbN8IfqoL3o1Kipa
         lTtdVYbi88G1PzL5HCW3iYYcyy7mxOLU6LJaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567521; x=1707172321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/TrL0zAkhRCOL6hP/WUS/KTp52244uNPAxUiRxs5zs=;
        b=f6WxiM6XzctX8tx0nr8MaBJvgS0rTtk95LlBBfu2XXssPn2Iz9Vjsqvgk7q5v6mu7I
         JJZMVP0NtIFBAbUf+WkPsQyeHeyAt0a5oE/5NIg09ytVf593+8ir8iWZeW45jbkjGUSb
         pLgjezDR/YICOLAhk8XWw3Jqfvx6oAWcuvmdAPf1RZ9RGQwD7OQtqhMTho8Ch/iIg6Ea
         VQyTCmuhHVibzgLd+bZ2SDPVm0Et32l4A+YoyHU76JcYu73rr+5XzWnm28fIsRvY9cQm
         /CftFjFYiIs/tQLBBC2g+BKZc4MV2+l/PHr9tQkg25VM+kiom3crAqolPoTeWszldn+m
         TPYg==
X-Gm-Message-State: AOJu0Ywttu202HQ56LxEsVWTKZ8VVnY5xcSlkAQfLP5ZENVDfDFJOgh9
	x4NkWl8n3QzpMlVTHBH9gC8992hSquuA+NQiN4Wywz3bFyZzILgteLEHe4Lr/+c=
X-Google-Smtp-Source: AGHT+IG1jhNEtbbQ6ZGvnFyOCExTJ8XBVKAZgPnaUM7RfEI1gwroZWa/GJi4PXy71AIOGUaKAYludA==
X-Received: by 2002:a6b:c953:0:b0:7bf:60bc:7f1e with SMTP id z80-20020a6bc953000000b007bf60bc7f1emr8213411iof.1.1706567520845;
        Mon, 29 Jan 2024 14:32:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w20-20020a6b4a14000000b007bf197d6ca8sm860711iob.25.2024.01.29.14.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:32:00 -0800 (PST)
Message-ID: <e5f572ae-7b2c-47b7-80d9-2e9b347533c0@linuxfoundation.org>
Date: Mon, 29 Jan 2024 15:31:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest-fixes tree with the
 mm-hotfixes tree
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 "Hu.Yadi" <hu.yadi@h3c.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240129085301.5458880a@canb.auug.org.au>
 <c29848d6-29ca-4338-bbdc-abdc71cdd5f4@linuxfoundation.org>
 <20240129142843.982dd12d63dc2d86a1e415ec@linux-foundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240129142843.982dd12d63dc2d86a1e415ec@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 15:28, Andrew Morton wrote:
> On Mon, 29 Jan 2024 12:01:53 -0700 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 1/28/24 14:53, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the kselftest-fixes tree got a conflict in:
>>>
>>>     tools/testing/selftests/core/close_range_test.c
>>>
>>> between commit:
>>>
>>>     27a593e3f13a ("selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros")
>>>
>>> from the mm-hotfixes-unstable branch of the mm-hotfixes tree and commit:
>>>
>>>     b5a8a6de69bc ("selftests/core: Fix build issue with CLOSE_RANGE_UNSHARE")
>>>
>>> from the kselftest-fixes tree.
>>>
>>> I fixed it up (basically the same patch, I used the former which kept
>>> the blank line) and can carry the fix as necessary. This is now fixed
>>> as far as linux-next is concerned, but any non trivial conflicts should
>>> be mentioned to your upstream maintainer when your tree is submitted for
>>> merging.  You may also want to consider cooperating with the maintainer
>>> of the conflicting tree to minimise any particularly complex conflicts.
>>>
>>
>> Thank you Stephen.
>>
>> Andrew, would you like me to drop this commit? I was planning to send
>> pull request with this in later on today, but if you prefer, I can
>> drop this commit and the send the PR.
> 
> It was in the batch of hotfixes I sent to Linus yesterday.

Thanks. I will go drop it now.

thanks,
-- Shuah


