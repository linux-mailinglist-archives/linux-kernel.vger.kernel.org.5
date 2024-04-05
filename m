Return-Path: <linux-kernel+bounces-133209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991E89A08C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13671F24684
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F0171095;
	Fri,  5 Apr 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WqNX9wVm"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17716F8F5;
	Fri,  5 Apr 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329343; cv=none; b=HdUzdRAqY2RxmU5Ax6cNMeejrYekPU/ZzKKAHvGFBGfBJ73w4HafFu2ZPJGWxwA+c+EC07+QKeBZj+6xeknMESV4ib5n0ezPxHQJDXFYAjU33N6nW19e0DJieTmYsptWOQMKYlkan2VErGwGJbRg+t4diDNgnKAzP7RyzrQoo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329343; c=relaxed/simple;
	bh=RQZA9rt6I9i+QQBSmnr1JodlJi319QmUstQmQXm02Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9BEhrxe2IiddYIi+nIer/KnttxLCaPES/ivMMWrBm6MWOADs7/nJu93RUd7DThJWiQLxr/c12u9UyNbSRE4TBllHDwW3/IZUrdZnMVQ+YavXSOWFSikGxa6utIWPX7hR6ABLyr7vTYssgh+GV+P7ScsF25fbbVPOtjEiTg8FMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WqNX9wVm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0CB31BF21D;
	Fri,  5 Apr 2024 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm7TX0bpIVYxGLrSDwf5aBC/t6bqErKnJF7vHkAQ4uY=;
	b=WqNX9wVmYWN05Tct3L98MvxWThB5skZXtlNBvqusNA48PvOw0pPmqn91/WtW/9bdPd8yT5
	DF/6/dii85vj6jGz+FUtFzyhO80dvVy1W/3ms1Kwx7G3dHoBWvwNPKXuRSOaZpXgJ2LSbr
	CATvbqHa7B22qF6UlYXtafcm9CxcZO57JcCG6eaVIsXAzYQXBLKaDWNrN+G4V7m86F7n2Y
	c8xV6PbI58/92IVluO3my73okmF1hjZb1FHBe4q+CD68OCIJI5qXui42Aq1TmfPBexze5+
	h/64fmLmwHP04YB+Q9Wm4kigBKKRCRla+49bJ3ktxAWO0VZJgqOuMh+wcGvQMQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:16 +0200
Subject: [PATCH v2 06/11] spi: cadence-qspi: minimise register accesses on
 each op if !DTR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-6-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
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
index 04a473fafe43..55d20d565fe5 100644
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


