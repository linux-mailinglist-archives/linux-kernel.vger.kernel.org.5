Return-Path: <linux-kernel+bounces-14173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1848218BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC83282C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958696AAB;
	Tue,  2 Jan 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w6JNbAmk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8B63A6;
	Tue,  2 Jan 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186835;
	bh=ImQ+ymQfWqAxdMGCUQbM0o1Jmc0/6yS4KLapzuXqGhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w6JNbAmknwR8jiIFUkRky+Lu1jqEU9GHaf6rZZDjMwnjTQWvGC0mgGa5wqe3ajNKN
	 +eeoKfWG6vs7mCfNnuQL/S+5d0e8uM97zK3HpW0RDN82K/AkmH8WWLpiihti97Vvmr
	 Ykkeicc4j9uhqDc2dZkvJB+msv3wdKG/8GO3I6bon0YQKDeje6PITa2wJM4FUN6tSy
	 etfL3pQg5kU1bgeksb/i21rJoTwT6mt79/+whW84YQIdGla3tYNhSHrBpGseK68eHZ
	 w0gnCU0/4aZw6InmZMnCpXGiI1fe53cWBywPwWRQLpeYe1AP+RN7ZjIQdE1He8tJnF
	 DhBoEwKRJSl5Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0BA5437804B2;
	Tue,  2 Jan 2024 09:13:54 +0000 (UTC)
Message-ID: <9c2c42f6-e10a-4ff1-89c7-8635b8f8b73e@collabora.com>
Date: Tue, 2 Jan 2024 10:13:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] dt-bindings: media: mtk-vcodec-encoder: fix
 non-vp8 clock name
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <20231228113245.174706-3-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231228113245.174706-3-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/12/23 12:32, Eugen Hristev ha scritto:
> Looking at the binding it makes sense that the `-vp8` compatible has
> the `venc_lt_sel` while the other bindings have the `venc_sel` as name for
> the clock.
> This was also mentioned in the txt version of the binding before the
> conversion:
>   `
>   clock-names: avc encoder must contain "venc_sel", vp8 encoder must
>   contain "venc_lt_sel", decoder must contain "vcodecpll", "univpll_d2",
>   `
> 
> So it is easier to check for compatible that includes vp8, since that's
> just one, to have the requirement for the clock name property as
> `venc_lt_sel`, rather than for all the others, some of which are missing,
> thus for them, the requirement is wrongly `venc_lt_sel`.
> 
> Reordered the if/then/else to match `-vp8` and have all the rest of
> the compatibles using the other clock name (`venc_sel`).
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



