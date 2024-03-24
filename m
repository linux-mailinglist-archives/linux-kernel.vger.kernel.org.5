Return-Path: <linux-kernel+bounces-114973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D6888D33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F567B287C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C52E0111;
	Mon, 25 Mar 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGgnTX04"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2431311B2;
	Sun, 24 Mar 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323705; cv=none; b=Jcyv4RhA7XSOrkjC+jSTFV2TuYCR0lX2KOdq54N3jhcdsEcZbzj321pxZjjgWAwSqH7uVdN9Y6CHoOKWq7ph/emysxerbSE0OxKzih9X7zxUAmGyAU/NZLMUxfpC6Mh7j+QLHIFIQtanpHNziFQdKnZhnDbOHVue7lpWdlPlFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323705; c=relaxed/simple;
	bh=aM8xageqbvxvKZ6EsJxxHf29jpzZD3ilwWZwqVMSnUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POCVKFAjbdLmQ//jwlwb6sm4dUs6wPJ1hozTQeZ8nhRMsSOVCQyZucWVdtQtguBX7b4yO3Omp1v2k44N6gSuFw9vcOfNZ0LGv+o40w3HqZFOlNnPpFDeMO2TeNwzJeJDBhZGNzT7Inb+P4hbAdLldrCZWfUEs0zlVw7/l2edo9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGgnTX04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1C3C433C7;
	Sun, 24 Mar 2024 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323704;
	bh=aM8xageqbvxvKZ6EsJxxHf29jpzZD3ilwWZwqVMSnUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGgnTX04J0nFN8Fnn4sG+xkTnpqaVdLey6A5CvZP8ne9BUWeFaN9X1TPFv4M8DQ6w
	 VWX/f3Dx20W5NBztwLrjLEU24AA2uMaBLDrQ4TUmY5fL/KuL4bEDdrQaKkC+gMvL6J
	 p30iSB49PLMyd97Q265gyp2RbZ3DK/wtoHsqhgj09jjOEdMcMcr/UgaPR2ikVrW5ZA
	 Ru52KBh8r1oyf/SpU6Wt5ctwggDpWxuAyNahI9GyPdZgqRzXQuGxHnfIq0RNzW81mm
	 8EQDX89iQyLkSPQLpsfOG+0rw9FZCJSANZM7/spW3ktp0qW/VBBJ9EXyu/uobX0MLe
	 QQ0NgdwnPMD0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/238] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 19:37:45 -0400
Message-ID: <20240324234027.1354210-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 67a5ee2fedfd3..f17f48bc13bc0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -321,18 +321,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
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


