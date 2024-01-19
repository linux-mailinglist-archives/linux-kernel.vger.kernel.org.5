Return-Path: <linux-kernel+bounces-31050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74883281D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CA42832A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4614CB40;
	Fri, 19 Jan 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kQi+KwgB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4074C605;
	Fri, 19 Jan 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661168; cv=none; b=Wsu1tOvuqYjpBXoprB8YLZZa2ITmVNdzEqdqb2vyBLMO3zrFy52/B/mKMdH03OW3VCrzQ04dIBJTVXI+GEFh2+qYvSl/KfGG9H/l6eSLQee7WIIM90dRO9MS49vB+94BTw225+yfVzuw6fwLpA0XW2Px1DknJ8TlAZcZjcR7lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661168; c=relaxed/simple;
	bh=+BtwhZWZLy/TV7bT5xQL0CluIjxMSGPYSHEHTV2fZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=steguazP/4Ty4LhmfEc9qr4vjKJwPj+s07mKekTd+qeBW5sudH7Jl55aEitonoXpjqpQAsirBfBN55o0ai9/4tyBhq20A54mxaZDW828bUokj6tfjMVcP/HANrGsoEAAIsB0lNCAYM4S9jCSkDZcaIO14falZs5VagniUfklkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kQi+KwgB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705661157;
	bh=+BtwhZWZLy/TV7bT5xQL0CluIjxMSGPYSHEHTV2fZ3E=;
	h=From:To:Cc:Subject:Date:From;
	b=kQi+KwgBvloxAnur4ACXtrvBUdciPBgjm4NPdwynxtEzi36qqnIUGCX2Q/rk4MF+B
	 z0Jnn4dSB/i9e0ueNQaKD/FeHD0UfuVviadwz//b7mww8YRKNvA9yqDXV1/HvruUSM
	 iqzjZ6MCibi9dXyg91ehzUWoUBplevDftfVGWQcg8zXORHwU4nhzzDrm7ZexiCDgso
	 wwlH0B1vmWOydihSb1m3DZSurvScU2qWq19jJgDUw/J9rhydTgSF3Sr7EYOQxi/qlN
	 9zJa0km4Jh2J2/9NnFYikx+NyCyb3A7DVZEUTJo5hYFfvpdj14HYPryAdoa/QDOAjh
	 DBSeJLN0uTctA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 04E09378202D;
	Fri, 19 Jan 2024 10:45:55 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com,
	matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	nathan@kernel.org,
	luca.weiss@fairphone.com,
	tianping.fang@mediatek.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] Add ITE IT5205 Passive MUX
Date: Fri, 19 Jan 2024 11:45:48 +0100
Message-ID: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the ITE IT5205/FN, found on various
MediaTek board designs, including the MT8395Genio 1200 EVB and
others following that.

AngeloGioacchino Del Regno (2):
  dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
  usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver

 .../devicetree/bindings/usb/ite,it5205.yaml   |  72 +++++
 drivers/usb/typec/mux/Kconfig                 |  10 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/it5205.c                | 292 ++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
 create mode 100644 drivers/usb/typec/mux/it5205.c

-- 
2.43.0


