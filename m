Return-Path: <linux-kernel+bounces-153964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266B8AD560
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F91F22055
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE8155744;
	Mon, 22 Apr 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKoFKO/r"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E081553A1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815959; cv=none; b=CeWc1uyCL8vkbW3+eFhL9juISuezLUuSX9MscOSgdy9pSHXagTsrhf6KvIdfsiczFu2A/zd5UbrYSTdZAHfAOeaN4SUUs60/Q1ObUOxB1lbTjLtTVHSmhh1kS3oN7c/k5Yj4704QIxtE8C59eODdFnpvUz5GoZs//ats7miah7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815959; c=relaxed/simple;
	bh=6c/Kg1xNo27Op6XkICBNXx/Xoyvd+dKCNm9t6A13Ocw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sJVUbrMlSMimtTmD9gyqfJuXIVAE9M0+fwsjCFdzVivD6x7S7vNI0T/yIprrsvP8l2qgJMtsSejnO7S6AH6/MfKGQVICuOsYp2Uj4kIM0AZKQnx74huPXaFusg1DCegvh9q6hqBZXs/4R7OYX9L+k8jGgwpiQQ4vXxk+Irj+h50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKoFKO/r; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=byDQ0svV42bhS8jcWYgt9aqMD2j5B1jNfc8xTp24NdI=;
	b=pKoFKO/rCk+PlT2syTZQJWC9a3QSaWH+X24OJrcb1WlOssy1sdVXsdQOVZ/0ob45ylnstf
	uPK6RKkVRdE4PQHYD86pWseL08FTjPuSvnVaqQvDJceMaKEwquqxjITnfKZbIHmtE+IaK2
	sXg97FLsZhhlc6kXuxxFH68EOhiwApU=
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
	Sean Anderson <sean.anderson@linux.dev>,
	Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 0/7] PCI: xilinx-nwl: Add phy support
Date: Mon, 22 Apr 2024 15:58:57 -0400
Message-Id: <20240422195904.3591683-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add phy subsystem support for the xilinx-nwl PCIe controller. This
series also includes several small fixes and improvements.


Sean Anderson (7):
  dt-bindings: pci: xilinx-nwl: Add phys
  PCI: xilinx-nwl: Fix off-by-one
  PCI: xilinx-nwl: Fix register misspelling
  PCI: xilinx-nwl: Rate-limit misc interrupt messages
  PCI: xilinx-nwl: Clean up clock on probe failure/removal
  PCI: xilinx-nwl: Add phy support
  [RFT] arm64: zynqmp: Add PCIe phys

 .../bindings/pci/xlnx,nwl-pcie.yaml           |   8 ++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   2 +
 drivers/pci/controller/pcie-xilinx-nwl.c      | 124 ++++++++++++++----
 3 files changed, 111 insertions(+), 23 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


