Return-Path: <linux-kernel+bounces-116264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0DE889DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC521C35753
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C443C798F;
	Mon, 25 Mar 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiVZ22hb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344628A58D;
	Sun, 24 Mar 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324062; cv=none; b=JAloTGRstU6mqk2nDmTicp3w5Yq+MfIHnw/pfJ/w/IfLP6Ws47NA4Ekwr0hQt8aSt/CDnyGZdnX9uhSQTC27qI5vSF7xqAITi1Cul3/QUtUsPHaL8ts4DR4XcT8pV5luoQB0etGBvB4WBltZ+KmLv4TGRHay1pM7Rri3G+gkpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324062; c=relaxed/simple;
	bh=KxoXkw8EMJ4UyTeRijlN1ijgtLEipvile9D9fHXzNVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngwvGceeFl+skgvfMR5c05UytsVWPqQDZJAlQIetS0CF5z53Gq5G+EFT8jrmBojbVmO0xvARGZz+LVxzJhR+uWC37AtDUitSqM1V3Qt6YL5YU6YkfBu7vpcIkRyrePksee0Q739HGvTKFD7ZMEwbKQm2vuiGuHSGdY2RjKfTep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiVZ22hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D460FC43394;
	Sun, 24 Mar 2024 23:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324062;
	bh=KxoXkw8EMJ4UyTeRijlN1ijgtLEipvile9D9fHXzNVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiVZ22hbrQQUcNaZFxgm/DYYjSILjZadb1lP+Jwwub2cVtGrtdC21DYHnYrWcOGO1
	 MLqrJVjScgkdHWX1RrgGnuvat4nqe1GDZdRk9gQi4Kqte1uyrrYgeUzcZ/eCEkxIyO
	 jFLl9J8SYXjq30b4V7uN/DLweWrmUJw/XlgF3/6L92mRAn8tEed4RyqUJraQxeIqZP
	 L+FpRane5AKWj4DXprdRNDrLQJCl3MXPuPJbKtqnfMoVBd7mNhMT6ye1fYLA48L8AA
	 XfNU8oxW8cILYDLMpf/POaSSaKogZndI5WN0XXrYHpS36/rtfg/gCF+rZUJ7PR1SrH
	 IrrBJhD6jhSuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/183] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 19:44:36 -0400
Message-ID: <20240324234638.1355609-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 5d4be80ee6cb4..629e6044f6233 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -322,18 +322,14 @@ static int acpi_scan_device_check(struct acpi_device *adev)
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


