Return-Path: <linux-kernel+bounces-102166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0A87AEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E001C23104
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226841948E1;
	Wed, 13 Mar 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zii+vZtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F97E1948C6;
	Wed, 13 Mar 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349384; cv=none; b=UMcYL8+Csym7NGUY+CtSaDORPUWi7f2M7E2UcvGJL05xE+fGe1n99AZxY7cGLnXQ6WD9MGJyPtNuKci2KAVlEqp8rv1xsmhxwHZVoDwRSdx7fO6sdu3aWCSVUPt+38a9gWM3Ma+PjwoyqfAMeUSxQki1fL3wJvdKjkdEaVL9l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349384; c=relaxed/simple;
	bh=AwSfW00Oqx1S8JYMbz0iz8+zYd9ifGgR8q1OwaY3Cls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0jr3s0jDecOqYkMROEiCcXxKxrkqEQOq+2M22rx21ttn7w5oK1f1pVvgfu8/SBjDxLMKr7x9hrJhHPcoUAoncxP1gYVAbXmESAuL/llXx8S9n2++4fqaCSyuFQJEPP2J4BcvAcGi0AmXtIdxb785tisI9AXES+U1wrR69GDl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zii+vZtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3DAC43394;
	Wed, 13 Mar 2024 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349384;
	bh=AwSfW00Oqx1S8JYMbz0iz8+zYd9ifGgR8q1OwaY3Cls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zii+vZtvKy8VMMT1lf+9DwC1A/XDAIqRq3gWe+2otLrw1LuJdH2bwg3Pl3GMm5Yqf
	 bVYO9ocBhe1frnBDFBy+QwZFL63WX95AqciIj7B//Xhjs+EUeS3hbS07vifrDDZx0h
	 89P9punGTWf1BGTf1hgW3H9sW467THK6+I7Q9laHPpUNPnKK0X2B1jm2O4a4klux4i
	 O66QAfOWOmxaEb7D0M21JtE7lpJQJT9Y50F+OxmicBSXtv6ACESU0GRZNX8QSY4qVO
	 iyM+yeRgjcYfwnZ+MOepAHNrsIsv0raXmyILI5Z6wjN4dNigBOhRhJrsfzWfhThy6A
	 lAE5g5Ixxxedw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 45/51] serial: max310x: Unprepare and disable clock in error path
Date: Wed, 13 Mar 2024 13:02:06 -0400
Message-ID: <20240313170212.616443-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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


