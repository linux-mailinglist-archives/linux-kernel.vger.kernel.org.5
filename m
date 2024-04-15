Return-Path: <linux-kernel+bounces-145566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261C8A57E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940651C2307A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F682891;
	Mon, 15 Apr 2024 16:37:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797582487;
	Mon, 15 Apr 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199027; cv=none; b=A57F19D9fsAKPoA5Ndf94reR6ksLwj3ooXQW9bTqrMgtk3IIIrpBhfAz3nzJy33ePAXMSkQTSMLNqYG9DH3ECPM5SDsrvRambe83mBCbknYkIPGMap/Ai5NswVFRk5ITmTVbyXKlgAAOzf138ZDEh7g/xtZrOTxdSW/zNQ9/1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199027; c=relaxed/simple;
	bh=laaffI+rGw07cNCZQZVakY5R0esIrFMlcl33TjYlg1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROUyHGusjBq68XVJp/6WGvNh8fmZ4rhHAQNlXlEHCtckE6zsEtqZjusYlpCWLsOIbv42Q+YuK9FJuDA+b1AXysx9nYXViJ09SQuj4FV2u6os+625bVL0THQv7vICgwG+I3lTdozqFYSX05/giQVsfPCzw869tNRahDNwy8LL8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01642F4;
	Mon, 15 Apr 2024 09:37:32 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C9DB3F64C;
	Mon, 15 Apr 2024 09:37:02 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 0/5] Rework SCMI Clock driver clk_ops setup procedure
Date: Mon, 15 Apr 2024 17:36:44 +0100
Message-ID: <20240415163649.895268-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
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

Only one single clk_ops is generated (per driver instance) for each of the
features combinations effectively found in the set of returned SCMI
resources.

Once this preliminary rework is done in 1/5, the following patches use this
new clk_ops schema to introduce a number of restricted clk_ops depending on
the specific retrieved SCMI clocks characteristics.

Based on v6.9-rc1

Thanks,
Cristian

v2 -> v3
- moving scmi_clk_ops_db from being global to a per-instance/per-probe
  structure to avoid sharing devm_ allocated clk_ops between different
  driver instances.
- using bits.h macros
- fixed a few dox comments
- explicit unit in atomic_threshold_us
- added a runtime size-check before accessing scmi_clk_ops_db using feats_key
- reworked scmi_clk_ops_alloc call to reduce nesting
- using transport_is_atomic instead of is_atomic to be clearer
- using SCMI_<feats>_SUPPORTED instead of SCMI<feats>_FORBIDDEN

v1 -> V2
- rebased on v6.9-rc1

Cristian Marussi (5):
  clk: scmi: Allocate CLK operations dynamically
  clk: scmi: Add support for state control restricted clocks
  clk: scmi: Add support for rate change restricted clocks
  clk: scmi: Add support for re-parenting restricted clocks
  clk: scmi: Add support for get/set duty_cycle operations

 drivers/clk/clk-scmi.c | 249 +++++++++++++++++++++++++++++++++--------
 1 file changed, 201 insertions(+), 48 deletions(-)

-- 
2.44.0


