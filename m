Return-Path: <linux-kernel+bounces-115986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA254889902
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52621C31F82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585E23847B;
	Mon, 25 Mar 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1iFticn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A115ECE9;
	Sun, 24 Mar 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322314; cv=none; b=dflRtMKFxe7z0gC2Xo8SIVjO7eWJxGRxAXic+F5T7rjuEdr6YaTi7u7J1aUgMKqVfhDQ3YxIvX0w7Di/QRzlNnOjiPJZG1oYl7mmBYrzRRLR00dqXWX0CN9peh07JaeIaJKshAx/9m0+4JEuW6NXN9quvNzMMRf2pIIWYf1wEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322314; c=relaxed/simple;
	bh=YhXWoF7MepfCPXmij53sRzwCZ61K0EVZc8y16yRySjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im7/L+yqrK27DwTN8kCZZlaukwOCmeKI6b6prB7mQXJXp01z4leJ9KN0h2UrhfeaeFOSuL/V2TFpF2GG24zr5MtscR5nN/KXmR5qqNyJqWbDszY7DGA3G9hG9EQ6Yj/b7aqnIlE27n4krefimuD/iFfcI8bmenFWLdAMqBPo1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1iFticn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F82C433C7;
	Sun, 24 Mar 2024 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322314;
	bh=YhXWoF7MepfCPXmij53sRzwCZ61K0EVZc8y16yRySjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1iFticnfZeKhZagLKoBQiVki0pIJ5whTmj9OhMCfb8YE8xYKlEZto9RMPd3JCf39
	 3tj7/kyKkqO52JTZppidQiiAfUJ+5Qipw1GpVQrPgM6UMw/WA1qnNwkZqiZg6uIf+m
	 tV7cir7Z6TgmuN24WTKLKIqb34erDJCV1xf2IXNygdRfnQ0cAerXM1VGqadKN04Z1t
	 wW75smKwinsel2QISeDpDN7/cVcn4UfyeplfO7pJcU7nHRdw3cCPLjIu+NXSilLYMy
	 CRDVBXuSEDK+NzdvtMkdcRGykoG1cGDr3xVBtaPIhfOPN8wf0AWlc4qm2U5+xYltK8
	 EnFH/kl0ypIeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 397/451] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:11:13 -0400
Message-ID: <20240324231207.1351418-398-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index dca1abe363248..55451ff846520 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -714,6 +714,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -728,10 +729,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
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


