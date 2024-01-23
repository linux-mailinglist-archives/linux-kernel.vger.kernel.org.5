Return-Path: <linux-kernel+bounces-35711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1A839574
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C0B1F30755
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96186AC3;
	Tue, 23 Jan 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7zxGhFK"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998186153
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028518; cv=none; b=S355Gy7A21yH438D32tHARKJ3dVCz6f9Gka50rU295YbhyLPbWXX0ZTQuvLcVwEtVFp8cw4/rl2VmV7Qh9/d0ffWBFA0YB/y1rW0tMdmy7H1XjFEmz+i3bFsyEQuLPMKPO39PjimPa0xmHKLBwzhcgFavY9+N3zr+iuJVi0IBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028518; c=relaxed/simple;
	bh=xeMH/PTY9RvVC0crS+oE1ldLHgl6NeMg+38kZCLwc40=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VyEGbXE5aMktEk7SUcv1zQHO6Eis/mXYCqUdaJze+Rq0ln2iaNkL/xZQgiy+9PDSx0WwjspWK1waIgZ3MOglRUOqCz7wsP8hWQa3Rz2rihxiY5nlDryf4p/EDGvMXWUDROYoFe20UGP2Gh3TFF5eRGTJ+8WLfDDfvEU5pe6I5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7zxGhFK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40eaed9b181so18982935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706028515; x=1706633315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBfCCDyzKoRpaf1abp6hy1jxU0Vk3dNquTbtYZnKWbE=;
        b=L7zxGhFKy7FtlxaeEt2ZTtalxk9MbHeWeLtUNTV+tGdIoXzWFzdCv2WnCe5Vj3Luv+
         OuhOq9jd6du87x1MBp4Wre00ADYn5lkIGF2VWfrtSEMDdWMwiWZuvLQPcbgfGAcKcCXY
         8zlzPnN74BmDS4JC9a+v6YCMFn6bkDfEolH0rm5IDB/xn2hFEhrjSPj0ynsjJ4A9dZSh
         VtRRZpVkcIBOvHvvAt5+jRPCjo1U8RgdaI+KxtAI+IoUrrifIXs2D2J6dX3YAEKxlW4S
         s+lR2r63QNUcwtO4ljcbnlBC7a31C9oPvi7VyT68Xt+aefXiOfjAi33tXNoOLy6LPn6P
         Pbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028515; x=1706633315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBfCCDyzKoRpaf1abp6hy1jxU0Vk3dNquTbtYZnKWbE=;
        b=VYUfJKrJpHUUj9v8V6MjjhT8ig6y7jN5abOB5LyKJ/OR0Bdqn/Bllisu7mdm0J/+AI
         X+U+uM5Lj/WlbcejIbyUgeSCdg95FNfJQeUBwHWhqe2NQYXnVjvhY8HhC0TAZwRQ6KPi
         fhksQuBROok+7py8WgpxWryg6Bc5R3DuTR8t21KVIQ7pXLiRewo70ortpCgedDqlIsUa
         tgAw5sjWIsUu1UBKkAkMiQ7//VTbTYYB5s03OZhXf94NXah9OXkOSZ8EId4tsNePkOOu
         kWq5Zfc8CtmIbHjRPcRQmlEosCpgLrjOYmMstxCr+73hit853/nSgjSZK3i4Um5RTwJ+
         4Sjw==
X-Gm-Message-State: AOJu0YwpZMYUNsrQEtSun33mYnAWqqztuwV/qHWe/b9IgHMJwBwDyLBI
	BMBQy4vfzvqys4t58pakZMKE6koRvwJ/FrE7/uz7KnG0WN88fLlH8IychHHHsVNP+HEdUWBZSmn
	hdn9fkou/FOJdOtPIUG3iChgKtQ==
X-Google-Smtp-Source: AGHT+IH+Mlr6tHRfY6bx2hXJSMKsnWPJRGl4NYKa0sp9VUfpgnmD9gh0uN5EJJTqznNM7e5Ct5DDTXdfW1jXBoCyNNc=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:4e50:b0:40e:bf1e:9e84 with
 SMTP id e16-20020a05600c4e5000b0040ebf1e9e84mr17364wmq.5.1706028515271; Tue,
 23 Jan 2024 08:48:35 -0800 (PST)
Date: Tue, 23 Jan 2024 16:48:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123164818.1306122-2-sebastianene@google.com>
Subject: [PATCH] KVM: arm64: Fix circular locking dependency
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
kvm->lock. The rule is violated by the pkvm_create_hyp_vm which acquires
the kvm->lock while already holding the vcpu->mutex lock from
kvm_vcpu_ioctl. Follow the rule by taking the config lock while getting the
VM handle and make sure that this is cleaned on VM destroy under the
same lock.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Cc: stable@vger.kernel.org
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


