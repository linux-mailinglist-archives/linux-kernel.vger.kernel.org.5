Return-Path: <linux-kernel+bounces-101736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9906787AB25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8E71C21D30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C95101A;
	Wed, 13 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nex90Pkr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672650255;
	Wed, 13 Mar 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347428; cv=none; b=ZhiJX10+5nDekrc2N1eBjUC2QxGnYIGaYeMqUAWTcgJ5L66fPiiZRmlliaU7m9wa6D0BQXvhmfaTZ+NITo6huRKAwJ9c+8RwMZDAbY9DZ0P+IA/JeZEJ7acCui4SMy1NAqpljPzMVnDgyKAwUEsGwdWevBnlQnq9JBvUnqdjUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347428; c=relaxed/simple;
	bh=QjmiehSPJ87rBU9jLAS1zq5YEKjrjTcokhRSGk2rOgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPLDdBnT0ZKaMh4EJ/U1ID8/IdUnAf203Noeay53pi++scRKtmC15sMhDUgzBy8v7WcNd0cnnfQWlhTHFbdfVGqLcIMQYFUNy/ll9efkaDnvRhm0wKmJFx55tl+MQgHF5fZ4h2R/+KgqaIIdisf7WokO5NlDw47mbqwOfwt2kkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nex90Pkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599EC43390;
	Wed, 13 Mar 2024 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347427;
	bh=QjmiehSPJ87rBU9jLAS1zq5YEKjrjTcokhRSGk2rOgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nex90PkreZXu6JAquWUkYwByY1PrE12bfHtmjMLDmmsbwUEyOnqMEsIvkJ99y2bgg
	 MXN92LyDGHAmBY6vyRtreM9bgHkIMaEKoCXNTPxigrAxNH9bGp2etmXPiKj4xqtrLJ
	 8jU4mdGOcQTxHE3aKEslmV2sDTnk0Tuai/RyDh7kw9V5GrnAxhDMRiMTYrppGepEA/
	 9/whDsVgQjyJuHxiDN2EWVp2uT2mhBF6Thn2hu5pEyETOQ1UmSiFRrGDB57z6Y4sA/
	 /1j17pW3IuPlQhhNLnNSIG19k+TwoEV4x6IN5Doeak7O3UjpNMbqEozt7lfM5U217X
	 Rd6/uOZXyRyfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.8 4/5] KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests
Date: Wed, 13 Mar 2024 12:30:18 -0400
Message-ID: <20240313163019.613705-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
References: <20240313163019.613705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.1-rc1
X-KernelTest-Deadline: 2024-03-15T16:28+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 2a0180129d726a4b953232175857d442651b55a0 upstream.

Mitigation for RFDS requires RFDS_CLEAR capability which is enumerated
by MSR_IA32_ARCH_CAPABILITIES bit 27. If the host has it set, export it
to guests so that they can deploy the mitigation.

RFDS_NO indicates that the system is not vulnerable to RFDS, export it
to guests so that they don't deploy the mitigation unnecessarily. When
the host is not affected by X86_BUG_RFDS, but has RFDS_NO=0, synthesize
RFDS_NO to the guest.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e02cc710f56de..ffe580169c93f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1623,7 +1623,8 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1655,6 +1656,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*
-- 
2.43.0


