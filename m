Return-Path: <linux-kernel+bounces-97552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883A876BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794411C2186C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A84249E5;
	Fri,  8 Mar 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RQQeO/Wk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A055D75D;
	Fri,  8 Mar 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929814; cv=none; b=FhBTa4HhOQKMjWG6ccyCz5BBDB2Tj49a7akBD0e8oditMJOeWqKfmN4RXYIk5mCOX2NFXISsP4Wn8SJSKc32ks1hmNs5ceFcZiOAWCvMbIRuS/GSK3R0M/wXW2p78GU0k5AlzGeBIztoWWT3/Xsr2ET9HXkPywgaTwMmUh73vdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929814; c=relaxed/simple;
	bh=/adHs8UdVF6eIv76YbhCdGPFqVNfYolXsQeI4oZE9uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N+3MqlCrSlHy1Uc52Z02W3MwiB7z4jQaNx+YwMNYb7Ladhny2L7o5UBg51Ns6RQLqhcBB0bZgqmE65i5Rp6LkNb4jNGL5P9qfPw2qPWbS5NNfeUIMSSRF3j0WZZXYzeXFOpgZ1yYv8E2rzGdUQNEcs6pOkaMq7hfNb5bLpXWUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RQQeO/Wk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709929809;
	bh=/adHs8UdVF6eIv76YbhCdGPFqVNfYolXsQeI4oZE9uw=;
	h=From:Date:Subject:To:Cc:From;
	b=RQQeO/Wkn6o2TdtidpJsJiobZy7eLnnr6sKKmHgzHO0Zb0Y+A4plHRqg1EgRL3PFj
	 1ekGdr53uZC0Lhxg5V9x+62b0f/NLHyZJ8MPseS6h5zrlcfTMzHha3PF03vly4T9zG
	 qfEEjmwO+SEZJSFdkrH4kiC4qy+dOSmZ5WHZRAHKe1DKAqnwvPHrS9s/KcdjDMK5wS
	 4vcohAKqFfITslM8mP63r8EbsN74W8TiDR348XfO2R8mBGH2ABeB/WDtcIzLTHMAqB
	 F4owS2OSZB8I0Nq4d3MMZ/w47OVX+HAZfIxs0WnVnncMPpw5o1HDUiAVz87CWA5IJU
	 WfT1iTxJzUSjw==
Received: from [192.168.1.26] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A09237820F2;
	Fri,  8 Mar 2024 20:30:07 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 08 Mar 2024 15:29:56 -0500
Subject: [PATCH] clk: mediatek: pllfh: Don't log error for missing fhctl
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-mtk-fhctl-no-node-error-v1-1-51e446eb149a@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEN162UC/x2MSQqAMAwAvyI5G6gLVP2KeNA21aC2kooI4t8tw
 lzmMPNAJGGK0GUPCF0cOfgkRZ6BWUY/E7JNDqUqa1WpBvdzRbeYc0MfEpaQRIKgVa7Rk65bqw2
 k+hByfP/nfnjfD2fV3KxpAAAA
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Johnson Wang <johnson.wang@mediatek.com>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Support for fhctl clocks in apmixedsys was introduced at a later point
and to this moment only one mt6795 based platform has a fhctl DT node
present. Therefore the fhctl support in apmixedsys should be seen as
optional and not cause an error when it is missing.

Change the message's log level to warning. The warning level is chosen
so that it will still alert the fact that fhctl support might be
unintentionally missing, but without implying that this is necessarily
an issue.

Even if the FHCTL DT nodes are added to all current platforms moving
forward, since those changes won't be backported, this ensures stable
kernel releases won't have live with this error.

Fixes: d7964de8a8ea ("clk: mediatek: Add new clock driver to handle FHCTL hardware")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/clk/mediatek/clk-pllfh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index 3a2b3f90be25..094ec8a26d66 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -68,7 +68,7 @@ void fhctl_parse_dt(const u8 *compatible_node, struct mtk_pllfh_data *pllfhs,
 
 	node = of_find_compatible_node(NULL, NULL, compatible_node);
 	if (!node) {
-		pr_err("cannot find \"%s\"\n", compatible_node);
+		pr_warn("cannot find \"%s\"\n", compatible_node);
 		return;
 	}
 

---
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240308-mtk-fhctl-no-node-error-d0f87b749d7c

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


