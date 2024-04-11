Return-Path: <linux-kernel+bounces-140704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2B8A17FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEA1285F44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2F5E552;
	Thu, 11 Apr 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lysQkaMY"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40108F44
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847612; cv=none; b=aSiLlWCkyucPLZuR4qWQINdJeOiG0rChKsZWXqSVHg/99ksPCwf4iNJFr84rLkcajo3WkAq8zyvV8El0+Nb80t8ieGcH/BR0CnH3OJ1+V0V957P4eavXs1xuCT/p+wHCPrWU54klQ50ScEWH0H3BgEQHoLtKPy/pim/qQ1e1qAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847612; c=relaxed/simple;
	bh=uB1JdinLhk3V0YLBg/+V682484sa3XigmLAVx4NVXSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIWeaBAz5kWV7EVNouI/2yRhmZoovSwgEpJ5fnCgd5DrGdd1h2AdqBDqiaczxDmN9T+VFh+EpPdXm5M1u2pIkv96Lm5xD0IOLMWqWD15TUTMR7cvBb4ID6/20oWhWYn2MO0nCs26fXCo88BSE+J/xKnCCzUr/GwzO2RdKOyYyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lysQkaMY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c5ec0c5696so873670b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712847610; x=1713452410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uB1JdinLhk3V0YLBg/+V682484sa3XigmLAVx4NVXSg=;
        b=lysQkaMY8Z6SgGk3uSs9XetZNeOArU0GA2DY0jhvHAnXMJevzNa99cPvMqmwxNi9kJ
         Uy/6bKjwy+6oqzqfX2ugzM5NNoB5jKNWrVhFLOwHAmKP/x3h9n3sT1dcjiWYyWqZtGiC
         BJLPRjBA/+dAmDbotIAJM/RuCiaE5c1/2YyAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847610; x=1713452410;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB1JdinLhk3V0YLBg/+V682484sa3XigmLAVx4NVXSg=;
        b=nQpnGA5f0FT567t8ClrLtAOaUcsKZ1sKUHhi4UT4RqyEM1MC399plfvV6sBFOA9Zbk
         44p3YHmpojZAc7e+RvP60nPG7o2PO8rm9EpJIUV5tBzfPFOMqiagE4sqLEmoq0aflCtV
         KdqcKdFQU8EFgo0moEw8SNFVNo8uiYJUFik/Wf5CA8gf7Mmy6o8y5QsrzC6rHEKkdgBJ
         AsKjAlGD0a0xFweJIPoFwiIZY3bwgm9fAVTGBGK69SpwtSTUWR1wxq1CZbK8I5yctT4m
         hcs5cXJtbvCfRpXpG9oxdb/D9uLegLoUb8bvysN/C7gpxCClWkFSuXm99G0SN8fwNxj6
         3XAA==
X-Forwarded-Encrypted: i=1; AJvYcCV+oBpjEMt093pxwWuexCto2uBqX8NlZFIKz1mD6aGYPUZEf2CJ/KBt8m6usTZ8HHSaSjk9jq52MP0rhGaR3QNPiW604qQKhSxAFLWh
X-Gm-Message-State: AOJu0YyKqzu68KYMOudjsbUaqoyA9BB1RSVytkF2r2EeWe5UMOqxwdj3
	UU0LYYnZcPEbDT11I4Uh7LXFX7FKN/gVafhqhToxp719V2206cL4MU/g8Lc3fF4=
X-Google-Smtp-Source: AGHT+IH3K6iOJEDwD+kNIHxp12FsVLU/AmbYpk4BowMj7PjzndhR1n81ILgtzJca3ud/I5Vc/qz64g==
X-Received: by 2002:a05:6808:2392:b0:3c6:12fa:286 with SMTP id bp18-20020a056808239200b003c612fa0286mr3166778oib.15.1712847609972;
        Thu, 11 Apr 2024 08:00:09 -0700 (PDT)
Received: from [10.80.67.140] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id jv21-20020a05622aa09500b00434ccf344d1sm773053qtb.85.2024.04.11.08.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:00:09 -0700 (PDT)
Message-ID: <7590c66d-96dd-4182-b99b-9a618a2a8f1c@citrix.com>
Date: Thu, 11 Apr 2024 16:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode or the kernel is running in a
 hypervisor
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>
References: <20240411104822.6429-1-xry111@xry111.site>
 <3ee70b6c-3399-43f9-8934-cb5a0e51f006@intel.com>
 <1f5d53596e2ac8948332570e3bda17c3877fd499.camel@xry111.site>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <1f5d53596e2ac8948332570e3bda17c3877fd499.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 3:48 pm, Xi Ruoyao wrote:
> On Thu, 2024-04-11 at 07:44 -0700, Dave Hansen wrote:
>> I agree that it sounds weird.  It _is_ weird that systems running under
>> hypervisors aren't affected.  But that's all it is: a weird bug.  The
>> documentation is correct.
> Yes, these hardware issues are just weird to me...
>

I have no inside knowledge here, but this isn't surprising to me.

VPID tags are unique to VMX operation.  At a guess, VMXON reconfigures
the tagging in the TLB to include VPID (and EPTP tags for that matter),
and works around the buggy selection for which PCIDs to drop.

~Andrew

