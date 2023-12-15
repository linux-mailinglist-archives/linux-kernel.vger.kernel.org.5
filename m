Return-Path: <linux-kernel+bounces-1015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485181493E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95AAB23889
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3E2DF9C;
	Fri, 15 Dec 2023 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXsLTunK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA72DB75;
	Fri, 15 Dec 2023 13:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408EC433C7;
	Fri, 15 Dec 2023 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646980;
	bh=rpyS4v8W+CuN4+EjjXEahB1+6g1qTTqMvB9+ugujzJg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JXsLTunKMBBISI4ECLjoovakgd/auY72meweT5jEaGxWUmWWMPpUZ0/zdNwREoc2g
	 2aS2ZNCm1VcCgKfG9UUbi1WD7ytS5cCUCgEypqXTrz2rzw7bDJr566wVPY4/Pny+JZ
	 9e+Ey7VpBE4EOB0iIPpVVjiFfWnmnA44lv/DdIN36uMLpGqTXCll4jaanDarSgmOP2
	 ZKcszw82ho2s3UYGfr7Wgo8tVp1rJ/hNwk1umGZv2WpM+73haNqFR0Rz01Xs04Y/af
	 xJEUIKZhkdybjvF/4OYAtLELSFBU4uAHRvGWHL0FUfH+95hDrJL/ICpWFM3DS5YP2S
	 sCWwwaOTG5JxQ==
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
Message-ID: <170264697580.1759617.6397953788753678096.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:29:37 +0000 (UTC)

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

I'll take this directly wireless-next, ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZXiU9ayVCslt3qiI@work/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


