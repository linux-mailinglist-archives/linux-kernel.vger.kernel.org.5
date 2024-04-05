Return-Path: <linux-kernel+bounces-132446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C5899500
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA01B25E01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88E381C4;
	Fri,  5 Apr 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbDDSfzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A94376EB;
	Fri,  5 Apr 2024 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297337; cv=none; b=h563A0COi9Jwh33twqJdWsj5Lw31mplpgmyymQlOktJU18/ue+bsspZ17XAxTd4s6nqSM0G+zYkyNqXNcl6UA4GDQrGxJvF0zfOOji2CeinJuripuko13c6jH5SdXmOUDCms1G4t+3KQ1OOksQ+n1LOB97/T8HVBvBMLOxikCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297337; c=relaxed/simple;
	bh=9yRltj2u1toAe8XDEiaX+4QhmVeUjmlStdgTFG4DGqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD4NWaEsxjoJwV+qgvj9WgVA4RqcN7yDsOIqPtLiA4ZRfGt36Q6ilIwddpGBrCy5Msyg0IKTrEJ67l6115vBNqjQf8zS+xanhGiG3DZZFGWaL8uT6B2KmM/r7YuZM4DerMCb9pR3aBvSD89M9nmF/oLXE569VoC3AgsAhuitChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbDDSfzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B07C43394;
	Fri,  5 Apr 2024 06:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297337;
	bh=9yRltj2u1toAe8XDEiaX+4QhmVeUjmlStdgTFG4DGqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LbDDSfzxn7F3lnVzDaUTXIw2aKkkIBEu1KBz6DFaj0AthhKa3sKXcIHkSzxrdWbYD
	 UJjOXQCoYBNbphO8qZmCJt5hQ8JNiBKTXOsY8577LaIZiitSD4YMbeEiuPJb2Pv8g3
	 bwLBWTRR6HAbSJ7BhhneGNb4lgz6QMXuTNwSlXhhaMRNYxgcQ38SEDV3AeABQiVq+E
	 tJ6XW3wakruYAXniYFc4d5xTRT/+9eM2ItmdnQ43a5kzuC9MvNPk9/bqBSJbhlaziN
	 MwIO/aBjFR9Sdw7Ecczr7wBCwctFK7ANgYcnQtyF0+u8E2esHYlysNO56h9/Cp+LO3
	 DS4yZm7YQ9oCg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/15] tty: 8250_omap: use dmaengine_prep_slave_sg()
Date: Fri,  5 Apr 2024 08:08:21 +0200
Message-ID: <20240405060826.2521-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory for the serial-to-kfifo switch. kfifo understands
only scatter-gatter approach, so switch to that.

No functional change intended, it's just dmaengine_prep_slave_single()
inline expanded.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 66901d93089a..879e77b30701 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1140,6 +1140,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	struct omap8250_priv		*priv = p->port.private_data;
 	struct circ_buf			*xmit = &p->port.state->xmit;
 	struct dma_async_tx_descriptor	*desc;
+	struct scatterlist sg;
 	unsigned int	skip_byte = 0;
 	int ret;
 
@@ -1191,9 +1192,11 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		skip_byte = 1;
 	}
 
-	desc = dmaengine_prep_slave_single(dma->txchan,
-			dma->tx_addr + xmit->tail + skip_byte,
-			dma->tx_size - skip_byte, DMA_MEM_TO_DEV,
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = dma->tx_addr + xmit->tail + skip_byte;
+	sg_dma_len(&sg) = dma->tx_size - skip_byte;
+
+	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		ret = -EBUSY;
-- 
2.44.0


