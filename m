Return-Path: <linux-kernel+bounces-116099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216A889946
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225D41F316F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87728D9AA;
	Mon, 25 Mar 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uucwHvuj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB2178CD8;
	Sun, 24 Mar 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323579; cv=none; b=leAn1ee2+kqrWafuPlCKhFcA+uJ54JCamHSmEqXPEb67EK21J1l9c4uQQ23sfq2hJW60M9trs+Bi+cO5t0sLMoqF7nSjDR9acBfOi/1OS7n48jBJ9dZP+Hf0Q1LSmww3gq4BjDlt+XJ8N0tipwamrWYWzOxTkP6MhCj++zm5Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323579; c=relaxed/simple;
	bh=ZALTqHQ8Wgb2/RsXp3dzlcuLKWdWaQRvc7gz6kO5UPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjL3YQXQlmd47tMwCTS4xgjOoMoCG48tZhDuP+TVOByvuDq/RugKaUPyxusYrnsH02HpaUkP2MLoxKlymlLAxE6jyBTyCoX4jTR4t35baHsApoVzcoC9guc9YA2etgh/b4ubQTiVVVz3znEC8Ke2fjKkA78Jl8kR0QbBkpon6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uucwHvuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68CC433C7;
	Sun, 24 Mar 2024 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323577;
	bh=ZALTqHQ8Wgb2/RsXp3dzlcuLKWdWaQRvc7gz6kO5UPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uucwHvujBHsWxxD9Bs7OywHG2pLmaed1RBOm8AwDAW/lReFTgeuhNR/36VztvrqeT
	 +QhChYIyPWozjm3MvON/H/o3ZiNBRqfmxMOUYYR7BvaIIRSEs3zt8IRlwe1O9moHpP
	 05AmNb05sqqK/dC8Hifx/kqrn5JdrbJjMWM3Zrc+b3judtnwPiQmEEN51L0gjO+3Ad
	 vE5gNh3LP5C3NhsU/KYE0DfFtl9b3V7jORemTHJ4RTM0FJQhjZOg/nDIAOQHlFNAqn
	 3lBmuo4mvIxvtlYlywLNQR9hPjCjtJV/7V3g6XyU3BWmBlv0WmJ1N7tVHSfIl2+ybK
	 eNhyl9C9k+dxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 284/317] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 19:34:24 -0400
Message-ID: <20240324233458.1352854-285-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index ada9666f59889..48769e059772a 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -715,6 +715,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -729,10 +730,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
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


