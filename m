Return-Path: <linux-kernel+bounces-118761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5D88BEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB70F1F63363
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68A6BFB3;
	Tue, 26 Mar 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="napLaSpR"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC06F060
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447863; cv=none; b=emKKj6nVQ7Q+Om4Kjd/z4P6Ty4DOiCBtdMaVfPNwTxYoDRp+8n4KIHsUOGkNQB96X2Goi18iZa5XUE9ufeqEfAGQsCrW+msGxorB+NEOlnuq66Cx5Xu/whHidLtPuJcongzcTIBM5+bNPFgyf8XceV8g9lVWKfZkhHctJzqBsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447863; c=relaxed/simple;
	bh=luF0DePhOxP9hOcT/xfXxKnxXQoPebGiYwffl+rfHkI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Mmj7SJztZhx1SOIGsMbr1KXnGz2W66ckI8iBaZIww4uOAXEkwyvXyZCTse0Z3JIGKYjIHe+k1yJNIW5UG3BlIM3X1s5rHGb8P6ZBe8v6Bd5u22Yjwt300D7VI0LhZKuA6Ye/8DERDYJQep4xDfFYv+SApZuAEH7CVjNOIC3MXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=napLaSpR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b22af648so4153173b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711447860; x=1712052660; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiNYGBSxUvNgdPnHEJE/xU3metbwCHzJuKT0A3W7MYI=;
        b=napLaSpR4hUxSSrL5css7LToxJ7dJ9Ld/wYk1saMy7j2g2mJ+1JPH/+8oY+YHHhFO1
         rCepsIh3Cpbw9Ar8cDlhbo8Dgkj8Cb24t6lLgcLGQ6QszFELu4s2lHeRy7RtK0iFx5eQ
         NzBVHbH8skQlYyV749zEdIwznvdarL0yMDSzflBGlr4yfgMdjf+D+MFU2O1sgpHGKcOu
         5h+gm6MsMm/VZQ5VxoE7beJGRSv2VqgUaV7JOEPeDbJQQ9LTKk8xmZka3VVqE6SGg63p
         x5KzlK0aaumwAoBaSsCr+vaInki7q9hOD3Q75mJXGyuOtrdidTMfiR+ywDzC0tW5o5s7
         03Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447860; x=1712052660;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiNYGBSxUvNgdPnHEJE/xU3metbwCHzJuKT0A3W7MYI=;
        b=nb8GZSqg3Nkzl/BS80oCEcKePJN6Tu3anhCnu8Tywe0TFQgye7PE5sn1UW9HEgj+TS
         GTsA0nctQGCQdRrlzlZ4alkbrXVPQxl60BMUDQVEWy8yvijC8MQK+bo5GAo7VudGjaDi
         7idqfkhsyckygEWwF8YM+Ow4/5kRKG5bFgd4ylLzZeXysapOuT4D5TfC6RW5qnTaW2Gr
         /UeLEjyyudTTI6hchij/6hNRlMVezSDVBxSvo3iDb0tYkpgsOZ94UHx99oP/kEz87UN1
         On4x9c8PyM0svv5Q4zMY3Gkt62VQW8gC4BaMaM4LJ8AKqGtdBmK8UFczUvfA8hk5w5kg
         Ny1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlfuTGzScKX8+MgUpXt68BS+9JxTdnEMAXMeYIqsPIj8nqqm9YUIddUh5qTpDVp3av6IcjhfhvRujwyUTbqhMBUT5f40n3VG1XG6GD
X-Gm-Message-State: AOJu0Yz1VWty3rQOR+6IBf6A+0ljDGMRlKmeqCn8t3+TBsqo303EbflP
	OprtULqRxXdxOxOSDs2SElZ0viY/nj42rDa6F3mTrLwjHSYrDq6btec3+TnFUYM=
X-Google-Smtp-Source: AGHT+IEqMrxzRfAQyyX5BWY+o9kj4fYO6R0c9EdEEs+a7j40uL9Tbsf27ODXSAN5Mbodl3JqSYvUug==
X-Received: by 2002:a17:902:e842:b0:1e0:188c:ad4f with SMTP id t2-20020a170902e84200b001e0188cad4fmr1519731plg.26.1711447859767;
        Tue, 26 Mar 2024 03:10:59 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c7-20020a170903234700b001e0e2b848dbsm1633240plh.83.2024.03.26.03.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:10:59 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] RISC-V: KVM: Avoid lock inversion in SBI_EXT_HSM_HART_START
Date: Tue, 26 Mar 2024 18:10:52 +0800
Message-Id: <20240326101054.13088-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Documentation/virt/kvm/locking.rst advises that kvm->lock should be
acquired outside vcpu->mutex and kvm->srcu. However, when KVM/RISC-V
handling SBI_EXT_HSM_HART_START, the lock ordering is vcpu->mutex,
kvm->srcu then kvm->lock.

Although the lockdep checking no longer complains about this after commit
f0f44752f5f6 ("rcu: Annotate SRCU's update-side lockdep dependencies"),
it's necessary to replace kvm->lock with a new dedicated lock to ensure
only one hart can execute the SBI_EXT_HSM_HART_START call for the target
hart simultaneously.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/vcpu.c             | 1 +
 arch/riscv/kvm/vcpu_sbi_hsm.c     | 5 ++---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 484d04a92fa6..537099413344 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -254,6 +254,7 @@ struct kvm_vcpu_arch {
 
 	/* VCPU power-off state */
 	bool power_off;
+	struct mutex hsm_start_lock;
 
 	/* Don't run the VCPU (blocked) */
 	bool pause;
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index b5ca9f2e98ac..4d89b5b5afbf 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -119,6 +119,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	spin_lock_init(&vcpu->arch.hfence_lock);
 
 	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
+	mutex_init(&vcpu->arch.hsm_start_lock);
 	cntx = &vcpu->arch.guest_reset_context;
 	cntx->sstatus = SR_SPP | SR_SPIE;
 	cntx->hstatus = 0;
diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.c
index 7dca0e9381d9..b528f6e880ae 100644
--- a/arch/riscv/kvm/vcpu_sbi_hsm.c
+++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
@@ -71,14 +71,13 @@ static int kvm_sbi_ext_hsm_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	int ret = 0;
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
-	struct kvm *kvm = vcpu->kvm;
 	unsigned long funcid = cp->a6;
 
 	switch (funcid) {
 	case SBI_EXT_HSM_HART_START:
-		mutex_lock(&kvm->lock);
+		mutex_lock(&vcpu->arch.hsm_start_lock);
 		ret = kvm_sbi_hsm_vcpu_start(vcpu);
-		mutex_unlock(&kvm->lock);
+		mutex_unlock(&vcpu->arch.hsm_start_lock);
 		break;
 	case SBI_EXT_HSM_HART_STOP:
 		ret = kvm_sbi_hsm_vcpu_stop(vcpu);
-- 
2.17.1


