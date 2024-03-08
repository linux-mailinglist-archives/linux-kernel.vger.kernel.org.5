Return-Path: <linux-kernel+bounces-97371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990848769A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA901C20E33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243935B666;
	Fri,  8 Mar 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EP25NqWk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C53BBF9;
	Fri,  8 Mar 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918310; cv=none; b=WbnBv/uJkjyLiM766nc+Zk8IMQo1qb7oebyE1IIpdoJZZmIPkvNgga45o0DhfqVFcaARCsOY0bo8d1HqqXzAVVnOpkjvN7iQUDCEnIjAzEF8i8ozOPtoLIZMkOxp7FBVHXXsbMIO7NoAdRjbkAE5zTormEqivyU1F8kj3GbjOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918310; c=relaxed/simple;
	bh=YXqqaMLJ6VjihU/yGeXa28hiwOZ8Xv4a3RM0++ZGF0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM5dtrt3vsT4HLSaruKk8DxFw+aH2GcCNDHvdU+I2trWSR6fFJKCHsuhtwx2p4iQTlOfEsGpJVrNC0g1PwfuaDyIUp3dQLPRVHmAkKvjLeUpBCXLQ9DMpML6usw7PgGbqYIVE77Y+NX4hPEuxDNdaHJKaXvHrjsGr+t8DOBSRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EP25NqWk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B513C000A;
	Fri,  8 Mar 2024 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU600EcnHX7eTl5hRWQKY3CNjHvFq+CeJaAfPTEOFUc=;
	b=EP25NqWk261JTUwPQQ+pVqeH6Dt0/r21G0RH4ltvXsAu/MAIcSZuNSF0/Ba0Mdb9PSe0kZ
	6MCPmZj/a8EE4ReQdaoylpl8Egk6uXTdam9BRxQMKVJI8mRuJECpZ2ZM1EAmLzQGgIpOsN
	Oxy9gZ14vXmKCNpW/31AkDA0staM3HGH/sqdVFQ8Pqvmv2agyBJSk3pf9OPDUiHA+mxvMD
	P5ZAHgWLyk72mcLZAHZnaNFkPkJy1rR24TAfyTQzJ2bT6wUUsnanZ7+pFUns/eU771VzXV
	VyvHdtGRb64AJFXeFqDK0+gE/Guw1vRdaLRN4zvR+aTa/w8ga9yCzNe5xRPCvw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:21 +0100
Subject: [PATCH 06/11] spi: cadence-qspi: minimise register accesses on
 each op if !DTR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-6-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

cqspi_enable_dtr() is called for each operation, commands or not, reads
or writes. It writes CQSPI_REG_CONFIG then waits for idle (three
successful reads). Skip that in the no-DTR case if DTR is already
disabled.

It cannot be skipped in the DTR case as cqspi_setup_opcode_ext() writes
to a register and we must wait for idle state.

According to ftrace, the average cqspi_exec_mem_op() call goes from
85.4µs to 83.6µs when reading 235M over UBIFS on an octal flash.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d178148788f0..0fc452bab0ee 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -492,8 +492,11 @@ static int cqspi_enable_dtr(struct cqspi_flash_pdata *f_pdata,
 		if (ret)
 			return ret;
 	} else {
-		reg &= ~CQSPI_REG_CONFIG_DTR_PROTO;
-		reg &= ~CQSPI_REG_CONFIG_DUAL_OPCODE;
+		unsigned int mask = CQSPI_REG_CONFIG_DTR_PROTO | CQSPI_REG_CONFIG_DUAL_OPCODE;
+		/* Shortcut if DTR is already disabled. */
+		if ((reg & mask) == 0)
+			return 0;
+		reg &= ~mask;
 	}
 
 	writel(reg, reg_base + CQSPI_REG_CONFIG);

-- 
2.44.0


