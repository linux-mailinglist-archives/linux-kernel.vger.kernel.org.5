Return-Path: <linux-kernel+bounces-132057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A15898F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11691C277ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AC134721;
	Thu,  4 Apr 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQXg7Ed/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9012B82;
	Thu,  4 Apr 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260007; cv=none; b=am2Z2tM7WQYa0GD8oFrkWfIRFeQCo2YHdJpENxHBzWwDGjLYLrLwKJiDDTpJ5xIMpN/30uqOP9j4Dt4TzTRDPpnH9ptmcWfEeU6EGjRKnfInxHbqD8dh7T+5bhT1wURZr8F6jnLq5KI4qQzicwD3Zty2VCiVgTP+TRVi+htWoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260007; c=relaxed/simple;
	bh=WK3fqVgXyhO4SaUPgOZtatPngfwA0rXyE9bTEsovzVE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IQIwNJyY6QX4mfYLkvAXX+14KNazNDML5RzemA3wIJF/edVU+gzGCToZnW/VOecNb7B+G8u/uudUu6idwiq4vdS+K0EfLSG8ncLfwBNFmgerz5ZmeZ0TquePxE70Ti7wuIB9c8/9BctJIsi7PYdlOLhIrq27KpBwpWJTl3azhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQXg7Ed/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4162b016230so7105125e9.3;
        Thu, 04 Apr 2024 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712260004; x=1712864804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyZX00utsqFHyIyMrK0p94XEseScZhVbdBOCzUKgoBI=;
        b=NQXg7Ed/n35bhMoMh4PUqViJtU0pn474gi6KlGQ21yMTeiKBm5i6KMIE2kvIj1XvG0
         pf+XCmw+6Jk60CggmyBs20LdbZss7c00japtRdJ0+hc673WhqeCVSnX7p0gO0JSewQmG
         P5gfJWIXf6EDwzajys4b7NteLOEfxpdvi4/Xvnf/9SnDUymdint8sXpUfSZVkHTFRnIT
         V3gRckMTkZ/+JMG3Kqdn+3F9QQhvWygZt2FiE06Fc8SXvorMJl+EnXVfmjnrAVEKfYlR
         j0+0kfHDrGBCtnxWZfmADr02lZtpodR2FCqrrxmz188Fw0RMMxBpJhN/6096nflwK4UY
         C1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712260004; x=1712864804;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyZX00utsqFHyIyMrK0p94XEseScZhVbdBOCzUKgoBI=;
        b=uRSOqOKfOQf/HwyQaBMGduT9gVhlzX2xfDV1OrJ/y3r1eXAmJvm+BUAdzBluelkqGr
         0UB0l70jO90nc9t/Q62NhrZpFKRaySDzMI1GO6L/C/C745uARCavPGvnPOyE5zj5vLnW
         YNL/Hyj9kpaQAVEo3kOmclGgm/k2lx52yt+5XHHtXI1RlS2j4wZdo8LpY+7s4OB2wO8H
         kbKL0FogYKO/+OzSbsJ10VWjBmNzwbdelGaE9i7GjXKda8XbW3icRsKwLVZGiVZ82jWH
         BcCHZP8vUseVEYJ35pT6zh9BCzy3cYHbHv7aw/cPCqpgDyzlIgtJ+TT4K53i9+L0TZrr
         WfVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlPfNz2G+Ddsk8qbKYdKBPrzhaa2Ys3McUNFOH9gKVKpZmdgxkcr35mwwgIzzMKbyQ0czQ/U99GxPwIylEfzQx6aGPY7sUoihF/u48ibAb/kxR9X7R1h+qDDmEwrSI1iNB7D8
X-Gm-Message-State: AOJu0YxBq9q5vm/IEZMwfxoCps3gVx++ie5r5KEWBXqYddaz/DsLyb7B
	WTImD9HBfJK/xayipRzz9uJ5+eixFWdMQ4PS6Avr+1Or3c8L55nR
X-Google-Smtp-Source: AGHT+IHekUzO777iLHR4liMlPFnVwBNBoqtPNNPXdvvu+XWFviFnIRx8MjBP7y94ROtz/nqECd2FNg==
X-Received: by 2002:a05:600c:4a9f:b0:415:b921:6121 with SMTP id b31-20020a05600c4a9f00b00415b9216121mr2570868wmp.10.1712260003625;
        Thu, 04 Apr 2024 12:46:43 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d5887000000b00343d38ee4a2sm164430wrf.11.2024.04.04.12.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:46:42 -0700 (PDT)
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org> <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org> <20240404174728.GL1723999@nvidia.com>
 <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>
 <20240404183540.GX11187@unreal>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d09cc7f0-3e2c-f22d-51ce-43a36412425b@gmail.com>
Date: Thu, 4 Apr 2024 20:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404183540.GX11187@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 04/04/2024 19:35, Leon Romanovsky wrote:
> On Thu, Apr 04, 2024 at 07:06:53PM +0100, Edward Cree wrote:
>> Why?  What does the kernel get out of it?
>>
>> Maybe *you* need them to be supported, but maybe you should have
>>  thought of that earlier in the design process.  ("A failure on
>>  your part to foresee the eminently foreseeable does not
>>  constitute an emergency on mine.")
>> If we let folks bypass our standards with a _fait accompli_, we
>>  don't really have standards in the first place.
> 
> Sorry, who are "we" and what are "our standards"?

As should be obvious from context, "we" in that sentence referred to
 the mainline kernel.  And while participants in this thread currently
 disagree on what "our standards" are, I hope it is not contentious
 that the kernel community *does* have standards as to what code and
 design is acceptable for inclusion.
Necessarily, for those standards to be meaningful, there cannot be an
 exception for "oh, but we already built our product, it's too late
 now", otherwise everyone would just ignore the standards and then
 demand to be merged anyway.
That is true regardless of the specific standards in question.

> And, please, please reread the thread, it is not about devlink at all.

Please, please, reread the email to which you are replying; it is
 not about devlink at all.

-ed

