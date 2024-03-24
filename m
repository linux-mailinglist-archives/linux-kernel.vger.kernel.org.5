Return-Path: <linux-kernel+bounces-115241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC616888DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2B1F248B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FD1CD604;
	Mon, 25 Mar 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya8gl1g/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD8184F0C;
	Sun, 24 Mar 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324340; cv=none; b=MVsPttx+Zr+6n91nA8yHkPtWZKhQ0riIXVTFj1I8FC+b4QQifhWUyo3D0IbVc5qQrsPMD9NBqLKjbVs6tQr5Y8U9unY6S8MeYxqVRUH0JvWEnAP9Ym63Ce9xIjKyAfjzHrFpbwdSu76r5PZ9QgvaO/3pq4deN3QK6RpXf08SToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324340; c=relaxed/simple;
	bh=Sti5y1M+NCqNbLP1ipleqJZwYr8eyzP543f+H+/2zBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0ruY4MJbQuMNJdwIeBWb1dHu9Ojw6nguBcpNAFG8fT60/96vKOOiwfPJFyXCimXKLNCcP1rs9oEJjzOVLwyPzwWl1wiSMxr40vqAKvJekW7GYdHuGc2x56FIANl2YzrKiJZdWzThBU7uucgot1ZGWarwlQvVGgH+YXlrPZ/DAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya8gl1g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882BAC43399;
	Sun, 24 Mar 2024 23:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324339;
	bh=Sti5y1M+NCqNbLP1ipleqJZwYr8eyzP543f+H+/2zBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ya8gl1g/meQBUDg+BTOsOL8zdnJNg8yKRXM2iCf7npBTqflizQ4nCnFdaJEz9d2OZ
	 0EiIwQ16aBDzllcTpUrShrfs7CnNLSfgStY0O7LFvHdxJ7aJLWa2xmefa0vCwR0TM7
	 f1KsWGGV5jOJKL7gUWHAR6JvXy6hYiGWl7MpR1fOsYlw2Cg2MnlkhuwyI3yOLvhpVs
	 ag/G8eKSVktHEssfo4ENFkxS6sJa2CIq5Qrzu+l4jS69F1X3zkyoaBFTKSNWnesaO0
	 V1BBHWPO9xsYa+olEqN/0qXCCsm15kP2//295Z9DeM9HxndO0LtFXy+Wyx6O79VlGG
	 iIjrccBbAUdbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/148] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:49:33 -0400
Message-ID: <20240324235012.1356413-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit d2b0680cf3b05490b579e71b0df6e07451977745 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: 45330bb43421 ("mfd: syscon: Allow property as NULL in syscon_regmap_lookup_by_phandle")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-2-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/syscon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b6d05cd934e66..d73869889166f 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -211,7 +211,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
-- 
2.43.0


