Return-Path: <linux-kernel+bounces-152799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA118AC46E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C93B211BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB6481C0;
	Mon, 22 Apr 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpxYVdQM"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D551802B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768181; cv=none; b=VT0Cs5iNHOlOmV2ENcglnJx2MP0FL/R8xgP0v2t7ftT3k8bmx6G2RvwqbQNGQtBlAa/0mhrqksiC96aJY2jizstLDWX8WVFQuhhVrCcHjJpB0Bvjm8H8cxdIYLUQn79Oyoo/rhXV3MENSGm0du1J4QJPy+AdtIHNa4duChm7eio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768181; c=relaxed/simple;
	bh=dzT2yIOltpCHuS9Qh2mNMPG/SJhkp/5Q1dBbriodTpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mht0GOg6V1Q48OpnOmm5pmoiIbUP8rNYuMAaNY0/XM0lk3wy4UfI19EBUBbNgZv1sH2O/OTURMAVeXqwAZyaHkfghNOG3vQDvIqiLzs+LiKxah2Qk7ngu+/bo7UvSa0jyfbRHhhS87uBkk1l/84GmnPrR2muwWOQEK7lz5SnoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qpxYVdQM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a523e2888so3655995e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713768178; x=1714372978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPvL4iKAh8EMRrWGhZ4Kx+fWBqS9MQHGS0oDFyItitE=;
        b=qpxYVdQMcNTokYrwawmom4MaMM+nnWAD9WaDs1dlzKQQ7s79Tb+vufdOylDrnr/pEn
         jXFz48YMi+uyTnB3noKGzZqfntSC+t8O5iNggtAXNV1Rfdv6NfeuXeyNqfp+lvL8amTd
         AUrB6DN6eXoOMdQWRVQxOtlvZvbEKfbwuaj3l26v2jyBD/q/6YmTKG1qopYfDeHPRzd8
         mWsSq9jksreGlXFnd6ha6UH28BnZH/BrOtBBZ4zwkvU4zknpANWuh3dcFOXuxMR2FmPW
         x9hlgjom2OQoe3DrvkrtFfIvFMY+cArnCP5xICdir/x/vYCxOUAxzjmfDM4rJSK1qE/l
         Q8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768178; x=1714372978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPvL4iKAh8EMRrWGhZ4Kx+fWBqS9MQHGS0oDFyItitE=;
        b=WPNbnXWveL0TobJtevJEpfwe8jijICQDPfDMm77+N60OQQrT0MWrpApUCmHxiIvETb
         DHWon+z81b3vsZ/cfkYJhxrU6rVkPY4rf75+GlJM+yBxsyea2r45ouhBT8APv4nRKt+7
         jknE4jTMN3SDZ6W/tOZS37P6jBuuMtFq2FpWyzOlv0NrVMxDmOTWEx2uvKA8f5HLjkwD
         3LJYuwLTZ0st40lQqC3v5A4RIkIeIpN2BS7aqcLUtz4DKSnPvqL3r559KClsbtgcfoEw
         t0BerI6cxdxlujHoknJTbFpG4RWZuPe5Xn4ptgFmIXwA2AWuxbf+nq1hmPyNbmq/DUXY
         OZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWZL/hIuUiWpuLemnbADxXE58PM97t29rC7qbE9m/l/H/8nkketAfSD+dRZtgUgj8jxjvtUk+KPflDuJU1IB0NJr79xoaBV/lmT0O2R
X-Gm-Message-State: AOJu0YwneekoQ+rRoDtGIwKfujXLfAX1B6xYzb9EfB3ZnJMLzQ0nPLgW
	LrA9Z0BXY+Gq1hsG2GSohBEB7614ZJEIYbddheN6MX1nWaeegT9y6+iDydZr0HA=
X-Google-Smtp-Source: AGHT+IGQHa0Bt9yZK33Ud0O7Ofrtd7OS2UlZDk4os8laOOr7Q7vEbiDq8lBjlyf3QFF1SDPR3MBzBw==
X-Received: by 2002:a05:600c:4f10:b0:41a:1b3f:b465 with SMTP id l16-20020a05600c4f1000b0041a1b3fb465mr3255435wmq.26.1713768177943;
        Sun, 21 Apr 2024 23:42:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b0041a5b68ea32sm2191668wmb.27.2024.04.21.23.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:42:57 -0700 (PDT)
Message-ID: <f1cc8da4-db4e-47b0-b1e9-d3b153fa655f@linaro.org>
Date: Mon, 22 Apr 2024 07:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: introduce support for displaying
 deprecation message
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-7-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240419141249.609534-7-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 15:12, Michael Walle wrote:
> +	if (info && info->deprecation_version)

and here you won't need to check for info again

