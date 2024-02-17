Return-Path: <linux-kernel+bounces-70042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23A859234
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E263A1F21FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E717E58B;
	Sat, 17 Feb 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Yx0qN48Z"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C217E586
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199695; cv=none; b=tdtZ0IIbuprAniAJdiGtQrIHD+XXvcdU+h+qYaXahu/Gkzl89x5jKVzPXLtZywEQDo3vIieKkd4aSc47ZMgdW3JZsdXi0EuwFc8gjy6Ixmt7a0+eBgt97VABkyUVX1Fy9lw/LQcUGRWU18BOCR9kLM3UWfHYHHr5RIxW3C+9Ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199695; c=relaxed/simple;
	bh=5B2tqwdAd/7cOO7ni6BM2Qq2D6cyGQe6gEUTcdh1o0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGUWhbFni3YuLNlWPHWYVk95auUtSROGEwf+CUzlEtp2B2N/AJkYJ7HOhtWeL8RY+E9pG94H0V+G0Y4Oi8ta237Dibkygn5LMErVtiJ2M/altm972gJSZfpSmTWTGGUQz029P+zGQnJuGvc7AHLS4TJ5K6Ha/wHsoibkKvNuYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Yx0qN48Z; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708199690; bh=5B2tqwdAd/7cOO7ni6BM2Qq2D6cyGQe6gEUTcdh1o0w=;
	h=From:To:Cc:Subject:Date:From;
	b=Yx0qN48ZlSDGwit5VnHGv+6fkR4z9AlguC5ICQW8lVNM00a2zcNXRkeUyl2hUF6iV
	 KrbHcfmDF45B/9UwHMcsFXVaQiGbuDXM2gfNED9vysQkGkZMgnpvBE3oylzqcLMQ3v
	 fpya6lQt5AidvVUOgb5e1V42oUqpaMaxV4KipNcM=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 3/3] mfd: rk8xx-core: Fix interrupt processing order for power key button
Date: Sat, 17 Feb 2024 20:54:35 +0100
Message-ID: <20240217195444.1767178-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Process rise event last, to avoid stuck keys when multiple interrupts
are coalesced. This can happen typically when resuming from suspend
via power key press and holding the power button for a bit too short,
so that RISE an FALL IRQ flags are set before any interrupt routine
has a chance to run.

Input subsystem will interpret it as holding down a power key for
a long time, which leads to unintended initiation of shutdown UI
on some OSes.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/mfd/rk8xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index b1ffc3b9e2be..e2261b68b844 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -43,8 +43,8 @@ static struct resource rk806_pwrkey_resources[] = {
 };
 
 static const struct resource rk817_pwrkey_resources[] = {
-	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
+	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 };
 
 static const struct resource rk817_charger_resources[] = {
-- 
2.43.0


