Return-Path: <linux-kernel+bounces-158519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE18B219D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099461F22DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92D12C461;
	Thu, 25 Apr 2024 12:30:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4012AAEC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048202; cv=none; b=Q0Lq+V0CkJbxQ7Pq1GR39EksN7zVEyDCG7WPoQX1kLgE2QU2K/Kh0zhveWDdozprju000tNDPz1tPy3Fr/lnfXuK/vGFu/tuIzEHj2C2Kw8iFklH3PbAsZDUhazeGsu6SkYNLKq7cC0lTRqvKLAscBK2/xkVcr1TUwgNGzTJLYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048202; c=relaxed/simple;
	bh=XOtdz2GBJHzfYj6u0+iNlZEZ0z81Fddcu4ldoyMhmlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOIifmHWibcOkT+p4FXLet9z9eCCDDZW9kv/yw60U9yOrsMr09T4v2kHRInLXzKsGVNipzAIn7gO7GxdtN9kRdwBKghW6OKxE0Ob4SxYPgP4sVdwyV2hh6JDAtSCNbRPL9v2S8FZvORT7G2XlZquD9xYdWa4G29iT0W9GgyJHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C83521007;
	Thu, 25 Apr 2024 05:30:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB75E3F7BD;
	Thu, 25 Apr 2024 05:29:58 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 0/3] perf: Add Arm Network-on-Chip PMU driver
Date: Thu, 25 Apr 2024 13:29:51 +0100
Message-Id: <cover.1713972897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Somewhat later than hoped (sorry!), now that it's finally had the chance
for enough testing to flush out all the silly bugs, here's the NI-700
driver I've had kicking around in various forms for the last 18 months.
I squashed in NI-710AE support since that appeared in the meantime and
the differences are minimal, however I have not felt compelled to go
back and genericise all the original NI-700 references. I don't think
I'm giving too much away to say that there will be further new product
support to add in future, so I will be back with more soon enough.

Note that the driver patch depends on the the cpumask_any_and_but()
addition queued in arm64/for-next/perf.

Thanks,
Robin.


Robin Murphy (3):
  dt-bindings/perf: Add Arm NI-700 PMU
  perf: Add driver for Arm NI-700 interconnect PMU
  MAINTAINERS: List Arm interconnect PMUs as supported

 .../devicetree/bindings/perf/arm,ni.yaml      |  30 +
 MAINTAINERS                                   |  10 +
 drivers/perf/Kconfig                          |   7 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/arm-ni.c                         | 767 ++++++++++++++++++
 5 files changed, 815 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
 create mode 100644 drivers/perf/arm-ni.c

-- 
2.39.2.101.g768bb238c484.dirty


