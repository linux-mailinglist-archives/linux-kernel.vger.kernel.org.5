Return-Path: <linux-kernel+bounces-144102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813218A41CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227071F212A9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D832C6AF;
	Sun, 14 Apr 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="szNgOXgL"
Received: from msa.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C71CD06;
	Sun, 14 Apr 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713090143; cv=none; b=nh5GVhCJvGoPp71gLRLUjxGTRFx2X3S5LlmjMeumqK9B2DFFMvWK1yBeurLbm+R+v5OTnYJtobqVKcXq2OsDjlxNArN90LtvXdXLuGjmaD8Z8naRYxa7gKrBJrstpq+3QF6fKNCrT57CMmNNPC59pCI8i421qU0EWbxJU4ebeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713090143; c=relaxed/simple;
	bh=3KjtX7RrGt+OMiORGrDzde69KGZb/8DuTUkR13Mu9uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pL7Qwt/RMsKAT1LWhvl+Scg2PC6y+FkbMuUbijYJyqMAR2VgtvpOOjAo18DoBJu1RRH4pX8bKHQ2FGn17As56tNRH0POFXTzSpxbmrqqnwzXAq23d4R1p9mIw8QpNQgy3XLWqtKMH1PH1XDZUFwQkqEuLUyrnltGhfyt1biKlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=szNgOXgL; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vwr1rPDFEVYR4vwr1rSj5Z; Sun, 14 Apr 2024 12:12:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713089576;
	bh=q4WeoEWKUV095yOrt9z2s5h7VxFHEIKdZezhJpgbprM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=szNgOXgL+vnUflzWkfBGajoO6THQTybLp1hgg7iQEv9MWMfzouYbcy76sJMe39Ssf
	 eVRO64xLozsw1zGDD0B1wPLBsMTWjjG9sJoFtvo0jVm4tZdPVClevY44t/Dqmk9nMg
	 2jySCi12BZ2/Mn3StvBfMI/mtnzKissla3pGfgYLUFJTbdsfYyo1XNix84PCjGYrRy
	 DSfZCTQpgHbZzHMwT8nCJN5hoxWmRVCZxenKVChh58ZH7kWHIJbuke5/wtwTOor7Fu
	 HbotJ7fM3WExjJNm90p3hHmCz/onC9Kh9DIY9U6Y3KJmwDcCi+9S2wcQF5H8/4wY21
	 mCYx91zXAFk9w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 12:12:56 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: akpm@linux-foundation.org,
	Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND] mux: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Apr 2024 12:12:52 +0200
Message-ID: <f82e013abe4c71f1c7d06819f96472f298acdcf3.1713089554.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch has been sent about 3 months ago [1].
A gentle reminder has been sent 1 month later [2].

Neither one got any reply.

So, I'm adding Andrew Morton in To:, in order to help in the merge process.

Context:
=======
All patches to remove the ida_simple API have been sent.
Matthew Wilcox seems happy with the on going work. (see [3])

Based on next-20240412
$git grep ida_simple_get | wc -l
25

Based on next-20240220
$git grep ida_simple_get | wc -l
36

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/727714bdfcd69d21e7f2a0c5c7426fcb70439b91.1702228605.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/9edc26e9-4f31-496a-969d-0edc33ef6f01@wanadoo.fr/
[3]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
---
 drivers/mux/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 775816112932..78c0022697ec 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -64,7 +64,7 @@ static void mux_chip_release(struct device *dev)
 {
 	struct mux_chip *mux_chip = to_mux_chip(dev);
 
-	ida_simple_remove(&mux_ida, mux_chip->id);
+	ida_free(&mux_ida, mux_chip->id);
 	kfree(mux_chip);
 }
 
@@ -111,7 +111,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 	mux_chip->dev.of_node = dev->of_node;
 	dev_set_drvdata(&mux_chip->dev, mux_chip);
 
-	mux_chip->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
+	mux_chip->id = ida_alloc(&mux_ida, GFP_KERNEL);
 	if (mux_chip->id < 0) {
 		int err = mux_chip->id;
 
-- 
2.44.0


