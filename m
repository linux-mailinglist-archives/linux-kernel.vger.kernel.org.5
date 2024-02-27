Return-Path: <linux-kernel+bounces-84223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEA86A3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBA01F25FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7A5820D;
	Tue, 27 Feb 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/9jUsDk"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7958124
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076734; cv=none; b=Da246UfwCIU7g5Ccuo/2YGey2zwhkxeuHAetQy5vM4GyGIMc9gunCsiul1ycpPQBAzZOBN/8l0IbY8GG2keUgxSC7d1pGi7k0UFR3XrHJYzFwFnO62ikTx+dpfKeQrByhgSQbCtvDs1Q6M6EGNaUPpjNsmcCiOULRp3akdXWVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076734; c=relaxed/simple;
	bh=vuJ8723KNo7c2i4PE8+dSpAbj4FcKwCZBz13erSUw9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDtsYZA5dW6jdoQKFcdPN4X+Uo2cT6vOuhR1uM64eBjxtxz/gX5seUXdqOEZ+BGbxd7EXOdRTXg6p0cJy9szRJmalp+QTwiH+9Sys3Mc+Dz08PRslHlAvGTN0UxECTACHqd6emq/7JUdBWHMKIDFc41LScsp//vdjcH873T/xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/9jUsDk; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso98703439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709076731; x=1709681531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80vE8I00zUuMjb98bapG9u6P0XhLZj80ZGaIUfonjH8=;
        b=M/9jUsDke8TosbOh9m+Bc+Whgu6pRM/Fbw2x6KlW4NmRhBXJazX2IOizi7Kz4id8MB
         hU89w9hUF3bF4ttXEun1OfTdOgwtJIHIFw4MIyPCCj2b0/nUPF5Ai0BQM478AYoTTTex
         yNy9fQCWHDb6GKdtfA8eenpxpx5ccnGpMI5hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076731; x=1709681531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80vE8I00zUuMjb98bapG9u6P0XhLZj80ZGaIUfonjH8=;
        b=AnMsc6lv69+6QhiyYO3kYJh3TTw3lfnyE5JcBhb6b0kH6y05Zbh32qeEaOmxaxUPFO
         NPPzFdIvpMIaIYHb0JsVpq5Pj7ihAUNqWPbb07AIQcIk1PHAuwk6hUpCc7uAp+6ZleJ7
         ONnhHRUf6oDI9yeejVlhyBxGCAYHJbCKiPZsnyqVb7uqAjbIqm0IN8uEmkOopO7s2Mch
         2qQSYo5wMpizVjVffy1RiUEKQaOP/wr0DQNluJTLwWKQ2pXbGsoMTvw5Q4dhsZt9L6vV
         GJOO4ns+Gj5ruyQWzUjuZ87aczcmoX2uL3+2kUbWVlFqSlfSN7Hlkgw63YFt/BiN4KZ5
         R3gw==
X-Forwarded-Encrypted: i=1; AJvYcCWDs4o8ns2BlE9uBOqnC6eb0rsX5n/mi5UIueD9Ba/A/cp3nLlG5wBXwwqiNdKggS10HhOslLBm/3J2OblF2byMM8pXj9YStz8i3oiU
X-Gm-Message-State: AOJu0YyodPXwNaxcPbQWUjNpQqj/dXHAk+zRKijElCjmk6g1PLG7nBq5
	h77cwv/724EvRvPssE0f9YuzMcbeiWDAvfrckBr32MkqRmcf8iMNSuhJLQSVlIQ=
X-Google-Smtp-Source: AGHT+IG69oUodDQLtj9TB2lWzXOa+NfkxOjVRrZm5njOmm/xNqu/JAHdlHJH3zfk/5jCzDJ8f9tmVg==
X-Received: by 2002:a05:6602:2195:b0:7c7:ce93:f532 with SMTP id b21-20020a056602219500b007c7ce93f532mr5798424iob.1.1709076731281;
        Tue, 27 Feb 2024 15:32:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s20-20020a6bd314000000b007c45ab3dc34sm1998648iob.29.2024.02.27.15.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:32:10 -0800 (PST)
Message-ID: <fd438c6c-87a2-4976-aee1-b706212914c4@linuxfoundation.org>
Date: Tue, 27 Feb 2024 16:32:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] kunit: Fix printf format specifier issues in KUnit
 assertions
Content-Language: en-US
To: David Gow <davidgow@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>,
 Cassio Neri <cassio.neri@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Arthur Grillo <arthur.grillo@usp.br>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240221092728.1281499-1-davidgow@google.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 02:27, David Gow wrote:
> KUnit has several macros which accept a log message, which can contain
> printf format specifiers. Some of these (the explicit log macros)
> already use the __printf() gcc attribute to ensure the format specifiers
> are valid, but those which could fail the test, and hence used
> __kunit_do_failed_assertion() behind the scenes, did not.
> 
> These include:
> - KUNIT_EXPECT_*_MSG()
> - KUNIT_ASSERT_*_MSG()
> - KUNIT_FAIL()
> 
> This series adds the __printf() attribute, and fixes all of the issues
> uncovered. (Or, at least, all of those I could find with an x86_64
> allyesconfig, and the default KUnit config on a number of other
> architectures. Please test!)
> 
> The issues in question basically take the following forms:
> - int / long / long long confusion: typically a type being updated, but
>    the format string not.
> - Use of integer format specifiers (%d/%u/%li/etc) for types like size_t
>    or pointer differences (technically ptrdiff_t), which would only work
>    on some architectures.
> - Use of integer format specifiers in combination with PTR_ERR(), where
>    %pe would make more sense.
> - Use of empty messages which, whilst technically not incorrect, are not
>    useful and trigger a gcc warning.
> 
> We'd like to get these (or equivalent) in for 6.9 if possible, so please
> do take a look if possible.
> 
> Thanks,
> -- David
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/linux-kselftest/CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com/
> 
> David Gow (9):
>    kunit: test: Log the correct filter string in executor_test
>    lib/cmdline: Fix an invalid format specifier in an assertion msg
>    lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
>    time: test: Fix incorrect format specifier
>    rtc: test: Fix invalid format specifier.
>    net: test: Fix printf format specifier in skb_segment kunit test
>    drm: tests: Fix invalid printf format specifiers in KUnit tests
>    drm/xe/tests: Fix printf format specifiers in xe_migrate test
>    kunit: Annotate _MSG assertion variants with gnu printf specifiers
> 

Applied all patches in this series except to linux-ksefltest kunit
for linux 6.9-rc1

drm: tests: Fix invalid printf format specifiers in KUnit tests

David, as requtested in 7/9 thread, if you can send me patch on
top pf 6.8-rc6, will apply it

7-9 drm: tests: Fix invalid printf format specifiers in KUnit tests

thanks,
-- Shuah



