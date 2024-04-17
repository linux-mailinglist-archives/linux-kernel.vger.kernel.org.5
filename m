Return-Path: <linux-kernel+bounces-147779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBF8A7994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44E5282F76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CCE394;
	Wed, 17 Apr 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSCIzlH5"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC529CFB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312223; cv=none; b=Qv3L/i3I9ZPvAvPvKIFtiQEuPJXFSqixUfPtviiaswQnuVfMEpK9aBXQbfp63svNhQCqoHsZ2Ht/5AhnabOZnRRgn1xp5Hs61E3nB5yUYMPxZ/E/C8EZrbdE4P/BWVL+Dvsmhsw38o7UjSU+qmlrCXyESlNvmVfs1FVhY9447og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312223; c=relaxed/simple;
	bh=sAYUqJIp1cIswCUgE2SHPOCm/Go8GvaZkQnCVt6u2pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2uJEOB/Vj6hWhFuZe0ljTEpowo9rQb2wREvG8pC09+6FprnOhqBklXOrbeSPMppqIBfnI4QA+S7GZ7/nNOT3CRYQmFVZChIlzVu+6zejENrHp19z77f2jSs4lUxJBBZpStjp072zuJrZ+PSQljwcqyu3nyJnzxeOhCRzDXm6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSCIzlH5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5acdbfa6e94so133122eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713312221; x=1713917021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nEb596pNHjGRxwi+zHrhblVQCdUyfcBe4WmHdhpM9s=;
        b=OSCIzlH5T+ape9XZzsDrsG5kxO9pF0qdJIncA2i5gKLUtvIZ7EnJ54BNtZOB8Ldrbu
         0dKbA58OO7efduI+EvO0kZWeH/+yLG2FgfmY9psc6VsvfNLHvUe9ycz00Ea5/BvZStUA
         iIOl4ZqPESHb8XiGB96NVahJkpjBSA5yEBf8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713312221; x=1713917021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nEb596pNHjGRxwi+zHrhblVQCdUyfcBe4WmHdhpM9s=;
        b=IZ4qIJhNFDuE9hs4MKL9BpBzkklhTZ4kGgSQ9W83cm0mbZVw0HTRugfAHYLXyDnPv3
         eqXemHur+FASUuOZYYRYPIG+OQ1xg2cPN3bZPx7/SYMyRXVsJ4PoLkA8kAG16Vqg1PFV
         pbcNpA7KBWM4vOA6PTKeTWxTLGrcII51CjPGRnsu2efTIpglnOH7EvZzzNuFRdzCNVZg
         cy6pJO5xCa08a3MQC1oDmItaRuniKpCGC0/J9oepAlhyC2Pktq7kAAf3V+PU3SDF2Dfz
         l4PSSaztikqANlGwC1BCcR1A0p/OsbCxcdjY0AoSTsYsbuPV0bWHcMj8f7/ETJsui2xI
         CIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKycDvq+hP8epEcVIwh91x5SJ0twJWHolJvJEHxTrMPWXQySapWpR+x8KyLHhrghlY2lGqbBRM+RjNzUgmn3a5MZ9mB6sHaH/rM0kr
X-Gm-Message-State: AOJu0Yw8nY+p7X2XUe6lyL6S4BSrJbEpQSxLufXqMzUdV6epd3rL3zk2
	cZe05/Z5+oKxkw6xkKpak0V17O8SXb6Cm64qbx1ZRdnZllHCDGP9XpZE7FXSGL8=
X-Google-Smtp-Source: AGHT+IEu81gTDsDdQDj17/Kg32wLhh2UcKNsPnm/8AVDNQyUumTOaGLjpZ6gDN+5E0kgCZng6wAY5g==
X-Received: by 2002:a05:6820:4187:b0:5ac:6fc1:c2cb with SMTP id fk7-20020a056820418700b005ac6fc1c2cbmr14358895oob.0.1713312221119;
        Tue, 16 Apr 2024 17:03:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2796107oot.11.2024.04.16.17.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 17:03:40 -0700 (PDT)
Message-ID: <3c4ab12f-caf5-456f-8a8c-d4211d843f33@linuxfoundation.org>
Date: Tue, 16 Apr 2024 18:03:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Mark ksft_exit_fail_perror() as __noreturn
To: Nathan Chancellor <nathan@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240414062653.666919-1-usama.anjum@collabora.com>
 <20240415154107.GA1538232@dev-arch.thelio-3990X>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240415154107.GA1538232@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 09:41, Nathan Chancellor wrote:
> On Sun, Apr 14, 2024 at 11:26:53AM +0500, Muhammad Usama Anjum wrote:
>> Let the compilers (clang) know that this function would just call
>> exit() and would never return. It is needed to avoid false positive
>> static analysis errors. All similar functions calling exit()
>> unconditionally have been marked as __noreturn.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 

Thank you both. Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


