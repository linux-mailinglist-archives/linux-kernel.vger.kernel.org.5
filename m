Return-Path: <linux-kernel+bounces-148033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6448A7CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E051D1F223BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A636A347;
	Wed, 17 Apr 2024 07:13:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639E6EB44
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338031; cv=none; b=chWggp8Ep81Vq9DrFez5QE3axYexCBoWw/wzCjwzT87UsNQaF2xCLrkrcKP86JGOShFN7uX1NWM3dek8WTZ1EOGRVwAZ3yTgFdThEMsjFzayJkl6NQJ1D+xc28G/ctKqAHKqiLvE0j5CU2V8tKO3XUHZcKkMJGGexRV9PeAlNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338031; c=relaxed/simple;
	bh=BmEr6PI9JmP6srt84r2Hs54N86dOzRtv6ztVCh0F30g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mgAmm9VGl1kPrszw5O6s2rFENIKmBnymyMuYzqjhJAbgHocRX+UmJs1P/zsxgbu0Jx4tP3U7YqNBDb0kpb644/3rn+ruehWiQQY/0ovrZuoZOsNrFT8tnQYv5FFl7T6dWZebphlU017L1ulOeMzQVxoYBHceWSIXLyWy7tiaXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUB-0003W2-EM; Wed, 17 Apr 2024 09:13:39 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-00Ckan-Ai; Wed, 17 Apr 2024 09:13:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rwzUA-004DbZ-0U;
	Wed, 17 Apr 2024 09:13:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/4] mtd: nand: mxc_nand: Convert to exec_op
Date: Wed, 17 Apr 2024 09:13:27 +0200
Message-Id: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJh2H2YC/yWMQQqAIBAAvxJ7bsFSUPpKdCjdag9aaIQg/T2p2
 8xhpkCiyJRgaApEujnxEap0bQN2n8NGyK469KJXQnUa/eUwzMGhz/YHymTxOFGaRS5GWCW1htq
 fkVbO33ucnucFA9omhGsAAAA=
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713338018; l=923;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=BmEr6PI9JmP6srt84r2Hs54N86dOzRtv6ztVCh0F30g=;
 b=y2YQOTHK2FkEXTJ1pkQQTy8Gb6++35MsVfFqBGxixH90xHYNEquICdXd5uPblhOl2uFNWN0lm
 3cf5/X2AHsrCXT93eqWpIgWOaIMLLLtX4p2mtAnrS/8I+cTViqwIrD8
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series converts the mxc_nand driver over to exec_op which gets
us rid of a bunch of legacy code. The motivation for this series is
a board that has a NAND chip connected that needs 4bit ECC whereas the
i.MX27 hardware only supports 1Bit Hamming ECC. With this series the
driver now supports software BCH ECC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (4):
      mtd: nand: mxc_nand: separate page read from ecc calc
      mtd: nand: mxc_nand: implement exec_op
      mtd: nand: mxc_nand: support software ECC
      mtd: nand: mxc_nand: disable subpage reads

 drivers/mtd/nand/raw/mxc_nand.c | 568 ++++++++++++++++------------------------
 1 file changed, 219 insertions(+), 349 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240417-mtd-nand-mxc-nand-exec-op-38b3b80c4377

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


