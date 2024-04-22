Return-Path: <linux-kernel+bounces-153882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C198AD472
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E1A1F23801
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19C154C16;
	Mon, 22 Apr 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BUUNOJ2g"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54C219E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812293; cv=none; b=P7oNcfbD+WpEEptm65DvyvUw2O1Cq9ovR+qOODwf1uu3rUaTs3pi4yh4NoLvKd5gZETtzESSMp2MDkkb78XO9mWFYIAMFvUKYfx0M9D1QWkRy/DGHqEeGiP0FOq7y09yrX6trjfpOnA5X52usdxAeJ/CPX518i0vYMAkEaCHmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812293; c=relaxed/simple;
	bh=gHUamq3eksIIe3LlnAfb/+E/e1qIFHSRh60rqNVc0sE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AYDuWiigbdun5tNQvPHoPXfWnou+mcVQA8z/DAWHoU30m2AUpRR4to1VxXy0YL5KsSw+FziJXMLvt8/rTQFQi/M44M7aBlovHsVLNy+20Jc5i2a9lEVWY3uw/k0vlZ3DuiBncEw7N7gCAN8aS66YQn3kXYVhbJhclBU5Z6W8/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BUUNOJ2g; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713812289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fTsWgzpR6TAFHUYP8yaObyYUy4tJKcjjHquOtGRhIDc=;
	b=BUUNOJ2gG5/4rEOCTq4iXCuV97JgHgZIBDl35crxeE+omMZhigOem8X8X0FNH5MQBILOCd
	LV9mENZITwhBRMJFIn9RsCPDDQcbZdeDg94by3/e320qsvOIwhuBznt6m0RFiBx53WwCJN
	515Kk+fLzmt9qHv0C4yU1BiJ9ak5sso=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/3] phy: zynqmp: A PCIe fix and debugfs support
Date: Mon, 22 Apr 2024 14:58:00 -0400
Message-Id: <20240422185803.3575319-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This has a few small patches cleaning up the driver, adding a fix for
PCIe, and adding some useful debugfs info.


Sean Anderson (3):
  phy: zynqmp: Store instance instead of type
  phy: zynqmp: Don't wait for PLL lock on nonzero PCIe lanes
  phy: zynqmp: Add debugfs support

 drivers/phy/xilinx/phy-zynqmp.c | 169 ++++++++++++++++----------------
 1 file changed, 83 insertions(+), 86 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


