Return-Path: <linux-kernel+bounces-156413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABB8B0288
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91C11F23A82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBEF158217;
	Wed, 24 Apr 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BewYgHGp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A62157E61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941614; cv=none; b=sktb60N/7W8ALxkm/wi5h0RBsLf2B7IuWfyWnFDY/YFBECoABy+rpaV78AJXZwM9W2TjN44Ts5RNZM3D7s6x7klMuIp8Q9dyyxstjfnhrFaBWtdxNgT3l5O97zAOoMVIvijHIwbMGzBci5bCD0u1Jr+EBSw6gC0VMRNa/dgSA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941614; c=relaxed/simple;
	bh=nZtK50s2pljvSWH9SjS8RhQ8MOr0YM/+RyiQ5mxFoAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h//7r/jfa888nuSh5ZkdLgikCVCBA8+HsYJGHv+CgpWZC+ku8EMCy4BTwwoPuzAgkwnG4D0RcKPZg1tH8HuKVR29SU5D/TmbhlsvhabKSjkIbfEHjslPNAlR4TrY/zNEJ0BXrq7C9WxkpatDao6LO8hEIffUTx1NRJpEf/+vpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BewYgHGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwh57ju7z3JS3Aj4lXtKKLhV+NDSnW3PVlUEuIh/LqE=;
	b=BewYgHGpHKi6HRzbY+p+aiMBRv+suFClhCht9FzU1D7YiY/SHurx+CaxDIhmcOLAneFUds
	2Ojdzu/PwJJeSm7M2F6bRTeNn+S+EDheuDvARB5T6uidDnyv65IeQUd6T1ACHSzI19xkCZ
	K7n/oJfzlS5+djOdL/9o27VmNtTLsDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-mw1Jc_EGO-iuh7_KCYermw-1; Wed, 24 Apr 2024 02:53:28 -0400
X-MC-Unique: mw1Jc_EGO-iuh7_KCYermw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9637E834FB3;
	Wed, 24 Apr 2024 06:53:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1382CC13FA4;
	Wed, 24 Apr 2024 06:53:21 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v7 2/6] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026 and 2027
Date: Wed, 24 Apr 2024 14:52:08 +0800
Message-ID: <20240424065212.263784-3-hpa@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
References: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This table shows the maximum support LED channel for KTD2026 and KTD-2027.
The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
4-channel LED controller KTD2027 controls R/G/B and flashing LEDs.

Datasheet: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/leds/rgb/leds-ktd202x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
index f1c810c415a4..60ca6ec34336 100644
--- a/drivers/leds/rgb/leds-ktd202x.c
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -606,6 +606,13 @@ static void ktd202x_shutdown(struct i2c_client *client)
 	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL, KTD202X_RSTR_RESET);
 }
 
+static const struct i2c_device_id ktd202x_id[] = {
+	{"ktd2026", KTD2026_NUM_LEDS},
+	{"ktd2027", KTD2027_NUM_LEDS},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ktd202x_id);
+
 static const struct of_device_id ktd202x_match_table[] = {
 	{ .compatible = "kinetic,ktd2026", .data = (void *)KTD2026_NUM_LEDS },
 	{ .compatible = "kinetic,ktd2027", .data = (void *)KTD2027_NUM_LEDS },
@@ -621,6 +628,7 @@ static struct i2c_driver ktd202x_driver = {
 	.probe = ktd202x_probe,
 	.remove = ktd202x_remove,
 	.shutdown = ktd202x_shutdown,
+	.id_table = ktd202x_id,
 };
 module_i2c_driver(ktd202x_driver);
 
-- 
2.44.0


