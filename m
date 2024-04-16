Return-Path: <linux-kernel+bounces-146821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7218A6B78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4D1C21657
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80612BF1A;
	Tue, 16 Apr 2024 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pk96PNKJ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A0129A7B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271980; cv=none; b=mKxtV2h/RqHibUPJ5tLVyKzxlCsjnWCIbCi8e7B9THqARDqU+ORuMKlfPXb0IYBd7tzz5UhyE6HSrcgRF/rXlceYlaERcq8vZssHBSnIlW/WSk6j4wwTnfVnDLAsrRu4E6FsciMJecB94RTcfrzAGIQ5qrsJDRwSjTG6Z+lVn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271980; c=relaxed/simple;
	bh=5kC7K574cqEV8ZNzQmO84DuPtoIppBMm+PsVptjsJ9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jQeOdTVz+JCtupxZB8PPCR8d28GSlEW7s+pmLH07gLJFYUG83xu9SDX1HBbOHd1M460Y/nZsF+dF76B0qDDQR7ArnyyK5Hr99t7q1Q4vVxQi1UQUhZ1PYVa/svVGCI/cXOmyjqc6wpLbLTY7Js7pUXD/cu5k62FwgmfTidClmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pk96PNKJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D0C920005;
	Tue, 16 Apr 2024 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713271971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K3y9GuS5/xl69QZWu2ZPRVC1k2WjWkSaQK5l7tBAvM4=;
	b=pk96PNKJvxtGcj+a+jiYvS7naxMkRd0XCRZgHvwwWUd2fx98vnmtLLzzNj/jN39ZFDmcGE
	gjjWqKEEPTJwS2utG2GNmPb6hcSVpqIIri3QHcwOiuIvyAZ5NwUzXUxBzhOAt0x6mHxtUu
	//3QwhwYhL12ERZmpa8UBHiyonerp6C7YGiPwP8wOL8xX2hbQhr+dsLxBdm6BO+dRUOE+5
	VcOL69u4+lYUcdyhyG1il1cIp3zHOGXVUrXmSxrsKcUiA44Rh4DIe8PT+FKA7CtdBdvTTw
	hiSHn8M1CG65mSGYSnmNaot2rIJGVFwvSG7IWgLUCd8JgjO7ecHn1fchW6qPmw==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/8] Add suspend and resume support for phy-cadence-torrent
 and phy-j721e-wiz
Date: Tue, 16 Apr 2024 14:52:29 +0200
Message-Id: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI10HmYC/x2NwQrCQAxEf6XkbCBNi1v8FfGQ1ujGw1oSEKX03
 7vr8c3MYzYIddOAS7eB68fC3qVCf+pgyVKeinavDEw80tgzvhIT4Zp/GOyYaFI5D6KSJqjOLKE
 4u5QlN6tNWtSq1fVh3//V9bbvBz6aFjV6AAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

The patches of this series were originally in the series "Add suspend to
ram support for PCIe on J7200" [1].
They were moved in a separate series as requested by the PHY maintainer.
This series adds suspend and resume support for the phy-cadence-torrent and
phy-j721e-wiz drivers.

Compared to the PCIe series v4 [1], these PHY patches were rebased on Linux
v6.9-rc1.
The only change is for the patch "phy: cadence-torrent: extract calls to
clk_get from cdns_torrent_clk". Now the cadence-torrent driver supports
dual reference clock, so the patch was updated consequently.

[1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v4-0-6f1f53390c85@bootlin.com/

Regards, 

Thomas

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (8):
      phy: ti: phy-j721e-wiz: use dev_err_probe() instead of dev_err()
      phy: ti: phy-j721e-wiz: split wiz_clock_init() function
      phy: ti: phy-j721e-wiz: add resume support
      phy: cadence-torrent: extract calls to clk_get from cdns_torrent_clk
      phy: cadence-torrent: register resets even if the phy is already configured
      phy: cadence-torrent: add already_configured to struct cdns_torrent_phy
      phy: cadence-torrent: remove noop_ops phy operations
      phy: cadence-torrent: add suspend and resume support

 drivers/phy/cadence/phy-cadence-torrent.c | 140 +++++++++++++++++++++---------
 drivers/phy/ti/phy-j721e-wiz.c            | 133 +++++++++++++++++-----------
 2 files changed, 182 insertions(+), 91 deletions(-)
---
base-commit: b6b2d5379911df41ad51f7773ed98ef18b939258
change-id: 20240412-j7200-phy-s2r-708ea63aea78

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


