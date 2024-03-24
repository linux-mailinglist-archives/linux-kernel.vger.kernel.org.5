Return-Path: <linux-kernel+bounces-114431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57812888A77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BBE1C28C17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70C5A4C6;
	Sun, 24 Mar 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtfvtE3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E821C97F;
	Sun, 24 Mar 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321843; cv=none; b=MsnAeM9XmqFSgj6HSCz2HT+oqUyoVSXp7Lb0BjQp6eyCHnU/MLF9tsk0iMTiik0fS9a2tS1tcHVYx9KWn9L2cvmkfM9/TMDJArIwixTZWyg7AaO6gAARdZMOeH1itWJ+mp2KgUECE6mLluRUekNuP9PYOpNQn1MonGLeXowdmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321843; c=relaxed/simple;
	bh=15HlHOV6IzS474RV+Rbz5Qqm0CUsJBSJxewEoFBqyFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwSsruJDjOKPO98diUXpKDopKL1i4zOI777MhAhTwHKPdk3kI8DVFyZ/qMRwG2erg75OAxeLIIhiLJRpmpxqQlLpjVSLV+fw3UYP1KCAKTqNUirlvH6tRNQIVIV9jAyInuLaVIFnk4KEBZzjq+0NLcA6jBYFFfgnvF3Ky3dMokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtfvtE3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC82C433C7;
	Sun, 24 Mar 2024 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321842;
	bh=15HlHOV6IzS474RV+Rbz5Qqm0CUsJBSJxewEoFBqyFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtfvtE3BIqnnSX/xTK/CtZHwANzgbIhTdOWRYV2oo4De9eFLPK1F0mPz+GbGuKnKM
	 m7PGE/s+Mlb46zHKMndAQ+mYPhg+mEUsEEudsIgMjB9oReOsaEJacouKOzqhtXQkl5
	 BYVace+FYpNUEDR78oNPtM0KIilZAy5WjP3taBAM90Y7SaQ6+a/fgxP1A20yTzRV0I
	 59LRGqYjAokqURTwJtplRitDHeDtMdVUn7tDV/N0m/Csx19rcTY5sEOljUrkarifzU
	 suzYI5phRunJYWa7v7IJcuzmUJmu9tKrcA2HH3LkdJAC+sPY5mDxAbDEbOQSqmduhV
	 3XSHbKX1qA/Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 570/638] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:00:07 -0400
Message-ID: <20240324230116.1348576-571-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8385be846840a..4d20f3aa280cd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -718,6 +718,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -732,10 +733,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
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


