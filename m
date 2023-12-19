Return-Path: <linux-kernel+bounces-5039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37198185C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19581C223F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8A14F69;
	Tue, 19 Dec 2023 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SnZH+wvt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8515AD3;
	Tue, 19 Dec 2023 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702983398;
	bh=E6SsGnEMQ5sQgGiV6jGfWzSqHuxNI3tqz6LYjcZqyto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SnZH+wvtXP/GDQpXtBpr6B06nuYwgID2MgVv83MO2PFYFvCRdaDS4P+bE87L8txKt
	 RoyiRqFbVhDQPx5AkWDyVDaTP1C/+6RjX6EM8EATNNe/kEk/VVzo460gYKNNl3uf+h
	 Z+zANvIvh14t56VGrNHm9Ib7EAx1ZPIorZaMWb4ZDWKFz4c4CAbkw5J9WUknEK7P+K
	 B7AfteaDmOitMNkbE0JdgIUwsTMehGLyt20I3ShIFFkacKwyca1lcelLd92qpahoe6
	 BvIoFdwvydjowZo1gVXSsF/SnaV7woUSYfhCiNu0Wd7p0T5UMFN8MTrKtHdWHQOxx0
	 3A16LWwIN13Hg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E8E3337814A3;
	Tue, 19 Dec 2023 10:56:37 +0000 (UTC)
Message-ID: <e23ebdd8-7fbe-435b-a850-0ef18a51b020@collabora.com>
Date: Tue, 19 Dec 2023 11:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fix overflow in idle exit_latency
Content-Language: en-US
To: Bo Ye <bo.ye@mediatek.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: yongdong.zhang@mediatek.com, C Cheng <C.Cheng@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231219031444.91752-1-bo.ye@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231219031444.91752-1-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/12/23 04:14, Bo Ye ha scritto:
> From: C Cheng <C.Cheng@mediatek.com>
> 
> In detail:
> 
> In C language, when you perform a multiplication operation, if
> both operands are of int type, the multiplication operation is
> performed on the int type, and then the result is converted to
> the target type. This means that if the product of int type
> multiplication exceeds the range that int type can represent,
>   an overflow will occur even if you store the result in a
> variable of int64_t type.
> 
> For a multiplication of two int values, it is better to use
> mul_u32_u32() rather than s->exit_latency_ns = s->exit_latency *
> NSEC_PER_USEC to avoid potential overflow happenning.
> 
> Signed-off-by: C Cheng <C.Cheng@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



