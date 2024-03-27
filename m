Return-Path: <linux-kernel+bounces-120635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4E88DAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23C1296450
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9473EA86;
	Wed, 27 Mar 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O9cgRC+o"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952A1401F;
	Wed, 27 Mar 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533446; cv=none; b=Z2I4p4h96uPkEHnJ/tMFsRDzGXqZy8ffBhqi0uTw7Ij7nVqHGJ+/Zv55FSq/RA1P4zQpdtsKUGK//6M6Ec8Uge+9W1bKEBsBjtmpMteFsw3uSOzT1/n5/8ssOps4z0pDdJsGXUlVQA0tQLY0wtaE+GNYNEkT5F2zzOJfR+w/SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533446; c=relaxed/simple;
	bh=6i66eyLtFjTaO1dIDXVZlX8Q+lSEqYTtOhQaqZ1TG4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olUdk4t+baotI/3lBFXfGd1Tq19y8PvssKaOISwzhcrTL6PwTj1BYhVnLGoizyTo0sd2NOO10P/8Vq+XS6a+n/WiHMaseNQAuA4qBCqFpbe7gMMB2HY5gvZEe+nibBaLzUvb5LyTXJc72Oa0YRVvK+nCNf1X13bcVfXiqSrWSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O9cgRC+o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711533443;
	bh=6i66eyLtFjTaO1dIDXVZlX8Q+lSEqYTtOhQaqZ1TG4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9cgRC+ouOzomKIMASnl8XCJ1FP8XAkY19uHoDuWXBSAWIZlGDY0K6OazuGD3rUtr
	 W+84Dbhj0HYbPFfVsW31y3n/oOwJaizH68tLgmYnXe1N95NkWeE7w+AM1u5jxeagp7
	 9V7K56LW3zRaVA/eY1ev92fshjbjjTC4v/DjH1suTp8ji7lYcmy9jDZYQvqm26OVK4
	 K79GWTLo6oyQIIhcQgMcrA3Kwes/Bx976S+xMIcUDMXcqQKt4Xd0bjLcHFD3cscaB2
	 txx57D+K/2wYNck23bjyo+0QMF5OnNFy5BfmWkOF/kuq16x61TdUZfi53fWZ11+fd3
	 cdy02UHlicvFw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2478037813CA;
	Wed, 27 Mar 2024 09:57:23 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:57:22 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Fei Shao <fshao@chromium.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 0/4] Improvement around mtk_vcodec_mem_free() logging
 and usage
Message-ID: <20240327095722.w56iugips6z2bl2p@basti-XPS-13-9310>
References: <20231221092226.1395427-1-fshao@chromium.org>
 <CAC=S1njAtbvjy1KBoVNtsw8WDKL1Zoh76mG3HvcUaOUBprEMkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=S1njAtbvjy1KBoVNtsw8WDKL1Zoh76mG3HvcUaOUBprEMkQ@mail.gmail.com>

Hey Fei,

On 27.03.2024 17:18, Fei Shao wrote:
>On Thu, Dec 21, 2023 at 5:23 PM Fei Shao <fshao@chromium.org> wrote:
>>
>> Hi,
>>
>> This series includes some improvements around mtk_vcodec_mem_free() in
>> mtk_vcodec_util.c.
>>
>> I noticed that mtk_vcodec_mem_free() generates a spurious error if the
>> target DMA buffer has been freed previously:
>>   mtk_vcodec_mem_free(),69: [MTK_V4L2][ERROR] 18000000.video-codec
>>   dma_free size=0 failed!
>>
>> The warning is harmless, but it brings some confusion to our developers
>> and testing infra, so I sent this series to fix that with some minor
>> improvement for the driver alongside.
>>
>> The first two patches are for aesthetic and style improvements, the
>> third tries to make the error logs more informative, and the last adds
>> back the missing checks when calling the free function.
>>
>> Regards,
>> Fei
>>
>> v1: https://lore.kernel.org/all/20231113123049.4117280-1-fshao@chromium.org/
>>
>> Changes in v2:
>> - rebased on top of next-20231219
>> - revise commit message for clearer intention and rationale
>> - update the error messages based on the suggestion
>>
>> Fei Shao (4):
>>   media: mediatek: vcodec: Replace dev_name in error string
>>   media: mediatek: vcodec: Drop unnecessary variable
>>   media: mediatek: vcodec: Update mtk_vcodec_mem_free() error messages
>>   media: mediatek: vcodec: Only free buffer VA that is not NULL
>>
>>  .../mediatek/vcodec/common/mtk_vcodec_util.c  | 23 +++++++++----------
>>  .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 22 ++++++++++++------
>>  .../vcodec/encoder/venc/venc_h264_if.c        |  5 ++--
>>  3 files changed, 29 insertions(+), 21 deletions(-)
>
>Hi Hans,
>
>I'd like to get some attention for this series in case it has been
>overlooked. It still applies to next-20240327 without conflict.
>Please let me know if you have any feedback or concerns on this.

Sorry this seems to have slipped through my fingers, I'll put it on my
list. Thanks for the notification.

>
>Thank you,
>Fei

Greetings,
Sebastian

>>
>> --
>> 2.43.0.472.g3155946c3a-goog
>>
>

