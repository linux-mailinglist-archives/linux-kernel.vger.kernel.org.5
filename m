Return-Path: <linux-kernel+bounces-81052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BCB866F80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4961C25624
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBE55C04;
	Mon, 26 Feb 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMCwgGzo"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AF55C08
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939701; cv=none; b=a4VNP0gIQIM4ZHDgXbes65EjgwC1SntPT2FKPdXEjV80jn/ZfhnIeB5f3+mAK9JROKh/s26x1FtCxcTqjZ68bICMOm7qgzngRibGzzBHidloaQn82pYAisLyHmoljjP4UVv1lKMMhyzOaW3+j9jEHsb4de5myYzMBndXmJsjwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939701; c=relaxed/simple;
	bh=z3uOX17cwp7c4O0x6gt/bDUlr46mcvH9sFHr67mzjeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUZ+/3ENixnThO/z6JboaE+eDxWBJ0ExqNza6gmDpqmebpzCsZ9Opxj2o7Secuq3TUQx3+0WcFRvZD8UQvvJzqb/KmbKuJbR7ixTWtFFhIZJ7u4KXNa7fyQL+9rbOOEitILFBBhFDucnkNgYsXS5aAyWU4YrL05hrgA8d4jRRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMCwgGzo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512f892500cso810782e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708939698; x=1709544498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3uOX17cwp7c4O0x6gt/bDUlr46mcvH9sFHr67mzjeQ=;
        b=uMCwgGzow6jW6tEc7yF2m38R+Q01cpzOzCaBbUwL7Wm7FUc47R7HvtOvj3WgvPLGCQ
         +2u+LkZ0n+6r0GZbbOHPpImxGtsuWyU8gsuVpQhUY7JuTTzKH4fVwJzrT0Rhgd0+KhN6
         OUBghWTQ7bm0hBFbTPyIE2X7OjewQ1VQu/pVjPjMENlnMXLtr8XPSVUlBQg6Y9UIEQ61
         3liQ2q61nu/9iauKKq+/zvW34Ao7zYyznxChG3bd2MiZkqkb4E9ULAnyEVf2F49x0s61
         ZuIenGekmbTpSu4d5y6uhygf5KOlQPN02qyas/ls10dhgbtNbYvhqHSlKQTieF9YFW5V
         XYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939698; x=1709544498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3uOX17cwp7c4O0x6gt/bDUlr46mcvH9sFHr67mzjeQ=;
        b=nEz0bkeGj/6eSxNex6DqzPlsUqsw6exH4hsn2aayv9kt7hRQxnX7nW9Q9/E8brbgui
         hvfk0nU3UwHqfPQ3FDklPkFv2Rf+4yDlbckuCiBVZJRnHoa3Hkle58vKO5Y+Py4LfsTZ
         Kjl3WFeCrF4Js44enjseNPszIoWjrPEB7UdkHjdqiS15qpr2PbbxrsJBwP9yZu/SBQd5
         vsbf9s9lP/ZYKuH3hC5HzI74T47fTXNZXdA4m53DuNl7tzcZqeCCK9Hre/7clrxKs29J
         anG7JOQCxBmH/EQ2ozCCokrnwKgvUNJtkb1OUXosSTjM5qrGnSI9noLoqQn9hnqGKAOh
         D9fA==
X-Forwarded-Encrypted: i=1; AJvYcCVmuD2D1LsiOxC6vs8AtL9LAwlIvoGCTqVwn4vWa79XEUFRqsUELBkcizznzc2d6xwU1lDowgCc2r0nhddeOK7JfKRT9EA6TkCX38EO
X-Gm-Message-State: AOJu0Ywd14s1LNv12/f+sCZqAZtHNw7gIydZGaKPA8PXBlnCg3BzQnvQ
	IROOljITR8sBXcV7cusC499Dya0n0ySr8jfuqIiJPjyiELlI78fiYObxwxsSrAQ=
X-Google-Smtp-Source: AGHT+IGGAcrLEFkafFapXBxHMLia5T9CmpMFYOPF8JXFQ7kc94mcRRPQwftwXrZu5bPpRnfVO80QVQ==
X-Received: by 2002:a05:6512:31c6:b0:513:c3:1d95 with SMTP id j6-20020a05651231c600b0051300c31d95mr610450lfe.6.1708939698040;
        Mon, 26 Feb 2024 01:28:18 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id w8-20020a056402070800b00565d42006b8sm1246945edx.62.2024.02.26.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:28:17 -0800 (PST)
Message-ID: <9ebf9cdf-eeba-417a-8410-3f87a0973136@linaro.org>
Date: Mon, 26 Feb 2024 11:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add Puya Semiconductor chips driver
Content-Language: en-US
To: Dmitry Dunaev <dunaev@tecon.ru>
Cc: dunaich@mail.ru, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240226092312.1834584-1-dunaev@tecon.ru>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240226092312.1834584-1-dunaev@tecon.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please read the review feedback from
https://lore.kernel.org/linux-mtd/4d117770-6e0c-412f-ac1a-d9ba84b5b4ba@linaro.org/T/#mbcfaac90f123410a35db7dbeb0464dcb0816e7c7,
it applies to this patch as well.


