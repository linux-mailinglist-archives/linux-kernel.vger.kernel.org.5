Return-Path: <linux-kernel+bounces-133471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A7C89A43B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC0E1C222D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B317172796;
	Fri,  5 Apr 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+5Eg3rt"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0E171646
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342107; cv=none; b=FwjH5AgnpaW92bu2p/qkJgMOnXrGZS0yjt/WSLXeR+IABmAJhi3wob/i1HACFACgdKDblPtTcGirBX51lzLr3BKmMT0+SBcWTGSC6TW8SE/ywjCEPLK0pXDMq3eb23rZtxsevbM1FqpVcSBEMvUNLRFbQq5jZmDmh+E5PcDBGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342107; c=relaxed/simple;
	bh=6ZjefErhMfmeYuBEs1nM6MSn4jNdNTdaFy6x1mnwXpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR0IZ9GPmsYYSqgV8zW3FSSL1BEyqI7EMvOWdVHPrxXPPt0aWSJuYvJ69jetgk/Z9pMX4tS8E34Y2K2nlA0ZAwa+IAKcQKI9w/myg/+KHk4vCS/vDK3GUargkJBDr8lQt/8G1GnmLMKL/nqhypA9KP9lciUZeRR1FDeR6Y3JiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+5Eg3rt; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so50721739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712342105; x=1712946905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qa9OWgSGHy86iFLsGhob6bEBoogAWHpT07UAtRblqpQ=;
        b=Y+5Eg3rtIe7VMYHiZr4x9lRDOR5iCv6ylQgOlmdxWHA1TFq634s31mPcYCe3pHO50U
         +y7Ym+WSNMZtaeUSuJYS0UipUs1FPTTt8HyWAhAfYqksxGn7chdP3M579DhWbFOFcWiH
         ziHV9/x0j8R4Nbfl60wkU5xzg/0E3n4vzq1DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342105; x=1712946905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qa9OWgSGHy86iFLsGhob6bEBoogAWHpT07UAtRblqpQ=;
        b=PVa75Vl4EjUgAu+T3bf62ZlaDX4cerZJEEbKIiqxZsGD1C1vj/D1OrUSHqwwwsA8AI
         JmltjNurYdQkXa7WyUcFqK79zv6ZjJN/V09Q1usa5yKFkoXofnU1br/7xob7zFQRdHJL
         m5KLAGZ9ZPRtYeNl0WzfRWk52+yiB6QbPZXQzlKk1ut9lVpxj2hU7tj+M2Z55iQ9h7pc
         atkRKJxo+7i4ISrWpBPswXxHCZ3zb4yW6smrL2XAWhSZuiuPhwDemQAI7Ok6VTpbmwgM
         /lN0z/nrzLMnR7ktLuZaxCASjfUPAgPQmoGAySm+IQ2o6CTnDu7ornJdz/LrTTWWzsoA
         a/4A==
X-Forwarded-Encrypted: i=1; AJvYcCU2tysXB/i5azo735dUuXAL+PzPiXIf3r0BZlPYZFhKT8naueIKRcnaJSYoD7Y9uvDx3Fk/VWAp7dyDg2Cd5kaeP7ExCKmaipZsNkfo
X-Gm-Message-State: AOJu0YyDomHGoMQdcS7mzvKR8ZV2oF/Kv30CXkxeo4G4gl2Gso4qT2q9
	X4mfBCC1aDHEpqV9LAvczDiwePRGXY58V8tu/fZxUZDMyzlE6XetmfSpkaAKzs8=
X-Google-Smtp-Source: AGHT+IGtByH7WDW3n0zir30+zDOgj0SA2esTzdcEHOquB4Tj3nh/EzZ8FEfaoZ2efToARrGR3C666w==
X-Received: by 2002:a92:dd0a:0:b0:36a:d81:6f35 with SMTP id n10-20020a92dd0a000000b0036a0d816f35mr2112409ilm.2.1712342105467;
        Fri, 05 Apr 2024 11:35:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m15-20020a92c52f000000b003684d4f6b44sm574171ili.4.2024.04.05.11.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:35:05 -0700 (PDT)
Message-ID: <040f65b0-5484-47f9-8e43-af5316988c5a@linuxfoundation.org>
Date: Fri, 5 Apr 2024 12:35:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jamorris@linux.microsoft.com>,
 Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Thara Gopinath <tgopinath@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>,
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 x86@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240326095118.126696-1-mic@digikod.net>
 <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
 <20240405.pahc6aiX9ahx@digikod.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240405.pahc6aiX9ahx@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 12:07, Mickaël Salaün wrote:
> On Fri, Apr 05, 2024 at 10:08:00AM -0600, Shuah Khan wrote:
>> On 3/26/24 03:51, Mickaël Salaün wrote:
>>> Hi,
>>>
>>> This patch series teaches KUnit to handle kthread faults as errors, and
>>> it brings a few related fixes and improvements.
>>>
>>> Shuah, everything should be OK now, could you please merge this series?
>>
>> Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
>> except for the important ones. :)
> 
> Indeed, I don't know how I missed that... Do you want me to send it
> again?
> 

Yes please resend. I will pull these right away.

thanks,
-- Shuah


