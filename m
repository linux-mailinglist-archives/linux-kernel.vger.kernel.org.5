Return-Path: <linux-kernel+bounces-113439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8D888458
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C210E281934
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3BE1AC76E;
	Sun, 24 Mar 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZDX3asv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE41ABFD8;
	Sun, 24 Mar 2024 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320241; cv=none; b=jmmtt6WkyOzJchWr4NNHXwl7/97bAtRtVK0yQq6P6TckXaqehunmgRvIdRAMLvoFA6oLc2duE18HlOlmpwin3dbzFrHrm77uGGQ8EmR3f+q0QAFgj7fh6NKx21cBznKbcCePJEg1jw90l9Ss7BT2XsWMeJjztogWDMFAAr3CbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320241; c=relaxed/simple;
	bh=vJO9V5YbNjm6VSQYv/Akl+4bvLFiaD4hxKDxh9ah8+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrhehGWhlXjaG4JFbT4cnHxMQJQ+kPrl9REnT4LQgzcggESFT+x9dGPPDc3s82mOjUGra1taz5slxOqi8aVPY1vTVtPOgmqCAMI7N8pKNMb2C5prjZqrNYL1kDB9PEMPrLcMVMdftNWeHsE8orwOhEXmkey09ZCxwhXdET4e/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZDX3asv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBB1C43394;
	Sun, 24 Mar 2024 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320241;
	bh=vJO9V5YbNjm6VSQYv/Akl+4bvLFiaD4hxKDxh9ah8+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZDX3asvFMhxtnuAiDnDFnECmUk4F4Dersvmkr6AunhIWI6MR0xRvw7WJ859FfVbH
	 f29M0jjy7EHb8kd7U8t01bK3YJl8FA4FD1OtJz6RdCOF6DU1+jKCyQdBYRoGAAm6B/
	 9ZfHOiy6HrXI3VZOaHgPZ9njHkzkoioREU1DBkzLZzu7B0KkrtgVpFjlc3LVHX6krV
	 ZoOV1uBG0Vyv2VBdy9RjEcHhrEwY8etY6WmUglpau0mPRMDnmwvNnRJHQerpJsP+Mp
	 BGZSkyJMf1XKcGkHQyX83sKF4x9XPHCRi0aODIHj3PZu22w3Kfyg4bqyURml/02h0n
	 g46EJG96ImieA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 548/715] mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function
Date: Sun, 24 Mar 2024 18:32:07 -0400
Message-ID: <20240324223455.1342824-549-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 8bc8db2ab2832daabdd06feeabdd511dc9575bb6 ]

The __mips_cm_l2sync_phys_base() and mips_cm_l2sync_phys_base() couple was
introduced in commit 9f98f3dd0c51 ("MIPS: Add generic CM probe & access
code") where the former method was a weak implementation of the later
function. Such design pattern permitted to re-define the original method
and to use the weak implementation in the new function. A similar approach
was introduced in the framework of another arch-specific programmable
interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
difference is that the underscored method of the later couple was declared
in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
methods in the subject. Due to the missing global function declaration
the "missing prototype" warning was spotted in the framework of the commit
9a2036724cd6 ("mips: mark local function static if possible") and fixed
just be re-qualifying the weak method as static. Doing that broke what was
originally implied by having the weak implementation globally defined.

Let's fix the broken CM2 L2-sync arch-interface by dropping the static
qualifier and, seeing the implemented pattern hasn't been used for over 10
years but will be required soon (see the link for the discussion around
it), converting it to a single weakly defined method:
mips_cm_l2sync_phys_base().

Fixes: 9a2036724cd6 ("mips: mark local function static if possible")
Link: https://lore.kernel.org/linux-mips/20240215171740.14550-3-fancer.lancer@gmail.com
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mips-cm.h | 13 +++++++++++++
 arch/mips/kernel/mips-cm.c      |  5 +----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b17..6cc79296c8ef2 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -33,6 +33,19 @@ extern void __iomem *mips_cm_l2sync_base;
  */
 extern phys_addr_t __mips_cm_phys_base(void);
 
+/**
+ * mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
+ *                            L2-sync region
+ *
+ * This function returns the physical base address of the Coherence Manager
+ * L2-cache only region. It provides a default implementation which reads the
+ * CMGCRL2OnlySyncBase register where available or returns a 4K region just
+ * behind the CM GCR base address. It may be overridden by platforms which
+ * determine this address in a different way by defining a function with the
+ * same prototype.
+ */
+extern phys_addr_t mips_cm_l2sync_phys_base(void);
+
 /*
  * mips_cm_is64 - determine CM register width
  *
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 84b3affb9de88..268ac0b811e35 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -201,7 +201,7 @@ phys_addr_t __mips_cm_phys_base(void)
 phys_addr_t mips_cm_phys_base(void)
 	__attribute__((weak, alias("__mips_cm_phys_base")));
 
-static phys_addr_t __mips_cm_l2sync_phys_base(void)
+phys_addr_t __weak mips_cm_l2sync_phys_base(void)
 {
 	u32 base_reg;
 
@@ -217,9 +217,6 @@ static phys_addr_t __mips_cm_l2sync_phys_base(void)
 	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
 }
 
-phys_addr_t mips_cm_l2sync_phys_base(void)
-	__attribute__((weak, alias("__mips_cm_l2sync_phys_base")));
-
 static void mips_cm_probe_l2sync(void)
 {
 	unsigned major_rev;
-- 
2.43.0


