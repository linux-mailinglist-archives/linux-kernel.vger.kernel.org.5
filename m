Return-Path: <linux-kernel+bounces-81419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0248675BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33B3289718
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34D80BE4;
	Mon, 26 Feb 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lE8evt7L"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE880020
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952180; cv=none; b=dTdWmW4Ey0lZgH352qECtVWN/EZorElpcUBtFl89BjWs4yw9QQ3Rgp3/8VdBJCliJrzMRn3KldHWn80hXZKn8V1KbjzZvI041FIp9J6dubDhefIZMOomNmTNECtA9YrvQaPld4ok6nPyA89LBmpVpWHugBuVaPihAmXljtT6NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952180; c=relaxed/simple;
	bh=ut35o+2oN2Qn7bwysQIKI2sLMViTmOjyvxHNEvySY7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4UaDDF6jouzM0wKZlEP+Lca8pu54KnnZCQW11sOGXH10k0vIlh8lzyQxCpJhijIT0kyeC5CwHQ8VbBMxzOn1b7ed0utyBEuT5ApWYctzcpXvLlJ3rh9W5q8xen8dc/7UTNs51DQOCItqMqF3EGYwcQizSmRf/gIZlTjgVZbcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lE8evt7L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a9a3dba2so348835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708952176; x=1709556976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFrxQiHYrsfnghwiEcly4TZu16vAe3cS7xn00Nu2N2Q=;
        b=lE8evt7LLhyMPL62h4NGBKC4vv6pX9/fPeiU+Sh1t2NpN4jSDha5bhnzKAE6EsiXxp
         ul440nSrSQuSuYaHtkPnG6fGRJBNOq+mHXH69jCNQbNgMXAGEGh7bvboUhpaL6I4hrBW
         xZtGcpMgyxDD8m/gMlrPUdRi4gW2UDwwVjyQxR7BXYOb0pj/YdDwuemRZpzhpSI/1JVB
         mIG50iuB5YgYw961yz2J3xi/CzPhRkBsa/y/y02tdY+jkRy9VWDa5i6nwna0sj3/UUAb
         VwJfI3WNfpizPPMOG7rwkLC4U6MLPbv6vrKGkHYQkOYAPjocB4zvNnIXwD5aUJwvAiQr
         nCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952176; x=1709556976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFrxQiHYrsfnghwiEcly4TZu16vAe3cS7xn00Nu2N2Q=;
        b=Rgr30xND+8dfabRXPqccVjLoBzzvTno7t4eBHCk+SGX8tt/NejpZMjcoMJMR44J/Sg
         6ayoj+SiUTDRD4O3WsoWNrwrsKl2Tb7PLJ7S/8q251zL5oTA4a5WGkb50jSDfPy3a9No
         5Z1tQyOCMfXXOeMzcFJMREGd0wAThtN5EVAoDWVIQ3r/bVJx4lXCYMqJBcDsKbiM9M0H
         IV91fXniJNqkLmcUI3/+7MPaWBtC8Y0ReO/9qC9IYuUSekRVP8hABjC2qO2Iogj87gSS
         wE9KJh4zrcZxO5DPR1g8zFsZbWU8sJVxFJ2xh+ngkDW0oiyoIz8jQ3HpnFjsCuLtfHWy
         ygqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDMt8soqHdEPcj90m17q48j4f5u054/A2uSR+Yy5XSvKO3MlBZBlT+okv3Gvv+N2DXYk5XZf0h+ICdmzODYsIh10nm5R6vjIsQtGxE
X-Gm-Message-State: AOJu0YwwtjfLdMryN2zFFNSB7u55YSYly2Y27OodeM20hyOjU8WQk315
	Qu7bSikaewR27DEZAclTCkYmlD50QX45+NzwFBP5Yv2yZrB3nt4apsG+xTK6j0c=
X-Google-Smtp-Source: AGHT+IHHeQtzlf12UyB07V/94hJb/CYNRe0xn/CubKev2viMPRPmMtQuMJ19vTXAxZluxRqI7qeKdQ==
X-Received: by 2002:a05:600c:4751:b0:412:985b:a1c2 with SMTP id w17-20020a05600c475100b00412985ba1c2mr3887098wmo.14.1708952176153;
        Mon, 26 Feb 2024 04:56:16 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b004126ca2a1cbsm12348515wms.48.2024.02.26.04.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:56:15 -0800 (PST)
Message-ID: <53abcb16-20f4-469f-b2d9-63544cbe1e9e@baylibre.com>
Date: Mon, 26 Feb 2024 13:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] misc: tps6594-esm: reversion check limited to
 TPS6594 family
Content-Language: en-US
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-10-bhargav.r@ltts.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240223093701.66034-10-bhargav.r@ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/23/24 10:36, Bhargav Raviprakash wrote:
> The reversion check is only applicable on TPS6594 family of PMICs.
> Conditionally add that check if the chip_id is one of the PMIC in
> the TPS6594 family.
>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>   drivers/misc/tps6594-esm.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)

Following my comment related to ESM_MCU interrupts for 'tps6594.h':
Does it really make sense to add tps65224 ESM_MCU support in linux ?

For tps6594. TI requested a linux driver for ESM_SOC only (the "main" ESM).
No linux driver was requested for ESM_MCU.

Since tps65224 does not have ESM_SOC, I'm not sure that anything should
be done in linux for tps65224 ESM. Maybe you should discuss this point with
TI analog team (our TI contact for tps6594 was Chris Sterzik).

Julien

