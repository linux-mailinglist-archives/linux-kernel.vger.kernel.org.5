Return-Path: <linux-kernel+bounces-97580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44A876C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5401C21831
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44A5F47B;
	Fri,  8 Mar 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uyLuEqbz"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02625E062
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931644; cv=none; b=KyDJfBXvotte3GymABeOBnU61MIJ/cckEVqru6myMyEi7xjoau0/6VIjllBmeFGCvLBOBOuM28R4pc90wq8N0dFCmqFnWDuLs+5hK1zO93bzO3jHs3aNUle7peNcOvgkSZNEa9c6kVBlVT+T0RLjQUdaJDqOEr++5zSoDsla4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931644; c=relaxed/simple;
	bh=3K5ULUfKXMnPO5jig2Y0yO2WjJR3O/sqFArdDG+H1sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8McqIP3YkCsWMGTZXpZDyTKV3RTKj00nLEJXKDWg9IfW6xfavxxhWgtdZa7wfdZpTm0PgO3n83Ge+ZPtwdQLyaLB95swxlSG2sQBCDp9pY6uulMbtn+tVZAUCEcqhytYlQ6gK7YyEAlyNf4qeqnKRhArEb7M/ZSLIP9EjymFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uyLuEqbz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709931640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QehjjxOVDT80rxgpnNGSVuuYoo3gXQUxxRf5l1oRF9w=;
	b=uyLuEqbzqAr2mbfreaXd4U5ktA6Pld8IeViU6zghRiluUWjgxd/YMB2xl04jL4z55T9yrI
	7tiwRB/mzzz42njknXjyvBcZk5fRL5+im/OIoRaEiU2Mcmw52ngTiirxUXVSt+d+3/ca02
	wh/Cenpo1Ua7grID2vIS54CtvQ8O6/I=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Tejas Upadhyay <tejasu@xilinx.com>
Subject: [PATCH 0/3] dma: xilinx_dpdma: Fix locking
Date: Fri,  8 Mar 2024 16:00:31 -0500
Message-Id: <20240308210034.3634938-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series fixes some locking problems with the xilinx dpdma driver. It
also adds some additional lockdep asserts to make catching such errors
easier.


Sean Anderson (3):
  dma: xilinx_dpdma: Fix locking
  dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
  dma: Add lockdep asserts to virt-dma

 drivers/dma/virt-dma.h            | 10 ++++++++++
 drivers/dma/xilinx/xilinx_dpdma.c | 23 ++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


