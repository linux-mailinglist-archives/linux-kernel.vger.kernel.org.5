Return-Path: <linux-kernel+bounces-114793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E442889146
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AF31F2BD74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B52458FA;
	Mon, 25 Mar 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egBYk9aV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D1130A45;
	Sun, 24 Mar 2024 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323417; cv=none; b=XR/FIC4Dx5vL6kYS1Q4GxQ4+bU2oAf2z9UE01mqG9QR7iS++zx7Grm9TsXE10ItY2fZX5vBPrEYz9T1PmUflqDT/YG25hTBxECYz65B2wSM3FIDXtweoSIbcflzG0uZB7svZ8VdYUE+yKktWBnjQOXjoDTtMgdFfIDrowJbefUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323417; c=relaxed/simple;
	bh=Mip5MWJ++KzY+R8yIoSXV3S+4kKpHzFO5vdVn6dFUpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSo3/jvUbUO4P7ib6D4S07Yi6MYDg50DoM9bBO9r8MbA5D7r5qocznauFQMNmmo92oUNcy4s9N9Q9kqhYHxejblUk3RKA01HVAFwsBfnKYVbKrA8KIswZ4qChlgwkVbr+d903SF4Bod9r4O1KxoGHLrdzV4ut98qM3pyORV413g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egBYk9aV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F06DC43390;
	Sun, 24 Mar 2024 23:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323417;
	bh=Mip5MWJ++KzY+R8yIoSXV3S+4kKpHzFO5vdVn6dFUpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egBYk9aVEzEx8OvlVaNZDvCsNnKxt3gYK7uVBmGFtD2B4+srMcKgN63+63oULTdxX
	 p5RGKwLS6OJm5O7AOjxQQePEzTc1yHAus58JuDefrNOQleb3DqxNE+tQa5RN1256eu
	 Hso5YVtPCdomrfPR6PydHz+jVReg69A+LfxN1FXR3OxmGCKnSIa13LPR+WeiFHm1hW
	 aqTNBCsApjCU2T3Z1rDuGSLgJL+HSW7rKHopF0oroztlzGLGzp68Ma0cApX5OsQULe
	 qtp8eNxLZve4/6j76R0+fsn02vaPn64FfN/gx7mDoyolt6k1DAZmDAyxbqUZW43XDs
	 ejMjAbPVghYMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 119/317] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 19:31:39 -0400
Message-ID: <20240324233458.1352854-120-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 793551c965116d9dfaf0550dacae1396a20efa69 ]

It is generally invalid to fail a Device Check notification if the scan
handler has not been attached to the given device after a bus rescan,
because there may be valid reasons for the scan handler to refuse
attaching to the device (for example, the device is not ready).

For this reason, modify acpi_scan_device_check() to return 0 in that
case without printing a warning.

While at it, reduce the log level of the "already enumerated" message
in the same function, because it is only interesting when debugging
notification handling

Fixes: 443fc8202272 ("ACPI / hotplug: Rework generic code to handle suprise removals")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/scan.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ae74720888dbf..2393cd993b3cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -315,18 +315,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 		 * again).
 		 */
 		if (adev->handler) {
-			dev_warn(&adev->dev, "Already enumerated\n");
-			return -EALREADY;
+			dev_dbg(&adev->dev, "Already enumerated\n");
+			return 0;
 		}
 		error = acpi_bus_scan(adev->handle);
 		if (error) {
 			dev_warn(&adev->dev, "Namespace scan failure\n");
 			return error;
 		}
-		if (!adev->handler) {
-			dev_warn(&adev->dev, "Enumeration failure\n");
-			error = -ENODEV;
-		}
 	} else {
 		error = acpi_scan_device_not_present(adev);
 	}
-- 
2.43.0


