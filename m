Return-Path: <linux-kernel+bounces-141632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F248A20F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD30E2866F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922F383AE;
	Thu, 11 Apr 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WVC6/N37"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396B2941F;
	Thu, 11 Apr 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871250; cv=none; b=l4OdcVW+7AH0LWAWWSggpyDvIkpgJZYYJQ4bCchRfDXeDPMC8fpe1HK3cEczUvhutzqgcrKa4svf0XRLLDe7vTFg8d9Z+9v0+izGi+Yvid8fl4IRKVMQqjDM05ymgWnhjwy1XDAqUt4gQKZbl7UlRMl3rfiDD4fg5g65H6Zs7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871250; c=relaxed/simple;
	bh=z2/Orf6yxKDaqub6BTAfFJIArBnI+mzGrz0nYL/Evhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eyeMg5poq006pt0dvPSGy6sbeOJzFYHvBXo8cB9chheAzEYMo+fWKUtd1H835mGENqd3OmW7CWbQYFJzXo5Bo48MVaddenYVWtTpME8VItGaefrlGkGSHUpzGHMzHOsw8hTo2hImHDzxUz5zzD1ZtdJMBz0BQMO33iA2pssLr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WVC6/N37; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712871236;
	bh=z2/Orf6yxKDaqub6BTAfFJIArBnI+mzGrz0nYL/Evhw=;
	h=From:Date:Subject:To:Cc:From;
	b=WVC6/N370UZmJtUN/b6OgQnoVXrQ58ZDT6hxbmTb2vITO3XnoZxbdtmfGvcIzeQkY
	 9TZNXBKI2rnl/vj9mZDdi/YxK/bufqqhocH6QrCdiHCzrMnMzCQv7X3sHNa21izw/P
	 i51h2YPw4UUzqwaKDh8PEYkGRAnr5R5fxt3Npm8s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 11 Apr 2024 23:33:51 +0200
Subject: [PATCH] misc/pvpanic-pci: register attributes via pci_driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240411-pvpanic-pci-dev-groups-v1-1-db8cb69f1b09@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAD5XGGYC/x3MMQqAMAxG4atIZgNWO3kVcbDxV7PU0GIRxLtbH
 L/hvYcykiLT2DyUUDTrGStc25AcS9zBulZT3/W+886xFVuiCpsoryi8p/OyzBgCECSIh6caW8K
 m9z+e5vf9AN5pcyFoAAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mihai Carabas <mihai.carabas@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712871236; l=1763;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z2/Orf6yxKDaqub6BTAfFJIArBnI+mzGrz0nYL/Evhw=;
 b=1V/RDtPVi+D1+yvtc1ilBYxY6/hEn6cz9tAUSdlW4pHg1paRQgjpUphNVFEQgr08yvZ0o3Pfw
 WV9r+6YzUXPAFZFYw/3A92lEjCJdmk3eGdG88pARtfZ3Q4oZV2brF5Z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In __pci_register_driver(), the pci core overwrites the dev_groups field of
the embedded struct device_driver with the dev_groups from the outer
struct pci_driver unconditionally.

Set dev_groups in the pci_driver to make sure it is used.

This was broken since the introduction of pvpanic-pci.

Fixes: db3a4f0abefd ("misc/pvpanic: add PCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Greg,

does it make sense to duplicate fields between struct pci_driver and
struct device_driver?
The fields "name", "groups" and "dev_groups" are duplicated.

pci_driver::dev_groups was introduced in
commit ded13b9cfd59 ("PCI: Add support for dev_groups to struct pci_driver")
because "this helps converting PCI drivers sysfs attributes to static"

I don't understand the reasoning. The embedded device_driver shares the
same storage lifetime and the fields have the exact same type.
---
 drivers/misc/pvpanic/pvpanic-pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 9ad20e82785b..b21598a18f6d 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -44,8 +44,6 @@ static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
 	.probe =        pvpanic_pci_probe,
-	.driver = {
-		.dev_groups = pvpanic_dev_groups,
-	},
+	.dev_groups =   pvpanic_dev_groups,
 };
 module_pci_driver(pvpanic_pci_driver);

---
base-commit: 00dcf5d862e86e57f5ce46344039f11bb1ad61f6
change-id: 20240411-pvpanic-pci-dev-groups-e3beebcbc4e4

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


