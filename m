Return-Path: <linux-kernel+bounces-159907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298BE8B360A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31181F215B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8041474CA;
	Fri, 26 Apr 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1P2dZb8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDDB146D55
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128611; cv=none; b=R2luaSi3da2MNUMAoFW0W9XTMEE+8lEVsxlwR8lC+HKhtz8NFdFKui56o9KORcpYAf4g025uMDZUqXeUT3ZBT8HA2z8D2tc1BQHYJETqXHUFxMOCGOJ+kCJhk4c1KMQjULOQ4hACGyFmMxXC9j8b2xcqY//jWybS1BXa8CHOsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128611; c=relaxed/simple;
	bh=jh0NGErGqzNPQk8HfQs0ty56UQwvTZ9Efo3G7pxJW+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCxj2oyH20kq0YJbmjTHju5Xqrf9Pv4O2oWwVcmm4wWTfN/GAeo7ukJFIGwhZXWXtIapzP6nb9qm9StPscX0ifPZwLUa6l1DSWuR+hg+GntkYvTF9ADrpwfOTQVaq8WPt8FOYgfzYh3ik6pYToeaYK1cjcFgiKwzcx6BXy1W2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1P2dZb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBEVlwbbJPUSSW/SmfUHJkSUS/tMVeS+WCfEWVSGRSA=;
	b=Y1P2dZb8xYs8OuK0Y5iTw7hkANNqWyeomB/f1FMC3n23rOdAp2dn42C3wZL1P/idDmgPY/
	3+0kc3W7F5Ti/s5JVWLXjrjUCz0Xa7lYGgK45ay1UE5bH6a3uALVcAsVoAmf2UY9cO38tM
	Pj3mhaV1X32D72K12J8LF5QOyF1CAho=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-5Yg46B-nOiKz1AZOqAwBOA-1; Fri, 26 Apr 2024 06:50:05 -0400
X-MC-Unique: 5Yg46B-nOiKz1AZOqAwBOA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb7eddbd08so2424403a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128605; x=1714733405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBEVlwbbJPUSSW/SmfUHJkSUS/tMVeS+WCfEWVSGRSA=;
        b=uRRg1v/yg+oe1PIkcGSbPVIta/m3YYafDztsNexQCNe76XTELOKXiQintI3o1dUlSF
         1pPG5dy2nD+Gzvthu1z7Uk5F4UUMvVLP8hoD+VlyumXxEiP3X6xflf54pUHLi50SkYim
         0VS4Rpk3R1lSizcLD2H1HMNXIAeJfgSxg9Q77wIzJo+kky3J6AKV1T4ry2i14hKIiGz9
         7RyWaFtXiHPxVsrzNKDHAMKl/upaq7S6Cafh1kKG+bEcRYmqzg7n1HXfAL/10sil4d5a
         tb8x57vrMhaRI+QvlbrTwciFo+Pkqgy+FeE/VCwtjaClKZ2diTDR+hr+dqobGIWmUtpx
         89qw==
X-Forwarded-Encrypted: i=1; AJvYcCU1fYJv0kbVEmF6OYmOIohWIkBaZAOF5XwVi8O+d7BRapI3OKJLC7QtBJpwdtbB3CzwMcYmEPtQlhFNot1wOZcke9067o+Eg7UAXORd
X-Gm-Message-State: AOJu0YycIUhIP/nvjFZpx+4Y/HuohvIl2/LhTnnN6O7n0M2Gh8YA2i0z
	fFu1wQdrAjPiRiTmUiRtIdoF8Qddo0h/54UTNSVf1yRGKuPhHbJdo1tdL4/AIUmgGMJzz5aGmc1
	1T9O70MXy2nc/MJOR7LFpZa51caUhBGJCtfBwQg5QlQtRY+kcMBS86eUO/sfH/A==
X-Received: by 2002:a05:6830:453:b0:6eb:cddf:a783 with SMTP id d19-20020a056830045300b006ebcddfa783mr2269773otc.26.1714128604907;
        Fri, 26 Apr 2024 03:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMwtq9AaLj7a7CoLw8WnO6n+wHmWUkrG5Ru4V9/wZCrwSv2FNYib3sVt3Sw6963MwbFEf/QQ==
X-Received: by 2002:a05:6830:453:b0:6eb:cddf:a783 with SMTP id d19-20020a056830045300b006ebcddfa783mr2269757otc.26.1714128604644;
        Fri, 26 Apr 2024 03:50:04 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:50:04 -0700 (PDT)
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
Subject: [PATCH v2 5/6] KVM: arm64: show writable masks for feature registers
Date: Fri, 26 Apr 2024 12:49:49 +0200
Message-ID: <20240426104950.7382-6-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426104950.7382-1-sebott@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using ~0UL provide the actual writable mask for
non-id feature registers in the output of the
KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

Explicitely set the mask for CLIDR_EL1 to make sure we present
the same value to userspace than before.

This changes the mask for the CTR_EL0 register in the output
of the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2fe3492ba3c4..7d5d55e5c16a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2532,7 +2532,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
-	  .set_user = set_clidr },
+	  .set_user = set_clidr, .val = ~0UL },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -4087,20 +4087,11 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 		if (!is_feature_id_reg(encoding) || !reg->set_user)
 			continue;
 
-		/*
-		 * For ID registers, we return the writable mask. Other feature
-		 * registers return a full 64bit mask. That's not necessary
-		 * compliant with a given revision of the architecture, but the
-		 * RES0/RES1 definitions allow us to do that.
-		 */
-		if (is_id_reg(encoding)) {
-			if (!reg->val ||
-			    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0()))
-				continue;
-			val = reg->val;
-		} else {
-			val = ~0UL;
+		if (!reg->val ||
+		    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0())) {
+			continue;
 		}
+		val = reg->val;
 
 		if (put_user(val, (masks + KVM_ARM_FEATURE_ID_RANGE_INDEX(encoding))))
 			return -EFAULT;
-- 
2.42.0


