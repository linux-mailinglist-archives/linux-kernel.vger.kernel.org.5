Return-Path: <linux-kernel+bounces-38471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23683C060
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF429D6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED25B206;
	Thu, 25 Jan 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRfou/QQ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F575B200
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180574; cv=none; b=j2DG683CvxkfIAUaW8rtwGz6n7KpkyraFMCSIl7B0OXX0o0DbdsSZciBiwp96P+WbRWubcnjPg4p57v5809Oqdjem8vcfRLGjFJkN1TtzYXlxo3wQa2ll7EpGM/6Jm+iYD7o8QfCNUUZWT64CBSIxov0uB2ZShLVBN7BaJmrHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180574; c=relaxed/simple;
	bh=NzpBSwHj3ANTe90qfNqofyt4I++n2BseQJCz4L4PJ+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bu5nbzMJsP4oDG7bl+QAQZswabWjUzl+4wQuAmk63zEz8AIH9m26b9ZdU8z0aTcL+76l+NaLnN8zLRJgabPhQ9iGBitQwPpo6rG0eG0HSrSvxHiDkM07ePjQBIJTe6E10xwb2iGu2tE1yzMQ/+DzqhggixQDXp3IGdD4YuSJ9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRfou/QQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so1281908a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180571; x=1706785371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cr6sgDCVNvl2+zTSYayZUMasMb5p1dzPzxTtqTYGBH8=;
        b=jRfou/QQJ3qUfR5OpK1W4LxWFRrK9rRfGxs7MafKcIZ5q0r8cPNTPn4/Kg6xc5OS5x
         cpCAuY1F/YroaH9wkPf7A77zHKRiLF21mP2DGFkrh2ZuTZz1fgP+bGc0focDgtAMzyds
         wA5N0BuLndt4WvvARKeUYRrE1hScg5Yq1eLOrjrCKHLbpyLzzwKRiqWAtjlag8JmtqwL
         v+tJN2cxdd5zK07fbSqZtgGD8EpnIfvFmr/PwuSeLq/99gdwDE9lJZR2+MULQIswaJsl
         rZ1QAJTLMcrtL7EWRD+zfztULH3nKP4rxlnDbT/vsiJWA4aXHh5dGljocshRZT4dEguc
         NpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180571; x=1706785371;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr6sgDCVNvl2+zTSYayZUMasMb5p1dzPzxTtqTYGBH8=;
        b=YYJzJbeuuniP8HG2fje0Ha/bD/VveECFnrBkejWvuigZSKfY9r8uKr8zvQ9vKVRZex
         zXifnUjU9HYybTTIjmSo6ejjB+pejn/JTkObU6X+6UhiDrPOaBhHDkWyxKMAOVEHFuNq
         7Tgc1yhQTx2iX8zKKY+yqFgHeBJlmqbDgoealmR3W27X2n4IA/GQjhg1utZhg2nZfUTj
         NYAIof8zBXLZCT5BzJIg/sTTmtl/98f810TkSQ6mbFggiTQq1HXz6Lv+t9/EXm4xl1tn
         V9xYeJvWUFVfz6Gbk4Slg90ysfXjqqL0EWAagMf8DQUm8j8kzqQq59pH90lJhhtDsg6k
         dDVw==
X-Gm-Message-State: AOJu0YwvKX1PpdOqLqwRjTZyq5SnpStguKO14UD0uWmW5y4L41oOQzUj
	AzIh0d34+6gFjaTGlkxTfsFeBx5RtQNHZgLUhLrPoRMl8errZry3oL8BLhdbxhOniVxkc/+CW6a
	2
X-Google-Smtp-Source: AGHT+IEE942Lq4JN3nGhqRL1L6Adh+ON9zzLB/mIoRBqKydoLVjTZKjcSeCU2SiAjUBpYFbjqConyQ==
X-Received: by 2002:aa7:c158:0:b0:55d:1615:4bd7 with SMTP id r24-20020aa7c158000000b0055d16154bd7mr31820edp.6.1706180570772;
        Thu, 25 Jan 2024 03:02:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fi15-20020a056402550f00b0055c73b56bb2sm2935445edb.29.2024.01.25.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 03:02:50 -0800 (PST)
Message-ID: <ec96c9cd-4734-4265-9693-d997eddccf93@linaro.org>
Date: Thu, 25 Jan 2024 12:02:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
 <20240117214722.GA3176505-robh@kernel.org>
 <1aa2c865-3a9b-441a-ba61-b551f3f7a832@amd.com>
 <20240119233231.GA1290941-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240119233231.GA1290941-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/2024 00:32, Rob Herring wrote:
> On Thu, Jan 18, 2024 at 01:34:16PM +0100, Michal Simek wrote:
>>
>>
>> On 1/17/24 22:47, Rob Herring wrote:
>>> On Wed, Jan 17, 2024 at 12:30:58PM +0100, Michal Simek wrote:

> 
>>>> +additionalProperties: true
>>>
>>> Why? This should only be used if another schema is going to include this
>>> one. That's not the case here.
>>
>> In v2 we discussed this with Krzysztof. I used pattern properties from
>> simple-bus.yaml in v2.
>>
>> https://lore.kernel.org/all/b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org/
> 
> You didn't answer his question. You just picked up 
> 'additionalProperties: true' which is easy because it avoids 'problems'.
> 
> His question was is this a common schema referenced by other schemas? If 
> so, then use 'additionalProperties: true'. But it is not. You've 
> defined exactly what 'compatible' must be and that means it can't be a 
> common schema.

Yes, I missed that it has a compatible, so it is not expected to be
referenced from other schema, thus it should end with
'additionalProperties: false'.

Best regards,
Krzysztof


