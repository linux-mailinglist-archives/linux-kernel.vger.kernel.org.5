Return-Path: <linux-kernel+bounces-73804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E385CBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A612859F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196815444C;
	Tue, 20 Feb 2024 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMgSqsC4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A7154430
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470452; cv=none; b=BFKcb44cYJWFqMiepCx+dDOlLrJMKQiWooJjPqZk62SXQn4S1Ad709YE3osIqNTJdsD5xDJtcQnAZH78Z+6V2UDBQxMe7cTHHVKpsIzxvs8FzIS2jA34cOLdIseAJVXoZdr2MdOXGVS/y9G3buIkZOXpfkOjoIT3nGuujw9EyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470452; c=relaxed/simple;
	bh=fHKOmlZcwTyigCc1C09h+brUzug3zaeOVrozq4hbx2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOzXIc32DQeL1UZ0CpkPL52gDEyLR0tnfK5LMaxbvYqaRYhLyZWhJZRcTzdXAGnn/x7dTJ2nA6ouSamLa0oOK3gpOFwK3dDPBvqEVMmqCZVXs9+sMHm7WWF5YOMM/T6PHykriQLZ9J9QWdTbvVRs+pOMcuSvHiEPGrNH+IVa8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMgSqsC4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso98629039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708470449; x=1709075249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x2CUPvUFUUko+dVNH1Y/5ad8W+x8zRKELcvKfDncbs=;
        b=aMgSqsC4jeQx6Cf0PWKk3p850ojupYtLxAg9Nf3C/yq8BRp+O3Z0XE+OYBm6pc5mmk
         D8uvxuNtiPoM+1EwdxtpSWa2NkQOMNoGXS8vdUyYbMF95ABbyvWbco18/oymczgU0X82
         GK1HkDH+BeZSN/RRmu7pZtjbYwvkxxjYWMBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470449; x=1709075249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2CUPvUFUUko+dVNH1Y/5ad8W+x8zRKELcvKfDncbs=;
        b=iWqxNGHpM/ZmO8P7DS+D25ePQQixCbTpYoJ0Kxi0YuYFrkWztM2OkKgOk1/OuTFK/Z
         Q0Y/xG5eXfB1ourT9+eenkTsd9gcNAJ6ssAkORidA2hB/0NWE92+KzGi+IbOKDMAC2b3
         qy8JnMJcVmLnv5Oe5Zk2yMqHThQI79hC9MjxSO+ti/rUMJVdQOV0DXWxqU0hL++JIgT6
         Un3pkroaOWdZFrYCWeKgwE7FaRq/HP5ty34RIa15aEtoUYKZb2xH4DgAEOVo4Vj0x4cD
         ab+n3jXqmj90eDaidCX9bsmaLv9KoQzTXbWU5WBMD2JJIFhO2D6aDpmQH25mJTHiRFno
         t7PA==
X-Gm-Message-State: AOJu0YxwPPpxZdTlOvsUGOVNFK/EZdlCMyaL6jKdHud0mU7RM2cqWYMP
	dzfKICBsewthIiyZwAh4npQMf+mXcdjzkQ1v7/60X56NtEl/8vlzhD8KDIAtqUg=
X-Google-Smtp-Source: AGHT+IF8qVAf6CmBpwXsy1pUXIlHU919CQ+KUf6sP/gKuYif37kpL2xFgo35WqEMwBcV6ZKD8DuBcQ==
X-Received: by 2002:a05:6602:1d47:b0:7c4:655:6e05 with SMTP id hi7-20020a0566021d4700b007c406556e05mr15344624iob.2.1708470449710;
        Tue, 20 Feb 2024 15:07:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t125-20020a6bc383000000b007c4926ebed8sm2649012iof.40.2024.02.20.15.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 15:07:29 -0800 (PST)
Message-ID: <bd0abacb-e0d5-40f5-b786-6021f6d8bd2e@linuxfoundation.org>
Date: Tue, 20 Feb 2024 16:07:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8-rc5
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, David Gow <davidgow@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kselftest list <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
 <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
 <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 13:16, Linus Torvalds wrote:
> On Tue, 20 Feb 2024 at 11:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> It turns out that that commit is buggy for another reason, but it's
>> hidden by the fact that apparently KUNIT_ASSERT_FALSE_MSG() doesn't
>> check the format string.
> 
> The fix for that is this:
> 
>    --- a/include/kunit/test.h
>    +++ b/include/kunit/test.h
>    @@ -579,7 +579,7 @@ void __printf(2, 3) kunit_log_append(struct
> string_stream *log, const char *fmt,
> 
>     void __noreturn __kunit_abort(struct kunit *test);
> 
>    -void __kunit_do_failed_assertion(struct kunit *test,
>    +void __printf(6,7) __kunit_do_failed_assertion(struct kunit *test,
>                                   const struct kunit_loc *loc,
>                                   enum kunit_assert_type type,
>                                   const struct kunit_assert *assert,
> 
> but that causes a *lot* of noise (not just in drm_buddy_test.c), so
> I'm not going to apply that fix as-is. Clearly there's a lot of
> incorrect format parameters that have never been checked.
> 
> Instead adding Shuah and the KUnit people to the participants, and
> hoping that they will fix this up and we can get the format fixes for
> KUnit in the 6.9 timeframe.
> 

We will take care of this for 6.9

> Side note: when I apply the above patch, the suggestions gcc spews out
> look invalid. Gcc seems to suggest turning a a format string of '%d"
> to "%ld" for a size_t variable. That's wrong. It should be "%zu".
> 
> A 'size_t' can in fact be 'unsigned int' on some platforms (not just
> in theory), so %ld is really incorrect not just from a sign
> perspective.
> 
> Anyway, I guess I will commit the immediate drm_buddy_test.c fix to
> get rid of the build issue, but the KUnit message format string issue
> will have to be a "let's get this fixed up _later_" issue.
> 
>                Linus

Thank you.

-- Shuah


