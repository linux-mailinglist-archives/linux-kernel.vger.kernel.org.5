Return-Path: <linux-kernel+bounces-155023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F82E8AE479
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D0B240DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301DC1369A3;
	Tue, 23 Apr 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA/i2N5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A947136660;
	Tue, 23 Apr 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872424; cv=none; b=W4w4Px8iZdDRDYfLqCRCQgfLhfBID4IZFU+WCx6jnO0jnmaOMVrKEoHpQh9O1swYJxkxI39RjAPpwQAdx/zoe3LLCMeLcA4ipbwv/SI3Pr/KR7OYJQ/FrKVXuQP3vV3mRuFyQMTGW3gmjlP5oWPnsyPnjNszwcO6YldFN7Yl+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872424; c=relaxed/simple;
	bh=TkcNi1fQ9TF91KAuebmGAZ3Sag/oWc+wWRlrwOCiSVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXUlQ2HwsezEJzbqItHZeDzOvqM9HOpUQ8PjRWnrTdYQj23KbygP9yEQOZtpYYRlCdKsDs0pxmmr2KClBEz3hoMltkVaq/inqC72zZFcHfHSxDVEq27ZZJTx9xtc3i3DBOzMGziZnZ0k3KlVvCY/ebAJWj0H3nkQcxwFMqQ1w3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA/i2N5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687CCC2BD11;
	Tue, 23 Apr 2024 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872424;
	bh=TkcNi1fQ9TF91KAuebmGAZ3Sag/oWc+wWRlrwOCiSVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KA/i2N5sC+1bK5CxUQpWfWhJjG0dm4WQldytT6vPSYCwC6Bkk8CIbhPMd0LCJnA0m
	 dtDvr+gG26U2GsubDE4j7lz7af5fo7h0PVuNhJLLh7Kar2l35H7XfQkjSeekDvj+WZ
	 tP5SG/B55pZlgFRntyPPZqfrIp2U6/IWEBa4s1PEP0XVpcffVMAvoX6E2SJ2+kSJC1
	 p7YshzSiZwwbSxCCyC+CNugR7qHF6bP6G1Yq7qiRee4RJcdUwQuQP69WnySuLNwQn6
	 JpYUef9kxAtB5CtxTkrFPfN+bwOJBUjOLt0DXdskylR701J9LBDEY7Pz8DPo0G/VSF
	 dp4gWaQEhB1Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/18] platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes
Date: Tue, 23 Apr 2024 07:01:11 -0400
Message-ID: <20240423110118.1652940-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit f609e7b1b49e4d15cf107d2069673ee63860c398 ]

BIOS 03.05 still hasn't fixed the spurious IRQ1 issue.  As it's still
being worked on there is still a possibility that it won't need to
apply to future BIOS releases.

Add a quirk for BIOS 03.05 as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240410141046.433-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index b456370166b6b..b4f49720c87f6 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -208,6 +208,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "03.03"),
 		}
 	},
+	{
+		.ident = "Framework Laptop 13 (Phoenix)",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop 13 (AMD Ryzen 7040Series)"),
+			DMI_MATCH(DMI_BIOS_VERSION, "03.05"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0


