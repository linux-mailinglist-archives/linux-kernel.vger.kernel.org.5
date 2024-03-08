Return-Path: <linux-kernel+bounces-96601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB725875ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E15B23092
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268364F5F8;
	Fri,  8 Mar 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nc8xtVoV"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64C51C4B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883987; cv=none; b=VbVYcBMpdcNdqIFKawXFTdrpAGdldI9NTI9UJ3/iZq3j6olAUBj4amoro1DAH+3lj3AqFLtSKsJdOLwhX4eLFqYqlrF0hP8xmf8ATpyvSekFoOR6ufpNpp2yhhz1fznL+dvxu3Pe4xMcVLyVV34dsOHoJtAHVbn4r1VZoj47KME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883987; c=relaxed/simple;
	bh=apa7drqXC+sUspJkxMBeLhvktxd4lLh4aXftu3PNjRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBfTDpjJbihOANKiQ/5foWOyhaBcbGwJKhnn2jgLeOkL6S7+Q2DhjIDFY54n2rXp0SElYQhabW6OiF8/s5Sh/1EPXg5ssy744A6SAK8jmVDee/QklvibDROPUCXxZ6rHXSq+YgnIRpEAH1itVd/tZNv1F9n3GR2pGwH25ih4+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nc8xtVoV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 02CDA40004;
	Fri,  8 Mar 2024 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709883977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rh/TMFw6/2TpSgFOITs518M418uS/FqGdKrbo+fGdeI=;
	b=Nc8xtVoVpS8MI7y8AubYuIQRHEo70NEsK0ci1FASAXmfJIaqYhzeni0fPfZeupKoo2WKTz
	GuAK4gcvX9oLICtDx3/QFK4ohzMFpTNjibclgWx61urSH8hoAcQXeM5cUpaBWpivaGXkw1
	Wtxmz5LwjAbHx5MNtEkHx5qFE66QR+3hkk30ERZ1vtNAnoQnqAv5AWhX5UHRAwVMbg01xG
	/jepdawxKCv/qU+4SxsJbDY4ljMLb868ya2RaI5OGwMYQy91G6b7jUHibzBMTg0UBiiwfh
	dOil7lSAcLdgWAPBeHUT/bmBvBYXL34iypOal/nYJqMLyDKGrORvpFP1rhvjIA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herver.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 1/1] mtd: rawnand: davinci: Add dummy read after sending command
Date: Fri,  8 Mar 2024 08:46:09 +0100
Message-ID: <20240308074609.9056-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Sometimes, writes fail because the tWB_max is not correctly observed
after sending PAGEPROG. It leads to the R/B pin to be read as in
the "ready" state right after sending the command, thus preventing the
normal tPROG delay to be actually observed. This happens because the
ndelay() that waits for tWB_max starts before the command reaches the
NAND chip.

Add a dummy read when a delay is requested at the end of the executed
instruction to make sure that the sent command is received by the NAND
before starting the short ndelay() (<1us but rounded up to 1us in
practice). This read is done on the control register area because
doing it on the Async Data area would change the NAND's RE pin state.
This is not perfect as the two areas are behind two different
devm_ioremap_resource() and could possibly be located on different
interconnects (I did not find more details). This means either the
additional latency due to the load operation is enough impacting, or it
has the expected behavior of ensuring the write has been received.

This has been tested on two platforms designed off of the
DAVINCI/OMAP-L138. The first uses a Toshiba NAND Flash (TC58NYG2S3EBAI5),
the other a Macronix one (MX30UF4G18AC).

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
nandtest utility sometimes fails because of write failures. It is likely
that these failures are due to a non respect of the tPROG delay
after sending PAGEPROG. I could not manage to fully prove this because
adding debugging to the code makes the failure disappear. As these
timings are really tiny, I can't measure them precisely.

 drivers/mtd/nand/raw/davinci_nand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index e75d81cf8c21..051deea768db 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -671,8 +671,11 @@ static int davinci_nand_exec_instr(struct davinci_nand_info *info,
 		break;
 	}
 
-	if (instr->delay_ns)
+	if (instr->delay_ns) {
+		/* Dummy read to be sure that command is sent before ndelay starts */
+		davinci_nand_readl(info, 0);
 		ndelay(instr->delay_ns);
+	}
 
 	return 0;
 }
-- 
2.43.2


