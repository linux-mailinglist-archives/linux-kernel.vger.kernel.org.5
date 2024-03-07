Return-Path: <linux-kernel+bounces-95121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0328874969
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE081F21270
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B016340A;
	Thu,  7 Mar 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MXkkll7o"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1D63108
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799502; cv=none; b=iOJlZk86Op4TkqJ/2MFj8yezFcNOSFQwkOWplgcoCAlFbDoMYhg9D0fG8pWO6HfCsDXF0Lb4R9Cv/QJxSWKBOqBRyYRoh0FO72x7VvWMB43UU+yfZurD0fH6MVwtKxOH5kMXJn2UFtdqIj41JmztnfBLWhqpXqEaDxmNT67oSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799502; c=relaxed/simple;
	bh=TYqpgTDuSv3SX5G0RXnA4YBOuaNXUw37znpbGnBjBA4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g0BJ0o2dx8HE9D23JxzWlYcbS2yGMHqQE+rhxb/U+/H4Ff6WFwWjyebdrYkp2ufKDSC+1nEaY/WVSxJDzKWGFCoHk8kojc9UBVrmjabWmgejQMuxdCSV7Au9tBlng70vz/MlS4MNvY6eOVE6KrYYYQ3JWGh7O37nYTUjMkxwC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=MXkkll7o; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-567fbbd7658so554114a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709799499; x=1710404299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSltyiSz6QzizDadpF6t+PXwLaV699fb9KhpCjpuKpM=;
        b=MXkkll7o5VmeClXkpxfLx8CNFdKDphA9e3mrzRTO20T85DDE03HE5O6ak69lcKmT2K
         G5tlrrwqMq8iFkrYmzmr6vi1vnBCfbcv6df2WN0wkpZIcLIDFI+Aec+KkVHL7mbpZEo7
         D59JHo/8pMQ3iL8cXu346+nngF7vLFtl6i5ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799499; x=1710404299;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSltyiSz6QzizDadpF6t+PXwLaV699fb9KhpCjpuKpM=;
        b=LPlBHmnwhXysQKvoG18hutiWn4jVfRIS8jAn1oAy2QUd126P/7HanYShGJLc8Z6hyt
         79NhXj8hcSXGTq2uhtT/y8am/yU+4XLlRPjEvysxzn1hWrhMbG9TogCskD0MgLXz9Nfv
         V5fygXVz+//PKyBNMVQvrcvu29EYfozR9vCK6PsklC+UEPt58mWgy/FakFfPsxEHVdDf
         6Z8cAe3SDRsvzOFntVj0/MsheRBm7Hb7PufBQ/Dcl0MUOjOD4baWW0R81t94FNBq/jc/
         PN1UsOJ+XEZPyvuxme7qN7eYVthq0lPlV7fjjkIN3eYHXZijqdrj+0S0w9L8LrRjdC8g
         gb5w==
X-Forwarded-Encrypted: i=1; AJvYcCWGYnCALuSw+8j6vmYd/RW5CoZPNGRjmoALerD1DiP8RuLK6DQ536WGCdSJ9NUK/d5Ovy8EuD2C8DwJTpUeBT9gvujdo1lrc/U6Rl0z
X-Gm-Message-State: AOJu0YwE4O34JhDDwDE2i7Q8UsI6AKM4Op2MqGAVVvRjcYgKnKArtDUD
	hK5SBmbnQ+GMLBzRnp2kblpdM31CS3xgAIlzvtntVdv1AACjyDbFe7M6cJ+wwBnPJ8hJ2w+ECHz
	Mm9o=
X-Google-Smtp-Source: AGHT+IE5+saef5qFZIJd7/AEveuJaiL0S5ePCy1yPoEQhNLpJLEw3L6knMS2MoZ/K3muVYt5lsLMow==
X-Received: by 2002:a50:9fa7:0:b0:568:14e3:fe75 with SMTP id c36-20020a509fa7000000b0056814e3fe75mr843322edf.5.1709799499152;
        Thu, 07 Mar 2024 00:18:19 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b005657eefa8e9sm7832112edb.4.2024.03.07.00.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:18:18 -0800 (PST)
Message-ID: <40914a69-d4b7-4fdd-bc58-cf9b28271ac3@rasmusvillemoes.dk>
Date: Thu, 7 Mar 2024 09:18:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootconfig: do not put quotes on cmdline items unless
 necessary
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
References: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
 <20240306124211.b490ea3c2372d89cff8c287c@linux-foundation.org>
 <e1075345-ea35-4b39-a158-a0d165314a14@rasmusvillemoes.dk>
In-Reply-To: <e1075345-ea35-4b39-a158-a0d165314a14@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 09.10, Rasmus Villemoes wrote:

>>> +static int has_space(const char *v)
>>> +{
>>> +	for (; *v; v++)
>>> +		if (isspace(*v))
>>> +			return 1;
>>> +	return 0;
>>> +}
>>
>> Do we already have something which does this?
> 
> Well, 'value[strcspn(value, " \t\r\n")] ? "\"" : ""' would be a
> oneliner, but not particularly readable. Also that list of characters
> doesn't necessarily match isspace(), see below.

I didn't look close enough. We do have strpbrk(), so strpbrk(value, "
\t\r\n") ? .. : .. , but that still leaves the question of just what set
of characters to search for. But there's no harm in just making it "
\t\n\v\f\r\xa0" except it requires a comment saying "these are precisely
the isspace() characters in the kernel's ctype".

Rasmus


