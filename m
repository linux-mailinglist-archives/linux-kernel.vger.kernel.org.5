Return-Path: <linux-kernel+bounces-101452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB77F87A759
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B0DB21240
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546863FB29;
	Wed, 13 Mar 2024 11:58:45 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305721CD00;
	Wed, 13 Mar 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331124; cv=none; b=ZFOdnw22u68D+gAk5xrbYw/SLQDyQss8skWBbH3GSHFXb3mgPbW0TsiBWSblK2FUojjy5sYpMas0butaguuUYm3+WqPvZe8yZzbIP5Vquz8atO1CqjCoBAy/AFbQlTGA1cuDwdHdhFi7XOJVrmuTAvSjO6zFDjIyrVP6L4zu4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331124; c=relaxed/simple;
	bh=aoEvFdGB+nG2R9xqMooV1MLL4u52sFIKEJkfVFd6HaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzQ/+L2qFhXcOwNZB8oIs6dzBSOP4JypnzM2F8nsMitjyI0sZfRc+Gx8t1hC43YjtUHPPu6rz7saxeHFXxEfAACawbaga4bfGLuh6+Z9yz2ot8xN9JmlCL16W7GbvmLtxUdjxt8kDTF3ofgtltQMCAgKhVSNuACducyJ426FqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0013.koleje.cuni.cz [78.128.191.13])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42DBwUok065194
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 12:58:31 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, balejk@matfyz.cz
Subject: [PATCH] input: ioc3kbd: add device table
Date: Wed, 13 Mar 2024 12:53:42 +0100
Message-ID: <20240313115832.8052-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without the device table the driver will not auto-load when compiled as
a module.

Fixes: 273db8f03509 ("Input: add IOC3 serio driver")
Cc: stable@vger.kernel.org
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
I do not own any device using this driver, but I verified that modinfo
does not show the "platform:ioc3-kbd" alias when run on the module
compiled without this patch and it does with it.

 drivers/input/serio/ioc3kbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index 50552dc7b4f5..676b0bda3d72 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -200,9 +200,16 @@ static void ioc3kbd_remove(struct platform_device *pdev)
 	serio_unregister_port(d->aux);
 }
 
+static const struct platform_device_id ioc3kbd_id_table[] = {
+	{ "ioc3-kbd", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
+
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
 	.remove_new     = ioc3kbd_remove,
+	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
 	},
-- 
2.44.0


