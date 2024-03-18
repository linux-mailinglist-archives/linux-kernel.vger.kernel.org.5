Return-Path: <linux-kernel+bounces-105748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BD87E3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A3AB20EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3B22087;
	Mon, 18 Mar 2024 06:41:58 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FC22612;
	Mon, 18 Mar 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744118; cv=none; b=rOfT6k3OVSGaN1QKMjuK2GtcFLUsAuTle2CtUY2e/jbEwxqpJyiVs488R8mLKAsp31ACNmpnlo/UdugQIKYe9bVND05z+C4bp3K8ry5oy/DJyYtDMHykf1zOyuq8y740UVijT37dsptmh0hWMjl3JKQRXd5QCKJ5vCvc3LJTWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744118; c=relaxed/simple;
	bh=AATr7CGNc+WPe0fSd7MYXySc17AXkQBdU/dEvJNO1uE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y/NyHqZbYTl2rCBvVAMtyG6wznSNIKEpolKklDz6eTggwXRrM1XMgbxF0S8b61HJ5Iq1c64u1ly6WLtmkM3kurhWWjcNwGLgGO4vrwdDkXmp0O4zgq87/DTlSKcm8FW/Kh2B4Jtql5TXHya/E6uu1iq3F5dGwB1bYQK9ARE63Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh247.corpemail.net
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id OZG00039;
        Mon, 18 Mar 2024 14:40:39 +0800
Received: from localhost.localdomain (10.94.10.188) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 18 Mar 2024 14:40:37 +0800
From: wangkaiyuan <wangkaiyuan@inspur.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<hvilleneuve@dimonoff.com>, <andy.shevchenko@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	wangkaiyuan <wangkaiyuan@inspur.com>
Subject: [PATCH 1/2] tty: serial: max310x: convert to use maple tree register cache
Date: Mon, 18 Mar 2024 14:40:36 +0800
Message-ID: <20240318064036.1656-1-wangkaiyuan@inspur.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024318144039383f8983b5a35fcdbd5d1775ba0cebaf
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 14dd9cfaa9f7..3b72b2137275 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1478,7 +1478,7 @@ static struct regmap_config regcfg = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.write_flag_mask = MAX310X_WRITE_BIT,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = MAX310X_REG_1F,
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
@@ -1582,7 +1582,7 @@ static int max310x_i2c_extended_reg_enable(struct device *dev, bool enable)
 static struct regmap_config regcfg_i2c = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
-- 
2.27.0


