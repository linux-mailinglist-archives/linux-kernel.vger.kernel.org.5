Return-Path: <linux-kernel+bounces-142799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C78A3046
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF96B2148D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7B386128;
	Fri, 12 Apr 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="lDvs6aoO"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10583CDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931358; cv=none; b=UyzYZkVuU5TzedSVrG+bJT4zMuM1DrEZEU5/QVIGMTgR7T/EgSaYwiKhFPadrAGUiaI1ML6aXtn3BgHtWLM6sVQVpytoLzLBs9s4ODciC49APGsN08DjPhT78mKpdhMzJn9h0LcYL2NCPt14LR4w/OJPR1vLyeC1p2QdmAFHqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931358; c=relaxed/simple;
	bh=LxXBm44a9SVfKzjdCdWLoMucjG/P7bLziiYfipcg0bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/Gm34gM2pM0EkmMOKHE+Qf+h1ZIeXTCB0t1x9Ti0PBpw5N7EIaUJ13PU57B5HnAaAbAFT8VRvQMDIgGNMw7W69BHJ9LPO4afWXXEPrsRBm3lrs0Db8DKNgQqmXwqvnri+PpejgJc2XcX5evKUsc6rJJtw2wfpcp/H1ZLzfRtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=lDvs6aoO; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF3F148CE9A;
	Fri, 12 Apr 2024 16:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1712930889; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WLfHwsGrJHJq3LO7YBJMataqBAqil/ftcquuEZ8C9D8=;
	b=lDvs6aoOH8P3GV5jx+e4L9FwX2dtdR8gGXN1QQxipIvmBzuYh+Up2LU79cLAMQ4z/gDD8a
	K760o+fWczxKS8P3X9J1wFC2FC+dVVKIvaJh+mM1iyzr7uUqJVrobJHePIvNaX1oHQ9im9
	GWCxo6v0CcMXoBxsLovdzjx/kkfPuObnAdG2ruNJgwtEX05wggGQp13tj4UW/Gh/q08K67
	Cxj+7wdBN+NKzMFXcfaPWHjlsRl2RCIeamjKOBnPD4hVs5V+ifQMop4E3augI8DnSMK4zQ
	K21whhg49adPfEZqTe73Hdz3nhnmLjnKcnvg7CluxzlhDOlzdoLxSTFSAKocNw==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] Timeout error with Microchip OTPC driver on SAM9X60
Date: Fri, 12 Apr 2024 16:08:01 +0200
Message-Id: <20240412140802.1571935-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

on a custom sam9x60 based board we want to access a unique ID of the
SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
content of the OTPC Product UID x Register in that case.

(On a different board with a SAMA5D2 we use the Serial Number x Register
exposed through the atmel soc driver, which is not present in the
SAM9X60 series.)

There is a driver for the OTPC of the SAMA7G5 and after comparing
register layouts it seems that one is almost identical to the one used
by SAM9X60.  So I thought just adapting the driver for SAM9X60 should be
easy.  (At least as a start, the driver has no support for that UID
register, but I suppose it would be the right place to implement it.)

However it does not work.  I used the patch attached with
additional debug messages on a SAM9X60-Curiosity board.  (That patch is
not meant for inclusion, just for showing what I've tried.)

On probe the function mchp_otpc_init_packets_list() returns with
ETIMEDOUT, which it can only do if mchp_otpc_prepare_read() returns with
timeout and that can only happen if read_poll_timeout() times out on
reading the Status Register.  Poking that register with `devmem
0xeff0000c 32` gives 0x00000040 which means "A packet read is on-going".

Kinda stuck here.  Any ideas?

Greets and have a nice weekend everyone
Alex

Alexander Dahl (1):
  nvmem: microchip-otpc: Add support for SAM9X60

 .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
 arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
 drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)


base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
-- 
2.39.2


