Return-Path: <linux-kernel+bounces-36681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD79383A4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9D81C21ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF917BCA;
	Wed, 24 Jan 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uedZXKC2"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78617BA5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087439; cv=none; b=fQI5PDLIn4CE1193pCKbbAbVGizldot6NoCt67SrhrxwI/MecxeRSZrWk2u4l3gGmHJJTBY+hpL8lY8vTTCYedeKNofAown9yj64ZS/bRXhzHOa+WKj22squaPFK76fZ852QhWKirSyuomEuGDvYT4KUw3oDEIQu0EjtusXC1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087439; c=relaxed/simple;
	bh=VbIlhMmrk27yNKtV56v+KJ/TtRK0LOiHjDYn+JraBwI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DryksBd2EA9uGuXP3HwOkcv0Onne7Hqd0i5v3hfBLMBu79/9KmjdfJN0sCxSMX9nIPvYuFC61AgxttmzOqU6FQNtMgijZF+JinVWH84gKx59Bzar06dmy5Gbn6q7NkjlZdm5idAcPDfVPWfYcT7EzjUXH4hor3OjD3exjwAvI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uedZXKC2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33927b1fac7so2253815f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706087436; x=1706692236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azYCHPhWGygUAZtVjzOnMMNYpv2pTJPs25+3mFpcg14=;
        b=uedZXKC2+RzmTKjt+Jbqhi1yd/+qzSqxlrk+L9NnuuyiGSGW8iM3rjwskmnOUlrXDE
         57ccLc1nj4jeDq2zCSqS5h3diAWLu1nyFfj+3Aq5rP7Jq3DrsY+i5slNUgwZKr3XZ29S
         9b5P0EtcCnNoA80RciwHAL9Kb7+eD1cvGiIq6TO9srUkVIaboubXc9a5gsSZT+OahsP5
         uL0fl7HaZG0uD1JWPug+/DFtfjyjhihnFQSimV0NvdJsAwRWTK3S5dlacnqlYga9r9Gu
         92d0uJOlmW9AOw1qiMeG7ZVKNG4VhHgL+kTcOygipqhMnMCTKjc+zTcueVNtu6Wx+PFT
         QyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087436; x=1706692236;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azYCHPhWGygUAZtVjzOnMMNYpv2pTJPs25+3mFpcg14=;
        b=jrj2a0x2IZT6dhoNl+S8lBq5ryyq7xCqCcVsZgIc2UlBrDYO2GQoMSWzbcMg1JgHdf
         LV6kfSE6vYBC482W/zTn8GooGe7nmtQ6jrTy5+TzxHtaSs4BWCOhZvXGfCfO4LdBf5eq
         agtwTIPA0pWx+muSTLrOdiufvTL30647/vcB1xsITB2JWuYjAisKWD9FSfSv56t9weP7
         pCOsiynwn2Q7F+OHcd9AEVguYTosl1pBtK1pYgXeNByPNy8V3BxZK8ApPQvXnB0ddJHB
         bhlh3CReyD6ZH0eLwrdcZpAJhM6XlPayJkiPIU+Gd+Srl6xcT1BVNLS8h4CLIynFY2ug
         z0SQ==
X-Gm-Message-State: AOJu0Yxs3Dbgl9S4vbh0kYTGAcMjOZLlrwlbw1qWTdUZi9TkhDwnpjAc
	PvWsQySkz++mUnsrQ+LbR2plAHdfwtVcrRhO+El47q8QWCrNYreMfTQAmbdm8t8e5V0msXCB0bR
	H97mo5llwZ5pbeoXxHWKpsoX5tg==
X-Google-Smtp-Source: AGHT+IHQu8PSyX8X6hBs0OxdOvH6yTQqd8GMOA0f4B5GP1tHJaIbkkEvv2xekuxmDaroKhS0ZGfjPA1hyZX71dbNPJg=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:518e:b0:40e:c602:e37d with
 SMTP id fa14-20020a05600c518e00b0040ec602e37dmr8947wmb.0.1706087436115; Wed,
 24 Jan 2024 01:10:36 -0800 (PST)
Date: Wed, 24 Jan 2024 09:10:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124091027.1477174-2-sebastianene@google.com>
Subject: [PATCH v2] KVM: arm64: Fix circular locking dependency
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rule inside kvm enforces that the vcpu->mutex is taken *inside*
kvm->lock. The rule is violated by the pkvm_create_hyp_vm() which acquires
the kvm->lock while already holding the vcpu->mutex lock from
kvm_vcpu_ioctl(). Avoid the circular locking dependency altogether by
protecting the hyp vm handle with the config_lock, much like we already
do for other forms of VM-scoped data.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/pkvm.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 8350fb8fee0b..b7be96a53597 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -101,6 +101,17 @@ void __init kvm_hyp_reserve(void)
 		 hyp_mem_base);
 }
 
+static void __pkvm_destroy_hyp_vm(struct kvm *host_kvm)
+{
+	if (host_kvm->arch.pkvm.handle) {
+		WARN_ON(kvm_call_hyp_nvhe(__pkvm_teardown_vm,
+					  host_kvm->arch.pkvm.handle));
+	}
+
+	host_kvm->arch.pkvm.handle = 0;
+	free_hyp_memcache(&host_kvm->arch.pkvm.teardown_mc);
+}
+
 /*
  * Allocates and donates memory for hypervisor VM structs at EL2.
  *
@@ -181,7 +192,7 @@ static int __pkvm_create_hyp_vm(struct kvm *host_kvm)
 	return 0;
 
 destroy_vm:
-	pkvm_destroy_hyp_vm(host_kvm);
+	__pkvm_destroy_hyp_vm(host_kvm);
 	return ret;
 free_vm:
 	free_pages_exact(hyp_vm, hyp_vm_sz);
@@ -194,23 +205,19 @@ int pkvm_create_hyp_vm(struct kvm *host_kvm)
 {
 	int ret = 0;
 
-	mutex_lock(&host_kvm->lock);
+	mutex_lock(&host_kvm->arch.config_lock);
 	if (!host_kvm->arch.pkvm.handle)
 		ret = __pkvm_create_hyp_vm(host_kvm);
-	mutex_unlock(&host_kvm->lock);
+	mutex_unlock(&host_kvm->arch.config_lock);
 
 	return ret;
 }
 
 void pkvm_destroy_hyp_vm(struct kvm *host_kvm)
 {
-	if (host_kvm->arch.pkvm.handle) {
-		WARN_ON(kvm_call_hyp_nvhe(__pkvm_teardown_vm,
-					  host_kvm->arch.pkvm.handle));
-	}
-
-	host_kvm->arch.pkvm.handle = 0;
-	free_hyp_memcache(&host_kvm->arch.pkvm.teardown_mc);
+	mutex_lock(&host_kvm->arch.config_lock);
+	__pkvm_destroy_hyp_vm(host_kvm);
+	mutex_unlock(&host_kvm->arch.config_lock);
 }
 
 int pkvm_init_host_vm(struct kvm *host_kvm)
-- 
2.43.0.429.g432eaa2c6b-goog


