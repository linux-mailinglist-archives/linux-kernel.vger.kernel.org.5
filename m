Return-Path: <linux-kernel+bounces-32578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34151835D79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AD71C21F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3F37143;
	Mon, 22 Jan 2024 08:59:24 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E2364C5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913964; cv=none; b=aa3DzAd9SnO+CAwrFYGzgChjrwSmCgTQA9NP4uDvPhAij04Mpf+hSi9T6nfGRVZQdm1xX0+6+4k9hu/3wnWgIPt+aNFqD1ULJhUWmOSLo9vggZ8IQwx0Zh7Ti3KUYaHHygowxfLSU84DQPSc3GgIgKDrX6YDYQNjOgcbMnwuGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913964; c=relaxed/simple;
	bh=TpdjWgl8rm+e8R5g/T7zj2OakXIxhkuLtJETNTCb2QM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzUqWsuS2/5JIL9l0Ign6B1oig7VMA5cDknKeEKCoxQ0XZFI/RJsFRXUTrSZeZisM8M6+375E8zUgQO6C55B3K+9wIFriu9amkV+QKO10QI4kTZwSMMrPNNRc7PAlWMZVNrazuXtuBKasdnWPFTupYly/sqZK8vfxEhpC3XV290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1705913931t1q1my5r
X-QQ-Originating-IP: eK/IfaiV/0lQpObfzrGBWw31Gb5grgDe6EGOaiE9ut0=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:58:49 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: I8hG9CuxGDJNZ5pk5XwddWQNmlaPcjGGg98kYiC3fcAAvalo7BtD20kGubVwb
	K+aOHokAsjyt5UshKmyGw1dBNi/aBa09uZTLkT2Eg4qmScsIPyxTjfAJWCnL6CP7oOb+Eql
	hBP4GujLNrS7nqccEIs6uPrFouYFzbDhDM522iDDIgWnfUVVTDRRiebnnLnfEuMVlTLG7d9
	7MOjhuVTQ0fyYHw2QC4iXdKxKU0/eO5c8UH6RE53v4ufOGYJNYuCDL2+zKN6LoJABUPpJzF
	zfJz+9dqKJWY4DdpyLg6o6hY/HdAMBwB1ASxRQtw4LRUDeHq3jxgwr1WoOAG1hChn+XOrs1
	9JBrLEHy6NUmEfbHAGGwlR1idZqhx+XLk2t3X5mjhZymi+XHFYxnVseniEt8k12mbOZzL3a
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7828049924746051990
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH v2 0/5] Minor cleanup on gic(v3) and genirq
Date: Mon, 22 Jan 2024 16:57:11 +0800
Message-Id: <20240122085716.2999875-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Thomas, Marc,

This is V2 of previous series[1] of minor cleanup on GIC(v3) and genirq.

Changelog:

v1 -> v2
- patch[1/5]: Address the issue by Marc
   - 1000000 -> USEC_PER_SEC;
   - Vertical alignment of parameters;
   - Update commit message;

- patch[2/5]: Address the issue by Marc
   - gic_irq -> irqd_to_hwirq replacement;
   - Convert the type of struct irq_data::hwirq to irq_hw_number_t;
   - Some coding style improvements;
   - Add Suggested-by from Marc;

- patch[3/5]: No change

- patch[4/5]:
   - Add Acked-by from Marc;

- patch[5/5]: New
   - As suggested by Marc, implement a dedicated API for irq_desc init

Dawei Li (5):
  irqchip/gic-v3: Implement read polling with dedicated API
  irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()
  genirq: Remove unneeded forward declaration
  genirq: Initialize resend_node hlist for all irq_desc
  genirq: Introduce generic init_desc()

 drivers/irqchip/irq-gic-v3.c |  55 ++++++++---------
 drivers/irqchip/irq-gic.c    |  27 ++++-----
 include/linux/irq.h          |   2 +-
 include/linux/irqhandler.h   |   2 +-
 kernel/irq/irqdesc.c         | 112 ++++++++++++++++++++---------------
 5 files changed, 102 insertions(+), 96 deletions(-)

Thanks,
    Dawei

[1] v1:
https://lore.kernel.org/all/20240118112739.2000497-1-dawei.li@shingroup.cn/

-- 
2.27.0


