Return-Path: <linux-kernel+bounces-41828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F252D83F826
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36808B215B7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137852F6C;
	Sun, 28 Jan 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY2L4iQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9008148309;
	Sun, 28 Jan 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458630; cv=none; b=XsUEsT0YqFLxBLyOgTXLRwnc7odb4aQjZ2ntVDgDVJdehoSi0jy2eMvSK5jSBq7T29O3yqJ24hFDuod1joRHNbrwEwRn5LNV5qyCAgP/7FjiiXumBQb3P/b0DuviRqUI6IzK+h/ySs+A/WpqIWE/8OJnzKlQQAEUVXaA2PxszjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458630; c=relaxed/simple;
	bh=Ozbl9lP0AmxpwPp3oa01zQIN9FIA1Lu/jLDLKxX96a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdWhtqHKwaraqS7TUR9dKnUQl+z4aiRQ66haYikDWMZZ4nxaacgfsSw12zkAwDVug1C6ailj+30RMfgp6MIL25fQdVXxm1C2CtTFflNqiJRHZ2qDPbRiprQGw37iQQTFTC1Pnnbklyb0f0h8BNyimLLoOwrJe0g2kwolNbaDX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY2L4iQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09A9C43399;
	Sun, 28 Jan 2024 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458630;
	bh=Ozbl9lP0AmxpwPp3oa01zQIN9FIA1Lu/jLDLKxX96a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OY2L4iQtuJMK+yPhH8dUBYebPGKE79TAzz7wrKRyDu9X4ZszlfSAFfN7/ZMIqvkwm
	 6ZakZfpdnCtTzjulOddet3kO8civylvX7qbDtu0htHWHWFbwdUg7p4iZWA6o5K3A8r
	 V3W+ieXkOAg96+tz81qsGw8R6+r7vTkivABgkzNr0xuUOyTLhPgjVrFkPzUp7h5zf1
	 OBD7VoTMdDTMt77+nAHQ1LyURmesB9BOHSKoLaTNZvLkQ1RQUu9bWWzqGTed7rOztU
	 yfyzXwQSSkRm82Y+BXYxyre4IG3e5jla1BN8+GjzlC36mPWrC2/eE96JY43/LtxupB
	 82I4W3XrwQ2zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	eric.piel@tremplin-utc.net
Subject: [PATCH AUTOSEL 4.19 3/8] misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback
Date: Sun, 28 Jan 2024 11:16:54 -0500
Message-ID: <20240128161704.205756-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b1b9f7a494400c0c39f8cd83de3aaa6111c55087 ]

The lis3lv02d_i2c driver was missing a line to set the lis3_dev's
reg_ctrl callback.

lis3_reg_ctrl(on) is called from the init callback, but due to
the missing reg_ctrl callback the regulators where never turned off
again leading to the following oops/backtrace when detaching the driver:

[   82.313527] ------------[ cut here ]------------
[   82.313546] WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put+0x219/0x230
..
[   82.313695] RIP: 0010:_regulator_put+0x219/0x230
..
[   82.314767] Call Trace:
[   82.314770]  <TASK>
[   82.314772]  ? _regulator_put+0x219/0x230
[   82.314777]  ? __warn+0x81/0x170
[   82.314784]  ? _regulator_put+0x219/0x230
[   82.314791]  ? report_bug+0x18d/0x1c0
[   82.314801]  ? handle_bug+0x3c/0x80
[   82.314806]  ? exc_invalid_op+0x13/0x60
[   82.314812]  ? asm_exc_invalid_op+0x16/0x20
[   82.314845]  ? _regulator_put+0x219/0x230
[   82.314857]  regulator_bulk_free+0x39/0x60
[   82.314865]  i2c_device_remove+0x22/0xb0

Add the missing setting of the callback so that the regulators
properly get turned off again when not used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231224183402.95640-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 14b7d539fed6..e8da06020c81 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -164,6 +164,7 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client,
 	lis3_dev.init	  = lis3_i2c_init;
 	lis3_dev.read	  = lis3_i2c_read;
 	lis3_dev.write	  = lis3_i2c_write;
+	lis3_dev.reg_ctrl = lis3_reg_ctrl;
 	lis3_dev.irq	  = client->irq;
 	lis3_dev.ac	  = lis3lv02d_axis_map;
 	lis3_dev.pm_dev	  = &client->dev;
-- 
2.43.0


