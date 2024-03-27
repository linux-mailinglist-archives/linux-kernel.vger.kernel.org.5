Return-Path: <linux-kernel+bounces-122117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7288F20B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A22B1C26E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812D53360;
	Wed, 27 Mar 2024 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cycSnOYF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC9153814;
	Wed, 27 Mar 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579921; cv=none; b=tcqLEhQ+BUQ5+iQRR+6GORy2J9WNWgQB4jq6sCUhdsm+2TYAimBhFV+P+ofagWoL1fpt2cH4selF46wxtRbEQ6eSe1ao5rwN+DHkmqV0fqpO8/X9bXGmjMtnGfgC1crFFD9Hb2ZTHNGDx55N+7ResZAcVHaSwoZAqIE40SaF8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579921; c=relaxed/simple;
	bh=4dKqvMz6d2W8NZgGdx/xyiuPz/8oQS2caUKeGMM634A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFX16GRyQLf8Di6NEyEb/Qa8eVDRXqUmibXnWn7fbFTgVqzJ+BCCPP5/frQ90d+wLYLR8fvqXO/1Vrt4EhqDi7LUW8E+lLcZTLF+n+wQ1ibtti9jAFmiN+DDN4NtoKPJdAMqwiMOUhS4sTCgUnf9T72sUHG1SyqXdtS8eY11ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cycSnOYF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711579918;
	bh=4dKqvMz6d2W8NZgGdx/xyiuPz/8oQS2caUKeGMM634A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cycSnOYFwQ20Mz2mz1Kkud/3Vy+/wpn2KIxWNaCZjmqATSIrTw+aerA+uXxySMQie
	 nzSNEUWGwtNPSWeXIFHjy9ghW9oVkzttyj8aRWTGIDggrghLFiTNdt6+W+bHtfbFtd
	 RS8YehfJJtZ9leWtbnQwfOEGMqbZZp8hYLpk/jjOqnLGhs9odLMwcgsaCDl9zZt2Po
	 lK8I3qcT9eIf68X4XvpG3yIe6PI7yNWfHiYFojt+pj08w5ngASxV80YZgPCWwZ8ReO
	 JGODuAlfDm4CH82iS3PnwVmNAXM0SHphDAMbAMklaw4P67qe9XnF4PF9RGsJYye88f
	 NAPL1yBwuTtBw==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B6C33782112;
	Wed, 27 Mar 2024 22:51:49 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 1/6] dt-bindings: reset: Define reset id used for HDMI Receiver
Date: Thu, 28 Mar 2024 04:20:52 +0530
Message-Id: <20240327225057.672304-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reset id used for HDMI Receiver in RK3588 SoCs

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v3 :-
  - Add an Acked-by

Changes in v2 :-
  - Move the dt-binding include file changes in a separate patch
  - Improve the subject and commit message description

 include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/include/dt-bindings/reset/rockchip,rk3588-cru.h
index d4264db2a07f..e2fe4bd5f7f0 100644
--- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
+++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
@@ -751,4 +751,6 @@
 #define SRST_P_TRNG_CHK			658
 #define SRST_TRNG_S			659
 
+#define SRST_A_HDMIRX_BIU		660
+
 #endif
-- 
2.39.2


