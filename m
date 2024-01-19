Return-Path: <linux-kernel+bounces-31230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B462832AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E01C2449D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C252F9B;
	Fri, 19 Jan 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="pBnoJggm"
Received: from smtp119.iad3a.emailsrvr.com (smtp119.iad3a.emailsrvr.com [173.203.187.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA347524D8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672616; cv=none; b=e9kUyTCSKKtEmT4+TddSXm2io0OHZcuJLGrW1D7pEgR8YVPdlS7gjSXICURA8LQAF6g4O3kkeG7W0zJxLwNbd6IF4b6HAHuGt9K4wsSFq/fblc9eimWIZic7swtK2ByE0GpX0Xv/XhMUM2EK0GG9QhrIeJFnlm5Cd7PbXcpEs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672616; c=relaxed/simple;
	bh=nS+r7MaskCPsuXGcVmc2lQaLyPRahw2eN/Qec5iMmx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4Zfq1BsUw/ijpIhrPByGYkCrnq/L4x9xiRdgxfUVRjaGQGiltlieGAIf821WSgqSmxSnhEZlT6fhRifMEhzXvec/p0Z4iIpW1zQWUYDRnUWVQ919hop3AyBAQo4UND54nxRA8lGSzDXpZBiuSyoq8mjWhqDm6yKNZdwIPNGM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=pBnoJggm; arc=none smtp.client-ip=173.203.187.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705670449;
	bh=nS+r7MaskCPsuXGcVmc2lQaLyPRahw2eN/Qec5iMmx0=;
	h=From:To:Subject:Date:From;
	b=pBnoJggmF7hEiOIjzQeyYvaxGz3p0EqaNbhOkhmR1LSX9p/vYFE5u1lKvh88F1D+0
	 puat1ryTvHenIFNjXmNq2baAJAOGWHjYM4bi1Prm2Rg1EAGnu/quYQyI5NrMQtw2Fl
	 +a6CPdD0O/sdRLM8YsKBMHHDYz/Jsl7PLejIDdzs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DBD4E24FCE;
	Fri, 19 Jan 2024 08:20:48 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: Matt Hsiao <matt.hsiao@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/2] misc: hpilo: rename device creation loop variable
Date: Fri, 19 Jan 2024 13:20:18 +0000
Message-ID: <20240119132032.106053-3-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119132032.106053-1-abbotti@mev.co.uk>
References: <20240119132032.106053-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5ab2b5c7-4f68-4b27-8b47-1878e9f7d96c-3-1

In `ilo_probe()`, the loop variable `minor` isn't really the minor
device number, it's the channel or slot number.  Rename it to `slot` for
consistency.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/misc/hpilo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 3428a0bd5550..04bd34c8c506 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -770,7 +770,7 @@ static void ilo_remove(struct pci_dev *pdev)
 static int ilo_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *ent)
 {
-	int devnum, minor, start, error = 0;
+	int devnum, slot, start, error = 0;
 	struct ilo_hwinfo *ilo_hw;
 
 	if (pci_match_id(ilo_blacklist, pdev)) {
@@ -839,11 +839,11 @@ static int ilo_probe(struct pci_dev *pdev,
 		goto remove_isr;
 	}
 
-	for (minor = 0 ; minor < max_ccb; minor++) {
+	for (slot = 0; slot < max_ccb; slot++) {
 		struct device *dev;
 		dev = device_create(&ilo_class, &pdev->dev,
-				    MKDEV(ilo_major, start + minor), NULL,
-				    "hpilo!d%dccb%d", devnum, minor);
+				    MKDEV(ilo_major, start + slot), NULL,
+				    "hpilo!d%dccb%d", devnum, slot);
 		if (IS_ERR(dev))
 			dev_err(&pdev->dev, "Could not create files\n");
 	}
-- 
2.43.0


