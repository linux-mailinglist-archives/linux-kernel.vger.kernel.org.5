Return-Path: <linux-kernel+bounces-136837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292F89D8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8FC1F218EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD712BE8B;
	Tue,  9 Apr 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P5l1xQQJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A912AAC3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664375; cv=none; b=TtqTA5pqtZNjSHdsMO1KoLbJ+DWEZ9fdUO8DKijeT1htNgvIciIudE4JnCCu56S4IesRiwJoubj9aBsR4F2WRN0VvRdQL773KOVxdQoOtlmGBOgtBaGDUZmJTNnrlkLssVRWzRJ7VEROZIzKlD9nOwfh9k/lgOsws5nrlPo7CpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664375; c=relaxed/simple;
	bh=bxete63RC9eyY/F1YbE2OTVoJGEBETCNOX3GFBbDvK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQbZH6qMqSZdAhc2d6ewiYJqbYiiveHVlUZcJhtdW8HNE5giJg2fhmjMm2/Pl6eZWp5jnPqfDiVtw0IB6SVUKuiWTw9Z+se6sZVxSEd1lGG7NNi5DcD+dXBw6h3Txrolcog9a01/2PEJxTb1wnWBZwiXX/BKEHLGimzP9zuqJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P5l1xQQJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712664372;
	bh=bxete63RC9eyY/F1YbE2OTVoJGEBETCNOX3GFBbDvK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5l1xQQJqk8igiSnjXLbP6ibC/X19GU65q233a+TeWdnpQ5GFllyjsm92UaHhclIg
	 oH9mEwGxGKMte7BHuSvUovqQa6MJ/86KOAopYgQZ9pqIVJPQQ412XTeNANheU5fht9
	 0FQxTkiAxIGI5ZSmLvAACVMugINnJLSUaG4DVYDEHJFyg8wopB2+rs4i55Ev7auu9o
	 zeFyaUqb8nWjh2R1g0xubWZFT5ujcDiDX6Rs+s4sO0UVtb425CdWuaQGhNFIqG8A+o
	 6I2FLmLTus1ttz/OjrXpV3T5NO2HZ8hskT0HuCPPgT1+ErUoc6GgadDTDe5X0OPcQ7
	 /AaTn5cUsusQQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8912E37820F5;
	Tue,  9 Apr 2024 12:06:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	William-tw Lin <william-tw.lin@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
Date: Tue,  9 Apr 2024 14:06:06 +0200
Message-ID: <171266435367.323153.3142211141417575586.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
References: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 17:42:41 +0000, Daniel Golle wrote:
> The mtk-socinfo driver uses symbols 'soc_device_register' and
> 'soc_device_unregister' which are part of the bus driver for
> System-on-Chip devices.
> 
> Select SOC_BUS to make sure that driver is built and the symbols are
> available.
> 
> [...]

Applied to v6.9-fixes/soc, thanks!

[1/1] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
      commit: 2217fb42a6d0e062b0a11f90fe775651f73ed05f

Cheers,
Angelo


