Return-Path: <linux-kernel+bounces-117902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEF88B118
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CCC29AE76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B745BF0;
	Mon, 25 Mar 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RBXNiGzM"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FB45023
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397583; cv=none; b=cAZ57aGijx0tM+9A6IgHLyyNdVCAHM78EdAbgEjqiNxKQJ5zmfKang4VypJcpUMkj9VNg8hFXtTGx0Ql3s4GQ0qd9+HhNa2jOiDvLRoRizAdsxLBOwtxRWdYT7NTJxVvZdkjOZBwY1SIbgcFt8RlQr9t9NCvUH9zwt7aCkjtvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397583; c=relaxed/simple;
	bh=krJixvHaEzKugH9Yh14vF7eWhxkAI5nrrUEL3NK/SBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YACcIDpNLzz1bAaVMd7HPZdMAMAOwkIRZ1IL1DCP6Ahe9Eht0FuWZEcNX1pIBjH5Wd6fkvjLpT4mvXe2ClQug0sBYQe5rJx8y1sEuza1s3fW3ZsQGb5N29dgREfyzHIrtFfwMYlP19X8jWm62BQWsZwx4BzpKEDUX1NGf3xDd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RBXNiGzM; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [31.173.84.243])
	by mail.ispras.ru (Postfix) with ESMTPSA id BF5D640AE01D;
	Mon, 25 Mar 2024 20:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BF5D640AE01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711397573;
	bh=S/22bUxOu8bhnHQdA0DpFckF5vvWg5SfT+9w20uPqdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBXNiGzM+Fhyg5XguFUyjrUeumCcdp9Z6yFbk+NZ0d4lOm1tXhF8kRnBO8G7ihRXR
	 9zYZEcOYfbNS0KF1MZjSh8kcSXuVJv6teAfLT/DCI0hi8ZL9QpSOwwVpM7hiC+oLME
	 N9qElgdlyyYViWa6TkKPwtXB2/2TfylzQh2QeMgo=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v2 1/2] phy: marvell: a3700-comphy: Fix out of bounds read
Date: Mon, 25 Mar 2024 23:12:49 +0300
Message-ID: <20240325201254.54445-2-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325201254.54445-1-m.kobuk@ispras.ru>
References: <20240325201254.54445-1-m.kobuk@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an out of bounds read access of 'gbe_phy_init_fix[fix_idx].addr'
every iteration after 'fix_idx' reaches 'ARRAY_SIZE(gbe_phy_init_fix)'.

Make sure 'gbe_phy_init[addr]' is used when all elements of
'gbe_phy_init_fix' array are handled.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 41162d7228c9..68710ad1ad70 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -611,11 +611,12 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 		 * comparison to 3.125 Gbps values. These register values are
 		 * stored in "gbe_phy_init_fix" array.
 		 */
-		if (!is_1gbps && gbe_phy_init_fix[fix_idx].addr == addr) {
+		if (!is_1gbps &&
+		    fix_idx < ARRAY_SIZE(gbe_phy_init_fix) &&
+		    gbe_phy_init_fix[fix_idx].addr == addr) {
 			/* Use new value */
 			val = gbe_phy_init_fix[fix_idx].value;
-			if (fix_idx < ARRAY_SIZE(gbe_phy_init_fix))
-				fix_idx++;
+			fix_idx++;
 		} else {
 			val = gbe_phy_init[addr];
 		}
-- 
2.44.0


