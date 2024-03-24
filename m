Return-Path: <linux-kernel+bounces-113902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA65888ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F16290627
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F768153584;
	Sun, 24 Mar 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6lGL61Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74E1ED700;
	Sun, 24 Mar 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320985; cv=none; b=pBHEaeJ6jsoOKX3LfCHmawUouigCXaOrTjnEnzG6CyJ6Ct8cSFI175z5v/Q4T07Euq33mIaV+lcgAyJqT4/U1sl/5iPSl3chuKc8sA3WQWdLsWBOA7jRAt2+ITfRKinLD0WV5Sw6053yYekZ4rOwHEj9RDTgnPZYnqKw+/rmTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320985; c=relaxed/simple;
	bh=sp+I6BBlIcJS79pai/X5kIFjSazMkV/hJKZ8rNYUafs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8meZfc836PD4zdqn6RHPM9c6WthyW/ZKO2wqVylwS7f7gXHDzoeEVjl5tr181LSGFq8ekpyGQ7NDrgv4+2b+qg4qg7awfqegBwieo4RYO2/GRrm13DKmwdijlPEht9K71YkCxoYo3YIGSUEvibjLj7iTauSPV2Z+a6HIXaobU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6lGL61Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A14DC433C7;
	Sun, 24 Mar 2024 22:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320985;
	bh=sp+I6BBlIcJS79pai/X5kIFjSazMkV/hJKZ8rNYUafs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6lGL61QdNe5oaEKQAlg4cJC6awxSuTSAukbb2WOnq0m1zJtru7CbEGkAM4z5FWXj
	 Uxo7On6wBViMQ4aNSsOigv7TxogqI3uxpCmK+cRYhOzG5t5EuxYbPYzbyOVfQ4cWd7
	 bY88QwrE6lcSAcYyX3VWBn6XJxmQvXVMubIrNIQdNCuNXMdItv6Ip6HD2CtCVI/z23
	 IwmnuTZlEVI8w15xaGBrs0ljCYlPaaJO3JwVSyc8iuqRQpj6PqACqWC4a1Rpss2F5U
	 047F9zUO6Gr590qSJgH1MBZRB4J967tF3v2KFA5CfNf3pXaEme7dEJydppWZL1BBGU
	 jJWGa3SQvy1Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 548/713] sparc32: Fix section mismatch in leon_pci_grpci
Date: Sun, 24 Mar 2024 18:44:34 -0400
Message-ID: <20240324224720.1345309-549-sashal@kernel.org>
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
index 8700a0e3b0df7..b2b639bee0684 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -697,7 +697,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci1_of_match[] __initconst = {
+static const struct of_device_id grpci1_of_match[] = {
 	{
 	 .name = "GAISLER_PCIFBRG",
 	 },
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index 60b6bdf7761fb..ac2acd62a24ec 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -889,7 +889,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static const struct of_device_id grpci2_of_match[] __initconst = {
+static const struct of_device_id grpci2_of_match[] = {
 	{
 	 .name = "GAISLER_GRPCI2",
 	 },
-- 
2.43.0


