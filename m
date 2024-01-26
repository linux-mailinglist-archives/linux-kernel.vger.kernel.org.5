Return-Path: <linux-kernel+bounces-39792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7783D627
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BF71C26C56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47E1CFBB;
	Fri, 26 Jan 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixWm7OZq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEA1CD26
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259068; cv=none; b=hwW84MCydNnZJ2LaxtstmWVVVlL1Jsrapy0oLZy7IHfScP9mjk3ZD/9ic2TyEG1YfHwcJDxNwYO97XlPQhfPy21AJDvX0klpML03UMr0G/Ptu1NEUq9d3q4mHUQiRNhm7RXEBR/ozCjea11ah0Uj5n9MS05OXG2ga4JoDbEH0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259068; c=relaxed/simple;
	bh=ZKTizQaJHHJH3PjyH6OKhCGsbR4OCSUkyPwcnIZcDOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nho8izGzQE1mP95QK85H3F35Pw6l9cnsY9ZGaInPBLPe42hCFKcEV3HmccaDOKRe7FBKeEvP9FxAP5hpd5JSCDODsiuVzNWo4zVH+MxA8aXucfpweudaOIRi9pyQ+6QUHVZOhuxpE6KxTZ+tlgBHsZ5nHWzfZoyO46K+jYzPbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixWm7OZq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ed2333c8fso2119995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259065; x=1706863865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwsJvLj+Sz5U7dCsT4fU1oJQCp0xyoSV1peR2bUZwRM=;
        b=ixWm7OZqx4jkmgEbe1n8NYDV4FVNcqx9TI189HWyltbKtlsDz+5yOXoc+C1dLJnmGI
         +PX3SPpJ4GnfcWCuC36D3OdYaSpmIUdX83kJ0SSsNmba3IGeEtXQvNOUuTDcch+IQUMj
         urt9Mj7gI/0ThLiygloEoNrAyt5tNmnrprjV/ncXaLPwUX3cgVjssLODXKj4yk8SnjHX
         DCAehXANstrFyyo4+bIBAjiBcdhYkynOqnlRxx/ReC/QPcaqFrJiIGwZlaIx+ZgMwxr5
         16iEuz1dGRtzyii++of9NQ6joFf9cn5Ls9hr7Fx5QzCD7P/cROvmyCG8VWWloLuZyNPh
         dM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259065; x=1706863865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwsJvLj+Sz5U7dCsT4fU1oJQCp0xyoSV1peR2bUZwRM=;
        b=BJy4lSaMt56BFiAM6KxEVfvA2oDIU3joaYEVRfGpy62aoRKphfX9AoxyLjXUgOKf5a
         exyYceKc0eLlrvxB+cNr1pjlYBkFduCPpUoacDQ+1ucWuLNEWYKdI9H989pabo1f/4z1
         NDXMa6K5TvooyKt1pWfyk7zY/n6Otq+Lw0SI8vwILqatH30zZXSrRbdMvu7UiY4oNqGB
         lUQ/rCsDyyBYK5+6U6STwozYCycZK9SdyvrIPv3Jj1kvmR6Te5+wowwf1NAUw6G6NtAB
         JArkkBzB19BO5vTonTkIOm7zTzBuLCzdPzo8CCOYgYSEMC7DF/CEbB95A2UsuMN3OqB6
         qONw==
X-Gm-Message-State: AOJu0YwO2C/6PjP4SnLJw0sCFOpucuM2Un7DGK0iae/SR93pLqMXJa68
	mjD+SO2+mM7kWQ8I0l/Y9QjOvYoCcoJlu8YjLvWTf64Ee1X10YPU7ztyKQU8YlU=
X-Google-Smtp-Source: AGHT+IGGd42xttnP9o8bD/Oezf05OjZFf/aoCxPYtbaqkInj6JCeHaKvIUDeoXvTlklfgYVzfu7LJw==
X-Received: by 2002:a05:600c:510e:b0:40e:6238:e9ef with SMTP id o14-20020a05600c510e00b0040e6238e9efmr552193wms.120.1706259065087;
        Fri, 26 Jan 2024 00:51:05 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040ecd258f29sm5158250wmq.0.2024.01.26.00.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:51:04 -0800 (PST)
Message-ID: <8cdbf784-e094-45f2-89dd-a2c58cf408ef@linaro.org>
Date: Fri, 26 Jan 2024 08:51:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/28] spi: s3c64xx: use full mask for {RX,
 TX}_FIFO_LVL
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: andi.shyti@kernel.org, arnd@arndb.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-11-tudor.ambarus@linaro.org>
 <CAPLW+4nOGjfniu+shzO5irmH5bC1E_yD0EZcuDwQJKdfMiDswA@mail.gmail.com>
 <e2c25c1b-7fe9-4174-95ed-e867eff14e37@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e2c25c1b-7fe9-4174-95ed-e867eff14e37@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 21:48, Mark Brown wrote:
> On Thu, Jan 25, 2024 at 02:03:15PM -0600, Sam Protsenko wrote:
>> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>>> +#define S3C64XX_SPI_ST_RX_FIFO_LVL             GENMASK(23, 15)
> 
>> What about s3c* architectures, where RX_LVL starts with bit #13, as
>> can be seen from .rx_lvl_offset values in corresponding port_configs?
>> Wouldn't this change break those?
> 
> I should point out that I have a s3c6410 board I care about.

Obviously, I don't want to break things, but it may happen as Sam
pointed out. I'll be around to fix whatever I break. It's good that you
have a s3c6410 board, maybe you can run a test on it after I send v3?

Thanks!

