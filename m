Return-Path: <linux-kernel+bounces-119803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D288CD24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142C51F87A52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0313D26B;
	Tue, 26 Mar 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B273VRIJ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422C13D251
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481091; cv=none; b=HGMvALRZFukiFDpT+RcWeCJ6fMDOuqh+NtS++zlOky8i1LAtx/smGdbfNOj30KVrRKd41DvvusgGNDaoKZo0Xp8TqV5tM7e579fzYSOR6wk2Xzh+MGAAEj0IAT35UD/RpXO7MCiumHxPkDxpb81Ex2bo1c7lehx3idCd1f7LOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481091; c=relaxed/simple;
	bh=nJEBYeRpGreh1QGrVI8xb2lqButvSZ322Cq+521//Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFnzQwhEMVxKECBX/1BiCs4BcHqrTlFdZELcYSV8FHhpqYN7qUg01BbVOS3gvzRS4BhbHg7bYfu9RPJRIfdEkNM8hDvfWQ0qXYbMwq9KgmDP+y+wl8SYAPTbDqnq3KSEZn4IOSHn3P+lOtxskmhGN5b5U5MS1FGraSoQih8Wlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B273VRIJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so85594639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711481089; x=1712085889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldMsiEP3mMIpydboV2AKm9Ciyx4AVPzGnmoIpfuSLAY=;
        b=B273VRIJvuaLdT0PcUdpfdXj7ikTwf5++cK/1AeEyiFcAP4cxK4mM7r95Uv9GLcZ9U
         mdmMmEax/pay4QZNK4/JPbS19fCH7XICDqc7KX39MGMT6xIS4xNdZvO999PyU0uR0s5P
         TynnZLio/9xEancMrDWcP4XAzEBgBsKQoq1qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481089; x=1712085889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldMsiEP3mMIpydboV2AKm9Ciyx4AVPzGnmoIpfuSLAY=;
        b=ttbOvLnqJ9Wk85ebqMs6VnDSqiX6BYzQhl80OIN+xhJLRAZRbW3fTg0Pg7DxZgJbLy
         GwvWHe6HDUCC7F8Ny6OUNCqyTV7uhASn7P4FvF9uUTLfKhlp3piizHPhcFCGd0pZ4mI6
         1r7Syaopf80pWWj+/zrWRRvjIwgRwbjtsRH8V4Sm7IROoqVRW3ufoRGU2n+Ayve8dY1A
         xK6mV3xGZYV0W3Y8uK8oYCTrAjNAPaWpV+1tCrNpnVRAwF4gaQfSopIN1u3RKeguInM1
         /d7fHtZB/PFPStD1FSFeuv+8xR/aGTTohJZ3xIWebIUTjhwkw8lpsfrZeGJYri/KQi9d
         NkGw==
X-Gm-Message-State: AOJu0YyYzzmEtojoDI/6DUEUQmkx/GO1bY6gx9JhrP5lZul/s+SJt3Up
	49E/8U3ZM7QE9hfLvG/a1Y2yUDsYhTXwiLC2Mm7+Ty2N9EDY9VYhcunZjuOb9oQ=
X-Google-Smtp-Source: AGHT+IFUHe5xOEXL/Du4BCSSxq1iQ4534XkkfdPWlPWgaWBt+Z+AC8GWX/FuKYk9lSWgJA/RBthZ0w==
X-Received: by 2002:a92:dc4f:0:b0:368:a917:168f with SMTP id x15-20020a92dc4f000000b00368a917168fmr1220395ilq.3.1711481088841;
        Tue, 26 Mar 2024 12:24:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id v12-20020a92d24c000000b00366bb13bd89sm3115775ilg.41.2024.03.26.12.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 12:24:48 -0700 (PDT)
Message-ID: <54e5ac2c-d844-47c2-b811-03d949554515@linuxfoundation.org>
Date: Tue, 26 Mar 2024 13:24:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix event filter target_func selection
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, aishwarya.tcv@arm.com,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240320141844.1779984-1-mark.rutland@arm.com>
 <20240321090950.f96e6b3918bb2dfd121db138@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240321090950.f96e6b3918bb2dfd121db138@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 18:09, Masami Hiramatsu (Google) wrote:
> On Wed, 20 Mar 2024 14:18:44 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> The event filter function test has been failing in our internal test
>> farm:
>>
>> | # not ok 33 event filter function - test event filtering on functions
>>
>> Running the test in verbose mode indicates that this is because the test
>> erroneously determines that kmem_cache_free() is the most common caller
>> of kmem_cache_free():
>>
>>    # # + cut -d: -f3 trace
>>    # # + sed s/call_site=([^+]*)+0x.*/1/
>>    # # + sort
>>    # # + uniq -c
>>    # # + sort
>>    # # + tail -n 1
>>    # # + sed s/^[ 0-9]*//
>>    # # + target_func=kmem_cache_free
>>
>> .. and as kmem_cache_free() doesn't call itself, setting this as the
>> filter function for kmem_cache_free() results in no hits, and
>> consequently the test fails:
>>
>>    # # + grep kmem_cache_free trace
>>    # # + grep kmem_cache_free
>>    # # + wc -l
>>    # # + hitcnt=0
>>    # # + grep kmem_cache_free trace
>>    # # + grep -v kmem_cache_free
>>    # # + wc -l
>>    # # + misscnt=0
>>    # # + [ 0 -eq 0 ]
>>    # # + exit_fail
>>
>> This seems to be because the system in question has tasks with ':' in
>> their name (which a number of kernel worker threads have). These show up
>> in the trace, e.g.
>>
>>    test:.sh-1299    [004] .....  2886.040608: kmem_cache_free: call_site=putname+0xa4/0xc8 ptr=000000000f4d22f4 name=names_cache
>>
>> .. and so when we try to extact the call_site with:
>>
>>    cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/'
>>
>> .. the 'cut' command will extrace the column containing
>> 'kmem_cache_free' rather than the column containing 'call_site=...', and
>> the 'sed' command will leave this unchanged. Consequently, the test will
>> decide to use 'kmem_cache_free' as the filter function, resulting in the
>> failure seen above.
>>
>> Fix this by matching the 'call_site=<func>' part specifically to extract
>> the function name.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> I think this should be a fix because test task name can have ':'.
> 
> Fixes: eb50d0f250e9 ("selftests/ftrace: Choose target function for filter test from samples")
> Cc: stable@vger.kernel.org
> 
> Shuah, can you pick this as a fix?
> 

Applied to linux-ksleftest fixes for next rc

thanks,
-- Shuah


