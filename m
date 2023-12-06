Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE76807114
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378503AbjLFNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378494AbjLFNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:44:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC2122;
        Wed,  6 Dec 2023 05:44:58 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701870296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hdgp/KXnKqI/YU7obBU7rXwS3m3tuver7rmEtNCRuvs=;
        b=VmtRfWqV3hQHWw9VM0X/u40G3JBc+TnoL06+8asysJtoMjehNdcAyCYdDP51wOaAb56uYb
        0m998H7iqXzrk57rQrmntYM1KufCXzDaEm18Ixj2nnLThkLIuCCh4s2wKUX1GjDHlK2omr
        +lFUOHFf6qGrpdGvZYbxAM4tRsEIHQ9e0zwYreDKbBTgvQ9w41LA15NKHlpe+5z3pdf+tM
        3TnQdxUk8VxUqR8RKY70iIpQvLkkq3rMsPcUvguZ+v+AFBTP0CsrdxaXaqC9Suh/SruWb6
        I9zWmvTPWLKAH3Lg/o0rjDnOZ+evJKaLMPCjwPC2+HxAKz1xnZLnv09+zsss4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701870296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hdgp/KXnKqI/YU7obBU7rXwS3m3tuver7rmEtNCRuvs=;
        b=VCYvcMflnN1n0brWx4OSl6nN71wZwkggRM0NknHhe57yunSjqHavDTLKwRqHbmQ9w8gS35
        AOqdkU359WyNczAA==
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@zonque.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Date:   Wed,  6 Dec 2023 14:44:46 +0100
Message-Id: <20231206134446.69048-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.

SPI transfer delay is already handled in SPI core. There is no need to
do it again.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 12c940ba074a..bd96d8b546cd 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -451,7 +451,6 @@ static int cdns_transfer_one(struct spi_controller *ctl=
r,
 		udelay(10);
=20
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
-	spi_transfer_delay_exec(transfer);
=20
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
--=20
2.39.2

