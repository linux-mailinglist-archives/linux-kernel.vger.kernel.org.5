Return-Path: <linux-kernel+bounces-113753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E556B88866D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B23F1F23351
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44001EFE2F;
	Sun, 24 Mar 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2BL3dUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DA1D8DFD;
	Sun, 24 Mar 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320757; cv=none; b=VbrlD0s0WcGs5YME8mo9wH7g64qxn6hoOwiNnNo1QBAGE8nfFGZOZvCUxM3OCgIuXi12wr2ub73u/QBxlIN0bcvE31hbHHC1idFnFIdylkKM/MnH8QFbzKmfr8VzUjIIZrR3PzLNeu6XE4hzHbQRlTRsg23RubvhkIrYjf1h7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320757; c=relaxed/simple;
	bh=0STq7XixVzodxPyfWUmK0TRE9zcmsjRtxfTpQn9z/xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyeaCoFhQfL4dUmxEVTL8cxhnnAhoWlHVT4n+ylId4purZLTIhuz833kk4BBYLSJKFgNCyQycJ+2TImiOaoWdy+mBRLy7pPFs8EhE18DisYCiI/XX1jjHOFuYnvvkK6jMz3gw1Nh7Vgq3oIudSUbFtsAOxIkyUFTcibB1a2Ely0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2BL3dUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EADC43399;
	Sun, 24 Mar 2024 22:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320756;
	bh=0STq7XixVzodxPyfWUmK0TRE9zcmsjRtxfTpQn9z/xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2BL3dUd4lUiPPuktns0JaLdh4XXUPfk8POTdxHu2zrWqGOFXZv3PPiI58x9iU8JH
	 5yUOG9Zi+PRzlSxxfES27Ti/YNsFk5q5oZOazxgoz2HqaXiBaFrw6LyVzVLkhVAdNo
	 o1tabIhX1Sd562dMPJQHCVC2Qoc99g4tgnEBKULWme3npeIaLEXpf2vec01Sg0cKp0
	 C8Iisdi36Nm58COifJl/0zWQOlo2hbcXncjQus+9gr6FWu+9KZ4hW5KaOI4wWoDjzl
	 N/hkCSsGOFzex8QmOxIs0SiW07LQ1C0vDtHMoH1mM9mFcRUAwMXJnq1C1XWKiJPhmy
	 epuMZRmUlJ/nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alexey I. Froloff" <raorn@raorn.name>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 320/713] ACPI: resource: Do IRQ override on Lunnen Ground laptops
Date: Sun, 24 Mar 2024 18:40:46 -0400
Message-ID: <20240324224720.1345309-321-sashal@kernel.org>
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

From: "Alexey I. Froloff" <raorn@raorn.name>

[ Upstream commit e23ad54fef186aa66007895be1382c88f1ee2bf7 ]

The Lunnen Ground 15 and 16 needs IRQ overriding for the keyboard to
work.

Adding an entries for these laptops to the override_table makes the
internal keyboard functional.

Signed-off-by: Alexey I. Froloff <raorn@raorn.name>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 021a67d09615 ("ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index dacad1d846c0d..3ebb74eb768a5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -588,6 +588,20 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
 		},
 	},
+	{
+		/* Lunnen Ground 15 / AMD Ryzen 5 5500U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LLL5DAW"),
+		},
+	},
+	{
+		/* Lunnen Ground 16 / AMD Ryzen 7 5800U */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lunnen"),
+			DMI_MATCH(DMI_BOARD_NAME, "LL6FA"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


