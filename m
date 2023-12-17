Return-Path: <linux-kernel+bounces-2542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E257F815EAC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B81C2106C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE58134C5;
	Sun, 17 Dec 2023 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nilvsnOw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937F12B8C;
	Sun, 17 Dec 2023 11:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE04C433C7;
	Sun, 17 Dec 2023 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702811839;
	bh=Sk2qe/uIHfzrqXwB7Gd/4Uel6P7DxOF+HQ9SsHoeciY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nilvsnOw4ynfGElnT481GCb04X9uZGXegbEKJs11zjB03awEgRdsiInGe9prJyfnN
	 nSFKipw2g85ljD9h0ZElOgR2f71CzM6ruVZQ/+TOlM0gYOY8Ujq5dQdyyViNOrOYhF
	 r1Ii5TB2+5Mcbkv8ECSSstKtcKSTudEDX8igiXRipOcUVH0INVrW9/Jf88quofTdZc
	 4tEnt16Tnv7IX+vHwKKXTDPMkYa2D83se/ZY5VOe8/QSlO8RbTJ6BKB3LYq2fI2BPr
	 mYfhnVPQvcaPdh2KFID7rFWHAxQycy0yAT+W9MkxLuNYOvQYogb21zUNaSezubzU5X
	 ETiKqqthhx6DA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2][wireless-next/for-next] wifi: mt76: mt7996: Use
 DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZXiU9ayVCslt3qiI@work>
References: <ZXiU9ayVCslt3qiI@work>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170281183364.2255653.11348778745254559115.kvalo@kernel.org>
Date: Sun, 17 Dec 2023 11:17:16 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Transform zero-length arrays `rate`, `adm_stat` and `msdu_cnt` into
> proper flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:544:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:551:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:553:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:530:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:538:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:540:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:520:57: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:526:76: warning: array subscript <unknown> is outside array bounds of 'struct all_sta_trx_rate[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

40d51f70f082 wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and fix -Warray-bounds warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZXiU9ayVCslt3qiI@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


