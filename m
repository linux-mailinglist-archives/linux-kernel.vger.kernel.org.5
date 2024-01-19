Return-Path: <linux-kernel+bounces-31150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE78329CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A21C216C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A90524A1;
	Fri, 19 Jan 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AfvubQDP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A043C493;
	Fri, 19 Jan 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669099; cv=none; b=Ls9RfjiNaRO4jXiyj2hDtpegqtlUaEoTSUfYBIcX768gaIiJujOcbI6jIfor16VjDXsFtXh/j8KqIaUCyHt/j6gUOkWcbvbtqk3eOiX8s8iRuDXQPeihuBfCJSPcj2Ms8ozdSX1wzXd3k/fKA6QPy5M02St2FdKil1jiGKzxxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669099; c=relaxed/simple;
	bh=bGrbcVKvkDIoSfHBTxlivOML0alDs0Jm3cTz73DwTkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSVFISoFPfdQK9Ts1NHfQlGddDnFeYzG0kVAll6xBlnKl0uFDKw8Jauu8s4YfpBzlDZzIOsstaZOmhT2fUGVPEJOUqxPyeeoEGJPK3sOMbTz7/FGLXHabCpAqPwwxZwljyRPtSNlX0EnaADzjFle+OHaejSUi/6kovHH6aeiwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AfvubQDP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705669096;
	bh=bGrbcVKvkDIoSfHBTxlivOML0alDs0Jm3cTz73DwTkU=;
	h=From:To:Cc:Subject:Date:From;
	b=AfvubQDPxx1z+zoJEr13Zm7CA4GIl5QXvLMMXzoULV6oQUHsAVLlwSLQrqWEojT4T
	 QFBS0scpSnOD0UwuwQLt+7SnZP4BD2NRskBqR8IgbM1qB8ZPUQUNAned1tTVR3cElo
	 i0OKPjxaaA5a+BlVnnqKOvcLwiAKnk/V/HhpXxTJFV+zp0TO6JSfkE94eYZotKpkjE
	 KdePlcbHbSM4DfVxYafEOvokgtyfhhpyJkooH6f/CsD6GMGnQ3ew2ufWD4w7bXl8Wb
	 63nEeQ+/U4IKpzefHJw4EKiinW7zWyBhwzWf/BxuLmNfTMjWHJsJEUBSCaCr2nOx2q
	 eBzNy5ZfOCuhg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4532437803EE;
	Fri, 19 Jan 2024 12:58:15 +0000 (UTC)
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
Subject: [PATCH v2 0/2] Add ITE IT5205 Passive MUX
Date: Fri, 19 Jan 2024 13:58:10 +0100
Message-ID: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
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

Changes in v2:
 - Reordered headers and removed unused ones
 - Added a check for altmode in it5205_mux_set()

AngeloGioacchino Del Regno (2):
  dt-bindings: usb: Introduce ITE IT5205 Alt. Mode Passive MUX
  usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver

 .../devicetree/bindings/usb/ite,it5205.yaml   |  72 +++++
 drivers/usb/typec/mux/Kconfig                 |  10 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/it5205.c                | 294 ++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
 create mode 100644 drivers/usb/typec/mux/it5205.c

-- 
2.43.0


