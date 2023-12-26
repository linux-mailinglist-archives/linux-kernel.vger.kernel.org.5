Return-Path: <linux-kernel+bounces-11216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B981E34F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174382843AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70646B9A;
	Tue, 26 Dec 2023 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ+wHcwl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80D487A4;
	Tue, 26 Dec 2023 00:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683A1C433C7;
	Tue, 26 Dec 2023 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550078;
	bh=RN9A5U2FKMTxKSCNjSOnUCXElpH8R0CU8ZqURoP3YPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ+wHcwlJfHzbcW3UxyPjWU7i1xJIV4KzVIjq9oTAzMUu4HkvG9yjPu68VVwbJP85
	 0BUsKKmGBlY5jZd+FFvAPeZ7XuqIgRh8vwCIWuReDIBaHJ8K+owVTKVQAreP+eZLa2
	 m3gbL4qtgSH1Opb/5SrEyFuwYaDLMmyfiqgPEyxDVJT3ix8Fv+7GVL+NZ8o46GidQY
	 ux5FJAn2My1e1L5IeYgxM778YPVZzVo3WEvrLpXhj8Of+D2msXufd//8iTP7MPu7Pl
	 pbJHtMoz7Sm70q3eQU3gNaf5b2yq6Zvq5jmFl5HNGZU6PCgLuocQu0aq9LawkedWT1
	 IiQpSMH/pDtLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Kieran Levin <ktl@framework.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/39] platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13
Date: Mon, 25 Dec 2023 19:19:13 -0500
Message-ID: <20231226002021.4776-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit a55bdad5dfd1efd4ed9ffe518897a21ca8e4e193 ]

The Laptop 13 (AMD Ryzen 7040Series) BIOS 03.03 has a workaround
included in the EC firmware that will cause the EC to emit a "spurious"
keypress during the resume from s0i3 [1].

This series of keypress events can be observed in the kernel log on
resume.

```
atkbd serio0: Unknown key pressed (translated set 2, code 0x6b on isa0060/serio0).
atkbd serio0: Use 'setkeycodes 6b <keycode>' to make it known.
atkbd serio0: Unknown key released (translated set 2, code 0x6b on isa0060/serio0).
atkbd serio0: Use 'setkeycodes 6b <keycode>' to make it known.
```

In some user flows this is harmless, but if a user has specifically
suspended the laptop and then closed the lid it will cause the laptop
to wakeup. The laptop wakes up because the ACPI SCI triggers when
the lid is closed and when the kernel sees that IRQ1 is "also" active.
The kernel can't distinguish from a real keyboard keypress and wakes the
system.

Add the model into the list of quirks to disable keyboard wakeup source.
This is intentionally only matching the production BIOS version in hopes
that a newer EC firmware included in a newer BIOS can avoid this behavior.

Cc: Kieran Levin <ktl@framework.net>
Link: https://github.com/FrameworkComputer/EmbeddedController/blob/lotus-zephyr/zephyr/program/lotus/azalea/src/power_sequence.c#L313 [1]
Link: https://community.frame.work/t/amd-wont-sleep-properly/41755
Link: https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20231212045006.97581-5-mario.limonciello@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index c32046dfa960e..b456370166b6b 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -16,12 +16,17 @@
 
 struct quirk_entry {
 	u32 s2idle_bug_mmio;
+	bool spurious_8042;
 };
 
 static struct quirk_entry quirk_s2idle_bug = {
 	.s2idle_bug_mmio = 0xfed80380,
 };
 
+static struct quirk_entry quirk_spurious_8042 = {
+	.spurious_8042 = true,
+};
+
 static const struct dmi_system_id fwbug_list[] = {
 	{
 		.ident = "L14 Gen2 AMD",
@@ -193,6 +198,16 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15s-eq2xxx"),
 		}
 	},
+	/* https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128 */
+	{
+		.ident = "Framework Laptop 13 (Phoenix)",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop 13 (AMD Ryzen 7040Series)"),
+			DMI_MATCH(DMI_BIOS_VERSION, "03.03"),
+		}
+	},
 	{}
 };
 
@@ -245,4 +260,6 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
 	if (dev->quirks->s2idle_bug_mmio)
 		pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
 			dmi_id->ident);
+	if (dev->quirks->spurious_8042)
+		dev->disable_8042_wakeup = true;
 }
-- 
2.43.0


