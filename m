Return-Path: <linux-kernel+bounces-119731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7B88CC81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C046309F01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7913CC69;
	Tue, 26 Mar 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5jhoRbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF30129E88;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479444; cv=none; b=RqQNu0uJUhxX0Cow/3E5ovLDp2G18jPh/vu8xwnEgsWy7+qH0iofu4RHIJtY4IsQq4zF26EEazWiGxVx4vqTJGqUK9CSTBz1MhzTmGvLygi4atR5dgE5lY5sujNhYUUraAvCKtXVsRfq84zSzAo7wSF7FtuD+p8eonWtE/JZxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479444; c=relaxed/simple;
	bh=E43foxj+UySf1m9AXwAy4EcKz2179uEogLNPhzYtuqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCD6/eWO7ibwJmFPz847GQzgiL8/NDbKhTF3D0sYlacVFyN8GAcJcdHWX0HAZlBnnVv5WKJqNBUaZmlbeYKY5NUcWRSV4MWescs547swNAebfHK2fr9ET1IIzMskZYLBWKeFL5JgaHqUjN2wel7oOqpWeuKuU1tHRbo7t6vO+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5jhoRbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB062C433C7;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711479443;
	bh=E43foxj+UySf1m9AXwAy4EcKz2179uEogLNPhzYtuqU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R5jhoRbNjNNZ8szwWvKMLlX9tX/YyyKDNyfAkAe32TdMq1uo6cOiS52xphFt+JGZH
	 omO2+t8Sa8P7vTUxVswN15s5zgc++QAdnLjbQbFK17bk3adqXKuG8i2y1pGAjoflt8
	 bPkb7f4M32A6sVrGV1Jk7AzBUq88Cz/k/moNAhnD+CMS6EUmqUv6CK2st1YRxxM0gQ
	 weFAdl0pEx4IB+K33U8U++YrMd574AXYvpBX/yphhQL41scrnl1YU0Vr55hLMXt1kv
	 OzWZPd7IdJCQOGZ6orl9TsiICs8Ax5r3Fx0sTvq9FHssSIk7ppsN3PxbCH0n82HsYS
	 msmQ9sOwiNILg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14FCD11DF;
	Tue, 26 Mar 2024 18:57:23 +0000 (UTC)
From: Folker Schwesinger via B4 Relay <devnull+dev.folker-schwesinger.de@kernel.org>
Subject: [PATCH 0/3] phy: rockchip: emmc: Enable internal strobe pull-down
 by default
Date: Tue, 26 Mar 2024 19:54:34 +0100
Message-Id: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsZA2YC/x3NTQqDMBBA4avIrB3QRKX0KsVFfiY6NCQy0bYg3
 r3B5bd574RCwlTg2Zwg9OHCOVX0bQNuNWkhZF8NqlNDp9WE8kZPwRxxR0rGRsKyS7aE2xGjz9+
 EWo+Te7jQ2yFA7WxCgX/34zVf1x+9MGmIcwAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, 
 Alban Browaeys <alban.browaeys@gmail.com>, 
 Doug Anderson <dianders@chromium.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Jensen Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Folker Schwesinger <dev@folker-schwesinger.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969;
 i=dev@folker-schwesinger.de; h=from:subject:message-id;
 bh=E43foxj+UySf1m9AXwAy4EcKz2179uEogLNPhzYtuqU=;
 b=owGbwMvMwCXG5FBoZNu1u5bxtFoSQxqzVPcG4XrhRdxbmas+173ql3lw5G3uxq5OPd6sDzq9m
 U3MsX86SlkYxLgYZMUUWVjzMrYwZ5Yvte76+RpmDisTyBAGLk4BmMgeNoY/nM+WhP5tVnq2wjs6
 kPnsU9EmyWUTV69YUBTcenfrjbKcfoZ/RmG52hezVCr2HS/90XD65CTtk8kWC3YYC4SuPKa2tfc
 NJwA=
X-Developer-Key: i=dev@folker-schwesinger.de; a=openpgp;
 fpr=056E68B4036977A53B8AF9EB024071323D8ABB7D
X-Endpoint-Received: by B4 Relay for dev@folker-schwesinger.de/default with
 auth_id=144
X-Original-From: Folker Schwesinger <dev@folker-schwesinger.de>
Reply-To: dev@folker-schwesinger.de

Various RK3399 boards, including the Rock Pi 4 series, the NanoPi 4
series and possibly others showed instabilities with some eMMC modules
when operating in HS400 mode [1]. Later, a missing pull-down resistor on
the eMMC strobe line was identified as the root cause of these
instabilities [2].

This series changes the Rockchip eMMC PHY driver to enable the
internal pull-down for the strobe line by default, effectively
restoring the behavior of the vendor kernel [3].
Addressing the problem in the driver avoids fix-ups in individual
board DTs.

As this change makes the optional DT property enable-strobe-pulldown
obsolete, it is replaced by a new property disable-strobe-pulldown,
that, when used, allows to disable the internal pull-down.

While at it, the enable-strobe-pulldown property was removed from the
NanoPi4 series DTS (which was the only user of the property in the kernel).

[1]: https://lore.kernel.org/all/20230705144255.115299-1-chris.obbard@collabora.com/
[2]: https://lore.kernel.org/all/20220822074139.3810-1-jensenhuang@friendlyarm.com/
[3]: https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/phy/rockchip/phy-rockchip-emmc.c#L310

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
Folker Schwesinger (3):
      phy: rockchip: emmc: Enable pulldown for strobe line
      devicetree: phy: rockchip-emmc: Document changed strobe-pulldown property
      arm64: dts: rockchip: Remove enable-strobe-pulldown for NanoPi4 boards

 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi            | 1 -
 drivers/phy/rockchip/phy-rockchip-emmc.c                    | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240326-rk-default-enable-strobe-pulldown-3356c8cf1b4f

Best regards,
-- 
Folker Schwesinger <dev@folker-schwesinger.de>



