Return-Path: <linux-kernel+bounces-153967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8B8AD568
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191171F2204C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44B156892;
	Mon, 22 Apr 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LDrKjlbM"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840C156232
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815963; cv=none; b=DGOXd/KUNSbJRsYr3/XMLZRqvjKwJQ5oQqL9MO+aQT2d2qy5MG3O1V76ugsOdCbyEaFHSMwxPBii4uvu8gCqqRxzicLObgMOU6jpm5kSnxClOGV6HoUIjREP425xFcRNeCtMitMJTW8+esuVqpxCwrUGLvskNA25pn2Bs2vd5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815963; c=relaxed/simple;
	bh=QMu5xcgCLE+WCRDBWokoEKaAeDoOZmUPyXdxczaOxYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tL1oIckIvQTXyefpwfrwtNuKygWVXYIkiIPjBHHOiSlRXrfs95cS6GBH7m3lKBollAUPlQ53U0/HwQUTZ4X8A5hyt+uzFRNn0/U4h45aUA9IJQwN6RQNmA+V8dsMvnAwVB0FEQKirGZxEF5bOj1I+cfIhvDHMfUa8OO+1wx3UyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LDrKjlbM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf7eZ3K3zp5B15WCzSEdzeiOvEohfOu0xeNNcWDApqk=;
	b=LDrKjlbMYR6zZSBwTR26bQPsghsLGT/CgKXTZdwN+VLqsvZoTa5FFzPzqxLn2ijVdDiHDk
	AsoywVLzwDhP9Iadpv5aXSQ45jk+6WkkAOnq4Y+csPn0OeYg1Gb2kX+Z26rfR5lwXDDFSX
	dGnXsafm+p/MuzQ/ViP1G6Q0knKmEc8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 4/7] PCI: xilinx-nwl: Rate-limit misc interrupt messages
Date: Mon, 22 Apr 2024 15:59:01 -0400
Message-Id: <20240422195904.3591683-5-sean.anderson@linux.dev>
In-Reply-To: <20240422195904.3591683-1-sean.anderson@linux.dev>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The conditions logged by the misc interrupt can occur repeatedly and
continuously. Avoid rendering the console unusable by rate-limiting
these messages.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/controller/pcie-xilinx-nwl.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index ce881baac6d8..c0a60cebdb2e 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -267,37 +267,37 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (misc_stat & MSGF_MISC_SR_RXMSG_OVER)
-		dev_err(dev, "Received Message FIFO Overflow\n");
+		dev_err_ratelimited(dev, "Received Message FIFO Overflow\n");
 
 	if (misc_stat & MSGF_MISC_SR_SLAVE_ERR)
-		dev_err(dev, "Slave error\n");
+		dev_err_ratelimited(dev, "Slave error\n");
 
 	if (misc_stat & MSGF_MISC_SR_MASTER_ERR)
-		dev_err(dev, "Master error\n");
+		dev_err_ratelimited(dev, "Master error\n");
 
 	if (misc_stat & MSGF_MISC_SR_I_ADDR_ERR)
-		dev_err(dev, "In Misc Ingress address translation error\n");
+		dev_err_ratelimited(dev, "In Misc Ingress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_E_ADDR_ERR)
-		dev_err(dev, "In Misc Egress address translation error\n");
+		dev_err_ratelimited(dev, "In Misc Egress address translation error\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
-		dev_err(dev, "Fatal Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
-		dev_err(dev, "Non-Fatal Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Non-Fatal Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_CORR_AER)
-		dev_err(dev, "Correctable Error in AER Capability\n");
+		dev_err_ratelimited(dev, "Correctable Error in AER Capability\n");
 
 	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
-		dev_err(dev, "Unsupported request Detected\n");
+		dev_err_ratelimited(dev, "Unsupported request Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
-		dev_err(dev, "Non-Fatal Error Detected\n");
+		dev_err_ratelimited(dev, "Non-Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
-		dev_err(dev, "Fatal Error Detected\n");
+		dev_err_ratelimited(dev, "Fatal Error Detected\n");
 
 	if (misc_stat & MSGF_MISC_SR_LINK_AUTO_BWIDTH)
 		dev_info(dev, "Link Autonomous Bandwidth Management Status bit set\n");
-- 
2.35.1.1320.gc452695387.dirty


