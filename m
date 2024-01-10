Return-Path: <linux-kernel+bounces-22288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E37829BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5D7284AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF1495D5;
	Wed, 10 Jan 2024 13:56:31 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDED48CCE;
	Wed, 10 Jan 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id C7B1B18692DF;
	Wed, 10 Jan 2024 16:46:34 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gVFb5WEP5ieC; Wed, 10 Jan 2024 16:46:34 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 7D93F18692D1;
	Wed, 10 Jan 2024 16:46:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lEysMdup5VIp; Wed, 10 Jan 2024 16:46:34 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.234.199])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 4CE9C18659DD;
	Wed, 10 Jan 2024 16:46:33 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Nishanth Menon <nm@ti.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] clk: keystone: sci-clk: check devm_kmalloc_array() return value
Date: Wed, 10 Jan 2024 16:46:21 +0300
Message-Id: <20240110134621.17209-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

devm_kmalloc_array() may return NULL, so
check return value to avoid null pointer
dereferencing

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically=
 probing clocks")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/clk/keystone/sci-clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-cl=
k.c
index 35fe197dd303..a2fa24e4f88a 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -459,6 +459,9 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_=
provider *provider)
 			tmp_clks =3D devm_kmalloc_array(dev, max_clks + 64,
 						      sizeof(sci_clk),
 						      GFP_KERNEL);
+			if (!tmp_clks)
+				return -ENOMEM;
+
 			memcpy(tmp_clks, clks, max_clks * sizeof(sci_clk));
 			if (max_clks)
 				devm_kfree(dev, clks);
--=20
2.30.2


