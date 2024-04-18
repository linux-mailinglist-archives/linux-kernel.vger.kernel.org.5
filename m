Return-Path: <linux-kernel+bounces-149911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731768A97C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F195281769
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2BA15E1FE;
	Thu, 18 Apr 2024 10:50:36 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878815D5D3;
	Thu, 18 Apr 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437435; cv=none; b=Ao6LfugeKlF4pPg9odvvBOQIC5HituDdmBWkGzkNlJ9zy4fo6UkN3SLeMPypM350yYypsktCJfOYAbSKSoTsmXsMadpqYfp5peAlmd5nPNcDQhfQx3WLbkeq8aooCb62qyYQHkW0hVYD4dELFqt2wzGUqpffFdqIaouVGWFH5O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437435; c=relaxed/simple;
	bh=FGPmtNVxMZjBo3vCKgEDev/KwARhmHgHALkJdN6ckUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFV9XB5R4TKDRrHYZuUx0n31Okat2dmR1t9bdK+7HmEGMCbY/ImxebdzBN1mFNDgrwFrzo1kFFiaN1KgcaTcHFQDmNlF1gMCDYjnz0P9BC0cDuUx2A9n3n8Vl/3lbh+Qg+l5dIxHj73QU9TbViCLO8hb90hSithukEi6pEfHonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1713437400t0692sa9
X-QQ-Originating-IP: 7zWAIrAbQg+muCVcADIzCgLr34gUnFanMA3THMcPEuU=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 18:49:59 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: /5D9664O2EV9Uc6QyTB3AFwf1hFnZCsD/RBva1FsPM/uo8P6J/B5V2u7wz7uJ
	9btRUrxD8YKo2PrZz7kXzbmIzm5iCObi4Rf6DxkiSHmJGAzUchnXzJiSIe/vH2bQ2av4Iw3
	IMRjwyGLbjNNkrEVuA1YrBQk1z+D8RoqrgVAhrijppb0aeLvURiqUd8dQnYMlCXspc11S+8
	kPTQt2u5w2ne71YGqzuwOnqSnIRaz3wbHD4LFpj3ALtbCtsjI63uHLHaojZvYyl0JS/fU3E
	l5U12lkpW0EIPO8GP64KsmsgGzsPUMY9zx2NnZJEW7KxHbpGBbPhbPCYJtg5L6yiEKGc4Fr
	TbnG7dm/GFUI2oyArgPUsyeHfVvvwhAobUKfHL5SAvuIxt9Q8kHM3XdKIYvmIXDe5MSP4PT
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13167488483409716727
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 0/5] Remove onstack cpumask var usage 
Date: Thu, 18 Apr 2024 18:49:44 +0800
Message-Id: <20240418104949.3606645-1-dawei.li@shingroup.cn>
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

Hi,

This series aims at removing on-stack cpumask var usage for sparc arch.

Generally it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Dawei Li (5):
  sparc/srmmu: Remove on-stack cpumask var
  sparc/irq: Remove on-stack cpumask var
  sparc/of: Remove on-stack cpumask var
  sparc/pci_msi: Remove on-stack cpumask var
  sparc: Remove on-stack cpumask var

 arch/sparc/kernel/irq_64.c       | 10 +++-----
 arch/sparc/kernel/of_device_64.c |  5 +---
 arch/sparc/kernel/pci_msi.c      |  5 +---
 arch/sparc/mm/init_64.c          |  2 +-
 arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
 5 files changed, 18 insertions(+), 44 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


