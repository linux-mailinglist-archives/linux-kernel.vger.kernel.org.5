Return-Path: <linux-kernel+bounces-83950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3886A075
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF401C23DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A5143C48;
	Tue, 27 Feb 2024 19:48:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AB524D0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063338; cv=none; b=D6s3hO4c0olxeXV5f0uB+iUDCrjRT4nPtbpigHFz/hb252vmK+Plx2tni0IOV4IXz16BNZ7qscuRKIZMEmbKIhjyq2Pka0Y+eaRQxwqgtrvkr5Q0fqtfAAjrvKBn0a2ZbUhfW0p8ZVjDywzKmYh1UlGS52D6j/JTAUey43BLqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063338; c=relaxed/simple;
	bh=djPZd5I/pMg6e5I9NCeoqTVSDgCYM/N+fPrTMqPZHO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlwEsSMBz709lTxTh0ESmBXJzTSnUu2ecDXkdTPqqeym9IKcQnlB2H4+ssVANiHYqEpi+edvMUswyhzH/OyLe0iB/PllLPvY2Xbh5qZZlZchrx8nx2ZVOHe+4ElprB6BbMyjaYLZvkWZ32LITPndndAOsExk2ympjAwrgScKut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BBADA7;
	Tue, 27 Feb 2024 11:49:28 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A563F762;
	Tue, 27 Feb 2024 11:48:47 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/5] Rework SCMI Clock driver clk_ops setup procedure
Date: Tue, 27 Feb 2024 19:48:07 +0000
Message-ID: <20240227194812.1209532-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

a small series to review how the SCMI Clock driver chooses and sets up the
CLK operations to associate to a clock when registering with CLK framework.

SCMI clocks exposed by the platform sports a growing number of clock
properties since SCMI v3.2: discovered SCMI clocks could be restricted in
terms of capability to set state/rate/parent/duty_cycle and the platform
itself can have a varying support in terms of atomic support.

Knowing upfront which operations are NOT allowed on some clocks helps
avoiding needless message exchanges.

As a result, the SCMI Clock driver, when registering resources with the
CLK framework, aims to provide only the specific clk_ops as known to be
certainly supported by the specific SCMI clock resource.

Using static pre-compiled clk_ops structures to fulfill all the possible
(and possibly growing) combinations of clock features is cumbersome and
error-prone (there are 32 possible combinations as of now to account for
the above mentioned clock features variation).

This rework introduces a dynamic allocation mechanism to be able to
configure the required clk_ops at run-time when the SCMI clocks are
enumerated.

Only one single clk_ops is generated for each of the features combinations
effectively found in the set of returned SCMI resources.

Based on sudeep/for-linux-next.

Thanks,
Cristian

Cristian Marussi (5):
  clk: scmi: Allocate CLK operations dynamically
  clk: scmi: Add support for state control restricted clocks
  clk: scmi: Add support for rate change restricted clocks
  clk: scmi: Add support for re-parenting restricted clocks
  clk: scmi: Add support for get/set duty_cycle operations

 drivers/clk/clk-scmi.c | 226 ++++++++++++++++++++++++++++++++---------
 1 file changed, 179 insertions(+), 47 deletions(-)

-- 
2.43.0


