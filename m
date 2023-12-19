Return-Path: <linux-kernel+bounces-5513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B8818B89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B091284C78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB71D558;
	Tue, 19 Dec 2023 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGZ6s/uI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9E1D529
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08150C433C8;
	Tue, 19 Dec 2023 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703000864;
	bh=vD7Qje2e5zx74+SAAnwR4GIvB/r8Tg9rSRMD9k+r2n8=;
	h=From:To:Cc:Subject:Date:From;
	b=bGZ6s/uITfwIpC2wBycYd81315kAJOgKnV+PoQVeWYlzEOQWtGy0ebzxc4b+JIulQ
	 VZPUqeMh+S0IFwbsaoaXphTzPC+ZRvQUueW2OujHCpylw6gCnoL4/oYrJ+avrEVQPb
	 vY+G6DJP8FNxQnNItooFF125r+nhBSJC7N3QTLt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: fthain@linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH] nubus: make nubus_bus_type static and constant
Date: Tue, 19 Dec 2023 16:47:41 +0100
Message-ID: <2023121940-enlarged-editor-c9a8@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 48
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=vD7Qje2e5zx74+SAAnwR4GIvB/r8Tg9rSRMD9k+r2n8=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNu2Um72RyuhtcOCvvxJZyfvOORXsW+n1/qbNx6pUf7 wsdvFRPd8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEZBwYFmz/tMGYq/9GTWPm yTPn+9Z9iQn5tIdhfvizhkK3NM97D5fHBYnu+v96x6sF5wA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the nubus_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

It's also never used outside of drivers/nubus/bus.c so make it static
and don't export it as no one is using it.

Cc: Finn Thain <fthain@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nubus/bus.c   | 3 +--
 include/linux/nubus.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index 72921e4f35f6..12df4d88970c 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -32,12 +32,11 @@ static void nubus_device_remove(struct device *dev)
 		ndrv->remove(to_nubus_board(dev));
 }
 
-struct bus_type nubus_bus_type = {
+static const struct bus_type nubus_bus_type = {
 	.name		= "nubus",
 	.probe		= nubus_device_probe,
 	.remove		= nubus_device_remove,
 };
-EXPORT_SYMBOL(nubus_bus_type);
 
 int nubus_driver_register(struct nubus_driver *ndrv)
 {
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index bdcd85e622d8..4d103ac8f5c7 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -89,8 +89,6 @@ struct nubus_driver {
 	void (*remove)(struct nubus_board *board);
 };
 
-extern struct bus_type nubus_bus_type;
-
 /* Generic NuBus interface functions, modelled after the PCI interface */
 #ifdef CONFIG_PROC_FS
 extern bool nubus_populate_procfs;
-- 
2.43.0


