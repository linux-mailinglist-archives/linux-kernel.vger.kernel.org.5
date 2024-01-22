Return-Path: <linux-kernel+bounces-32831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626F8360AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26715281850
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE933D992;
	Mon, 22 Jan 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXbOocbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCA3F8C7;
	Mon, 22 Jan 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921488; cv=none; b=taFOFkYI5oc/hvIzlwxQ08q6bg/OclHW34SWWfUnp8QtROJWRbf7G0LPTgKo9MLUL56ng1acNPZ8mXXUPYswHLjYZLnonpfs9AwrcptVTKAWUQdtPUkE/QcQ+oQI/O5M4mshoVXUxQ7EXe21USJcmARebqJcJmFkZ98f0jGs1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921488; c=relaxed/simple;
	bh=/HUcPJ1BjPv5GMtQ1xgKekTdrhD9fVd1hk++uDzgCqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO+HY94d/gm7scp85Mons5NQN7qIi7lCSv1VxAJATRN0E3N7DSHnzMdqNKM5M1RfRoL/A7M9CPkH+WQ42R5YJF9D2xaQjU5cRc6UzZhRVpUKRCh1TJhGc4Bd2EYmPxsaMN1843xQQ3clgKx7feZ4k4OXIPTx8n8aevS/QTCusbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXbOocbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890A8C433F1;
	Mon, 22 Jan 2024 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921488;
	bh=/HUcPJ1BjPv5GMtQ1xgKekTdrhD9fVd1hk++uDzgCqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXbOocbLT0ABXMV2bnERsN9uywnmn32QE1DxP0RPGKVWf8/czfcvQdQsXJlpgw3ca
	 31LnHSn/3LN0BOPake745sz7M5VbvfBkfzWgF35j3pHzM3A+zJAeQiywh2v+n+dcHe
	 VYxdUNsWrsyqxLyNwt172Kbg6KwoAdjvvcfFwbTYywLVH1nGeI6fCQV7sIQuoVB4pZ
	 EMuOjN1WBzH86YiQpxGtdzO6XEYj/afiTBkXxWbvJhwRSfBjB6nNakU6Kr8AsKKYJC
	 ENNakA+0bkF+/pROEgWKv49RDHnRWCSnSFGU+EN0d5qy2cWOVpOP6Nq5jFkgYf+dAY
	 PWP/RL22+7V/g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 22/47] tty: vt: remove checks for count in consw::con_clear() implementations
Date: Mon, 22 Jan 2024 12:03:36 +0100
Message-ID: <20240122110401.7289-23-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'count' in consw::con_clear() is guaranteed to be positive. csi_X() (the
only caller) takes the minimum of the vc parameter (which is at least 1)
and count of characters till the end of the line. The latter is computed
as a subtraction of vc->vc_cols (count) and vc->state.x (offset). So for
the worst case, full line, it is 1.

Therefore, there is no point in checking zero or negative values (width
is now unsigned anyway).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/video/console/mdacon.c | 3 ---
 drivers/video/console/sticon.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 1ddbb6cd5b0c..2ff2c9394d40 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -448,9 +448,6 @@ static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
 	u16 *dest = mda_addr(x, y);
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
-	if (width <= 0)
-		return;
-
 	scr_memsetw(dest, eattr, width * 2);
 }
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index d99c2a659bfd..b1d972d9a31c 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -303,9 +303,6 @@ static void sticon_deinit(struct vc_data *c)
 static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
 			 unsigned int width)
 {
-    if (!width)
-	return;
-
     sti_clear(sticon_sti, sy, sx, 1, width,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
-- 
2.43.0


