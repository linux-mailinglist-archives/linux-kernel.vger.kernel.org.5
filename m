Return-Path: <linux-kernel+bounces-97028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A622A87648F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4882838F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8C1EF03;
	Fri,  8 Mar 2024 12:52:27 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF321429E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902346; cv=none; b=hMz81ajxhy2HOSPimwhUtmjH7TKljGyoMw+kjOLiCRZckJ/8vPJivzJOgxMIh2zM5XQVoBa9IPUHiebw7+YqC029gam4ukGjOLTn8pdokEiu0zi0ZJZj7u0RY/ccEkBDoFMac8BPeqzLrAs/Z6thMbwa/ueLi/jlHCD79wCSCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902346; c=relaxed/simple;
	bh=XlOhwNLXVrKct8OH/oxJVQEEYWtbUzLjg60WCqrTM6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g5UriBdbbaWg8ZZqURCbsJetJtkw0B+Xf14YDkY37ybttMsQ1BvAx7G029ML4LIqILk+tD5AKUHaCFB+HS7xnwK5yMKka/RouZgwGzLm4SdQaSF9Gq8xyn1Rb3L/BY33+2aK7zqi7beYnGMVPs8yHWcPJndU8vqei0LmxuPZUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrmKC4vd3zMqB2L;
	Fri,  8 Mar 2024 13:52:15 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrmKB62vyzMpnPl;
	Fri,  8 Mar 2024 13:52:14 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/3] rockchip: small DTS fixes for RK3399 Puma
Date: Fri, 08 Mar 2024 13:52:07 +0100
Message-Id: <20240308-puma-diode-pu-v1-0-2b38457bcdc0@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPcJ62UC/x2MQQqAIBAAvxJ7TlDTiL4SHaxdaw9ZKEUg/j3pN
 nOYyZAoMiUYmwyRHk58hiqqbWDdXdhIMFYHLbWRnRzEdR9OIJ9IFYVC7Y21aqEeoTZXJM/v/5v
 mUj5PnP/3XwAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

There's a pull-up missing on a pin that is used as GPIO input for PCIe
which will make the diode/level-shifter not let voltage pass and thus
not allowing the state of the pin to change.

Also add the missing regulators for the PCIe PHY+connector though this
is purely cosmetic.

There's also a missing PU on the USB ID pin used as a GPIO input, so
let's add it for the same reasons as the one used for PCIe listed above.

Note there's a light dependency on
https://lore.kernel.org/linux-rockchip/43d84aa9-ce0f-406e-82ac-2a691264ee23@theobroma-systems.com/T/#ma0499cbc5e5c20f1a4c6b8452baa2d296abe2d0d
to prevent a git conflict for the maintainer(s).

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (3):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma
      arm64: dts: rockchip: add regulators for PCIe on RK3399 Puma Haikou

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 33 +++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: 370e52abbf8306f09b0022995ad7ccdff3a834bb
change-id: 20240308-puma-diode-pu-1d2f4551be6d

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


