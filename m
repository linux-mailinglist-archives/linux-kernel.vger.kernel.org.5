Return-Path: <linux-kernel+bounces-151151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F98AA9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216DDB24C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095F4EB43;
	Fri, 19 Apr 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRf7Kv+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F194405EC;
	Fri, 19 Apr 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514175; cv=none; b=RZGUZq0a5+OTPZ/SlNiG3+ASm1j38HUoN+bYJEEXfrWR0rkD1A40Ji8qWcu9ORmNzL/eXQgWW5LgnRslPLHYzmxwnzLmBec+M/gGImHTJVBtihYeUPdnZdYUsyozHA1J1aXGCMqMs+x3FzYKW9LigBltC3oVYnvUFT25couPUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514175; c=relaxed/simple;
	bh=+2vGmxIZsR1RCaOsZaJdfGR4PG7Qb9AaMhUzcpmWI9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee9+Tzyh92n0uIPVLh0gQ2haCGJlq9WE2zIDFz3/QHg/WcbK+SCtM4X3bbq13i7bakDOak/bd5UWh2bITGeVUyA/wKZWJAV0g+xcRQ9PAoBsc/mPLS2WbBqfDZCpOdp8TMHA+6mXYkFDvJNIRIUxS6W5M+PJj4N0TEc3xXOBQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRf7Kv+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9BEC072AA;
	Fri, 19 Apr 2024 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713514175;
	bh=+2vGmxIZsR1RCaOsZaJdfGR4PG7Qb9AaMhUzcpmWI9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRf7Kv+16vUrWteJ0KWa33026iDWD6wuOWvXGKnvyp5X+h828egaO7hF/yiB6KbbT
	 Ve2caukxwuWYN72guqQabn5JjDwuxLxY33VD3P9W9CrQwkjmvnuTicg+4eqfJBI24S
	 ZjjpnlJM8vad3nU8JKucVPwBlhfsbeTyJlCwSL4ek4CiUD5TxO6fWGVHcOZio8C8mY
	 5/ejKzR58leDyBLyk+/2Y37VgvpqZyXa5kHzc0ADba3Drh8Z1x8WUDhrcfs7O69pFu
	 /xngypL7hKe+jTlkOTgxaizRT3MtO1Jw1OyRoQj4bzTUHoLAk49UB7mVgRsNbL71ci
	 UMPoNPa2FO9KA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] serial: msm: check dma_map_sg() return value properly
Date: Fri, 19 Apr 2024 10:09:31 +0200
Message-ID: <20240419080931.30949-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
References: <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -next commit f8fef2fa419f (tty: msm_serial: use
dmaengine_prep_slave_sg()), switched to using dma_map_sg(). But the
return value of dma_map_sg() is special: it returns number of elements
mapped. And not a standard error value.

The commit also forgot to reset dma->tx_sg in case of this failure.

Fix both these mistakes.

Thanks to Marek who helped debugging this.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/msm_serial.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index ae7a8e3cf467..0a9c5219df88 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -499,15 +499,18 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	struct uart_port *port = &msm_port->uart;
 	struct tty_port *tport = &port->state->port;
 	struct msm_dma *dma = &msm_port->tx_dma;
+	unsigned int mapped;
 	int ret;
 	u32 val;
 
 	sg_init_table(&dma->tx_sg, 1);
 	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
 
-	ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
-	if (ret)
-		return ret;
+	mapped = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+	if (!mapped) {
+		ret = -EIO;
+		goto zero_sg;
+	}
 
 	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
 						DMA_MEM_TO_DEV,
@@ -548,6 +551,7 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	return 0;
 unmap:
 	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
+zero_sg:
 	sg_init_table(&dma->tx_sg, 1);
 	return ret;
 }
-- 
2.44.0


