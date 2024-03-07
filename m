Return-Path: <linux-kernel+bounces-95604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13874875012
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449041C234F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417512DD8E;
	Thu,  7 Mar 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BSM3Rc2s"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66812C7E6;
	Thu,  7 Mar 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818459; cv=none; b=TfDiyStYvwivgr4DVjNGaq5qiKy3ATyC0sXXQ6b9MgFrl7CHc1u4N3jxWEK2RZ86qJmjgSIJpQchoBg8my7+vZwCkbGuRT9McQvKpO9znGifPDuAzHoSWg5M65c9Sew8xFmaNZBEF3d7e9q4WbXAhf0CjAbqGeh6pbXTf6/ghuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818459; c=relaxed/simple;
	bh=xUlBpmb0di+/Oq5gPxw44wMQ9DN9MwcNDjYg1cBWBgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXabDK2IPKT691peWhr68V7rhB4fchKgnlHJCJ3Jj0ViJ5GnqK0IZPTgF0/+lF6yXX47wAmV0C63sOpEPUuQAHKSgFtloEud1Mwaj9HNb2Gj/v8PsMl5sMDHYpiOVpvU3JRhhuj3IGTuHtadvfNq040qxif6kfyHjmsMP9VjR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BSM3Rc2s; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279qNWo012206;
	Thu, 7 Mar 2024 14:33:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=7LeJn9+
	Q9QIQtH5uQXab1IA8eA4efREKX5wOGGIBS3M=; b=BSM3Rc2sTkwW/SSubKD6fLC
	05z9P3/Fm2m48yRgq+w9jQ8/5phafEptIDVMXf7zaHOZtjHRn/W0MKm7C8ARTUap
	V18vADY8+pIyXUXZBb3mVQNibh+EHyOgyAQd0jFp4IliSMU7PGzpijnp+gDG+JQj
	6x6G2H9cfzJYbMEsg0hIC8/IJ9eaVsrLz644TnKqZNJrbdcsRhI5u9lpDEvg4gdC
	nnULL6foMcqKriiWuBT5QndpYxDYkBJtTpZWWsPyG9uiBMd3dv1Qf+JVRrVAGG59
	SHFXpCq0HXDkcJbcdnfQ1qnD062Cgu1vrNVBNc03JTRsDitYNSU488DSB4fEjyA=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5dtn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 14:33:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9EFE94002D;
	Thu,  7 Mar 2024 14:33:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C987F279E99;
	Thu,  7 Mar 2024 14:33:25 +0100 (CET)
Received: from localhost (10.201.22.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 14:33:25 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 00/10] counter: Add stm32 timer events support
Date: Thu, 7 Mar 2024 14:32:56 +0100
Message-ID: <20240307133306.383045-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

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

Changes in v5:
- Rebase on counter-next, where COUNTER_COMP_FREQUENCY() has been applied
- Add collected Reviewed-by

Changes in v4:
- Introduce new COUNTER_COMP_FREQUENCY() macro
- Mainly update two last patchs, to address William's review comments
  (details in each patch)

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

 drivers/counter/stm32-timer-cnt.c | 461 +++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h  |  13 +
 2 files changed, 460 insertions(+), 14 deletions(-)

-- 
2.25.1


