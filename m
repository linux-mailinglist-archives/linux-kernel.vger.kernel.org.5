Return-Path: <linux-kernel+bounces-26648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551D82E486
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E041C222D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E31C28C;
	Tue, 16 Jan 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DArZbYsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957541BF5B;
	Tue, 16 Jan 2024 00:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5C0C433C7;
	Tue, 16 Jan 2024 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364013;
	bh=tLd/qPIbdz6vLgxnpMnZFGIeYXMjiMrRkG7LUOxJCUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DArZbYsdxGuaeF+qxvywUAJ+WPB0goUSyeBEU4xm/AIiO2rITTPfvVWOE/wmlULag
	 rVKkst0WitfN9QcRqC2yuPIS0l6Hy45dPLyyJaeXL4dvtup//duliuDk0ntLKlK8LC
	 XbEzPw/vK0hqu8/9WteDfmq3GeCQlppEfpnFJ/B5NvwC9z6K8eTRk/2E+WyKJ09QRk
	 +afRFKuaC0l+0qDaTeHSplXAbF2Xjmb2e8nrSzLHaVVjFzMUZK/NrgniiuxVlN797Q
	 N4mgCS7ZL0i9uMG8B4XuoF9Hs7RTqwUoWdV49rQGAFKsRwynO52xSfLLKCcMCXprX4
	 M91VS/IklQobQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 15/18] platform/x86: wmi: Remove ACPI handlers after WMI devices
Date: Mon, 15 Jan 2024 19:12:57 -0500
Message-ID: <20240116001308.212917-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 22574e17626391ad969af9a13aaa58a1b37ad384 ]

When removing the ACPI notify/address space handlers, the WMI devices
are still active and might still depend on ACPI EC access or
WMI events.
Fix this by removing the ACPI handlers after all WMI devices
associated with an ACPI device have been removed.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20231218192420.305411-3-W_Armin@gmx.de
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5dd22258cb3b..d400e61d6801 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1494,13 +1494,12 @@ static void acpi_wmi_remove(struct platform_device *device)
 	struct acpi_device *acpi_device = ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device = dev_get_drvdata(&device->dev);
 
-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(acpi_device->handle,
-				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-
 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
 	device_unregister(wmi_bus_device);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wmi_notify_handler);
+	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC,
+					  &acpi_wmi_ec_space_handler);
 }
 
 static int acpi_wmi_probe(struct platform_device *device)
-- 
2.43.0


