Return-Path: <linux-kernel+bounces-37125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64083ABD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E93A1C21E27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FFC823BB;
	Wed, 24 Jan 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlZwE7aK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E798120A;
	Wed, 24 Jan 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106523; cv=none; b=nXI28Q13xGd1j9KE/KTD+hwEPGcS8YHC/3VG+CyADy7R5F7FLjFMZlB5nAHJKEltD6mK+m4xy5dsX1ieeC4ODGTwmFORxBWuN9Kccck2J/xTj4oHnH7dXJEOuQAFh+sskoZxtyeJ21IEhZaHCOWrtmFgT2pmI/BG0CQx+HHQq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106523; c=relaxed/simple;
	bh=HiD2LprOCXBmHOcscZKZk27b2znPpMOoqV4yFj3Q7TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc34mWfRFwHNIcBxuGiupaD1Wk0K9Anp2esNz/SPNMGBMZpmLN+uFLyl119KG9I3kzqs7C583AflCx4TStpCLBp/hRdjpMgvpsfw+PYPdj/HDR0+9OBzy+mSIPedjlab9XFVxgwMI+lmBtLAUiz2S1m7QCgwQkd7/UJRM5ghWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlZwE7aK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60448C43394;
	Wed, 24 Jan 2024 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106523;
	bh=HiD2LprOCXBmHOcscZKZk27b2znPpMOoqV4yFj3Q7TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlZwE7aK/N9N2tf7n3Io7lWYEuzR8D87YFxQ6h6EF9q1EmjIMWFALk/yjNxnmq5fX
	 fPW8a2rWYF+/PD98JtI+PGk2qw6LBuht1k+GlYG0BaB1F0YYx/jj8KEdTSJjaGnqRO
	 QNOrHCroHX77gIJOeTBnbTo9KZQsM6p8dBiL92iUWaijcxPNRP7tYg9GHj67QUQo4j
	 qGfyobKkHpOzRMrj9fZHoswDoqXOq9GkprLXUfyeofSjeju9/OOt3ez9IpcsKQaX2b
	 hG16aK/pb9oWOcJv4lCa+Hl5XAVGOI3B+LY8wv/yODyh9RJ830NeE5c97i1fBuliZO
	 Zj894m9MAjfbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Maltsev <mekosko@projectyo.network>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/13] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA
Date: Wed, 24 Jan 2024 09:28:02 -0500
Message-ID: <20240124142820.1283206-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142820.1283206-1-sashal@kernel.org>
References: <20240124142820.1283206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Michael Maltsev <mekosko@projectyo.network>

[ Upstream commit e315e8692f7922cd1b2a26bd7a1741cc8ce77085 ]

Like the ASUS ExpertBook B1502CBA and various ASUS laptops, the
ASUS ExpertBook B1502CGA has an ACPI DSDT table that describes IRQ 1 as
ActiveLow while the kernel overrides it to Edge_High.

	$ sudo dmesg | grep DMI
	[    0.000000] DMI: ASUSTeK COMPUTER INC. ASUS EXPERTBOOK B1502CGA_B1502CGA/B1502CGA, BIOS B1502CGA.303 06/05/2023
	$ grep -A 40 PS2K dsdt.dsl | grep IRQ -A 1
	                IRQ (Level, ActiveLow, Exclusive, )
	                    {1}

This prevents the keyboard from working. To fix this issue, add this laptop
to the skip_override_table so that the kernel does not override IRQ 1.

Signed-off-by: Michael Maltsev <mekosko@projectyo.network>
[ rjw: rebase, replace .ident field with a comment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index eb34d201b65f..5935d4c79c3a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -461,6 +461,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1502CGA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
+		},
+	},
 	{
 		/* Asus ExpertBook B2402CBA */
 		.matches = {
-- 
2.43.0


