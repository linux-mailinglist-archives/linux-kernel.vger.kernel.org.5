Return-Path: <linux-kernel+bounces-89725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73A86F4BC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E22833F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B086BE6F;
	Sun,  3 Mar 2024 12:14:21 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A499BE4A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468061; cv=none; b=hhVkT/2ZDrPIvK1uPG3Re8mqS5s8fda3IF2GkhDrDPDPLlrV17e6fHywFoj1+Yhni4xLb8Iaj0RbyfoCLE1eDL/FDqWqPOBhBxz92E5pbyxPD+2B7c0Pp769cXzHYQT9wlB16vizSOLUxfy857LMkuXNElYLVMFmKavl6uLFMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468061; c=relaxed/simple;
	bh=ueeAezcywm5cI/6F2f6lA2+yuhtrVFvftQ3aZWTbDfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud1YxLb0PQUe8SDZZqnCIxvC+n8JHM4CnwZUEkm/CxYINNYxjLd52UWWFUHzz0jFbdGc/Grw3bk2P7JfEsjzN4sazgH8icg6LzL0OoG1sXU6Y3JL+23dY5YOOS5ludQHLv8KiLFsL/OXrLK1H1E9pAFM6PdQ28PBvhPOsLe5pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 8b2a64d2-d957-11ee-b972-005056bdfda7;
	Sun, 03 Mar 2024 14:14:11 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations out of lock
Date: Sun,  3 Mar 2024 14:14:10 +0200
Message-ID: <20240303121410.240761-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to calculate masks under the lock taken.
Move them out of it.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/clk/clk-fractional-divider.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index a0178182fc72..da057172cc90 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -195,14 +195,14 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 		n--;
 	}
 
+	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
+	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
 		__acquire(fd->lock);
 
-	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
-	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
-
 	val = clk_fd_readl(fd);
 	val &= ~(mmask | nmask);
 	val |= (m << fd->mshift) | (n << fd->nshift);
-- 
2.44.0


