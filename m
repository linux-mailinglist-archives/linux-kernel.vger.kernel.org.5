Return-Path: <linux-kernel+bounces-129558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A041A896C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC4B25053
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0C1411DB;
	Wed,  3 Apr 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SkHScl5u"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B9145FE3;
	Wed,  3 Apr 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140284; cv=none; b=a7ln+dssvS5aBtL9Gg7oNnEXTTR5zDtAGt37NcuTKKuOuD9s2ee/S5nEa8i9i9I4PQFTVXDH+/XR13Wnf48oVoYKIxe6X8mkMahwp2w1Z+yrO70aGu55CGLtt3X8G5C/vk+aTbPi0e/bXY0od7YutCTHMIonVzvQ2qXJ+++QZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140284; c=relaxed/simple;
	bh=JuSZGXontp1uaYFNzm+IpjhYl/FHDLiUCjatgpsESdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX8gcsY3KOHNysRBwEs0sqMfe7BLUA+hUo9764+6ZxVYuAz9LOM+046YXbbJvw8THDFgd0XAVUn880KRcECQKTmrbInxmK2DnfSOB4oUQI/LSa/JPv8wVJ531Bofw8cGM+ZnyaB11jIBYZB9usLHEtcbBRVM4mqQZWLhEekFryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SkHScl5u; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140281;
	bh=JuSZGXontp1uaYFNzm+IpjhYl/FHDLiUCjatgpsESdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkHScl5u+fybKvow/PSCZ/LAxJg6xER5pcBDkb6a1rl1sdwU3MWFXCFRSb7qEIp9O
	 eW/rbU3QMdieM8rBXTb9ljgDIm/QFmwMwBZvkLO1FZAdxhXCfytWo88FPj/jS6SqBP
	 9XXDiGWNg5mCRWai4SWc7XrDsHt52GK64jX7qbJaPNL3nJzsALFh8kkwnrM9PUbjSE
	 soBYuNGMmHfvaxGEjy2J5RZHb0twOReXLckK8+YGo+p8pjDSCdOQwwWuKYNpacKhQ8
	 pzzQEbf7BQGgSqVUECse4upNfmo8WEkPYY2pEmmYm1b6PJ+YDKoVFo1yPQ7WOXGtqs
	 rqKhrkF8k4dOA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31B0D37820F5;
	Wed,  3 Apr 2024 10:31:20 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ikjoon Jang <ikjn@chromium.org>,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
Date: Wed,  3 Apr 2024 12:30:57 +0200
Message-ID: <171213179798.60933.2204877373664709221.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240223091122.2430037-1-wenst@chromium.org>
References: <20240223091122.2430037-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 17:11:21 +0800, Chen-Yu Tsai wrote:
> mfgcfg clock is under MFG_ASYNC power domain.
> 
> 

Applied to v6.9-fixes/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
      commit: 1781f2c461804c0123f59afc7350e520a88edffb

Cheers,
Angelo


