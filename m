Return-Path: <linux-kernel+bounces-168148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77D8BB44B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345281F228EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A903C158A39;
	Fri,  3 May 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+2VW4/8"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E6158A04
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765410; cv=none; b=e4YvWmSGX91IcvZ/Y9yZK5MTSKCM4el86lxjh8YzS6jAMymGFlPtYAkvLd9U3rgxkDbkGYxEyDmLrrevaToRWAosOcEKHo8olsyl5WL+82QxsXBxCgByI7NIRYPWKxWc03U7gHoSFxm7e4tvNtmArETJWWicOYRDPq6qQkSHKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765410; c=relaxed/simple;
	bh=tRo3l+NY6pKlyguTf4ZErUgbx5G9G0vJfh3NkwVHbv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAFvtuvb9gsEnmoqn/zD9QrWbEDbWhDsjZJwSNOKRRzS+r94wsCbVoZaWoeL7xfcPwVLP3eW5FL2UIcFpKD4OIK+A7SKZr4mpxB8bYXcuStcxgUeuiujF3aAj9KrIqwYG41CPmcZkwwGDh4dFmGstmLhNjAoNkrs4xHzzQTrKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+2VW4/8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d9c78d7f97so193739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714765407; x=1715370207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoehBqnXPQ17o2dkVZhBr+IIq52xBLa/0bscC+2UHww=;
        b=L+2VW4/8OZAOrSx0eMkiW0V69snecqC2GOVIpcwZnFkBgdOsXDuQz1diIyA74mhATG
         tPEvYtUpD7c+blT7ZftG9fIE5/lolPotHzijLuVq5VVXtcam0ozxoPItCI1EmRN5BQU3
         VvK/PXTx+vFb5iQme2Wks4CQAVYYBRmw6piKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765407; x=1715370207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CoehBqnXPQ17o2dkVZhBr+IIq52xBLa/0bscC+2UHww=;
        b=e5lxcPLyKXKJQ2gvn+Agz1imadHKsQvGjnaMOFjM9REMMX7GYueqpkzYP3F5Bb6CUK
         PzurDJ3Z7KOsvS+6eJSdOvcLywqVzi4J4DIUZcTHd2bYxtXjb17E6/v6oEKiamhbQs37
         0BmYemjFpT02qD/vHL46Ero6SdE2I8Bje6ZuE9xO6HC5+rNyvod4FbnOZLiVxH4WIhmd
         mQuGWIAydc3YNYa2oYl/oJiCop43nPYCCXcoAKIF0LPEN0nE1MkCiojUH1ALliFTDtZS
         4WMlO1cC6K9QryuwKbTb4WOPjvXrSy366HylJWF2VQ2DbnBFdgTR22NDEJQU0OkRVpy9
         brSw==
X-Gm-Message-State: AOJu0Yxfni8D5UQMMCp+N6obZuj1GIaAcMKK1FOkK6NlUj2PxKIaqy+n
	dU2LN/C49eG8Ns9EiPS5/pD7+MPbg79kGy/1YsU+Qn5VtXD3/jVRzoAYZ0IGev8=
X-Google-Smtp-Source: AGHT+IG9sDNLiicfk/AlMxI0Uk0RAKTyF0DWx5qbaxCi1rjdOmrTdOLWZifYuj1bIkRUBQrj+qo5HQ==
X-Received: by 2002:a5d:8909:0:b0:7de:b279:fb3e with SMTP id b9-20020a5d8909000000b007deb279fb3emr3636654ion.1.1714765407144;
        Fri, 03 May 2024 12:43:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u9-20020a05663825c900b00487bcf58da9sm943699jat.90.2024.05.03.12.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:43:26 -0700 (PDT)
Message-ID: <a4e28fb2-6dc2-49f5-831f-95c9fc60570b@linuxfoundation.org>
Date: Fri, 3 May 2024 13:43:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftest/tty: Use harness framework in tty
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org,
 msekleta@redhat.com, gregkh@linuxfoundation.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430161807.96050-1-shengyu.li.evgeny@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430161807.96050-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 10:18, Shengyu Li wrote:
> Similarly, this one is based on automated tools and a very
> small percentage of manual modifications to automatically refactor
> the version that uses kselftest_harness.h, which is logically clearer.
> 
> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
> ---
> 
> v2: Fixed the last Assert

See feedback on your v1. Same comments apply here.
Explain why this refactor is necessary.

thanks,
-- Shuah

