Return-Path: <linux-kernel+bounces-156919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A898B0A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E461C22E39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57E15B154;
	Wed, 24 Apr 2024 13:04:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18315B12E;
	Wed, 24 Apr 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963866; cv=none; b=j92/oBexSYUzUm9DRdCOzPK7WuayWHao/lJveOv0ynLgOvcbXcfZGvHiffOceqBuL++bGf0Z4gTJErDjJDMYv01U6Z9wZUcfkkT8tu85qMnQWgp8F0qM8WmBC08TC+Qq3xyWd1zClLNRsMd9Ri4RHqBYZ1m1XSNc4MJIiIxWSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963866; c=relaxed/simple;
	bh=apjz49t/OeffXH166b76VyqGkW44Vc0v5uVQrC0o0po=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OqMWiD6nT5Kjvxnom//TYYlcKkRYq7pFCqCS/Fgu6MYLVWzwIQF2nimKqJwi+LO+0Q6mkcczAAGwT/Bv+j3i/CfdkX09vj2b5ypIL5Sf31VHg5H5UNO70+SZ2owAyZYyWyk2INDjPdlfyLlq6mjl15RygE1hAo1857H+btS+rWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VPfLF1zT7z1HBjj;
	Wed, 24 Apr 2024 21:03:17 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id BAA9618005F;
	Wed, 24 Apr 2024 21:04:18 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:04:18 +0800
Message-ID: <3d245976-6509-4260-b232-04637c644350@huawei.com>
Date: Wed, 24 Apr 2024 21:04:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-kernel@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yisen Zhuang
	<yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH net-next] net: hns3: flower: validate control flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
References: <20240422152717.175659-1-ast@fiberby.net>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240422152717.175659-1-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)


on 2024/4/22 23:27, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
>
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
>
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
>
> Also propagate extack to hclge_get_cls_key_ip(), and convert it to
> return error code.
>
> Only compile-tested.
>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---

Thanks,
Tested-by: Jijie Shao<shaojijie@huawei.com>


