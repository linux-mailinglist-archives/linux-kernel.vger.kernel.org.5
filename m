Return-Path: <linux-kernel+bounces-113504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D88884D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69D61C24239
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D81BAC45;
	Sun, 24 Mar 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2FACutk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9F1BAC2B;
	Sun, 24 Mar 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320305; cv=none; b=rUeEa2ASJ46RmsGkzCJce4xtnwtuORZogPijtTjfH81ett32PkugRoAW/vECCLnZ8Xqu/BladqoKG3VOUsA8+1cN8fc12gOROR9PZisCEkSdqL4RWGXhrcb+iXGo1KLojD8C0n/+Uq99B20DsuXJ25a4NM389Qj4q0syyg3Dq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320305; c=relaxed/simple;
	bh=LVisl8OfVxIbrdEFZkynPMVduesmX11cmNWXaR+adV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6H58lGLZ4I5go1kLB5DG5bhsd9B6/mfkD2rq7YyIe+L3ST2L2VX5pU2x/YV8G8eulTyEL1l+SqsHSPgoRgyHbFPw7heIO9YNHRWgbFN59KnobQSUabww0IgrnQ/xKKlSwIlXmZ5xo3aaBetPzeNoU6V04+/qifu+ZfWGvjJw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2FACutk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50DEC433F1;
	Sun, 24 Mar 2024 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320305;
	bh=LVisl8OfVxIbrdEFZkynPMVduesmX11cmNWXaR+adV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2FACutkDyubAnz1LyxZFSKZaVKS+JJxRqunkOvc7gnmHpiZoGx/pb1rplUi8876W
	 S16dKoOW70BspRqSAXixHZsJKKSC8ldDwP+fK8FCWAwKLACBNQRd+1aOCGzV3V+TYZ
	 tziusVmurT90yA5kKR8VYA411290OVfbZ5ycaGKigaX4a9+K+iZuV3njPWV5SyQ/gc
	 JdKiw0xNezfK4AVBAog58KLsSIeLvEE8r93qmYEOq6w9W9N2YfiTM4fuURGRM2F58Z
	 cWxdSq3O/fH4nddZhX9c/6jmQz6SvQDT44UShARERbw0DaNYmM1ZeLNMSCh+/PIExV
	 0RrhtBQrwxUIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 613/715] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 18:33:12 -0400
Message-ID: <20240324223455.1342824-614-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 8ede8c6f474255b2213cccd7997b993272a8e2f9 ]

Replace g with q.

Helpful when grepping thru source code or logs for
"request" keyword.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240118152213.2644269-6-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 10bf6d75bf9ee..f70e2c277ab7e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1461,7 +1461,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


