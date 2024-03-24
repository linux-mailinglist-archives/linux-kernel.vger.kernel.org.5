Return-Path: <linux-kernel+bounces-113164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A58881F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C8F1F21A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6E1741D7;
	Sun, 24 Mar 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEYOH4jk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B5172BD4;
	Sun, 24 Mar 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319966; cv=none; b=qzhIvtJwb7hbENtVts1VRJ7HkXvXCeU+NhfIP6sHtsNiZuJ/VucZKmh8csZQcTHIf+uOtgBKYI0CukyZIVusy2rsgy+xJXAl2XexCUxSGP93JfcketuxMImhFE55bLolnfqKfGVdSgdwsbiP5rX0dpWK0NqSwwuMzdBLDa6le48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319966; c=relaxed/simple;
	bh=G2nFSWvTjRA3LBCHCsROK0kX2JXbUoFgeHqE6piTCxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTejY1wTPw0UvMTaM0RiUOKb5Bhl8KWkoFPSS1nufimSPTNLuLnWQJ/EvTZsmvwYfEsejbXzxIRb+Te9TU1J1zBG83KmQOBN02WHAo0yBL4HkUjg6nqSfFKS+vUHVQNP7laHohhQLUZfvYXHUEoDaEyReK6wQURL404tZnG48GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEYOH4jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886B4C43399;
	Sun, 24 Mar 2024 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319966;
	bh=G2nFSWvTjRA3LBCHCsROK0kX2JXbUoFgeHqE6piTCxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEYOH4jkULON/ymCKVkFnWzG9/dMn68uoYWx0ShJSLxeuF5LAV8syMr/l0yVLk4Z0
	 5ed/MO9PaV2Vyec2VvBYsD4vytvfmRssKzxpbrZVFyGF4m73mZ6ZhD+/nJTBtxKEqX
	 nhyUcXSOfIbHLYTbr7rDVyV1C/mb1zXB9j8vM8rFS6iXx2CA45TRXrcEFlqx98kj1i
	 GkRlsPphAq5TCgF30ox5kWt35R3LRZxidE0FwSBnM5tPsn6CzctpxI5Z4zeApYPCq5
	 CiMVfQ7mPhK8pbNrvQzriF7P3Y/O9/eE6ftf9oC1Tx++euHjCR+LsTYtbKOLAeh3Me
	 PtqUrBK016XJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 273/715] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 18:27:32 -0400
Message-ID: <20240324223455.1342824-274-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index e6ed1ba91e5c9..617f3e0e963d5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -314,18 +314,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
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
 		error = acpi_scan_device_not_enumerated(adev);
 	}
-- 
2.43.0


