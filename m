Return-Path: <linux-kernel+bounces-129750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F6E896F77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062141C267F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8A14900A;
	Wed,  3 Apr 2024 12:53:09 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CC1482E1;
	Wed,  3 Apr 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148789; cv=none; b=QcQPBQ9YjIY/FZcbFigAnQlfWXYaze9FEKwxNw6uWaR6x7Ghixyp8yxnfH3LO7UeXUF5pj1nPsbBv9S57y/jJ3mq024+w9pZFjBRPlErqqAVYOJ+JIDABBtA2ZoieMr4/cVXeQ+gHD4QJhu4C8HT3UaKSPcJXp2W5ix9U87g4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148789; c=relaxed/simple;
	bh=oEllcByHTb5ruy6A9Usqz1VtCeCPw7v0KZkyVRzJ3FY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PR+PNDeaLC3aAZfhqCnT3fM3tvTsVZRyC5PM4t60lr86s7pRsVzHRhtL9nTUYxLSBXCmfGsD3pZDQPANWsPH5uyweRSBVpqEtn4gQyYS9W3jECprx28cke0NGKlf256c1AwmjvCmkW4hvqqe22vfsWYUznDoZlYRVvtTnr2SFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz11t1712148686tdr3l7
X-QQ-Originating-IP: SM5s8FAZLkIg0k+zF/ph3vSArsy2doitvdgwni5O9z0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 20:51:24 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3j5lef41+AwE9Y+CgaUKkKYmVC9Hf7Y5u3aB2n+VoMXvS/oH3NmX
	CN9ZCNixChYwql3f3fM5oDTW1nlfJ7ur6GPa+OMpaISt8QpYZ3KML+ejjTkle5SChoMBkgB
	WfWGVyewEtJl6VYASlgkfrQIxq4VAaduXp54kOyVX4zNbMJghsvQkYBQYfi8cBHe5za7UEL
	rpIWIjPHyvAvgLrR26/oD3TEzfFgc9ReQ/8Uqkt3zOeI8x2Cu35qyHya2Z+AqCdmQCcfrYo
	HWGcPRgZh4ba2tQlpgXjn6fh2yfZl6dOsND1xR0VcpYdup7f5mWK8CO9qO3ty89A9yfewrJ
	fsCIZOvws9FjUKVUirxoDWz54Noyvtuf7ij3guUpEAwvlXSkbr+N1toNtijbzkM9eu74dlN
	OQKCh/y/vMYHRSkIBZDRvA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6104082383576056037
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 00/10] perf: Avoid placing cpumask var on stack
Date: Wed,  3 Apr 2024 20:50:59 +0800
Message-Id: <20240403125109.2054881-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi all,

This is v2 of [1] and [2] which basically eliminate cpumask var allocation
on stack for perf subsystem.

Change since v1:
- Change from dynamic allocation to a temporary var free helper:
  cpumask_any_and_but().	[Mark]

- Some minor coding style improvements, reverse chrismas tree e.g.

- For cpumask_any_and_but() itself:
  - Moved to cpumask.h, just like other helpers.
  - Return value converted to unsigned int.
  - Remove EXPORT_SYMBOL, for obvious reason.

[1]:
https://lore.kernel.org/lkml/20240402105610.1695644-1-dawei.li@shingroup.cn/

[2]:
https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/

Dawei Li (9):
  perf/alibaba_uncore_drw: Avoid placing cpumask var on stack
  perf/arm-cmn: Avoid placing cpumask var on stack
  perf/arm_cspmu: Avoid placing cpumask var on stack
  perf/arm_dsu: Avoid placing cpumask var on stack
  perf/dwc_pcie: Avoid placing cpumask var on stack
  perf/hisi_pcie: Avoid placing cpumask var on stack
  perf/hisi_uncore: Avoid placing cpumask var on stack
  perf/qcom_l2: Avoid placing cpumask var on stack
  perf/thunderx2: Avoid placing cpumask var on stack

Mark Rutland (1):
  cpumask: add cpumask_any_and_but()

 drivers/perf/alibaba_uncore_drw_pmu.c    | 10 +++-------
 drivers/perf/arm-cmn.c                   | 10 +++++-----
 drivers/perf/arm_cspmu/arm_cspmu.c       |  8 +++-----
 drivers/perf/arm_dsu_pmu.c               | 19 ++++++-------------
 drivers/perf/dwc_pcie_pmu.c              | 10 ++++------
 drivers/perf/hisilicon/hisi_pcie_pmu.c   |  9 ++++-----
 drivers/perf/hisilicon/hisi_uncore_pmu.c |  6 ++----
 drivers/perf/qcom_l2_pmu.c               |  8 +++-----
 drivers/perf/thunderx2_pmu.c             | 10 +++-------
 include/linux/cpumask.h                  | 23 +++++++++++++++++++++++
 10 files changed, 56 insertions(+), 57 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


