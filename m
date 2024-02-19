Return-Path: <linux-kernel+bounces-71846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3A485ABAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A732842F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BC482FC;
	Mon, 19 Feb 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EoGXnPCJ"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375447A4D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369105; cv=none; b=IY0UJvfsrxFV8DYMqS1ougOfZbWxLDL8+8ebDgBiWKNawyQJbIsOtU63pXcnNyW44aAHKBa0DYfs++UBxeRlz69/FlLMKrIR71tRYWL2zs5h7EggZfqTQu71dVMrFAuNo1cWe8IAVz0b47bvQkadZsCjPpmrIsMzKEucYDV6qk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369105; c=relaxed/simple;
	bh=5OU0GHTdrAKrf4dsHeadS9f7uXCHbQibWUgINaNMk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4s9WZHBJiFeSjKLaedx9fcVgNtppcRuLc2n6qha/WaGive5S+b6E9Sj1nXBm+kEjyc4xHAwfePwFv8J6LUpWdnoihRo7bdn3wCBvcwju3SX19AVBsgQan6PXoz5+y3EPnAGk/0A6+zUHwgwW+u7buAyPWJQ5jQxiTM7fMtSFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EoGXnPCJ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708369101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pW+8iNQbeLyIbXJPdyK8epJlh98fOASyjU7Mp6Za3ys=;
	b=EoGXnPCJuOK9jAEWm2hEqf+Nlz33xTl/DnShq8918M7ywhjJ4P8txTql9CiVAZXo0w19Ms
	n3wG07f6xe/IXqediWEBTfKzf4PSvw8E4vx4xlPFMTKB9WuEoJ8AxMwI9cok6qLJBoosFy
	8t4HI2Dl21Qc3YEpGST/4tWy2GDLCBY=
From: Oliver Upton <oliver.upton@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Jing Zhang <jingzhangos@google.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 0/3] irqchip/gic-v3-its: Fix GICv4.1 initialization after kexec
Date: Mon, 19 Feb 2024 18:58:05 +0000
Message-ID: <20240219185809.286724-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix an issue with GICv4.1 redistributor initialization after kexec,
ensuring the vPE table gets reinstalled even if the kernel is using
preallocated LPI tables.

First patch is worthy of a backport back to the introduction of GICv4.1,
second two are intended to avoid these mess-ups in the future.

Tested by kexec'ing into a new kernel on a GICv4.1 system.

Oliver Upton (3):
  irqchip/gic-v3-its: Do not assume vPE tables are preallocated
  irqchip/gic-v3-its: Spin off GICv4 init into a separate function
  irqchip/gic-v3-its: Print the vPE table installed in redistributor

 drivers/irqchip/irq-gic-v3-its.c | 50 +++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 17 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.44.0.rc0.258.g7320e95886-goog


