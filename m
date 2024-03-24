Return-Path: <linux-kernel+bounces-116096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EE889941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CB02A70E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBE3A8179;
	Mon, 25 Mar 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiURJUtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43A27DE07;
	Sun, 24 Mar 2024 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323573; cv=none; b=imo35hP3DcCHN/AvzWoPbgZSxLuPinmWWCyby8Dh96EqLhhFH8GTuUUONkB6BrQYA1A0I8PIf4mEgCAUGwAXPFW1nf8wRmbBxhncZwwCFm7MCWqDY6FItgDa2DOczwjZmuzfGbbkLFJZdHVySdKY6F92JdDFot4ILDhZ9BsLkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323573; c=relaxed/simple;
	bh=76JkSKRm97cAdcOCps2E8v0iYvWOcRRw5O6tKYzS5aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq9MdRNUfJZWpGRi3UVwVtuEgkN+H73zT4EtMKF/w6swqtnaWxH0KY4aHc4uj8DCpzKxZ7TXoSG7gcPTpr5aqqiU6iOuWL9IxPlyf+onjGSNwEv2RneamQynfHo6dQo5pci4cLgYIm1tIy7sCicAtz/Cq2088u2V5k2krZMZiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiURJUtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D6BC43399;
	Sun, 24 Mar 2024 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323572;
	bh=76JkSKRm97cAdcOCps2E8v0iYvWOcRRw5O6tKYzS5aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiURJUtln9/vq+Mfy2HPAJsEgzWQpKaMFOPNuL3s9iYd8zl6jbBdBlKguBPgqr7Cv
	 kEQ/iQkPM8opHWM6zgsxzdeFxdoKG/V8pyVcFUyjnASnMk60J97an65YIQXhrspbCi
	 sY9ZA+1reRaZXMHqzXeCDX5+Pjt30oWukbKYpi6MbezhP6HtpXZ++8mv4lTdHSAnoD
	 +YcvVupQZm/1Cu9i/4TShH1tGSYwDIfqsy3Ho0FYgpUx9a8daOTjChiiyeAhYZstb8
	 gO6b9IVrKURBJPO5VCD1vXj5cnVwGHGCy9sencYEceDbg1YN38kbdv8ANcr7q9WnIb
	 ANr8X80eQIuHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 279/317] serial: max310x: fix syntax error in IRQ error message
Date: Sun, 24 Mar 2024 19:34:19 -0400
Message-ID: <20240324233458.1352854-280-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index c122e7e90fc89..714c23f9504fc 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1433,7 +1433,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	dev_err(dev, "Unable to request IRQ %i\n", irq);
 
 out_uart:
 	for (i = 0; i < devtype->nr; i++) {
-- 
2.43.0


