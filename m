Return-Path: <linux-kernel+bounces-156180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3208AFEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D24B24235
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944713B2BF;
	Wed, 24 Apr 2024 02:56:37 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432A7F490;
	Wed, 24 Apr 2024 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927397; cv=none; b=aD1Jljgd+UFypxtF62OaHcDpOqtkWmLHS3klKSQlbF2VmsYn+QVC22xV83ogQe6I9JgaUXTTSf8mck9YlH6DLK6Y6/Sks9fiFQchzeSHBOkmo8ZjKPLbwLz2f2uFUT4WuQHpXk2XsLyqf07maTHcZ+0WxfttmeB2E9CeOE5dTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927397; c=relaxed/simple;
	bh=yb8eJJPFl2tkuFQKzjHMxdKWsZ9qcqM55zk2rzYZcCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ccfBH3J8aqZbtMdpekfSW23rBTW/bFTnSHYyGUKhSWEpdfvbUIfZGjFZOfrwSKwURVoEhYfAfV1ZBQZ/IwTYvBmPilYhLXQFVovPYA5yfm0PYsOr3LhM4C8crR2wcnIM/p8+qOWeJgQ32y/orZ18P7V/miyVjloyc08grqOmbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1713927354tf7i31l
X-QQ-Originating-IP: yi9okuZ1DjO/2d4GcZAw+6JBRr0iS7O8rnPasZkzw2Y=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Apr 2024 10:55:53 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: znfcQSa1hKboFoGnXB/PrQQ0NNwe+m6eDs3goMm7htGyD+AKm7LTs6X2jWl5j
	M5ER50h3POS0SpVpGxyjhEtogJU+GDNOu1YsNQrzUxYrLs7/YBGDQqdWq4grdNhkhrKTMUj
	adSlXjRZyqTdrF/sshiw4nLE7gOdAlmrZQDGr4NAGgJFV5sjyZbPzVdxI8HlabHKFLJP2TW
	r8Pwng790psoWLoGAbIXlDQFBm8/BcOL28wr4K6LjAgQ/9ctCjr4wTbJlZVpgtfstRdoyL4
	7MIiQafjI8uxMCxqz5vC98UnoWWGWBxbQgmtC7oQNkJevqsxAMvOa23VppPlX7d0xdMhZ6N
	MBNseG7vHaRbYnK2dQJT3CJ1FIIqrn3la5l8tBz7Z8tajaQvWU9U4wUdRVARmwPjIe/J1oT
	sr9TXxlvV70=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18105697174608553188
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v4 0/5] Remove onstack cpumask var for sparc
Date: Wed, 24 Apr 2024 10:55:43 +0800
Message-Id: <20240424025548.3765250-1-dawei.li@shingroup.cn>
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

Hi,

This is v4 of previous series on removal of on-stack cpumask var for
sparc arch.

Change since v3:

- Rebased against for-next of Andreas.

- Add Reviewed-by from Sam.

- Remove PATCH(sparc/init: Remove on-stack cpumask var).

v1:
https://lore.kernel.org/all/20240418104949.3606645-1-dawei.li@shingroup.cn/

v2:
https://lore.kernel.org/all/20240420051547.3681642-1-dawei.li@shingroup.cn/

v3:
https://lore.kernel.org/all/20240423083043.3735921-1-dawei.li@shingroup.cn/

Dawei Li (5):
  sparc/srmmu: Remove on-stack cpumask var
  sparc/irq: Remove on-stack cpumask var
  sparc/of: Remove on-stack cpumask var
  sparc/pci_msi: Remove on-stack cpumask var
  sparc/leon: Remove on-stack cpumask var

 arch/sparc/kernel/irq_64.c       | 10 +++-----
 arch/sparc/kernel/leon_kernel.c  |  7 +++---
 arch/sparc/kernel/of_device_64.c |  5 +---
 arch/sparc/kernel/pci_msi.c      |  5 +---
 arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
 5 files changed, 20 insertions(+), 47 deletions(-)

-- 
2.27.0


