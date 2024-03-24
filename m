Return-Path: <linux-kernel+bounces-115885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828188969F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FC229CC99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FF227527;
	Mon, 25 Mar 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwzKdkiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0E148315;
	Sun, 24 Mar 2024 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322108; cv=none; b=L5+blqR2FnnGnFyXtsUK1h74TTC1inEuvrjKZ9v++KoCtc8qK79jvbUXttPejT2ToLfbT2e/ZsDQxPGaphA0PPeRh2To2UvtOHYTMJKfI4KP/40AzuKp+y4GPBDLo1Y6iYENs/lwOlND9TRPEAb9b2d2Jq7y3fwHrNaoU2oxtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322108; c=relaxed/simple;
	bh=s34dqxsBVuJEo+Uhd4PDQPvUNDoBzlzGIbyFisqBYbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbW8gTZqZMzKk0c/wpbHejmLdbBiDczBIly+ct8HKNFsEncDZjhv1sJodYMVY+MTFzNV2w1NY+gGXsEzp7wAPXq/zoT345o5OMMEpFrrEnTZlH5ApqEEPtaOlxuWm+vJlJ150htpE96HlIzUr8Qj1A8Gk50nzaTv324Pt6U6lqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwzKdkiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E6DC433C7;
	Sun, 24 Mar 2024 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322108;
	bh=s34dqxsBVuJEo+Uhd4PDQPvUNDoBzlzGIbyFisqBYbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UwzKdkiSWpYYGaofCtGKQIKs0Rjud+GfGz4pOK15LWP2dOE738BSzMW45bKn1xbMX
	 yt4sduZtNuEmqOqu1RNFD4MnskVDHjtpWAct6biyXGN1YGcQCTkxvUs/nLObdACtsw
	 wExaL51nFO3q7Hz1ZnEGQg1cf5vsXlVXfH3aept9jIH/wqetSL+H63vTC+xd1UFMiz
	 GWzbgjA9WDdsu1WDO8ebs3yD0SKgci7HFkOFyCOovMwYBUgPn+Dggg21+rRzW/+KLy
	 ka3eQ2gZQP63pjjS4XbxSeUjOmimscA+ImhSloPTCLjBvP1JwYpz5dyIQgOvzrXWKC
	 rpVLejDRCTdsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/451] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 19:07:39 -0400
Message-ID: <20240324231207.1351418-184-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 94154a849a3ea..293cdf486fd81 100644
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


