Return-Path: <linux-kernel+bounces-92383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44D1871F51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61971C24532
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469698564D;
	Tue,  5 Mar 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IRdF9bzc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2B85920;
	Tue,  5 Mar 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642277; cv=none; b=I8ExbYCPE0vJ9HsA04Wt0f4qbanvQHTDMfKWQfqNIKZ3gbC54zNT2MEAL/lptKEj/gqtFipi3pVFyWijatQvLo123YVTYMAbA4TS6qKxjMgoqsz/LvjRFpA54ZZZXhw3KvvNYEqQ+IzeR6xMzxRae36wwL5xHykdLF5sgVsmOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642277; c=relaxed/simple;
	bh=86J1Y70nbFomIcZR+wldbHnAg/1d9IQlH/UukIiYDyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnLsf8s5i+hZ9E9zyXKi84zrRbM6U5rlgHwWNdLOraiwahF1ezfRa/tnbXkv8DztKS5DD8vD143RHiS2fu7DGebEYmnk+EqZvlB6PMZjV1QQXKE8q6m44N8L60uEneBPREkYM8K3jLQNQsXfyryM4Y/aBkEvCsFqgZaexCHmOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IRdF9bzc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709642274;
	bh=86J1Y70nbFomIcZR+wldbHnAg/1d9IQlH/UukIiYDyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRdF9bzcM6ILlptiG/sYaf4wbKpaQ7+/bQnNc0+rXKYnMpD9vq/IPBd+7Cmv/i8rd
	 ZqSxxT8QIhJMvkgi64kqwdNgI20n23powjvHw1Isq32V/hW3suxe8NAXcwe5zi6wGA
	 mOHmXd34sdxNTh5erKzeY8nCuSgkoyTnkYp57cLUX8Ktopu0UqiuTH4WpK9mqXhe/Z
	 fj4wthmvMrqmRDZbwdmV/nMlDS/JOm9ivl6zf1OCT6LGbERjUmhv5l7Dc2LNhmtOI0
	 mo8+9Q1duBtBJUZd4rcQaZLVmLst5TtodnLmWqOkwyCKDpPrQ/840oz/+ji/hz4Lb4
	 ja17iNdq9t3ag==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9BF9E378020D;
	Tue,  5 Mar 2024 12:37:45 +0000 (UTC)
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
Subject: [PATCH v2 1/6] dt-bindings: reset: Define reset id used for HDMI Receiver
Date: Tue,  5 Mar 2024 18:06:43 +0530
Message-Id: <20240305123648.8847-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305123648.8847-1-shreeya.patel@collabora.com>
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reset id used for HDMI Receiver in RK3588 SoCs

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
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


