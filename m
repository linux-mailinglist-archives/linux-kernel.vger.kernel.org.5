Return-Path: <linux-kernel+bounces-49112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17428465FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DDEB24424
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA625C155;
	Fri,  2 Feb 2024 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2goiYu98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D87C14E;
	Fri,  2 Feb 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841890; cv=none; b=i0P/L1rpXZARq2RrZF26QQjZ4yWIZZLPDXK0cOQL3k1XxHNMTYfMHYSOg9/ZzEn0Ywf5CF9SWQh5PQc9PNUckIQwAdPidgn0izshXOIJrhbx2GOPGUZLgbHRkFlHJGAL8fHTtf6ZT5y06QUvRPI9H3Bph8ycFbfiYlVsEdmdzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841890; c=relaxed/simple;
	bh=UxYhGOC3xGtEqwmfDbPKpEHtugDzcWDIdIzgloJyoj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXcv6NFhDlvUWEZ+rpgEgM3HwhSuZtINQcpjiRt615pOBBUU6G0nzbp6j7fMk3XNr0U7ENFW7z2zNvHGyYMC/Fjkl09XbJ8Kv+G6yru5L394X4K/WNC8LOrhq4LNRcgDFAkPtz0s1OaZLWZj+Y04py5/6VzuceWQ1wHibhFtAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2goiYu98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FED2C433C7;
	Fri,  2 Feb 2024 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706841889;
	bh=UxYhGOC3xGtEqwmfDbPKpEHtugDzcWDIdIzgloJyoj4=;
	h=From:To:Cc:Subject:Date:From;
	b=2goiYu98felbKd5KISw9FnvrmutZFoQa+GKyAQur7cZdCfbtDbhmseIPSY7YvxWWg
	 5RM4+4kPghag+iU+Tp/U7gNXJbCMuV+/F0Bh0x+VVwgtp7T4V72Nde6BlHRIvgYH7L
	 PS7TVsQs9jkwCKs9FfEa3r2kkuepqDILGA3KmIsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: naveenkrishna.chatradhi@amd.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86/amd/hsmp: switch to use device_add_groups()
Date: Thu,  1 Feb 2024 18:44:46 -0800
Message-ID: <2024020145-junior-outnumber-3e76@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 36
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=UxYhGOC3xGtEqwmfDbPKpEHtugDzcWDIdIzgloJyoj4=; b=owGbwMvMwCRo6H6F97bub03G02pJDKl7wmU91nxoz5Q+LvJuvuWflDex+1nj5i39HPA3Yrqyh pX3B4E9HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR0D0M89RDXZfPZrK/qf5/ /cOcpLl/w3g5Wxjmmey4deHWqopb7FecLy9tXNF+O/v4DwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The use of devm_*() functions works properly for when the device
structure itself is dynamic, but the hsmp driver is attempting to have a
local, static, struct device and then calls devm_() functions attaching
memory to the device that will never be freed.

The logic of having a static struct device is almost never a wise
choice, but for now, just remove the use of devm_device_add_groups() in
this driver as it obviously is not needed.

Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Cc: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased against platform/for-next

 drivers/platform/x86/amd/hsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
index 1927be901108..d84ea66eecc6 100644
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -693,7 +693,7 @@ static int hsmp_create_non_acpi_sysfs_if(struct device *dev)
 		hsmp_create_attr_list(attr_grp, dev, i);
 	}
 
-	return devm_device_add_groups(dev, hsmp_attr_grps);
+	return device_add_groups(dev, hsmp_attr_grps);
 }
 
 static int hsmp_create_acpi_sysfs_if(struct device *dev)
-- 
2.43.0


