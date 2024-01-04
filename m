Return-Path: <linux-kernel+bounces-17343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7493824BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302F5287434
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74352D61C;
	Thu,  4 Jan 2024 23:57:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97182D60A;
	Thu,  4 Jan 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9AC41206D8;
	Fri,  5 Jan 2024 00:57:28 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: m_can: remove redundant check for pm_clock_support
Date: Fri,  5 Jan 2024 00:57:23 +0100
Message-Id: <20240104235723.46931-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

m_can_clk_start() already skip starting the clock when
clock support is disabled, remove the redundant check in
m_can_class_register().

This also solves the imbalance with m_can_clk_stop() that is called
afterward in the same function before the return.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
I spotted the issue while debugging some other part of the code,
the patch is only compile-tested.
---
 drivers/net/can/m_can/m_can.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..bd1d1626684d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2056,11 +2056,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 {
 	int ret;
 
-	if (cdev->pm_clock_support) {
-		ret = m_can_clk_start(cdev);
-		if (ret)
-			return ret;
-	}
+	ret = m_can_clk_start(cdev);
+	if (ret)
+		return ret;
 
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
-- 
2.39.2


