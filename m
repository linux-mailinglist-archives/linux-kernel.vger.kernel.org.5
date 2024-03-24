Return-Path: <linux-kernel+bounces-115033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9009888CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260BD1C2A1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3061E2EC085;
	Mon, 25 Mar 2024 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/CQGL5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279D17D252;
	Sun, 24 Mar 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323838; cv=none; b=bIPt9vGjn5Dec2oHqroq6KfQFd2mRimGf8hZCHswP97bHAc0PcFn3ekEXbQbkkH97v6ItfeqlNQEp0HC0l8ZrtggL7Mr55zYL1T46w2X/3/apbpwfRPgFstGrYVYMKbx6TIlEp92/6Q8D5wWciBaxSe1f5bHsnEB22cInEBfC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323838; c=relaxed/simple;
	bh=gPCxG5KUKMDBx+4xfg2ayTlP2HLGPyoCCR1pzIXSQz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dElQdnkmc3+rx39h2FvSJoz/NP98Ta8CuDEXuizzgj1TlAf6grbUWhAX43M9LF2qpXSnt+h/amLvYwP80tuta6MyxNMVZUQiLZYPiH4EQzUoUckgLHszOi+Cfz45ZikrO/4cV16S78Mal+ZuA2DLi6EzNTFhZxg73E/hXJ8FeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/CQGL5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B211FC43399;
	Sun, 24 Mar 2024 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323837;
	bh=gPCxG5KUKMDBx+4xfg2ayTlP2HLGPyoCCR1pzIXSQz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/CQGL5PHG0Cobr2gWZHLxBx3+j3PGp9nQ2mJR2zaQib7tGILczhLeJH3xrdcxx0a
	 NsiTeA1MsKBsPLnjqF6v7zO+s8DDD0JWWytb23AIpCFQ0v3THO3XijL5s3CVjwbL+M
	 jY3+dyt5nslBxFx8vwg93G/peFzY5bIgekfgD+416OfXbYcqQMoNc0w2MD12iVg3bF
	 jXIdB/NzyFhdel68hxgR9fG3u6vnVKmOTPSGrmGAfIz1LJiW9969EkaRobIxzy7hXR
	 atjhS3Xq4/DS0lmeqBuPc0LsovWBgTlUDn2hOeEWXn88rxNa6bYaLCGGgIffStRASC
	 DtF2ZFDu/4F+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 215/238] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:40:03 -0400
Message-ID: <20240324234027.1354210-216-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 6e33c74e569f0..7c28d2752a4cd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -688,6 +688,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -702,10 +703,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
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


