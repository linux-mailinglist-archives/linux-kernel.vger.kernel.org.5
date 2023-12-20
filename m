Return-Path: <linux-kernel+bounces-6946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A28819F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3AF1F22C56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF552577A;
	Wed, 20 Dec 2023 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CFJ6GVQ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4536AE5;
	Wed, 20 Dec 2023 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703078033;
	bh=U12hPniJ+DF7IxQzd9EDTvjLsfdGz2472CrJfYpM9O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFJ6GVQ0Qq/6obqVZnHcU/vZWLRZCY+ZYJn45S9ToZ3nFiZkTN6TZc6JYzpiAhdXb
	 VscFsaNOUSZbDHINbB/rOolsFnUhV7LcwvpVdQrQzTX3mTOqY5KRmUrYr7RkNk7z3g
	 ejipU50/EvlQ9S2xC+AX9WJAM3JewvYLNjnFNwGhSJOBIUDb6W45vczg1L3HA9hAVi
	 4CqQ81S6JhAEvutaN22Hx2yXDkah9uEdTGgWL4UZ1Nu+i7uVGyhJdmqCJ1Mni1cQEU
	 kbuvch/iDfRj8F6p0REB/k91oxNa+WZ+y0B/r/4QIYqZRmNhDlKufsCazYbVJdkQct
	 8QLw6SRI0rMkw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AAD32378107D;
	Wed, 20 Dec 2023 13:13:52 +0000 (UTC)
Message-ID: <479fa717-8de7-4f1b-b02c-2cfbd49f71cc@collabora.com>
Date: Wed, 20 Dec 2023 14:13:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] soc: mediatek: mtk-socinfo: Add driver for getting
 chip information
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 William-tw Lin <william-tw.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231220103901.22180-1-william-tw.lin@mediatek.com>
 <20231220103901.22180-3-william-tw.lin@mediatek.com>
 <97d54894-7c71-49d8-a456-869c398636ec@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <97d54894-7c71-49d8-a456-869c398636ec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 12:34, Krzysztof Kozlowski ha scritto:
> On 20/12/2023 11:39, William-tw Lin wrote:
>> Add driver for socinfo retrieval. This patch includes the following:
>> 1. mtk-socinfo driver for chip info retrieval
>> 2. Related changes to Makefile and Kconfig
>>
>> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> 
> ...
> 
>> +static struct platform_driver mtk_socinfo = {
>> +	.probe = mtk_socinfo_probe,
>> +	.remove_new = mtk_socinfo_remove,
>> +	.driver = {
>> +		.name = "mtk-socinfo",
>> +	},
>> +};
>> +builtin_platform_driver(mtk_socinfo);
> 
> module platform driver, because this is tristate and because this should
> be a module.
> 

Oh! Yes, right! Thanks for catching that, it totally slipped off my brain.

Cheers,
Angelo



