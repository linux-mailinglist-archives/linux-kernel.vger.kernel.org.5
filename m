Return-Path: <linux-kernel+bounces-7097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CB81A1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E4287B43
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07843FB04;
	Wed, 20 Dec 2023 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zzM5Qfya"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6043E472;
	Wed, 20 Dec 2023 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKAZxDt026700;
	Wed, 20 Dec 2023 15:57:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=nUweHrL
	oWkVRbhnzAdO5FIQ7Oh566+WDmUQR5BF8Aow=; b=zzM5QfyatUw70qMKDTp9vGN
	9e/2t/4vy/Zx7oYVwSQJp+IfMN5inPFoY0LJEs3kKrZW/MESikvqSqhg/lbMU1mC
	DF/QGvLurAEc3JSP++E3WJxwWkwEwciQA85DqzZvtnbtCmrQ5nzKgB9PGsrVZT0k
	Wjxh3TpdJVOFiOpMyULgy6spK/tQ1XbWCBV9leWOUcJIapdigQFWN9g6vxQyQ4Wm
	/ILm4fd8v5bEDGH3YD9BNza4HNvzgC6bQW53eIC39mjj2+EIBkufxvKKvFf6nYmC
	fLnUaCyS8nzg8/MNR6YJosua5QJoxpdEsUXh5/Oz9X2pAUTPwm1tFK6F8xjoPsw=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v11w91w9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:57:55 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8EBB3100057;
	Wed, 20 Dec 2023 15:57:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70A7B21B511;
	Wed, 20 Dec 2023 15:57:54 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:57:53 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/10] counter: Add stm32 timer events support
Date: Wed, 20 Dec 2023 15:57:16 +0100
Message-ID: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_08,2023-12-20_01,2023-05-22_02

Improves the stm32 timer counter driver by introducing new signals,
e.g. counting frequency, and missing channels.

It also adds support for interrupt based events using the chrdev interface.
Two event types are added in this series: overflows and capture.

Up to now, stm32 timer counter driver focused mainly on quadrature
encoder feature on channel 1 & 2. It was limited to timers that has
the HW quadrature encoder.

With this series, all timer instances can be enabled for:
- Quadrature encoder on channel 1 and channel 2 (when supported in HW)
- Simple counting on internal clock
- Capture counter value when rising and falling edges are observed at
  channel 1 to channel 4 input (number of channels varies depending on
  the timer instance used)
- Push overflow and/or capture events through the chardev interface

Changes in V3:
- This series has been split [1] and renamed.
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
- Watch events tool patch applied, hence dropped from this series
- Refactor / split several patches
- Keep original signals order, to avoid breaking existing user space
- Don't adjust number of signals: adopt static configuration. rely on
  error mechanism to manage diversity across STM32 Timers instances.

Changes in v2:
- counter fix and improvement patch applied, hence dropped in v2 series
- mfd patch applied, hence dropped in v2 series
- revisit watch events tool (mainly command line interface)
- add one patch to rename STM32 Timer counter
- various review comments from v1

Fabrice Gasnier (10):
  counter: stm32-timer-cnt: rename quadrature signal
  counter: stm32-timer-cnt: rename counter
  counter: stm32-timer-cnt: adopt signal definitions
  counter: stm32-timer-cnt: introduce clock signal
  counter: stm32-timer-cnt: add counter prescaler extension
  counter: stm32-timer-cnt: add checks on quadrature encoder capability
  counter: stm32-timer-cnt: introduce channels
  counter: stm32-timer-cnt: probe number of channels from registers
  counter: stm32-timer-cnt: add support for overflow events
  counter: stm32-timer-cnt: add support for capture events

 drivers/counter/stm32-timer-cnt.c | 455 +++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h  |  13 +
 2 files changed, 454 insertions(+), 14 deletions(-)

-- 
2.25.1


