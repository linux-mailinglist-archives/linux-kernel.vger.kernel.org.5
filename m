Return-Path: <linux-kernel+bounces-138168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7889EDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143FEB22DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785113D634;
	Wed, 10 Apr 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0CzQTEv5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0213D60F;
	Wed, 10 Apr 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737813; cv=none; b=qnmPlbmoMo4ONHbdC5ZOtwTv7JRIk3NMnTVt30qY1ll88xvKBQRr4IFu1jzQRNouEp+WIjMwT37m6kllqE+EkaPAICXPdwchFedIpT5CbQbyBKdOT5LiBDPKntHM7e8yG010pZZYhCirB/UGriFSAJS3J70yRodcNEDqV15aaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737813; c=relaxed/simple;
	bh=g0inTgKrdcNpJsKqCIJbmzWiWIcGhn7etTaylPEt72k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQoI8f3scWIWwHIAlbteYDSMf4FfGK9+6huZDIJAxSoRcpHUzKjwmXQOf7NA8MFfkt5HXnrtVb8Hvnt81UmUUEGRTNwk2WpviJGwKdnpzbMb+aDVx4RJPCDOTTHzbxexcI4JrZzBKbPOiG+nlF/d/RK4ChWj6pGky/4Wp6aldNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0CzQTEv5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712737810;
	bh=g0inTgKrdcNpJsKqCIJbmzWiWIcGhn7etTaylPEt72k=;
	h=From:To:Cc:Subject:Date:From;
	b=0CzQTEv5Is0lS8S/YQQiHjx1OCNaRTRntcQuHvj2PqUhv0hRT+AXsBKYzNwQOAOvU
	 js3m81Vjg3RoXEW5QokN5ZcgjuIJBI1h7DRkwmy9jmpUTlw7+GD4DiSga3eK4BKVuG
	 mtn35/hYjST820f9JfrNAdoi26UssBcmEJl1eUVlXKWOGag953/+ZT0ap/XGXo14TJ
	 5iklUxWTh1CEuvSJ4tlte7BErnKVO6C4+QChJlpVTHFyJJbg23DVXLMzCfB/821pxH
	 J5IO2rwrvSqCDcHBKkogEdj9L+EtHjLKhZgM8i6R0v9HethsgAVzw3GsICG2o2gzP7
	 4Inr5VhcxnStQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 252C0378208C;
	Wed, 10 Apr 2024 08:30:09 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bchihi@baylibre.com,
	bero@baylibre.com,
	amergnat@baylibre.com,
	nfraprado@collabora.com,
	michael.kao@mediatek.com,
	mka@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/3] Address thermal zone issues on MT8183/95/92
Date: Wed, 10 Apr 2024 10:29:59 +0200
Message-ID: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thermal zones on some MediaTek device trees either have cryptic
names or wrong ones.
Having the right names is important for both human readability and
for MediaTek SVS functionality: fix those.

AngeloGioacchino Del Regno (3):
  arm64: dts: mediatek: mt8195: Fix GPU thermal zone name for SVS
  arm64: dts: mediatek: mt8192: Fix GPU thermal zone name for SVS
  arm64: dts: mediatek: mt8183: Refactor thermal zones

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 136 +++++++++++++++++------
 arch/arm64/boot/dts/mediatek/mt8192.dtsi |   2 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi |   2 +-
 3 files changed, 104 insertions(+), 36 deletions(-)

-- 
2.44.0


