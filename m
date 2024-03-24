Return-Path: <linux-kernel+bounces-113741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB47888E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0051C25BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59B1ED70C;
	Sun, 24 Mar 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dholJIfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DE1E0621;
	Sun, 24 Mar 2024 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320759; cv=none; b=hOvjpuM/KtqQGwaEA4iNUxQWvLppPEs0kwl8um2woBvdJz19VzMkgzSncy6FonMps06Ahyhpfu9eo1HCV6voomZwnxQ3X1h9kvWCz+5RmUoWLE1BOe3fC50Zb+HygLntfT4FPVeWlefRzz0WrhTL3qVg5E2aYPy0TwDwCSJx0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320759; c=relaxed/simple;
	bh=lqQQQTexJ/MMhl+mj3ydgYMv1bw4L4LJ//0o9zshRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdWXZse72MnZ7HoD6MfesYzb6VCGJLpqbO54v4tZx0DYswQf80s23VR4IQwT4gfl7pYC9VIhMNuOy8k0fg/7+ovErREB7UToXdw/Kffm1BntDb+a2macNXxeG8+V9IJrNMs155VbxRykbAamiIls7Rn6I5qGRNCKjG1RNWfLhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dholJIfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69558C43141;
	Sun, 24 Mar 2024 22:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320758;
	bh=lqQQQTexJ/MMhl+mj3ydgYMv1bw4L4LJ//0o9zshRDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dholJIfYo3IRwtSqaYSBK03V3DjyXlNWvHfFHE76PBS1YQYfiPPA8QHxE9ytIY7DR
	 1j8MKJZ9M2GfDjBzCeCmtJhD/ned5SejyAQYPZWAXqTK5p1Z+m/SgWrLSInLsYTUEu
	 bvveTLrU3tMkBOTv9cWs0N0SupJknUCy7WgZdXSpB24fAX7q0Tahgsy0gmHClIpsUD
	 eZmElhPAjgGSQyazRutoo4DTngHVb7oEiiVLl9HdmqEY3U8KkOqqEsiMeSMjNn/Gbz
	 fMn6urUXonIyrwgX42gNrC0Fe8Q8IR1n+Z+UijL4Cg2bXD71Y0xTFAQGYQ+n6eLXhr
	 KRh9GZ7lfntsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 322/713] ACPI: scan: Fix device check notification handling
Date: Sun, 24 Mar 2024 18:40:48 -0400
Message-ID: <20240324224720.1345309-323-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 02bb2cce423f4..35ad5781f0a5e 100644
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


