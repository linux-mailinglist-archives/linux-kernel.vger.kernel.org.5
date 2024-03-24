Return-Path: <linux-kernel+bounces-113959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C77888EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A0A1F21E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782121C199;
	Sun, 24 Mar 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5dXFC7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61F1F10AF;
	Sun, 24 Mar 2024 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321071; cv=none; b=hMarIBEh7F0RluvVtIKmVhiJbYHvX9RSB0dJkWRs5LyVQZGiTdUsrPstme4FPZaKYqBY+XpUBKt2j20YVK4NTmK+OCLKRJq1IjbHFIqWLudeqvnGUno89nY7nupp83OEfMY6FdmgcRx616xr4mhneXOkAiVncGn6wMWa1819II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321071; c=relaxed/simple;
	bh=8jusht4l5bIJ/bAuq/+9JuK/sqkynemaRzFgoT/98JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osq6/fmZxYA4Bhs9RDT1ah4V5tY3Vs7Tw4YvImYJcMMQrEbT/reLJbiJLPMfOQy0yWi+PR3NJcapGenRyCBOM116r3NrmBaqNqeEASO9fUE5q1K14nISghTZvRgR/RaGBKWrDTdyx+cwhWBVKDbRnarBH8G1n+J9tw5QgiCCnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5dXFC7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBC7C43390;
	Sun, 24 Mar 2024 22:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321070;
	bh=8jusht4l5bIJ/bAuq/+9JuK/sqkynemaRzFgoT/98JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5dXFC7Yhcm+aFcFna7KRd6ATaiPQcHv/dHonYld+0eUlk7OEi85deuXEQsq4mcod
	 oFi3Xk+nWCKR6vubycAx+8Rk1/6kMLK9ANbX0BYlTzvp/Kk2efj1znsxXjG6LmwhTb
	 jTB1olxod3ItSV1niPGg+3CmEhmPF2ktxEKKlyNhlXxdf2p3o7Rzc1P0pnIYNe1F01
	 LUBkTxNqNAAW53tSGIJf2gPs5vQ9qZR+GO18Th89Z5paicbN0HOtB58M7v3sB658cz
	 bTeqarrFfIwV0SZUzzRP1w185bBiLy5/xea8jeZ0+484sWzbVbNj5eg92ojlrDuGG8
	 QkxPs13xmm1Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 634/713] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Sun, 24 Mar 2024 18:46:00 -0400
Message-ID: <20240324224720.1345309-635-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


