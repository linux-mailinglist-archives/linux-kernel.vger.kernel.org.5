Return-Path: <linux-kernel+bounces-150045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2888A9998
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8491C21060
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9115F415;
	Thu, 18 Apr 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QZKskoh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2515CD6D;
	Thu, 18 Apr 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442397; cv=none; b=FjBPyl8DleWTJmV3QrInVmU6lhTUch5VZgs2HYngzTpmL9z7tv8lLcqiwzcBVTbgmSkwbh/c88L1OZCtjC1Ei/oROP2zVW477Fu0qHShwxvMjG9Qcuc+OUmf/6CUxwDThGXkoUnTj+ups3O36b60a38pk4AqhZjtexSbJD5hllM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442397; c=relaxed/simple;
	bh=HxsguZAiND8dos6ZuH+ziu2ZtuOU9eBSUicLkDQ2/Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VM7MxIwXf98hOC1D4nJ63DYPUbGDGaDdMan2QBKSYX04GQDa00MSzRDlY82s/TXgBLpmbsRuGInTHNE48fiNXgAmUuFcCQTqdDWk8xe/9nWSWPTSgCSGmBY2bxoMIyKhhgao2P6s/1T8XTgwLJO74E/wak2srzSiSsMWOFp5zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QZKskoh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D2C113CC;
	Thu, 18 Apr 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QZKskoh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713442394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+oJqPZw5AQXZu4QX4SS/nMWpk2RFT/2PtyZ6M4OlIXA=;
	b=QZKskoh9gGyyCUC9/S43imrO9mAZx6p0nv2skuZ6DsSMGfHZkt2TbrOzoz9WKlMoowDbNq
	KKclte65w62fNb/VvGBYXPy1lan2vRF/6AaQvMRxOJkvPW3ENbrGPE9w+siySqQKMsSR5q
	MDWlch/KQanX7rnczAdhKC8XLGKs+Sg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e3547100 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:13 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudanl@amazon.com,
	graf@amazon.com,
	dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 0/3] virt: vmgenid: add devicetree bindings support
Date: Thu, 18 Apr 2024 14:12:29 +0200
Message-ID: <20240418121249.42380-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

This is a cleanup of Sudan's OF vmgenid patches, simplified a bit, but
still with the same intent and mostly unchanged. I'll take this via my
random tree, but I would appreciate having your ack/review on it.

Sudan - if I've mangled something here, please let me know. I verified
this still works with ACPI in QEMU, but I don't know about your private
firecracker OF branch, so please pipe up if something is amiss. It's
basically the same thing, though, so I suspect it'll be fine.

Thanks,
Jason

Sudan Landge (3):
  virt: vmgenid: change implementation to use a platform driver
  dt-bindings: rng: Add vmgenid support
  virt: vmgenid: add support for devicetree bindings

 .../bindings/rng/microsoft,vmgenid.yaml       |  49 ++++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   2 +-
 drivers/virt/vmgenid.c                        | 150 ++++++++++++++----
 4 files changed, 166 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

-- 
2.44.0


