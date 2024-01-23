Return-Path: <linux-kernel+bounces-34553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A83837F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB5B29E84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585D1649C1;
	Tue, 23 Jan 2024 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jP8trZ5U"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0B163A92
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970771; cv=none; b=VJwwQcClrrgFv5MEL/sLDogI22joyZw7jXQCQ2CwfwQjvW5IRaB/ibAfmMXm8HDjhIGU0GCsa2iHSkS5qjlOMW0fu0pDFclPE7pych7fy21nXNRbgcXmFcKhrSP1Xzo/W13oZsMjQXS9kADUfFi2cLTUl3YSoSc9vazgmJ5JCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970771; c=relaxed/simple;
	bh=GddXUjJuZ+2bGLFR1fNATJcBu0uRqs+B42yjt68FCHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSIJETVMMuyRBXHvS4p13p9eYUwLJ8NKPCe7g7ZoduVDRoCDYOI4xHpiAfV3LwsY7aD7Ehdbku7EY0obeoIepSCJBkwhXq8aqHWVQG7jM06ASTtIyTECAHROXu+7E95XZoMOyntlD+EKIZZpE6xCaCDGhU2IoFgW71R7QhAZGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jP8trZ5U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d6fbaaec91so30439035ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970768; x=1706575568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9VeAC0n6GMx4wPi40NMz4SGPTTQe2yHzPs1JgVwamw=;
        b=jP8trZ5Ux+surP57gcV9Qyxvx1cm3ehCLnwyPfzBh2K4bFN9S8sokZw3r9k97AcmkV
         g4DPgW3nd1dl2JWmvtq1SlyODXfbLIQitNsVCH4kWzomz1OzQuriYTYT7J1prHGARub2
         cu1YO2TejonQI2uWYkBZ0ON7ury4q/z4b2j1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970768; x=1706575568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9VeAC0n6GMx4wPi40NMz4SGPTTQe2yHzPs1JgVwamw=;
        b=LEcZ4yiNKO6OHe6zPAyow8oM7sjKwcNRO8zMu8p05tmpodIcPwuq4vEB+J2psTAM7M
         CO5B56lTG8S5qsCH41F+zJi+FzIRATUj5Tz2RwTWfUvs8Yl8qxP64d6jnu7ca8Eu6MRz
         DAY4o/d8pCGKUgoJ3CLrbeaxSamiPZMLDM14TrbtRjW/bC0yJXxHvmg6FgrPonyOy561
         ky4aJSOGD3GunTRDiZ92/Fh25u6O+PQGFrjumUDO4jLWKY7Byqp9bdUdpxBEdsTaP242
         +0BpQOB9qEZH8cxFCTNLR1c+lOmxxqM/cQ/QXUKaWUuMSa+jQ0u1lE3i/+zBjSwyQ9GV
         HKeQ==
X-Gm-Message-State: AOJu0YxFrnscwQRZ3gt4pffWDSsT1ekaI909mutclvF1wGAzBhnNDrXn
	+3ye9wtj/qMD+jJAJX3p9qyaRE9luzwmF48Z70/YUMO00enh9j/pyLBRT3HO/Q==
X-Google-Smtp-Source: AGHT+IFeI6YycjKnBoqLRaEce0XOlcWb1lhT+14MzKScGnQ0O8QUPwnivDqc4t/MzboWs6mmtDCiSA==
X-Received: by 2002:a17:903:2348:b0:1d7:6060:c1fd with SMTP id c8-20020a170903234800b001d76060c1fdmr1485888plh.83.1705970768081;
        Mon, 22 Jan 2024 16:46:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mj11-20020a1709032b8b00b001d73a2acc2bsm3598712plb.142.2024.01.22.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Reiji Watanabe <reijiw@google.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ricardo Koller <ricarkol@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Quentin Perret <qperret@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 24/82] KVM: arm64: vgic: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:59 -0800
Message-Id: <20240123002814.1396804-24-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3802; i=keescook@chromium.org;
 h=from:subject; bh=GddXUjJuZ+2bGLFR1fNATJcBu0uRqs+B42yjt68FCHs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgGWO9y3Y/zEJG45Jiuj5PhDwKbjJDqkH4IS
 kNGsePCJRqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBgAKCRCJcvTf3G3A
 JqBCD/9v7CKsi/Hp5MouKCy7vLngZngkzYEdtOtxvOJgkUFMmGHIkK2gyz3sJe4U7qqfIEZ0SIH
 byjwpGGQ+Wkbvqgus0jhOeC7XosIpO5nK83FNGAUV+4MfxCBW9saxE0quwl3Ie+gR1zNXAXEqta
 HtaMpPyFf4WXUs4KsfbCtnxQHKhYiU+B/tB6lN1SBzRm60x/3cVJuQ20JZ/i/kmandUheqFP0bj
 A3H9hdaRlfvsDgWjIHJ8Eo1A6vVgRhkgrXPhd4/FenNP/Jz2IdwVDxNxU1ConcuKOt/aA8eavFW
 5rnNaKwaIgWZpM9B34AoDY07DSYmMlbC5jIIcFQCG22pmVItHkejUwE8DpLPrBjJWqpd75CkQvm
 VYPa4oC24OVpGUmyN6LyxhIjaVDqr5Y8WP2GqhwhOFLeq4ndz3iUyyeo+NCs9kbLiCIn+i/8UQd
 aTUuW4NzKzChhyeYxkQ3DSQ1oglFaVSoG+DZVG9LGK3pG2aGtPMupHfwxlyuGXB/0reNaDiCV4O
 th9KxB/tcrzhzWw7YGwOeUyw6UHIF8CUu/ecKm8CE8HiwxAxveX29SzicfeLz45rTrGItmaz6Zb
 19dbQNQyeeGBES1P35IUEbY7CsxIA6muFz7htulmypE1jgwHu2k/Dv0H0r5e4CdMI5J9gkBbRHw +10i2uWcrpKRsjg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Reiji Watanabe <reijiw@google.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Ricardo Koller <ricarkol@google.com>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/vgic/vgic-kvm-device.c |  6 ++++--
 arch/arm64/kvm/vgic/vgic-v2.c         | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index f48b8dab8b3d..0eec5344d203 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -18,17 +18,19 @@ int vgic_check_iorange(struct kvm *kvm, phys_addr_t ioaddr,
 		       phys_addr_t addr, phys_addr_t alignment,
 		       phys_addr_t size)
 {
+	phys_addr_t sum;
+
 	if (!IS_VGIC_ADDR_UNDEF(ioaddr))
 		return -EEXIST;
 
 	if (!IS_ALIGNED(addr, alignment) || !IS_ALIGNED(size, alignment))
 		return -EINVAL;
 
-	if (addr + size < addr)
+	if (check_add_overflow(addr, size, &sum))
 		return -EINVAL;
 
 	if (addr & ~kvm_phys_mask(&kvm->arch.mmu) ||
-	    (addr + size) > kvm_phys_size(&kvm->arch.mmu))
+	    sum > kvm_phys_size(&kvm->arch.mmu))
 		return -E2BIG;
 
 	return 0;
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7e9cdb78f7ce..c8d1e965d3b7 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -273,14 +273,16 @@ void vgic_v2_enable(struct kvm_vcpu *vcpu)
 /* check for overlapping regions and for regions crossing the end of memory */
 static bool vgic_v2_check_base(gpa_t dist_base, gpa_t cpu_base)
 {
-	if (dist_base + KVM_VGIC_V2_DIST_SIZE < dist_base)
+	gpa_t dist_sum, cpu_sum;
+
+	if (check_add_overflow(dist_base, KVM_VGIC_V2_DIST_SIZE, &dist_sum))
 		return false;
-	if (cpu_base + KVM_VGIC_V2_CPU_SIZE < cpu_base)
+	if (check_add_overflow(cpu_base, KVM_VGIC_V2_CPU_SIZE, &cpu_sum))
 		return false;
 
-	if (dist_base + KVM_VGIC_V2_DIST_SIZE <= cpu_base)
+	if (dist_sum <= cpu_base)
 		return true;
-	if (cpu_base + KVM_VGIC_V2_CPU_SIZE <= dist_base)
+	if (cpu_sum <= dist_base)
 		return true;
 
 	return false;
-- 
2.34.1


