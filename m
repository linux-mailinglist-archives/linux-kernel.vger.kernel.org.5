Return-Path: <linux-kernel+bounces-74306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC085D296
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95B21F250B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970D3C680;
	Wed, 21 Feb 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ9zVwE6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D963C06A;
	Wed, 21 Feb 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504176; cv=none; b=E7H/aolvyu/ICSQq+nzo6TQbjO6/DLrp0riGZATgfjlXkov1EfK6DA5sVKiQZFIYiJdmeYskCs5fJmUf5EUGIau9+xDMD1984lvqu7u3pkQK8B1e7h41sO9pKQyXP2zaJwzt0SLPw/F4c2F1vzwp8OO0hjoyXVtdU2q2bbUJ1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504176; c=relaxed/simple;
	bh=l+USiKsOoo5GxfeqF2OVgrwbmx7XziXEEcxHQXx9izU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLEpRM6L8m2EIs+mi7AzlmcGIsIPDRDB8u51OGXI96H8ljvGYZtTOorIu78eypLHXGGl3mMxaNdUqeUeKCPXgySsFZOp7NoOTml3BZGfLQoeeIxkJ0gCjVxsBGLVjYoWl8HObGFdnQ6QSrWiJug+gFjJe2nJd9rdCAZ0LZBmJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ9zVwE6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f48422fb6so35170966b.3;
        Wed, 21 Feb 2024 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708504173; x=1709108973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ijo+X2EXC9W1Fu/WCqYIZ+xP706TUOFUSratEaFrdE=;
        b=BQ9zVwE6ihXl6BHGh9G5g7Dd0DGRlIOJw4YRjJQbiktGjbwI6muX7SA7nSDgJamLdR
         hFlLLRGyIFmTOS/wp8B2FgVRrs6ZVLsJr/HbdpqL/qcY6SoZLYEfUpvuEeFjWdVe7x/j
         sjWD32rEAjMPA2rvllUt8y0ykfmij1hqyAos4cLt0vYr8VRAKer1srFAWXYnvH1tvXAw
         xjFaGSabsENWyKU0wJej2LKbnKdXe/m5NYmP/OH77uHKYpUdzXPN5lArVdW53139FK1q
         nAYd3K0dfrmg/RQy5Fa42eNl9gItUONhiLs2kcdXTpjz8/o6959k/7ZesFkf2Bb0ss4S
         k+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504173; x=1709108973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ijo+X2EXC9W1Fu/WCqYIZ+xP706TUOFUSratEaFrdE=;
        b=hLjw1Pv53MaZWbA4ZuI5GCvBBi9qJLkjKaP+ATPBOmwdX55Uo+0iUWQGAqtwHNZptw
         gPCBwn1jk6EyTVOA9VkjY1pljh/LAr5lElH7KHgwoHNUKaICA7jsJyMuwnHm4AGWceEJ
         g6TM1Y0vFW7ZH+dTVmkk5gCcBbqC2Dj/gHKpd2npVo74oTsGyqxXWPHHXQSt/e+Ip/87
         q6yBiLOj9l3jgmR6r3JrISTHboIw92ZcOFqyd5hIGrsJefjVQ6Rf6p4TvnIB2YLXQuU5
         PsHD06ZRYv35BSMV5zE8erFYhnASH++Qz+N4KrBWBKECO0N4EmGDYgcczoVW08ACV2r/
         6rGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2W5M02O+HB97/0jj76IvBzTMJjrFvConMQdA6PwjiwhQ/Voo+VynZQmxEUOaeyZ73Gn7pitkw8+mUvdGxbemjtsdLZ/niHcAk9IoeaIZ2IZJx/SOsqVSl5i10g7OWOFukL5MjPVqRzJM2ZnLPSecdhQb2XyU0esxZ8xU0t56QhYE9pGFp/JdF1+SM4bYxZqv8BQU+8SwMbiouh72idJM=
X-Gm-Message-State: AOJu0YwzbIK+p76oal+XXsbRhGSOAuyFu+nBhLQNARWXGTRGMjzfCo4x
	9rcWTmgI5qBsgwS/uLVLFcyHeSbQV4gAqx/bNNWJQyfI3KKo9qcg
X-Google-Smtp-Source: AGHT+IEByevySHGOYsiHoumsPUFFKnbfOL/epOfhCWUPHg6vKAN8y5PnWG9rjYr66ZXMDSQ2WnecRQ==
X-Received: by 2002:a17:906:1358:b0:a3f:4b10:134 with SMTP id x24-20020a170906135800b00a3f4b100134mr377542ejb.72.1708504172834;
        Wed, 21 Feb 2024 00:29:32 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a3df7003552sm4711384ejc.32.2024.02.21.00.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 00:29:32 -0800 (PST)
Message-ID: <0fa819d1-2a0f-4243-8e5f-a098528278c3@gmail.com>
Date: Wed, 21 Feb 2024 10:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
To: David Lechner <dlechner@baylibre.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <CAMknhBEZ7Y1Yx=wJGnfvYWGKPLas3pbCyY+sN8vrBzdkYO-A4w@mail.gmail.com>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBEZ7Y1Yx=wJGnfvYWGKPLas3pbCyY+sN8vrBzdkYO-A4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/24 22:54, David Lechner wrote:
> On Tue, Feb 20, 2024 at 3:43 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

..

>> +  clocks:
>> +    maxItems: 1
>> +    description: |
> 
> Don't need `|` here.
> 
The description contains ": ". Without '|' yaml syntax considers the
whole string before ':' as another attribute

>> +      Optional external clock source. Can include one clock source: external
>> +      clock or external crystal.
>> +

..

>> +
>> +      diff-channels:
>> +        items:
>> +          minimum: 0
>> +          maximum: 31
>> +
> 
> Are we missing `bipolar: true` here? (since we have
> unevaluatedProperties: false)
> 

No, since we are referencing the adc schema "$ref: adc.yaml"
Which contains:
"""
  bipolar:

    $ref: /schemas/types.yaml#/definitions/flag

    description: If provided, the channel is to be used in bipolar mode.
"""


..

>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Aren't the various power supplies supposed to be required?
> 
> - avdd-supply
> - avdd2-supply
> - iovdd-supply

From my point of view, if someone uses a single supply (avdd == avdd2 ==
iovdd), and uses only the internal reference then the supplies should
not necessarily be required.

