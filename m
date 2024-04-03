Return-Path: <linux-kernel+bounces-129484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FE896B79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A11F2AD77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6E13BC04;
	Wed,  3 Apr 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE2qrn7N"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F613956D;
	Wed,  3 Apr 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138590; cv=none; b=jYwq49DPtqVr4EXAWMmmb9YX75IzOwpLNH2SWBEoA0yK06sTmlVUM+726x6jVfmsAZfQMtRBEIZghdEedL9BkbazgVks+eZ3aeGwzKFrAkZFigfTkhiq60NTBy55pqjVGfIdr3kuH6ODUA/yEQVJ5XDwcRBb6PkmDKrQGatcsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138590; c=relaxed/simple;
	bh=QYCX1jPZRA9mBN9WbDTTkj2alyj87wbWpl7dlf9WHB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDdVNw9ZFdq+yuy5+Csofs/mrnu+7iOR9YsYl1ZGWuqb6Rb60swTLdXhPSowa0TrZd/pSA74C3p9bFhuDGLNdzgjxl0OCu+yUc4YwG+7xIdXNbfA/OXZChTiqtSSsTwtDm0w9UoVlJSHz7GO9Mrq+SLbNkZ9vEYhnRoeYPH6GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE2qrn7N; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78be3087929so206831085a.1;
        Wed, 03 Apr 2024 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712138588; x=1712743388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okwrWftmvNcXpB56Zqn89hTDrTD/k0euc+aRy8EAFxM=;
        b=HE2qrn7N5hZBC+4ixUV64pEJMnynrdYFFm7Yb8Q0MvekgBube1YuBVqz5NpEzo8u+E
         E32XvHaZy3tmIDRRdWtxxo8CPi6TngEynXwn1oXz9uUZxRSwowvVtSZbrC4DzNx9X3LQ
         gKMt/AV+wWc8yGelRAazIjHg+lgDq+nerSe7bQWSTAih2pK4sYJ/KOHZ8s9rnqSBH7wH
         k82ndYB31iQToUto062acrRmM1XLKb0sGYQ5LN026j+B0pXj+zbFKN/pG27easB0EMfK
         ux847ig/S96nroKJajt53o4njYcelAVR9BPG3/TsKphk/nRfgyfqJ67qhdDNajKdvE5+
         pPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138588; x=1712743388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okwrWftmvNcXpB56Zqn89hTDrTD/k0euc+aRy8EAFxM=;
        b=KvaU91PbKzqi2b1mCnR7AYwt0QNg6N265CMJWdfzfaVERULJ1HJ4nZanfABXFCfdll
         uYrHb7GjTkR3yaSeerrEHRILwPNFSYokGVmsnZESLvt5hTIj1yV50whvxsRPFg7yKzc/
         OUp2UIlfcETCU5qDJ4XmQhQlnqspB7xf6P0aDkRHhORiIZB84kAHLpey1xd5cH0REBqM
         4uqD1gSW3k5Z46a0VRDpOOT2+ZNvu0ej7idGS8gd6XdwF1ygXcPSi5HBjQhRmJP4GTEK
         Z02En9N5tdJimRZppS+kVLiplEONuWVTG1QSIAPMyNtTNp/AwZrX/Ui/h3+XoqJpkRfR
         53Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUJfbw7rFnYAzo7S8GrMkN7O9nCz//jy6fTBhnY2wBV3ym/Up4N5TO8L1g3hIDF3mkT61y0hOaSoIvErYpe9lYuvhmC5zjw7uz26igdtVwTR1fn25o3PRq6E11YBC9qbcsEzwFbHb6BtCrKaM3BmxFETc18rKzw8jpTdibgRSM6FlfIsQ==
X-Gm-Message-State: AOJu0YxL6RfD7IEkmQk+2iohfB4xT8J0Ri6N1umQ1s7jTVtMsZvOvao3
	CeGeAjAS1nWGSYpRWwb5WK+bajnnPxaUica0VHG8itFKgOCGrZKD
X-Google-Smtp-Source: AGHT+IGQiezN86tiXaNQBszC7yECury8fbWRF5vNBtsN4ObIWwioumK8+Lp6YowH6iiD2VdiCUZbPw==
X-Received: by 2002:a05:620a:bc7:b0:78d:36f6:4668 with SMTP id s7-20020a05620a0bc700b0078d36f64668mr1816252qki.76.1712138588172;
        Wed, 03 Apr 2024 03:03:08 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id vy9-20020a05620a490900b0078bcc4b72adsm3913782qkn.124.2024.04.03.03.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 03:03:07 -0700 (PDT)
Message-ID: <78cab1a4-e085-4df5-bb8c-277fd5ec3d70@gmail.com>
Date: Wed, 3 Apr 2024 13:03:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-4-34618a9cc502@analog.com>
 <CAMknhBH8UEPSyYiyMPo4en4vcjnJ7_W5q+iJtMOhdp5eNmP=8w@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBH8UEPSyYiyMPo4en4vcjnJ7_W5q+iJtMOhdp5eNmP=8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 22:40, David Lechner wrote:
> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Move validation of analog inputs and reference voltage selection to
>> separate functions.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
> 
> Same as my comment on PATCH 3/6. We would like to know why this change
> is being made.

Move validation of analog inputs and reference voltage selection to
separate functions to reduce the size of the channel config parsing function.

Good?

