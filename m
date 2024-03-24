Return-Path: <linux-kernel+bounces-113520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC748884FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EDE1C243E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDC1BDBA7;
	Sun, 24 Mar 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhzEVXfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601741BDB8F;
	Sun, 24 Mar 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320322; cv=none; b=beY6NXuySux2UBa4wNoobYQWzDVNaVNeqKsflqvXCt0ZaQq6yatn4Mh+3V3lAo9sHgAp2xPrK4tDtGtOqqyK0ns2iI2yCKi3BQ+We3O7Mydwmzrpx7yzoPlJ1uGeLXmjlDNvGc/BVEDdvAvTKYsmXr/aYoQ2kzrhOESbIt10wgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320322; c=relaxed/simple;
	bh=8jusht4l5bIJ/bAuq/+9JuK/sqkynemaRzFgoT/98JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9GLsHoGY/8H58kynOdGh3Y921XoatyFhF80nznhbfdt7vIr6Yd2PCdis8dj5pCo9kRpUeWKfaickuQIQyys2lBLLSgg77unRO+XBB3DSRe5QqZcfIJL65aBBzRdplg03hUlwOQvN3Vm+P55eUbFivTrrEEShV8JE04Tqk0JrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhzEVXfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6CAC43399;
	Sun, 24 Mar 2024 22:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320321;
	bh=8jusht4l5bIJ/bAuq/+9JuK/sqkynemaRzFgoT/98JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhzEVXfOFZS/CweD8WW0F9PbAcWnY2gc45yYQynj88MAoE0eqY0nVjNquDFF6LM0n
	 AFnmgFIvJwc/YAUeFR9QjPmT1E3PrhFfR8frtCeRsePxP4Tl8V9/PaN8+VTG2DOlTz
	 R54QsJJeESJX2+HjUBF2SbatLWW4xLHfIgFx8hAYL/MtQdZy9rgF58+0WD9rocQMWm
	 LmGV+QTud+ZRoBgM/xLsVv4An/B+E/ZgcPgSFiveDwfBDHlhKGMh11JeblB5vGGntx
	 Js0Yzuv4RRxRm4gABdcfhN0sVYawpKEdTYl1uob5uLD/sgmTdctxVekh+Dv6lXGI9n
	 jibCerHjYuaPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 629/715] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 18:33:28 -0400
Message-ID: <20240324223455.1342824-630-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 23366f868ae3a..dab94835b6f5f 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -753,6 +753,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -767,10 +768,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
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


