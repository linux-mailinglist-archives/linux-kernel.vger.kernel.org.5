Return-Path: <linux-kernel+bounces-105749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30E87E3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63651F215A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72822087;
	Mon, 18 Mar 2024 06:42:27 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1622612;
	Mon, 18 Mar 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744147; cv=none; b=S9OftS8H0Rg4HpWrGsPP2OVh89fwO/tqFO3PondUYZWlTNtPCklheS0XwyzlZ3JJPz+n8ms0SmPzlbRPMfNzvHtBiZ57LU9RUQQrVKsxZgupA/2diD+xbfenejLgh79BGIlP4FePqrYxxX4PRBa5RKouEAQHx8nsvULZYu3W9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744147; c=relaxed/simple;
	bh=PWYCjG1RUX4B3xxYUQthNnqRe0G2F1gmxMOFgQ5o2vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C+E+j7MDyBUVTg2SieYxijdU+aTTG7VarRFFUIKysQ3KtDKt8uwy9v1M0D47bm+u8zK/iiu9l//aB+/4WgZHPZhkdCMLV9ASSw58ZdL3bGxB6+J4F98NUylHN+MZRy2VIsYr5OtgqCy95y5/CM4ftE+gKpIh1hxZBA59U8A7OAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id OZI00019;
        Mon, 18 Mar 2024 14:42:19 +0800
Received: from localhost.localdomain (10.94.10.188) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 18 Mar 2024 14:42:18 +0800
From: wangkaiyuan <wangkaiyuan@inspur.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <andriy.shevchenko@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	wangkaiyuan <wangkaiyuan@inspur.com>
Subject: [PATCH 2/2] tty: serial: sc16is7xx: convert to use maple tree register cache
Date: Mon, 18 Mar 2024 14:42:16 +0800
Message-ID: <20240318064216.1765-1-wangkaiyuan@inspur.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024318144219cf7f534fda99d27d1e15aa6df0c5cfc9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e1..410b772cdbb3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1696,7 +1696,7 @@ static struct regmap_config regcfg = {
 	.reg_bits = 5,
 	.pad_bits = 3,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = sc16is7xx_regmap_volatile,
 	.precious_reg = sc16is7xx_regmap_precious,
 	.writeable_noinc_reg = sc16is7xx_regmap_noinc,
-- 
2.27.0


