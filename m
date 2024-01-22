Return-Path: <linux-kernel+bounces-34129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04DF83740B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF3A1F280B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8207A47A72;
	Mon, 22 Jan 2024 20:40:45 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4047A53;
	Mon, 22 Jan 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956045; cv=none; b=I4zcP04Sy2lKyrs8kPw0xmFzE3aszcoLu1MpXZuKeFS5WhTAVHyi0utibevmuO6egU2x0WX1hOrpxldltjEneT3oexjYpbdn9q+FQvt1yhT9OlqDOBgm6mIjsimRlyasY4Cqusij/1jnEOrseqdPD5dK4GpT/VZ7GGK3DHAiZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956045; c=relaxed/simple;
	bh=bAPGFNo77+D9kNCksfSqKSycd65DXYyf8t7nE08TAF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tTwujwy2xOJRUpq4iubghjK2rT1ZvYvh6yUsfF9WjEUL8YuDucwQAq3I4A4AV0QSx0jkaSSVPxnwBowgr8pJPFiDhmo56UTrMPOD6aj44QEreJDurYAdLqd5yl+a6LSSB3F2jb6X8CUPYVR2uGnKKZnnmYddxZf5xQER8k7t90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 79E38DDADBF; Mon, 22 Jan 2024 21:35:14 +0100 (CET)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	John Clark <inindev@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Andy Yan <andy.yan@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 0/2] Add the thermal zones of the rk3588 to its dts
Date: Mon, 22 Jan 2024 21:34:56 +0100
Message-ID: <20240122203502.3311520-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver got added back in 45d7b3867a5cabb97fc31f16122cda8540c3a30c,
but the dts never got updated, so here it is!

I’ve added it to the rk3588s because that’s where most of the
definitions are, but I’ve only tested on a rk3588 so maybe there are
subtle changes.

The rk3588 TRM also documents slightly different values (in part 1
section 14.5.3) than the driver, but I’ve left the values alone since I
have no way to determine which one is (more) correct.

Only the CPU is properly mapped, as neither the GPU nor the NPU have
been added to the dts for now, I’ve left some TODOs there.

All of the thermal zones report almost the same value on my rock-5b
board, I’m not sure if this is due to a programming error or if this is
to be expected.  For instance, after running for a while, all of the
zones report 44384 m℃, despite having used neither the GPU nor the NPU.

Additionally, the alert and crit temperatures have been arbitrarily
chosen based on other dts files, not based on any knowledge of the
thermal behaviours of this specific SoC.

Emmanuel Gil Peyrot (2):
  arm64: dts: rockchip: Add the rk3588 thermal zones
  arm64: dts: rockchip: Enable the tsadc on Rock-5B

 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 181 ++++++++++++++++++
 2 files changed, 185 insertions(+)

-- 
2.43.0


