Return-Path: <linux-kernel+bounces-133493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB689A47B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA822855C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6F17279C;
	Fri,  5 Apr 2024 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByxBk627"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E66134C4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343671; cv=none; b=RY0e9ouhbjvAVc1pLmGEWOQVga5nhItNUo22bPidoMGkokVHgJzAbbdl1ccGx0ipbinBTIi1Ks8tyzYnedfmyJWLOzjNguDh7M8f8PLegA2Dnegg5YWwtZPuA9deqz314cfuvBOop3r3uCkCGzG+z39kxo0QRzvGlXDd00LFNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343671; c=relaxed/simple;
	bh=mEihz6zqcX9v7bQ02/ysSsNjr2UrPpG2hdP6uyBhtpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osYL45zwjdyychPAsNXmJOpLbhILsmyJ23/79exfCqQTUXRlkZ1AigLRkxBZqYyWU5kaTZWYJXndMkiG09a0BBMrYmQqvQt0u74J/Pb1eRyen+mCrFpFqQXHGFOc7H5y9I45ugutrxid0xJaEK2fJTng4VHN2/OgIvRcQz1AxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByxBk627; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712343670; x=1743879670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mEihz6zqcX9v7bQ02/ysSsNjr2UrPpG2hdP6uyBhtpo=;
  b=ByxBk627YEJT6qpGLWrp7VfJijHJpikSi3mifHpDewAzu4j80ySqUcnb
   91UmKTRhls9gbo33U1a2X1pcSna9qP2pFcuwjpt9xvpTe7Y8wOM2fQqVO
   eFmqzstdfOKy6RjrqlRSyQ0E9zs36s6uc71Cb1zi2f3CxwdTCfDWzX6pj
   rGMZmk01Os03Cqh5Y2gFvY/yUe+eiVqxyHt+pq+e02UIsBXB8bA4I5tdr
   M+o1oIJ67BExWytUipLZ7cfySpK8JTEWwXWZ2aahpLgaQDT2IfQnsTCuc
   4I6asl9GA3skF7D/pYueKllseQfsYJI79G32NJNjSlVf2njNdQAV5E+wJ
   g==;
X-CSE-ConnectionGUID: 0bQqd+xER+67xAknOtxa0g==
X-CSE-MsgGUID: tmGXhv9IQMKpb1Dlt9Mc+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7530968"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7530968"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088099"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088099"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 12:01:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4FC483E5; Fri,  5 Apr 2024 22:01:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH, resend v1 1/1] irqdomain: Check virq for 0 before use in irq_dispose_mapping()
Date: Fri,  5 Apr 2024 22:01:05 +0300
Message-ID: <20240405190105.3932034-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a bit hard to read the logic since we use virq before checking
it for 0. Rearrange the code to make it better to understand.

This, in particular, should clearly answer the question whether caller
need to perform this check or not, and we have plenty places for both
variants, confirming a confusion.

Fun fact that the new code is shorter:

  Function                                     old     new   delta
  irq_dispose_mapping                          278     271      -7
  Total: Before=11625, After=11618, chg -0.06%

when compiled by GCC on Debian for x86_64.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c871e091..aadc8891cc16 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -909,10 +909,11 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data = irq_get_irq_data(virq);
+	struct irq_data *irq_data;
 	struct irq_domain *domain;
 
-	if (!virq || !irq_data)
+	irq_data = virq ? irq_get_irq_data(virq) : NULL;
+	if (!irq_data)
 		return;
 
 	domain = irq_data->domain;
-- 
2.43.0.rc1.1.gbec44491f096


