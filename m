Return-Path: <linux-kernel+bounces-42551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A48402FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA911C220FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03435647A;
	Mon, 29 Jan 2024 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yK5IHEbo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CC56B70;
	Mon, 29 Jan 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524919; cv=none; b=CWTppGW6SmhWsHkKT43PxvQjIa72/kjuJVz5D8SGpv8H+9sRfVOA3BoYA+jT+0MkJLRMgIw7XDQqjbQmUaTm+vzQxxFYrZm23DaIX9leRd2C+oedEzIaF1f06JlCZ+2AMWwWjvTofFkDv5cadPzMS2ElIQERIGEs/MDEo9hUsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524919; c=relaxed/simple;
	bh=5K42SYeoC+w5voAFjka3K8jssH6MUMzwzzlFjaiWuq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFhQasGJ9dt/6nQUQr6E3PAlBg1K6LKze984Zkd3UVDoPZPWf2wKL8VuIUEIumbdPi0jOTKPQpoDxOfxWCxdR0lRZH69/KwD964W7kZHdSXK71oPF4OtR/JEneL262fOsr/bWKGLdOmZrItIo05iJRUbLTEbV3mU+Zv/AYpVm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yK5IHEbo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706524916;
	bh=5K42SYeoC+w5voAFjka3K8jssH6MUMzwzzlFjaiWuq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yK5IHEboSYgBsJWcg4lNpZ967zp4zSh/slm5W1q3/zwtHYkIgcg4uRsYolaG0RrdK
	 UStPmhONTOaXD0lRVaPU3a7iKj5PJxnvsZ745SC/y2glJXs9b2kIgQFNIcS5PGbwDv
	 PFGI1i/OR/tSmfBPQiGOO/ZdjUTHjVomzGujPGZwA2m2QA8IIAWKHa2yocCWwci1Yc
	 8nFiJrPbQBdo7vzncgUpmRXDN81n6lo1+naHigyBstytHFUlxkrrIdgu91XYzTTq2S
	 QaRBclMsX+69vJef3gAPCXWEz+RRp6lqK9ZkdbMswGHWOheDMfAkmpj4M8VEi5VrbZ
	 lW4drTZb2qySg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B9153781FCF;
	Mon, 29 Jan 2024 10:41:55 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org,
	Eugen Hristev <eugen.hristev@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	kernel@collabora.com
Subject: Re: (subset) [PATCH v3 0/6] video encoder on mt8186
Date: Mon, 29 Jan 2024 11:41:42 +0100
Message-ID: <170652472371.127352.1415914611175058375.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228113245.174706-1-eugen.hristev@collabora.com>
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Dec 2023 13:32:39 +0200, Eugen Hristev wrote:
> This series adds support for the video encoder on mt8186.
> 
> Few patches fix the binding, there is a patch for the DT node,
> and one patch for the driver that fixes an imbalance.
> 
> Changes in v3:
> - removed the patch to add dma-ranges, because this was intentionally
> removed (e.g. https://patchwork.kernel.org/project/linux-media/patch/20230303013842.23259-3-allen-kh.cheng@mediatek.com/ )
> also removed dma-ranges and cells from the DT node
> 
> [...]

Applied to v6.4-next/dts64, thanks!

[2/6] dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
      commit: b8248c4831787f0854e2e856fa83da68ad5afcde
[3/6] arm64: dts: mediatek: mt8192: fix vencoder clock name
      commit: 0157de54920b556d575ffc82ae5d16f2b4cb9494
[4/6] dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
      commit: 178eaba322868a75c2e0ad078fcf91c3a6f5abba
[5/6] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
      commit: 2a08dba6bf6637295175f48ad870a24833955cd4
[6/6] arm64: dts: mediatek: mt8186: Add venc node
      commit: f971c7ee301bbd423e06f82bcae768223a4dd602

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

