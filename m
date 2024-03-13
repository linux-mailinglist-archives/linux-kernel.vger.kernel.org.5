Return-Path: <linux-kernel+bounces-102092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D887AE53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24271282C97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDCF18CEA0;
	Wed, 13 Mar 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgwFB9ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589A18CE88;
	Wed, 13 Mar 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348476; cv=none; b=nhfQgvedj04YMCRqWAsLvSRhflx576g05jIYZsvPGmF3xa3qe4Z0vwBmsaGIIL+Uv7wFctWLBMDvzegilNMWE/tlqL5pDW8eJUmQitkEvooLJNnNO5g/PgfmZWrsTXYfHv0/SGq5TGB4K2SRMHbUYVcawKHL+DKwrUQn0x47yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348476; c=relaxed/simple;
	bh=AwSfW00Oqx1S8JYMbz0iz8+zYd9ifGgR8q1OwaY3Cls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZDDeAEKakrGhY++ChLja+dpOLOYBgvkSCZe9Tnl76htq8t1lGJ9UGYByotW1eExugBOt84WU93MSZpAHgTS5nTfVmj1gHwAsVyGHotbXlPvZh/sb3xAB6orE9i6GRg/7yxhSeKKk12D8CP9Vl7Kx/zz1JdJr61jKcNW1nQkIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgwFB9ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7524C43399;
	Wed, 13 Mar 2024 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348476;
	bh=AwSfW00Oqx1S8JYMbz0iz8+zYd9ifGgR8q1OwaY3Cls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgwFB9tamHTJ+uJE7KVFyTfnoKR52mhVZYldsYgTRlzq/OeYNtDfeSOS14IS14/YA
	 brXueKtAApPJSyhuipGfcapgqLZXYPCScPTKtLreMHrnD/s2MxhyXUZX8V7OFFdEXI
	 dM383uYYBClCZydgBPSJce6I1ltPrXvJ+nGoZYyK/5pxWVkhO44b+DwKtsjMRTJtI1
	 h3IP8H993omHy2fOcNJsX9AEbiIprgoml5WYGtkZ6F9wtjvURNI37jVzeutfzfzlf6
	 EzdUdSZG34mYQdUApgKMpM31RKbTTsNPMPDsVtuWeBRCWEo75ko3oI2o2YWScf0WyM
	 MiR2tsT4Ssm+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 66/73] serial: max310x: Unprepare and disable clock in error path
Date: Wed, 13 Mar 2024 12:46:33 -0400
Message-ID: <20240313164640.616049-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 61acabaae5ba58b3c32e6e90d24c2c0827fd27a8 ]

In one error case the clock may be left prepared and enabled.
Unprepare and disable clock in that case to balance state of
the hardware.

Fixes: d4d6f03c4fb3 ("serial: max310x: Try to get crystal clock rate from property")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20210625153733.12911-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 978d9d93127e5..a09ec46e0310d 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1293,7 +1293,8 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		freq = uartclk;
 	if (freq == 0) {
 		dev_err(dev, "Cannot get clock rate\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_clk;
 	}
 
 	if (xtal) {
-- 
2.43.0


