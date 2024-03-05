Return-Path: <linux-kernel+bounces-92388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD9871F66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5678F1C248F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0F86128;
	Tue,  5 Mar 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c9DEEfbJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7485920;
	Tue,  5 Mar 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642336; cv=none; b=IKZxQQxC6o73kCJBe7MIqsNheSxk22yD6gk7k2lYDP0udKf1sQ7bKsDKZjc3qDh6mUTu5H7MY91Bl58cRXwBwbGEtekDHhjowKlON0c6vPinfVYyHfG+Tfn8ILgq09f3Lrn6u4MV7p24paGGWscKoafAUShv0zSeoZ8oVq7p/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642336; c=relaxed/simple;
	bh=VwkM35Jda0C3h7EKsFxBVHx+9GeS6C01tG+KewTTe5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWbbDG0vl2Ltvg8JQHdBctIUybZEQB+p6Q7qqDjri7Qr2wJEekqQcu6emgZMhxl1QbjhiqimAmqUcAqIZ2rPRxQxN2TxUjveXxlCLiBLwUXnI3mRG8eq3jd3fc89mfFNTLangwkdBZwbNFAA6pX3g6djXQqGBZ/Cyxl2rh8wOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c9DEEfbJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709642333;
	bh=VwkM35Jda0C3h7EKsFxBVHx+9GeS6C01tG+KewTTe5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9DEEfbJVYKRbFyOJYn8GW/3eer+MVMTZCVghdzEDNmyMtuzEmZ5djstfXjQs9qSn
	 1PsF1+WJNA2ujD0EReK4D1MKvljfQBIhmwNDF/Ta9rmHFUqNp55E02eIW2SFunNdkS
	 aSyKEuzmnbPNngDhbo8XgZ1kbLQRybQh3l6pdABCsjSgVEFBcc2YOjJOJ8ZnsGwx8T
	 vHV5egg2/g6TiGoRIGY2qQJxPZEtDWP48Ws+idTnZ46EJf7z+U1Rdo2wgQiEQ5QS4E
	 EU2gnCms6fcWUxt9nxD7gARz+Wvo1S1zFMbieEKVNL2+pU7bKgi+E5xKT23DTEsPn0
	 2a8cHaDFB7CVQ==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D182437820F2;
	Tue,  5 Mar 2024 12:38:45 +0000 (UTC)
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
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Synopsys DesignWare HDMI RX Driver
Date: Tue,  5 Mar 2024 18:06:48 +0530
Message-Id: <20240305123648.8847-7-shreeya.patel@collabora.com>
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

Add an entry for Synopsys DesignWare HDMI Receiver Controller
Driver.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v2 :-
  - Add a patch for MAINTAINERS file changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 897fbf1b0701..26ff6a1cb24a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21427,6 +21427,14 @@ F:	drivers/net/pcs/pcs-xpcs.c
 F:	drivers/net/pcs/pcs-xpcs.h
 F:	include/linux/pcs/pcs-xpcs.h
 
+SYNOPSYS DESIGNWARE HDMI RX CONTROLLER DRIVER
+M:	Shreeya Patel <shreeya.patel@collabora.com
+L:	linux-media@vger.kernel.org
+L:	kernel@collabora.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
+F:	drivers/media/platform/synopsys/hdmirx/*
+
 SYNOPSYS DESIGNWARE I2C DRIVER
 M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-- 
2.39.2


