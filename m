Return-Path: <linux-kernel+bounces-114207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A5888918
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F81B23EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74024F719;
	Sun, 24 Mar 2024 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ2G/9CK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FD208990;
	Sun, 24 Mar 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321549; cv=none; b=QZ7GKrhlcpk0oshwyxBJ64UK9U7od02+h0P4/NHzdfZ0Yxm+WTQMqE1IP34v6DRKz08E0t/OzX0aWUywZ2xCqxyark64f8wPTDh1oRhC6KnGQT6fTz3AvU8hDcNHOAu5FGRWKoI9gGZ1o1QEALxb01kdR+krLn7gQl5Eh+jI9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321549; c=relaxed/simple;
	bh=g2YXO61G3NauVALNbXM7ivW6aNYn2CeUlSl5s3qq4tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul5Yvk22cg/0vvohOOHdYP4CDZc5wmeZLeJEiteMZTExpRNiHWAIHBiImk+6K0cQKf8k3a2DJisPAhCe5QwSlaEUh7nVNiy24EUGK55Gg8WyTIUzRC6BAA+Vr703aP/oNZ2hm1k9NOB+6Nq5dtwA8Ht6cs06itASHJbv9zii+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ2G/9CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D72C433F1;
	Sun, 24 Mar 2024 23:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321548;
	bh=g2YXO61G3NauVALNbXM7ivW6aNYn2CeUlSl5s3qq4tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZ2G/9CKNITl5Tip3KF4G4M0lP4Jc2MmiXTQRNB0PHvhbTuuH0x9gzIx0N+gnFXK6
	 L2mVd8QmSBjDprpqaEjMUI83PV2lABtPyGitMc6hl9Zby9CebhiewOWxvm4WBKgZg0
	 ZJ1ZL048zfWIIBPOOIzQxfpLFCMZqN0YN1PBRcqYX2Foiwacho/beDM9jPOnjfAuPE
	 yZlIuPPBR60v+LMYhGgET79WSyGYi9gaGZ7EfdasOzma88WZD0QbxKdxnbNj5tLsrc
	 a1u0mVKlHO2MS5NaQpPPrv1FBE7hjRoplCc4IaLPvuO4q8RmdlHBkkLpAJKN7Pa1R6
	 pO5ArErMveiPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 277/638] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 18:55:14 -0400
Message-ID: <20240324230116.1348576-278-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 1d249d0f61ae4..597d75baa1cc3 100644
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
 		error = acpi_scan_device_not_present(adev);
 	}
-- 
2.43.0


