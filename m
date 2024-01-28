Return-Path: <linux-kernel+bounces-41703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A683F6CB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974821F258D0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEEF52F9A;
	Sun, 28 Jan 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcQxntly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E052F75;
	Sun, 28 Jan 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458327; cv=none; b=bchGjQKLVXyNngeqj5NnKCt5qmz7fvo4dI+Nq2CTanDcvLSwbLRv2YOUT3wwr+tc2xAsHmFLmwlck9dX4S2aNeZZHjrtr0YUZYc9w37Xiw7P+83OQlQRU87n9Ra+sNuZFPddjt0rDMAk+5fHJKvPAJvcucFZsFPYlmtIs0tNv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458327; c=relaxed/simple;
	bh=+fZ0Nxb4A9KjgBR/X0X6eaaTRkFBI5A2CAqOGHMBIZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCPth+1FSi/VKMUv5xi5fSwjscW7ELd+xEbDtNDOsTqUARAcRRdbPa3Ggl4v+MS6i17Th5HmY1rMf2RxNIzaPN8V0rJN0b5tOy0ow+hDyY6jNQR7+PITqQLf0SOCNaRnssZ4rbkUvOnhNL0XLG6EC4TLvny6Tpl/wifUyayYmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcQxntly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12ACC433F1;
	Sun, 28 Jan 2024 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458327;
	bh=+fZ0Nxb4A9KjgBR/X0X6eaaTRkFBI5A2CAqOGHMBIZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcQxntlyJrb4rAT7AFmPoaBCGlZIltkU+4E7/3VUxluKw+qvqQGYs4omh/phPpyFF
	 VNY/mywLIMJR8dUeuVB2oV8IFBq1b13zMs0WnsggnUeLG6wax5LDdMWEvdwA8om+tn
	 NrfWaoCKNtqxhuNEafwmZwCbA3Eoh6as8S0LMlmEbK1VVlD9CwHuof/RpbBIQ6yIMJ
	 YQ0wqJvNY5hceBdEO/YyhU7XnO1Ti+VUaZVFPs1/MltGg3JzbmIM4hMKzghvZrD5y5
	 drxUWGcaIZ7LP9cdGcTcgcB+2oKyoTjgGr2RpwpvU3bbgn7P7am1acdK91jNIu/6tN
	 m2pbbt2QIfOZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	eric.piel@tremplin-utc.net
Subject: [PATCH AUTOSEL 6.7 21/39] misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback
Date: Sun, 28 Jan 2024 11:10:41 -0500
Message-ID: <20240128161130.200783-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
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
index 3882e97e96a7..c6eb27d46cb0 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -150,6 +150,7 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client)
 	lis3_dev.init	  = lis3_i2c_init;
 	lis3_dev.read	  = lis3_i2c_read;
 	lis3_dev.write	  = lis3_i2c_write;
+	lis3_dev.reg_ctrl = lis3_reg_ctrl;
 	lis3_dev.irq	  = client->irq;
 	lis3_dev.ac	  = lis3lv02d_axis_map;
 	lis3_dev.pm_dev	  = &client->dev;
-- 
2.43.0


