Return-Path: <linux-kernel+bounces-159901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCF8B35FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8441F2275E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8A144D34;
	Fri, 26 Apr 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6KgwVKZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F884144D1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128601; cv=none; b=BOE3b7KEpl4zD5iSy5qrMBCIGU0iej+htq1UPpVJP0XhDOV7I766zrRa0BzOvKEnl2+70nbpG1yY0XR0CaT4JN3JaatxC7Ga2SRe9nUBblz26ibKgZ8k1r+d81cIaB8oTEuPtB99MyMWGLZs+lmb4JAnL6mhuWqkU22UAdSIxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128601; c=relaxed/simple;
	bh=FRiRwc90NawBYQ1NhQ/i4LDW0LXM9/iVyn9EgL+Kf4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+iKAXQgoVMxnhQiW8zORuggrrP7kW3k5aNUwpe2IeVramRrpwlzTDQyTk0PgCwmyqPQMrSzHrQLOVRFE5jrWiK+KY7Bpgej1aXTEQv4hq4XMIjMiorMCrzqWatmqN4HS4GOrFKblbQ6b7MtcLYdUSQAZnX18AAbjNPL++VIrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6KgwVKZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv0f7+ZooceAuz8ErMSH+4jWIomyiUMNQo0xCMMDiy0=;
	b=A6KgwVKZcqaE3W1wk0vpl2WSFn69ohVD4WI7puqK9uq8CeAjl7Lpf0Nma045miR+E8XKag
	1BnpZd70i+yeJyraRtvWv76r2nnjB44yKHkUigxmcc7IsBQjcn3EGuB2v6OaIopx81JkJt
	hW7P8HZmQheEeSR2UFjJY7zTA/gEB2I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-FKVa-qTFN-WOz3nr_wbs-w-1; Fri, 26 Apr 2024 06:49:56 -0400
X-MC-Unique: FKVa-qTFN-WOz3nr_wbs-w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78edd30a24fso259495085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128596; x=1714733396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yv0f7+ZooceAuz8ErMSH+4jWIomyiUMNQo0xCMMDiy0=;
        b=D8QgKrrofjWf+IXeyCXLt76CeHKLyhZm2OBRV7BOdjdcukrj8Mm/4+oXkVnFlTG2+J
         TUro3dkP1DkkuLP2kpYsfs8Uxttt9QGMwnZuDxlfrUmQUZMpJePIgN9AKXVtjBu23RGa
         p3pFIlTwwVMJ1TpBvDLTwMI+Pa+u0zKXBa3uMz8nvJSlHQn4QOD8VnKZ6KicyFzmlelf
         0lU7G6UDDiugjWfyf8k/7dmcHX4fW0KPlDWuh8//MvId3iGNvAPUQ2oRWZlTCzWAzbPl
         yDy3yKE2ytP9TBwy1MtpAnKmRbluAc5jTKh6St8CX6E1Zw8+tvnu5WRMG02Jbm4IVrUx
         NHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlTZLMdGoKpvuJ8poUkC1kXDeamnHCuV4vpCgMk5wMCxopJNxZcFY9EtS87HZyXxLUe+3+thOCipQ1Wcc8R+hHokIGCkoow1R1LSzt
X-Gm-Message-State: AOJu0YxufHCSUjU9Btu5qv0RpKj2BEJj2jaG1JhuWAjZJonRBKgPJmxg
	2V27ysFEB0nK3e/19iWO6dO7vtGsDvme0ImH/1bpIaYVcqYwxctfrTY63/6MITxupoYCrwRq+Ry
	6LN2faGJWr8u4f/K2cnO1VOXPR1enadmSkki1vLu/vkZSKxW4fANV27s5MVygEA==
X-Received: by 2002:a05:620a:558f:b0:790:9792:ccf9 with SMTP id vq15-20020a05620a558f00b007909792ccf9mr2474360qkn.26.1714128596244;
        Fri, 26 Apr 2024 03:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuK9q7K5MnARR1FYXhNoL5QlURcOPFxWs+be/9tKmV0SXMgVdbnC3Cd+KrI9ajhgrIqvqt3A==
X-Received: by 2002:a05:620a:558f:b0:790:9792:ccf9 with SMTP id vq15-20020a05620a558f00b007909792ccf9mr2474347qkn.26.1714128595916;
        Fri, 26 Apr 2024 03:49:55 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:49:55 -0700 (PDT)
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
Subject: [PATCH v2 1/6] KVM: arm64: change return value in arm64_check_features()
Date: Fri, 26 Apr 2024 12:49:45 +0200
Message-ID: <20240426104950.7382-2-sebott@redhat.com>
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


