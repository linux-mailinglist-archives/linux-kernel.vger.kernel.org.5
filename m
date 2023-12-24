Return-Path: <linux-kernel+bounces-10799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8A81DBF5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F09F281EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8118C24;
	Sun, 24 Dec 2023 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA7iF933"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30418C17
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703442856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvZOHxWVh/mJiCQHlq/7UwzyMBE7eRNX3nk6Uoehacw=;
	b=GA7iF9339OKz6TJhZuD623+BSyK2mXpcLq4aGEl7Oal1uS2Nutq2OJ+15N/PiWd9PQlhoJ
	10AeeUrXpALIqcco5x9nI5HA3sI0gH+S77Z7XpYN5faYsX3zDGQ0FpQ2qdwlynyglAAt5x
	EAOHjL/8Hb3Ni8GpZur4+6ZjWQ1s76c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-PpWDDgHrPOimc3FcWeExTg-1; Sun,
 24 Dec 2023 13:34:11 -0500
X-MC-Unique: PpWDDgHrPOimc3FcWeExTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D592738562C1;
	Sun, 24 Dec 2023 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE44A51D5;
	Sun, 24 Dec 2023 18:34:09 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Eric Piel <eric.piel@tremplin-utc.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback
Date: Sun, 24 Dec 2023 19:34:02 +0100
Message-ID: <20231224183402.95640-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The lis3lv02d_i2c driver was missing a line to set the lis3_dev's
reg_ctrl callback.

lis3_reg_ctrl(on) is called from the init callback, but due to
the missing reg_ctrl callback the regulators where never turned off
again leading to the following oops/backtrace when detaching the driver:

[   82.313527] ------------[ cut here ]------------
[   82.313546] WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put+0x219/0x230
...
[   82.313695] RIP: 0010:_regulator_put+0x219/0x230
...
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
---
Note I've deliberately left out Fixes && Cc:stable tags, this driver has
not been touched in ages so apparently this bug has been with us for ages
and has never really been a problem. So lets play it safe and not backport
this.
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


