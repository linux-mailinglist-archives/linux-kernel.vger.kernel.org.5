Return-Path: <linux-kernel+bounces-132942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E751C899C43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AABE28211A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18816C458;
	Fri,  5 Apr 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpvmWBPw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2633989
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318481; cv=none; b=TOq30Dgyab0HMECCHQT5FeV1c3yQe7+nQ0JBlsNqHk1eSvux07kQUZ2p1bS1dOWs/scSTH+hbKP0pkNcIUa5dJ1UqcS+3m9sTCqAOyYFdZ/i1KYZI/tVr7059U8105dCaLr7onNrzUwdRl0pOUOV8v56QVsSNuSM+EvoWPGwxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318481; c=relaxed/simple;
	bh=FRiRwc90NawBYQ1NhQ/i4LDW0LXM9/iVyn9EgL+Kf4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqwYn7QXx5iCzzrfG2Oof/vCQki8M0pA4SG6A/sd/r3Vh0v0gpJU9qFNiHKIGafPJbf8t2o0upMhHjca2ShBRlbKXlOO5fp5aWoJ7UkjIl2MvbznxgirdDTlIOVfLFWKxCTUy8nbr38By32JeqZIida18Psow1T3egNVXATry9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpvmWBPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv0f7+ZooceAuz8ErMSH+4jWIomyiUMNQo0xCMMDiy0=;
	b=VpvmWBPwdzSKBhmiDjdnOIhLCrID9qkMpb8qZBC2tVVthBDeeavyKGL3LlvAFUkq+HfEvm
	+cDeps2+xUNT9gDVJjok0es1VWJxlWLuLCmn9sYN72H0dTSuHVoQulR+lIewmjx/rZ68cv
	h7X0CKRpbj3SmQSBzQmVkQX8cJ00OJ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ngfdyHmUMWaz51M7PYvA0g-1; Fri, 05 Apr 2024 08:01:18 -0400
X-MC-Unique: ngfdyHmUMWaz51M7PYvA0g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430b7d8b428so19862951cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318478; x=1712923278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yv0f7+ZooceAuz8ErMSH+4jWIomyiUMNQo0xCMMDiy0=;
        b=WZDGHZM941C6gUQvpsSLbG9U6j1cx3TimurxzF8hRPT/ZdhsqaAOmQVypE7Mj6Epme
         CGkovYDBNy01yXLRePqJzr4w9v/OKXWF1snkaOGrFsl4mJsee752afJs01+8L6EJkjTp
         h7oeNjTR8Pa7aVRWtYl4wvegi+Tmap5dzCHvha7x6WhCpEELbKmRd0xJXJHbTrvovkQ0
         70FWi0HV3SiiwVXSmKfa0Sird74YMVYijtdGCHdyUu22cGEtAuJaGjMJ3wvBRIKKVUMj
         rC5hnxhdkkPOLRUAsRrLf11TjHA1oWa3FF4Y+pkt6p1h9N6lzxkJ2fvHiZk8HJ7zsJNz
         biTg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNFynXRoQkbyABPjL27jQUwD3i1P/MbB0lhzY8qsosPul/SXqiAgXE4jOzsCs7hOqMT++N77NVYcksmGx1dSTDDijXk8XcpAbBrWA
X-Gm-Message-State: AOJu0YzzUFLlB85NizprSszt45zVsX61lGOO4Rgrk89h4XUhGnbmbq2G
	UonjkFgkXZGZNfVrhUlH/nxJGYmWsMTq/YbSdMYVv8i+o1JTgmzn0ikOJ+EnPt3D47zPVm+UZxk
	iNpTrZWHpcRdWJj34MpAn6zdAv2p5REHBRJypEbhQSG/1IDM8xkywFahIH7YG3w==
X-Received: by 2002:ac8:5886:0:b0:434:516a:5486 with SMTP id t6-20020ac85886000000b00434516a5486mr976112qta.21.1712318477245;
        Fri, 05 Apr 2024 05:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhQuEwy17Cph2Q2g7cvwJ6s/aiHUU0/VZ7nyNR44guIaL32ndi6+BiWQVeBBtgC3cEN4G/SQ==
X-Received: by 2002:ac8:5886:0:b0:434:516a:5486 with SMTP id t6-20020ac85886000000b00434516a5486mr976080qta.21.1712318476646;
        Fri, 05 Apr 2024 05:01:16 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4c24001316a1e598258370.dip0.t-ipconnect.de. [2003:c9:3f4c:2400:1316:a1e5:9825:8370])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm679808qtb.87.2024.04.05.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:01:16 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/4] KVM: arm64: change return value in arm64_check_features()
Date: Fri,  5 Apr 2024 14:01:05 +0200
Message-ID: <20240405120108.11844-2-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405120108.11844-1-sebott@redhat.com>
References: <20240405120108.11844-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64_check_features() returns -E2BIG to indicate the register's
feature set is a superset of the maximally-allowed register value.

The only caller of that function changes this to -EINVAL since
that's what userspace expects for invalid register writes.

In preparation of adding another caller for arm64_check_features()
that would need to do the same conversion just return -EINVAL
directly.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9f4f387155f..131f5b0ca2b9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1445,7 +1445,7 @@ static s64 kvm_arm64_ftr_safe_value(u32 id, const struct arm64_ftr_bits *ftrp,
  * considered the safe value regardless For register fields that are not in
  * writable, only the value in limit is considered the safe value.
  *
- * Return: 0 if all the fields are safe. Otherwise, return negative errno.
+ * Return: 0 if all the fields are safe. Otherwise, return -EINVAL.
  */
 static int arm64_check_features(struct kvm_vcpu *vcpu,
 				const struct sys_reg_desc *rd,
@@ -1464,7 +1464,7 @@ static int arm64_check_features(struct kvm_vcpu *vcpu,
 	 * only safe value is 0.
 	 */
 	if (sysreg_visible_as_raz(vcpu, rd))
-		return val ? -E2BIG : 0;
+		return val ? -EINVAL : 0;
 
 	ftr_reg = get_arm64_ftr_reg(id);
 	if (!ftr_reg)
@@ -1490,12 +1490,12 @@ static int arm64_check_features(struct kvm_vcpu *vcpu,
 			safe_val = kvm_arm64_ftr_safe_value(id, ftrp, f_val, f_lim);
 
 		if (safe_val != f_val)
-			return -E2BIG;
+			return -EINVAL;
 	}
 
 	/* For fields that are not writable, values in limit are the safe values. */
 	if ((val & ~mask) != (limit & ~mask))
-		return -E2BIG;
+		return -EINVAL;
 
 	return 0;
 }
@@ -1840,16 +1840,6 @@ static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		IDREG(vcpu->kvm, id) = val;
 
 	mutex_unlock(&vcpu->kvm->arch.config_lock);
-
-	/*
-	 * arm64_check_features() returns -E2BIG to indicate the register's
-	 * feature set is a superset of the maximally-allowed register value.
-	 * While it would be nice to precisely describe this to userspace, the
-	 * existing UAPI for KVM_SET_ONE_REG has it that invalid register
-	 * writes return -EINVAL.
-	 */
-	if (ret == -E2BIG)
-		ret = -EINVAL;
 	return ret;
 }
 
-- 
2.42.0


