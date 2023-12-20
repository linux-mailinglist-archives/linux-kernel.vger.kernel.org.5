Return-Path: <linux-kernel+bounces-6745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67A819CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF791F22E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C420DEF;
	Wed, 20 Dec 2023 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iutGlf2J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0420B11;
	Wed, 20 Dec 2023 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703068242;
	bh=YVVXuKIyCnfmhYXofbFSKAEHH88LRfArJsiXeVCEWNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iutGlf2JvAvI5tVVVndsYew77bFzOFFdE/2AR6qxWDoYBTasTm6YgFnIt47BQjVyb
	 VRw33XHBUX0FpfjdeFfOONOHc46/R2nVBaqTHOwxLh/sSjNX8jJFo6LOE5fQmaiM1j
	 qE0QYB36fk5x1SP8y90AmXkhUiP2y4wIUV4cJT4w+86RzLYQuDF2WM7P5GHvHu2Ypm
	 vmxlcXzlQbZdLh+aNs3Sxccc9+8+EAeeLSPjHEmeBt+vImHjYkURfH2y+Po0ZzuTbS
	 V4Fi6eFt/Phin10GrvHur3UJ7n768NcKuXsm81bnRKYyX1ZpN8IuHKZ2A+woDU46jI
	 DUu5pK6SPjsiw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0906B3781FC9;
	Wed, 20 Dec 2023 10:30:40 +0000 (UTC)
Message-ID: <9ebfe163-c86a-4aca-8f60-179a218821b4@collabora.com>
Date: Wed, 20 Dec 2023 11:30:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] usb: xhci-mtk: fix a short packet issue of gen1
 isoc-in transfer
Content-Language: en-US
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eddie Hung <eddie.hung@mediatek.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, stable@vger.kernel.org
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
 <20231220025842.7082-2-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220025842.7082-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 03:58, Chunfeng Yun ha scritto:
> For Gen1 isoc-in transfer, host still send out unexpected ACK after device
> finish the burst with a short packet, this will cause an exception on the
> connected device, such as, a usb 4k camera.
> It can be fixed by setting rxfifo depth less than 4k bytes, prefer to use
> 3k here, the side-effect is that may cause performance drop about 10%,
> including bulk transfer.
> 
> Fixes: 926d60ae64a6 ("usb: xhci-mtk: modify the SOF/ITP interval for mt8195")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



