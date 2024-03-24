Return-Path: <linux-kernel+bounces-116349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC45889E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA1F2A5894
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE253D9BA3;
	Mon, 25 Mar 2024 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbF28nGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237122F500;
	Sun, 24 Mar 2024 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324374; cv=none; b=cqizvOu/Ejw1NO2wo3ssKqNDtvw3Xsjyr/ievLKVPIGl1QmIwzDYfhjs9lejnAymv7vzZIOKKMUYYctK6MiKQxFazysFNIemR8ytS2NMVdjiGonnnMgfRKLURxuAmnIWvxdWq1X7sx4K98+agRq7Xg7nW7jPHfQvnWYLLikZzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324374; c=relaxed/simple;
	bh=wzcLOFErmxgbR3bL6+t3Pc8OhoA272ipSkVOSgI3vBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaEjE4dfIldJK1BH0APA0D5+AIdK1JYYz9iGF//IWX8jo3IJv+CnSs/Po53aRfDI8p8Tv4dBZ+1uaYBxzrQ1cI4Dtb5eQlSmWoAeRKCqyhO4xwRnTmcdHcpaeIhtZx5RcChciMSHhSnccAfv6lsma3XVtdzQXKqqDsMBFO6tMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbF28nGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06E8C43390;
	Sun, 24 Mar 2024 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324373;
	bh=wzcLOFErmxgbR3bL6+t3Pc8OhoA272ipSkVOSgI3vBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbF28nGhCuR3MY2+7xLBYV7jhjWPcvJbuKMuQD4TULYie8RYZMJMxF4IiFRLI+wTm
	 CjjKnbEFgbu4kZJfHbxpVgt6yVd9Z8eFwlyeyxmJpLd3SJFX5WZlp4E2UQCnm8pteE
	 c1CxsWU1s4UD9gwTd/ofnKO9j3dGHXwOdwaQEmzmepLqxtvVo+sUbDVjhqBdHQAbh2
	 HSeY1cVantcGmU2KZM7LKicvUAp1mali/6SM7ZyjEFbz/iouqZtWkZzMEOiMCIeYdf
	 /ZsRbPnOMy8ahjtzhroJeEQtoKJmX4tL3u5U6ijaYXntjH32MuvJoENJfD1d+SV1Rx
	 WUCKe4lLa5C5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/148] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:50:03 -0400
Message-ID: <20240324235012.1356413-140-sashal@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 73b5a5c00be39e23b194bad10e1ea8bb73eee176 ]

It seems a copy&paste mistake that suspend callback removes the GPIO
device. There is no counterpart of this action, means once suspended
there is no more GPIO device available untile full unbind-bind cycle
is performed. Remove suspicious GPIO device removal in suspend.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240219150627.2101198-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 195f58c5b477f..319737919381d 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -553,6 +553,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -567,10 +568,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
 
-	/* Ensure that every init quirk is properly torn down */
-	if (priv->board->exit)
-		priv->board->exit(pcidev);
-
 	return 0;
 }
 
-- 
2.43.0


