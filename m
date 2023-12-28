Return-Path: <linux-kernel+bounces-12609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C360E81F7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4982861E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C072B6FD6;
	Thu, 28 Dec 2023 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E5P1ammQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B96FB6;
	Thu, 28 Dec 2023 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703763175;
	bh=H+p65aUaK9evKJt3enmqsrg8ME3wuAMZvoXwXZVX8Bc=;
	h=From:To:Cc:Subject:Date:From;
	b=E5P1ammQWbyCeX9t0SiIGu5Ct5h2/6FJMJt03TnMKPdEYBY0bcht87BFCAli94FLc
	 3J64pKc3R2UmsMi7u0Hf9TQFslrZu4cwxl61yjzm1g94X1V4VP6AQM7vP0pz2X4PFX
	 YcqkzM9dhtc7efd9pcEa3Ssj5z9zZG2Q92l4dCSufS0xT0OXBDv+10WfhbLgXS0Ieq
	 cSi94H3dZnmqFfdROEDqmURM/4vpUhIworix0bTdsSTrWFg74CTruEHyrpQT67/Pl2
	 aZdryzm92Nq62AAncS7Rj6g+jC8rPUgIukpzp+BC3kl7JQbtiJ+04BdTOfLxVP7mDR
	 GFIyVsQawwIng==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B21123780436;
	Thu, 28 Dec 2023 11:32:54 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org
Cc: eugen.hristev@collabora.com,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 0/6] video encoder on mt8186
Date: Thu, 28 Dec 2023 13:32:39 +0200
Message-Id: <20231228113245.174706-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the video encoder on mt8186.

Few patches fix the binding, there is a patch for the DT node,
and one patch for the driver that fixes an imbalance.

Changes in v3:
- removed the patch to add dma-ranges, because this was intentionally
removed (e.g. https://patchwork.kernel.org/project/linux-media/patch/20230303013842.23259-3-allen-kh.cheng@mediatek.com/ )
also removed dma-ranges and cells from the DT node

Changes in v2:
- change log in every patch

Eugen Hristev (5):
  media: mediatek: vcodec: fix possible unbalanced PM counter
  dt-bindings: media: mtk-vcodec-encoder: fix non-vp8 clock name
  arm64: dts: mediatek: mt8192: fix vencoder clock name
  dt-bindings: media: mtk-vcodec-encoder: add compatible for mt8186
  arm64: dts: mediatek: mt8186: fix VENC power domain clocks

Kyrie Wu (1):
  arm64: dts: mediatek: mt8186: Add venc node

 .../media/mediatek,vcodec-encoder.yaml        | 31 ++++++++++---------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 23 +++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  2 +-
 .../vcodec/encoder/mtk_vcodec_enc_pm.c        |  4 ++-
 .../vcodec/encoder/mtk_vcodec_enc_pm.h        |  2 +-
 .../mediatek/vcodec/encoder/venc_drv_if.c     |  5 ++-
 6 files changed, 47 insertions(+), 20 deletions(-)

-- 
2.34.1


