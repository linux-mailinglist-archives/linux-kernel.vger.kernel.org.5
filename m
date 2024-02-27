Return-Path: <linux-kernel+bounces-84116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094D86A24A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0BC284AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69724151CD9;
	Tue, 27 Feb 2024 22:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ZSqTq+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331284F208
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072258; cv=none; b=N9kIR36bv7A2edCr5xsFfvr7HOAH4zJpJF1/rE/OKJqWKWVS+NiACF0gTLeJXHJ08MFuFTFxbnYccsR5+gcvu5FaDDaISZvdsZ29GynP2GRhT/S4WXwX2b9JloSdjhxRHT8VmOdv49b35mJymx/ow9r+Tc2ZpGUJZGE/60wF5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072258; c=relaxed/simple;
	bh=aR5t2Wfku+THDivp53lV36poeGH4/NI+Gq8iHybN7bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s44wXh/RZPFqgms2PV2FjOkMcuyoYXo0sKnxqleXERi8X7JNCp3tH9MHx6H3QHP/Pi5CJ2ZmYvXmJaTl9hENkgmQJcV7hnB+7O9tmcIvNvuQ0dCqJ2qdgN2tE7P82PiZIbCvfZ3V5S6IlCwZy3x4cn3tQChXoBSR3mU31Rxokms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1ZSqTq+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a3903586so21249055e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709072255; x=1709677055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jL1OrywmYVgdUyq4Qpu3yOEeDXFaEcSGIdQX1BM8BP4=;
        b=I1ZSqTq+O6yzQATL9A2vwhelVnIvz7JluDbRA0Mwg40VwUDQ6+1Z1CwwumiT2PZm9V
         mi7ksrs845myGS+cNHawPzPtzdQVI9tcPf/k2lZ4z6sv/skUeSDbA71SgrkhmNZn8wqI
         c/Z2Btye1TpxmoafJmjUcAUuhkLdUYVtJElUUCXo41ho7NXCAkSHannpCTtd7y0Vampc
         7MjFmDe2gQMM1jXKGWAMDHwLUOmi1ijN3VCe/jxbENTIWGQLnSuLuP+ZxnWhOn+oW5Ev
         hipzygTnjBZkfv8sbhtvRjUvO2mEEKXIZthqmRGm2FQxxAsgNagzMzZgrMGZp2cc/zce
         8qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072255; x=1709677055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL1OrywmYVgdUyq4Qpu3yOEeDXFaEcSGIdQX1BM8BP4=;
        b=kZQPyqWuGg+yU86bWnArOKZplkSVU2/KaqaV/LOEIWaVTY4F/nM9I0/ff6IZCGFPF6
         7j6TUVpIr1aCmWElg1CeLzDwngIfwWgNIp09km8jzZSZyiAl6qtoC2Ys2KzG4S7drrY3
         Gb8/y9emXRHYR97hV+NkjvnXRVsHEMd8qDwjchO1FolapAPtbuZKk4o3c9BXWZIFj74L
         5ehtUvDedCa68qJHqxf8AcyXvLHIPOKiR2o84V/XkUI4nyFMp8tz0UT82T2VxfgX2x4w
         Egs3VEVeYFuWqcm4nHpyBEyYrnWYHgvHh87OShkZpg6H02UoYqsL8rxY9H/MIWTYhzb9
         9cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKHZg62MY85qXumKOoFvzpCfgDqL73ZPqCRl9aExpm1btKMxc32Q7Sd1A2/AYyryKrotxAREfC6ToySyGDjYZos6/QwrUUbwK4PDOG
X-Gm-Message-State: AOJu0YynkZSsJaBG7iT5/wEu5dXuA2ho7N3akkJxTaB7yWOnDsdru3o9
	uvaoRn8l+Pk1AM7FwdOulFKmT9sA0+1sTjPyV4KB7ZYF6z57c11r
X-Google-Smtp-Source: AGHT+IHQ/oHFxiN6KJDBu9GX112uZI8SoNaVjD7teKCAcFdClHDhdK7NfXhX5gnjzn7G8naRwqf+5g==
X-Received: by 2002:a05:600c:1914:b0:412:8c96:b15f with SMTP id j20-20020a05600c191400b004128c96b15fmr8088331wmq.37.1709072255506;
        Tue, 27 Feb 2024 14:17:35 -0800 (PST)
Received: from ?IPV6:2a06:c701:736b:f200:73a5:2235:8954:9b7c? ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id a26-20020a5d457a000000b0033dd56b002asm8380083wrc.73.2024.02.27.14.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:17:34 -0800 (PST)
Message-ID: <38e1b141-f7ef-40fe-be8a-97d9f9273a8f@gmail.com>
Date: Wed, 28 Feb 2024 00:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] staging: pi433: Remove a duplicated F_OSC define
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com,
 benjamin.tissoires@redhat.com, elder@linaro.org, robh@kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240225173341.1278918-1-ikobh7@gmail.com>
 <20240225173341.1278918-2-ikobh7@gmail.com>
 <ZdykDGo9fMw5fEdp@smile.fi.intel.com>
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <ZdykDGo9fMw5fEdp@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 16:45, Andy Shevchenko wrote:
> On Sun, Feb 25, 2024 at 07:33:38PM +0200, Shahar Avidar wrote:
>> F_OSC is already defined & only used by rf69.c source file
>> Also fix define comment
> 
> You missed periods at the end of the sentences.

Thank you for noticing.

>> -#define F_OSC	  32000000 /* in Hz */
>> +#define F_OSC	  32000000 /* Hz */
> 
> Instead of having a comment you can
> 
>    #include <linux/units.h>
>    ...
>    #define F_OSC	  (32 * HZ_PER_MHZ)
> 
> which will be more robust code (no need to count 0s).
> 

All comments are fixed in v2 which was just sent.
Please note I sent the updated patchset twice, I forgot to add v2 the 
first time...

-- 
Regards,

Shahar


