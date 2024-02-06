Return-Path: <linux-kernel+bounces-54407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B020184AED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC91F237AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF91292D8;
	Tue,  6 Feb 2024 07:14:42 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C3128837;
	Tue,  6 Feb 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203682; cv=none; b=HWVmlZAfLkvk/w/+gJXFCeOpkpCW0qrsDmM66a1ouG3EcV6yXVe1YxsrFCaiMak6mnHeUD/kElsVZFc5jXtqEnM7DQ1ocxvqQvlHJrFDGgfnr5rygCbCg1SIbXH6+uDHoArHdDKDDgQOQKdZ3J3l+oDad1UxkxnzSi/B1WZSkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203682; c=relaxed/simple;
	bh=u2IB6ZvRRCA8m3BGj7669aLh1okQbyK7JwexDiQP8KU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ncastn1Ad8WCeiXypoUZSShuZvjJ95bPQeCT8fw+tYJwAlz0ZcoNTZ8Krxi8nJsj7zT0j+6TCg6YueVumFX6b98g/opdEOrUEjiyiBEFPjPjqt8DxqxNkEYABLOZKPADtql9t2qU4bPAIF5xXYKShaMlJHkneM2PwOnpvOH7yaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id CZT00124;
        Tue, 06 Feb 2024 15:13:24 +0800
Received: from localhost.localdomain.com (10.73.45.222) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.34; Tue, 6 Feb 2024 15:13:24 +0800
From: Bo Liu <liubo03@inspur.com>
To: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
	<support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
	<ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
	<mazziesaccount@gmail.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH 00/18] mfd: convert to use maple tree register cache
Date: Tue, 6 Feb 2024 02:12:56 -0500
Message-ID: <20240206071314.8721-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 2024206151324b9f9b62304e62d05a8d60d6ab6a8ea99
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Bo Liu (18):
  mfd: ac100: convert to use maple tree register cache
  mfd: as3711: convert to use maple tree register cache
  mfd: as3722: convert to use maple tree register cache
  mfd: axp20x: convert to use maple tree register cache
  mfd: bcm590xx: convert to use maple tree register cache
  mfd: bd9571mwv: convert to use maple tree register cache
  mfd: dialog: convert to use maple tree register cache
  mfd: khadas-mcu: convert to use maple tree register cache
  mfd: lochnagar-i2c: convert to use maple tree register cache
  mfd: wolfson: convert to use maple tree register cache
  mfd: rohm: convert to use maple tree register cache
  mfd: rk8xx: convert to use maple tree register cache
  mfd: rn5t618: convert to use maple tree register cache
  mfd: rsmu_i2c: convert to use maple tree register cache
  mfd: si476x: convert to use maple tree register cache
  mfd: stmfx: convert to use maple tree register cache
  mfd: stpmic1: convert to use maple tree register cache
  mfd: rc5t583: convert to use maple tree register cache

 drivers/mfd/ac100.c         | 2 +-
 drivers/mfd/as3711.c        | 2 +-
 drivers/mfd/as3722.c        | 2 +-
 drivers/mfd/axp20x.c        | 4 ++--
 drivers/mfd/bcm590xx.c      | 4 ++--
 drivers/mfd/bd9571mwv.c     | 4 ++--
 drivers/mfd/da9052-core.c   | 2 +-
 drivers/mfd/da9055-core.c   | 2 +-
 drivers/mfd/da9062-core.c   | 4 ++--
 drivers/mfd/da9063-i2c.c    | 2 +-
 drivers/mfd/da9150-core.c   | 2 +-
 drivers/mfd/khadas-mcu.c    | 2 +-
 drivers/mfd/lochnagar-i2c.c | 4 ++--
 drivers/mfd/rc5t583.c       | 2 +-
 drivers/mfd/rk8xx-spi.c     | 2 +-
 drivers/mfd/rn5t618.c       | 2 +-
 drivers/mfd/rohm-bd71828.c  | 4 ++--
 drivers/mfd/rohm-bd718x7.c  | 2 +-
 drivers/mfd/rohm-bd9576.c   | 2 +-
 drivers/mfd/rsmu_i2c.c      | 2 +-
 drivers/mfd/si476x-prop.c   | 2 +-
 drivers/mfd/stmfx.c         | 2 +-
 drivers/mfd/stpmic1.c       | 2 +-
 drivers/mfd/wm5102-tables.c | 2 +-
 drivers/mfd/wm5110-tables.c | 2 +-
 drivers/mfd/wm8350-regmap.c | 2 +-
 drivers/mfd/wm8400-core.c   | 2 +-
 drivers/mfd/wm97xx-core.c   | 6 +++---
 28 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.18.2


