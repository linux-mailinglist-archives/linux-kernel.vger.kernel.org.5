Return-Path: <linux-kernel+bounces-115251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB62888EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEADB357B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2A23155EE;
	Mon, 25 Mar 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VryHTXQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FF2987B4;
	Sun, 24 Mar 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324360; cv=none; b=OTZXIjCgp1m0SEoCR/yfBpcglYyyWovRGFSc84WWdOUcPWAM1Ynu7ZrZYC7LAjO1xn/nOCBth7ogkXXk5X+3wI6dj4H5NbYMLtZi7g+tJRbPR6AQs+Y4aFPVjLMktcDMOXQW3fGzgwTOID3iGLr0gsIojdMu2cag+bdEM+i0KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324360; c=relaxed/simple;
	bh=qUsKLSR4/2S+QJrOFojeB/hmcUgRxhpYTpV7hOoNmWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5QtsI4DHI9O8tUa2eNbwB1D1QZhOahKSWjHK1nY7YhjLMQ0hr3a0Jqo931bVMEibOg9i7+HVJdSYJcIVAZguDACISIpgGI5vxhfyjbkh4cJRvZX0BHpmYcf2gBUf1J8pgeqXLKRo/EbUPVBxx9vNoidja0wSyUTwKF1ZVG6vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VryHTXQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75D5C43394;
	Sun, 24 Mar 2024 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324359;
	bh=qUsKLSR4/2S+QJrOFojeB/hmcUgRxhpYTpV7hOoNmWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VryHTXQzyrUtBA4lIgQ00TIZIENk0Ll3mbshnXvU2ZfC4rPpoksC3q5CrQoTwPr69
	 2xIhlEIJfxsrwwTv8/DNTsgTxqsurXDWvzcmSFD6iegtUzF3uANJH/fs4eSzbkNWcL
	 07ZJTXLoOod6gqGgXJNQ5JQ6UEkDwGnroYd9M8NrCue8iUhRDnbzII5PR77XleT4Fd
	 F8DNlmJw3mcZudKfHYSlDcwaqCrjMoHGtT90BsmtmokRwAKXfDDXMzsgnQHbNGTrjd
	 U3G9n26senFY4OIXn46qwyKofcocjn14R/5K2NIA2r3lkEgMmEw3yqvdggfrs1eS6N
	 bzKvNVlq2sNiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/148] sparc32: Fix section mismatch in leon_pci_grpci
Date: Sun, 24 Mar 2024 19:49:51 -0400
Message-ID: <20240324235012.1356413-128-sashal@kernel.org>
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

From: Sam Ravnborg <sam@ravnborg.org>

[ Upstream commit 24338a6ae13cb743ced77da1b3a12c83f08a0c96 ]

Passing a datastructre marked _initconst to platform_driver_register()
is wrong. Drop the __initconst notation.

This fixes the following warnings:

WARNING: modpost: vmlinux: section mismatch in reference: grpci1_of_driver+0x30 (section: .data) -> grpci1_of_match (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: grpci2_of_driver+0x30 (section: .data) -> grpci2_of_match (section: .init.rodata)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Fixes: 4154bb821f0b ("sparc: leon: grpci1: constify of_device_id")
Fixes: 03949b1cb9f1 ("sparc: leon: grpci2: constify of_device_id")
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/leon_pci_grpci1.c | 2 +-
 arch/sparc/kernel/leon_pci_grpci2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index e6935d0ac1ec9..c32590bdd3120 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -696,7 +696,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci1_of_match[] __initconst = {
+static const struct of_device_id grpci1_of_match[] = {
 	{
 	 .name = "GAISLER_PCIFBRG",
 	 },
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index ca22f93d90454..dd06abc61657f 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -887,7 +887,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci2_of_match[] __initconst = {
+static const struct of_device_id grpci2_of_match[] = {
 	{
 	 .name = "GAISLER_GRPCI2",
 	 },
-- 
2.43.0


