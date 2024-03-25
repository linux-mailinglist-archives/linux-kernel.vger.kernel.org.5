Return-Path: <linux-kernel+bounces-117998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0388B22A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AD51C62D89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEE5C919;
	Mon, 25 Mar 2024 21:00:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE55BADF;
	Mon, 25 Mar 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400451; cv=none; b=HQMSUcr0vcz9TrHvMz+hVyXxM0jKa/GHLMKPnIlJNfUpBP1S4RzlEE8tj8GJI6P804SpakahwvtkI0ektrqblCNtWK/q0wOjtx797WHa7TAYCBpESa/NdFg/MDQQXSAh1L+VHfW4VETiLsBzMGbUsGEb5l3dQ0tKus54GCAWwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400451; c=relaxed/simple;
	bh=VGfW2ygdXRe0beLL5uJWPnIFplxxoJfWxlkqmFCAWfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhcBuliABhYonPsnj+C5mzk28jN37/o0kjQTS/ypUSvBUa5XQaWldgEkwQFY5cTRIn78m9YlNpQVQBEK/OOQzf+DRmbiIc7ZMtoXtF/XH2EDBklc6Vu8Gd4YA9wnzuNZr9vrBlR9pFp4vLtorbTQVt7VsJdkgElFGEnZ3zNtZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159FC2F4;
	Mon, 25 Mar 2024 14:01:22 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5EF3F694;
	Mon, 25 Mar 2024 14:00:46 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Rework SCMI Clock driver clk_ops setup procedure
Date: Mon, 25 Mar 2024 21:00:20 +0000
Message-ID: <20240325210025.1448717-1-cristian.marussi@arm.com>
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

Only one single clk_ops is generated for each of the features combinations
effectively found in the set of returned SCMI resources.

Once this preliminary rework is done in 1/5, the following patches use this
new clk_ops schema to introduce a number of restricted clk_ops depending on
the specific retrieved SCMI clocks characteristics.

Based on v6.9-rc1

Thanks,
Cristian

V2
- rebased on v6.9-rc1

Cristian Marussi (5):
  clk: scmi: Allocate CLK operations dynamically
  clk: scmi: Add support for state control restricted clocks
  clk: scmi: Add support for rate change restricted clocks
  clk: scmi: Add support for re-parenting restricted clocks
  clk: scmi: Add support for get/set duty_cycle operations

 drivers/clk/clk-scmi.c | 226 ++++++++++++++++++++++++++++++++---------
 1 file changed, 179 insertions(+), 47 deletions(-)

-- 
2.44.0


