Return-Path: <linux-kernel+bounces-116318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B405D889E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DF41F372B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952533D3ACC;
	Mon, 25 Mar 2024 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJmBflbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0817ADD8;
	Sun, 24 Mar 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324268; cv=none; b=aIw81XG/uqN9cpg7YWPYBignrY4WS2yoaWkahUHTPYy/MeJPUk6S7phpw/7ajJHywVYAOBFaV76TBMYgaiX6cZuJjUhkySf4QY6cLR/WzeuehIRLGCIRQNQVv9PPxB6Gsu0hJUZT3jgVUqsAvIuqFz1Zd632qHxJoryHQn3vFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324268; c=relaxed/simple;
	bh=9Ip9mEpa6TN8g4FP9wQPYH3+tz8QM2hDeFv91hXNndk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCxgDWvQAuOBxqU2F0SyiX2MzQmvZtrT5Kmvli2bQwV9UjxP1wcgWMg/bUIfXdikfF2M5mIKQj3pwUxPgdP+Ctvwxh1dthRRcBoHqXR7iSCvqeardnidMYkBP/ZU7w0kGfCDkEo0VmvA8IfBcqJcE0bRDnbr9rntaTaeUVvLp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJmBflbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC0FC433F1;
	Sun, 24 Mar 2024 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324266;
	bh=9Ip9mEpa6TN8g4FP9wQPYH3+tz8QM2hDeFv91hXNndk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJmBflbRvs48ckqkyXzJOjlSveebh4325l4nTVa6XhO8Qo28cBKi2LffdBUteTTM0
	 3zsBcukRKUoD/SHhgWEYx/itixhCvKVpSQcqyVtWF7SHe4jGCfeF5OAp7ybNNDsjOU
	 AfTtdANtc19ioyLY4et35Mxgh55P0x0KCjkIU+K0gH4BATzYdxngHxMCAUdiceHgYt
	 ABg3Q4oEYznXrYv6hHnaeT19J4p0I5SeMTXZ1ATTXTTKKfmXb4jKxoaHLaSKtDEmDf
	 fJgu/tsQwkpfp3UrVaLsoIABMAVARZM9joh1vZyiPfOq+KgSx4VpGtp4JfyRUiQcPV
	 ictN+YsWUAzIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/148] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 19:48:30 -0400
Message-ID: <20240324235012.1356413-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 1e7e2c438acf0..60417cee19b9b 100644
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


