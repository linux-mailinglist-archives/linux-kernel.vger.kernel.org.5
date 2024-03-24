Return-Path: <linux-kernel+bounces-114007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C55888F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E91F31B64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C47E1474CF;
	Sun, 24 Mar 2024 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5O1arQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093E128387;
	Sun, 24 Mar 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321281; cv=none; b=nPmHB7biOTmUbuTRZSISa1NFsRXYDgU4LaF836KNy1l1rz30YVuVkifVYJlF0SBClwzYBJ0drzqhh6GBge2N5nqVZf9gisBFkMokmz9biwvAomwcID0tmw3DP1sssaCkAHYMYtjZiqObHGp5UdHZrs+nbadRPll10CU//LvuvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321281; c=relaxed/simple;
	bh=69h97DXk3sezN9njqO4oxBgBj5oS7i0ELO2Bz6h1VXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWwXKYEd6C44uknX4wJYla7EDa/Io+m9vgLyfUW62nEWUiuf72JFOg87iMAbAEMVzOUH4kGkuNJENwSdztp9mBRR588PcuCP9WgtPHZhDHhreTMKXj7dMIMDHpBax7zTVFOlPfg36Dcjb0AfCJM5kLxZFRrr0GP3dmFapd2a5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5O1arQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C14C433C7;
	Sun, 24 Mar 2024 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321279;
	bh=69h97DXk3sezN9njqO4oxBgBj5oS7i0ELO2Bz6h1VXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5O1arQ6kDgAHV0lHt0BkKRteMC5Gu9dNELziSpN9EupVBa6HJ1MDPmdE1yvfLvNM
	 peeOpvHVkiKQGsN4tJzRjY03aomesJV5kv7DEZNym7kMxSL5mc+IRsMx4/R3W/HWfw
	 DpAVNBcLMDse9rWvoUsPMZkW4i50LIJsKsKcZyVDI/Yirf/rWRwaReYfrhCwJGvXjy
	 Lj15pe7Raz73HsQftcVvZRRc205YHmGrBviz4zdeL/OwqwMEdbe7KX5X5d+7b0C5Fj
	 9k6W+uZj44O6zAmA5RvOi7qLwCEGoYJbBYb78aO0/L0NXURfIVC20uh2b8yI80YgJp
	 HMCI5aLMLCyRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 001/638] platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
Date: Sun, 24 Mar 2024 18:50:38 -0400
Message-ID: <20240324230116.1348576-2-sashal@kernel.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit aec7d25b497ce4a8d044e9496de0aa433f7f8f06 ]

On Goldmont p2sb_bar() only ever gets called for 2 devices, the actual P2SB
devfn 13,0 and the SPI controller which is part of the P2SB, devfn 13,2.

But the current p2sb code tries to cache BAR0 info for all of
devfn 13,0 to 13,7 . This involves calling pci_scan_single_device()
for device 13 functions 0-7 and the hw does not seem to like
pci_scan_single_device() getting called for some of the other hidden
devices. E.g. on an ASUS VivoBook D540NV-GQ065T this leads to continuous
ACPI errors leading to high CPU usage.

Fix this by only caching BAR0 info and thus only calling
pci_scan_single_device() for the P2SB and the SPI controller.

Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Reported-by: Danil Rybakov <danilrybakov249@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218531
Tested-by: Danil Rybakov <danilrybakov249@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240304134356.305375-2-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/p2sb.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 17cc4b45e0239..a64f56ddd4a44 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -20,9 +20,11 @@
 #define P2SBC_HIDE		BIT(8)
 
 #define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
+#define P2SB_DEVFN_GOLDMONT	PCI_DEVFN(13, 0)
+#define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
@@ -98,21 +100,12 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
 
 static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 {
-	unsigned int slot, fn;
-
-	if (PCI_FUNC(devfn) == 0) {
-		/*
-		 * When function number of the P2SB device is zero, scan it and
-		 * other function numbers, and if devices are available, cache
-		 * their BAR0s.
-		 */
-		slot = PCI_SLOT(devfn);
-		for (fn = 0; fn < NR_P2SB_RES_CACHE; fn++)
-			p2sb_scan_and_cache_devfn(bus, PCI_DEVFN(slot, fn));
-	} else {
-		/* Scan the P2SB device and cache its BAR0 */
-		p2sb_scan_and_cache_devfn(bus, devfn);
-	}
+	/* Scan the P2SB device and cache its BAR0 */
+	p2sb_scan_and_cache_devfn(bus, devfn);
+
+	/* On Goldmont p2sb_bar() also gets called for the SPI controller */
+	if (devfn == P2SB_DEVFN_GOLDMONT)
+		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
 
 	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
 		return -ENOENT;
-- 
2.43.0


