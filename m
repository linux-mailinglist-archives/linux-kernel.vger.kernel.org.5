Return-Path: <linux-kernel+bounces-14190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C808218F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35898B2199D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E422C8C4;
	Tue,  2 Jan 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hC5jvCVa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D66AB7;
	Tue,  2 Jan 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704187910;
	bh=GS1ilAjGtQe9kYt0ZI0ljTUErP/Rc2UM30xX6zpBUl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hC5jvCVas/Ki5j2R6EMxqy8XF1AZwdw0WBI++dRQdLK8BF7Czcj+1Mk/pg2Q5D0V9
	 3aRpZnVS/OU9GI2ZFp6vGxtsykLR7XHYgG9ap6SRWHOhD9Mos/KDykGIZ5y9GAtaka
	 syEVvz0ceeDCbtkfyAfbRumHjHIfklYBmzWxKf7Y6n7U3g8Zs6znpMdKmnLfMK6Z0O
	 ZlxeH7ysuRCuY2rU45gJm21/abxJCWBxqv2TFxVBSRi+uvopFMpOm86kR99IXURS9X
	 d6Igr+QeM6FYjxbm30Kf4s4FHJ3YwmxFisRHKB1PQPHUkVY48A/bYgOgWbyT74vYG5
	 u245MsWFF5YDA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8122737813DB;
	Tue,  2 Jan 2024 09:31:49 +0000 (UTC)
Message-ID: <db7b4cb4-7302-47c0-9712-0d746347c6a9@collabora.com>
Date: Tue, 2 Jan 2024 10:31:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
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
 Eddie Hung <eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
References: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/12/23 07:03, Chunfeng Yun ha scritto:
> For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
> still send out unexpected ACK after receiving a short packet in burst
> transfer, this will cause an exception on connected device, specially for
> a 4k camera.
> Add a quirk property "rx-fifo-depth" to work around this hardware issue,
> prefer to use 3k bytes;
> The side-effect is that may cause performance drop about 10%, including
> bulk transfer.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



