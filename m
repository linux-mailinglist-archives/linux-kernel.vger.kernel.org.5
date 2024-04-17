Return-Path: <linux-kernel+bounces-149027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4EF8A8ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1331C23027
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF235172BCD;
	Wed, 17 Apr 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="uCj8vNCk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF2171668
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376920; cv=none; b=FcpqmT2/FAxWh1ePNs2//+ncQURZmWALOuG9XharXADGQk/L5eYsFaA8izrWeSs2fF0TfllALHQyXd4oKnlR97GLFHwifebC72rX0Di85cFB6TrjZA+VAfEsHHIS6bzNfl8sxY6KTR35aAaSYQI+bVCUllPeeES5fnY+ap7gZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376920; c=relaxed/simple;
	bh=HiW94CFUU7BsecIQJppbBV5q2YYYI0NIca7K9uJp2wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaQhl9Crk270F4hu0K9xWuo/Om30puV4nbaTx7irC4VToU5vCOAPekQvummkhn8JbYGRGSuaufYxt+Mhb06DGV2ngL2bPI/ZqgyCWQMFt6m5LMW59D47iykgjyuDcp/fCbs9100lUdzZM2LhWBWsSv+4sr/JIFkx3krzSEwM37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=uCj8vNCk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436ffc2798fso7436141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1713376918; x=1713981718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTZjWUYxj2wH2IhOsrS74DQHrPvPTmRBeeG4eS3BQm0=;
        b=uCj8vNCkeTRwwfhBZ4I7+UcQVitM54AscsaAiqfTV2yhuXqARa1xslySt/6DqI/5+g
         H7Lm19n5qxW684ASRPmUqO0Gux7XuATbZpEvZjbmEKcIGeO4M+8ZFQaU34nhwEY87RqI
         cw+64XM5c3LLijrdFlm/TNNd55yV1Q3MwQwDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376918; x=1713981718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTZjWUYxj2wH2IhOsrS74DQHrPvPTmRBeeG4eS3BQm0=;
        b=OTSq7L8cRMttaJhKD5sd8g+T8wJoh2TQozsRctBL1XiM/M0MnP8W28m078DM56k//5
         rEVqBQCC1kIB8ucHqkrdj71v8wx5AQu+QN1YHNxd0V4wPBm5BsPPr8Ic0yihhgBdFoTx
         RhE5Wfdh6AXPrRnpsWq3DDu0ftamFXcx2zrmgmy1KmjuU6rInm4x/ovZ8QtAOcPoswbX
         dRFd5/hsy3XdopxjzW3qzBx6n4cLbUsiEt4nfrsn6YNcxPwiM+ZpxE3efJpC9e759VMb
         DsUvsGzYuSqwx6W2xDG3QdXXoEGJjZsJ//4sUVAJp6joc8QtwTEn1J8Ht+4bHnBWBFQZ
         8jNw==
X-Forwarded-Encrypted: i=1; AJvYcCVQf3dvr8GRxFJ6TSX5uKDc4hD4ttAX4Tt7ZC0Tg+IdQraJNK90JMPaUeIWIo0n7WRTD/bcxNyaANqO/6JfhIQgPG/mVUGXRmak6vuX
X-Gm-Message-State: AOJu0YwrUk1N4UHF4OnIQPPeftjvuUYnobXX0Z0S0KMdtb0ijZDzE6z7
	P6v8qG9oI0L0NWOd8MRHuR8HbNLRziz4lTfaTVa5P2IZYZUO5i7ze4wKJWiz5C8=
X-Google-Smtp-Source: AGHT+IEm2OG90KUDHxury7s6a4ajVbDyuEzeh44moBmhFRNj4sp5OpYPvyTBqabmW98tw0L1PrP6KQ==
X-Received: by 2002:a05:622a:210:b0:436:b948:7e6f with SMTP id b16-20020a05622a021000b00436b9487e6fmr223301qtx.17.1713376918303;
        Wed, 17 Apr 2024 11:01:58 -0700 (PDT)
Received: from [10.80.67.140] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id f26-20020ac8465a000000b00434a352e239sm8334102qto.43.2024.04.17.11.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 11:01:57 -0700 (PDT)
Message-ID: <2a490bb4-fd00-46e7-b7c3-bb8ef962d8b9@citrix.com>
Date: Wed, 17 Apr 2024 19:01:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>
 <20240417164514.66hgypzxgqxt3ssk@desk>
 <20240417175723.r4si62d6oqirqadb@treble>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240417175723.r4si62d6oqirqadb@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2024 6:57 pm, Josh Poimboeuf wrote:
> On Wed, Apr 17, 2024 at 09:45:14AM -0700, Pawan Gupta wrote:
>> On Wed, Apr 17, 2024 at 04:14:26PM +0100, Andrew Cooper wrote:
>>> On 17/04/2024 12:02 am, Josh Poimboeuf wrote:
>>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>>> index ca295b0c1eee..dcb97cc2758f 100644
>>>> --- a/arch/x86/kernel/cpu/bugs.c
>>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>>> @@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
>>>>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
>>>>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
>>>>  
>>>> +	/*
>>>> +	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
>>>> +	 * considered safe.  That means either:
>>>> +	 *
>>>> +	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
>>>> +	 *
>>>> +	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
>>>> +	 *
>>>> +	 *   - the user turned off mitigations altogether.
>>>> +	 *
>>>> +	 * Assume innocence until proven guilty: set the cap bit now, then
>>>> +	 * clear it later if/when needed.
>>>> +	 */
>>>> +	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
>>> Following on from the (re)discovery that X86_FEATURE_RETPOLINE is a poor
>>> name given what it *actually* does, can I recommend s/SAFE/OK/ here?
>> Or simply X86_FEATURE_USE_INDIRECT_BRANCH.
>>
>>> This flag really is "do I want indirect branches or not", which - as
>>> noted here - is more than just a judgement of whether indirect branches
>>> are "safe".
> X86_FEATURE_USE_INDIRECT_BRANCH sounds good.  It's a bit long but does
> describe it better.

Works for me.  Definitely an improvement over SAFE.

~Andrew

