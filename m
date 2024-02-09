Return-Path: <linux-kernel+bounces-60144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738F8500B1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731021F26E47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FF381B8;
	Fri,  9 Feb 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN85CGzV"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BE36120
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520845; cv=none; b=p6776rlscd5PPxUnuOQUZ9ikIEIJh1O45EacThWYNbI1pimGpQnzb/ObXRQjEMPP9Cr4XPPVNfcEjyFgbL3otoK08HHyinEcGWmtKJ87sUilsIC6llAr9pslgbNUsBfcVxHM7P6d9t7gtGaR3mG+8KMtmEe8pBnKnUj2mNF6kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520845; c=relaxed/simple;
	bh=uf75RmmaasfJs85RE/vtD2MDKZCAkQJrySp0Fe5u+Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX1qWk/6M6D+0O+6BTQGqtGy20rSmuTPAkaphkuCgQhjjUo3RvTHrlUTG7hIa+Fg4BzbGaWxF1AOrsTYoy4+AycQ5NIhBon/cqrBfuJdTGsW6570En2B07hmMokghdF3zj6y3KPWm0ChgJsN1gWR975kVIeKbZweKO0XxvIZhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN85CGzV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2970f940b7cso550623a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707520842; x=1708125642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pUX7rZnvyFvDNPjdlReFBmCCuHj67RGrGqzMayPKgZI=;
        b=cN85CGzV/8L9ObKB+yKGIAt3V4ZJrpyCNoUfkf1mSrLI+SlUtEn/XGKs/udlb3MQZU
         E2sr9GtMGKWwy7SB/67H/jVfqvLLBMfpZbfENV6KBLWA2hnOdnOV9b9+lZDnn5czoW+S
         zGGhxO76YqnPRRhLKNex48qcusq+Z8zIFtQfUENHPLt4pH+EOzdn/7yTrIZt0asf8kzZ
         eELFsBSGLJcK+32GR9WEbAbasiFys1Abj3jMWh+ulL1MBnLQzo2KsDxTBSntWbm736lM
         Uv/sWkwPRqRQAHnL6M3MnCUz66zMo56IjVEbn9+mN4sLDvUpNr4mukRO620GmPpoNnH7
         ncgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520842; x=1708125642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUX7rZnvyFvDNPjdlReFBmCCuHj67RGrGqzMayPKgZI=;
        b=slqCkLZ3ScKhwghVOrGWE/Wc5Y7QFmbzmUf+GMVdRU8pVn8W5YN570VJ/24GWX9Ii9
         QNs8NJQUVwZYlsC0HciDpy53nX8z9Xqa652mNhBCQ6NqqcjsqKeaacsgalFNztsIqB2O
         zs+pVLsLpGJ64HQtQ4PiCFCPkF6MuUFBdIvLV08eesjCOVkG/KF8GsOX+hjMVW8MbJ9o
         g4BFT5Ms7H9yz6Q24slog1XSsXJG0foH0jdw9ODaMbUZmuaJJa9sGqzQtPCZPuGM4Mow
         6yrebScTolYnH291t/BYv3ARcg9XfCtcjnY+4o9G8F55DDyrsOmq/9w7ya1FM2Sl88LU
         7xWg==
X-Gm-Message-State: AOJu0Yz1vupFTs2KNwM2bssqiBfOqwEap+smmWqT6HDa9TFy8IQcD6Ys
	5FhgjD4hsp0SJRwmfjGfIcMt2Ko/iUgWk6f+8fgic8PPvS79/zbSeUTIKTL5
X-Google-Smtp-Source: AGHT+IGUsY5Q2E7R5Anl9qHZBwl21KIW3GdFPbhJ5W+fDcaCtamSmi8icEAHwM6sO8DraOi2XdhNNg==
X-Received: by 2002:a17:90b:380e:b0:296:43a:932e with SMTP id mq14-20020a17090b380e00b00296043a932emr598534pjb.7.1707520842505;
        Fri, 09 Feb 2024 15:20:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fr21-20020a17090ae2d500b00296bb0b2f57sm2355152pjb.21.2024.02.09.15.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 15:20:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2c9b610-ca76-4104-9969-7dded960d4a2@roeck-us.net>
Date: Fri, 9 Feb 2024 15:20:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] regmap: kunit: Ensure that changed bytes are actually
 different
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
 <7d077da1-e792-4570-914e-5c26de420c43@roeck-us.net>
 <ZcapjWTuggJNdV/o@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcapjWTuggJNdV/o@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 14:39, Mark Brown wrote:
> On Fri, Feb 09, 2024 at 02:07:38PM -0800, Guenter Roeck wrote:
> 
>> This is actually worse than v1 because hw_buf[6] isn't used anywhere.
>> Making sure that the values in the val[] array don't match the values
>> in hw_buf[6..7] doesn't add any value.
> 
> Yeah, I realised after reading your earlier mail.  It's passing for me
> somehow.
> 

It is passing because the probability for it to fail is really low.
It only fails reliably with the cheat below.

>> FWIW, I had struggled with the re-use of val[0] for two different tests
>> (on hw_buf[2] and hw_buf[4]) myself. The only solution other than making sure
>> that it neither matches hw_buf[2] nor hw_buf[4] I came up with was to use a
>> separate variable for the accesses to hw_buf[4] (or hw_buf[6] in the old code).
> Indeed, it was fine with the old code due to not caring about having
> different values but we need to generate three values now.
> 
>>          get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
>> +       // Let's cheat.
>> +       // Remember, the above code doesn't look into hw_buf[2..5],
>> +       // so anything might be in there, including the values from
>> +       // the val[] array.
>> +       hw_buf[2] = val[0];
>> +       hw_buf[3] = val[1];
>> +       hw_buf[4] = val[0];
>> +       hw_buf[5] = val[1];
> 
> I don't understand how this interacts with the pre-sync check?

That is because the test expects the memory in hw_buf[] and val[] to be
different (because hw_buf[] wasn't updated to the new values). The above
cheat forces hw_buf[2,3] and val[0,1] to be the same, so the pre-sync test
fails. The post-sync test passes because the values are expected to be
the same at that time.

Guenter


