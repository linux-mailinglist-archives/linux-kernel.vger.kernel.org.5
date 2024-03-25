Return-Path: <linux-kernel+bounces-116750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8588A54C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF19B62EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68417496D;
	Mon, 25 Mar 2024 10:37:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3955181491;
	Mon, 25 Mar 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359146; cv=none; b=Uy9Vid/DwE+4wp06yWeZT62iSCjF/l0wAjmzqOQ4jiyuc/SVXxheQ2ULvWAurXG71Wgs2R/1yUlXICS0f9JJGddVo/QgkiKYirM6zV6DyLWHOGKBSSZbxJ8GLwZcetrLXj0afwF6558wyjdZlNzNkvjoad2S0f+uSTIaecaBonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359146; c=relaxed/simple;
	bh=ZDD9oI7+kzl+Iom4aF4liYA+/NSY9xwPsvohVm6SgA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgfigdtZ8yuxWbqSPdbZyKk7S7ezrQifyp1aiF46/Ac9C3e7YSuSSZrGtGYBV90+OFdR/kPap7M/Ncnr0Eli8AquEoyky9y+CHZEGr3dQpnGfC1ckxo08TfrMLGRABMTBQuntHv3UPWLY5g4+ldoH3fxAtXzKDprkF4RhKNcnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1roggb-0004XE-8B; Mon, 25 Mar 2024 10:32:09 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Sugar Zhang <sugar.zhang@rock-chips.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: Add support for audio interleaved transfer
Date: Mon, 25 Mar 2024 10:32:08 +0100
Message-ID: <2115347.bB369e8A3T@diego>
In-Reply-To:
 <20240325103731.v1.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>
References:
 <20240325103731.v1.1.I502ea9c86c8403dc5b1f38abf40be8b6ee13c1dc@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Montag, 25. M=E4rz 2024, 03:37:49 CET schrieb Sugar Zhang:
> This patch add support for interleaved transfer which used
> for interleaved audio or 2d video data transfer.
>=20
> for audio situation, we add 'nump' for number of period frames.
>=20
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
>=20
>  include/linux/dmaengine.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 752dbde..5263cde 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -144,6 +144,7 @@ struct data_chunk {
>   *		Otherwise, destination is filled contiguously (icg ignored).
>   *		Ignored if dst_inc is false.
>   * @numf: Number of frames in this template.
> + * @nump: Number of period frames in this template.
>   * @frame_size: Number of chunks in a frame i.e, size of sgl[].
>   * @sgl: Array of {chunk,icg} pairs that make up a frame.
>   */
> @@ -156,6 +157,7 @@ struct dma_interleaved_template {
>  	bool src_sgl;
>  	bool dst_sgl;
>  	size_t numf;
> +	size_t nump;
>  	size_t frame_size;
>  	struct data_chunk sgl[];
>  };

hmm, this only ever adds this nump element. I think for adding things
to really generic structs, you definitly will need to provide an actual
user for it in a second patch.


Heiko



