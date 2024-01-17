Return-Path: <linux-kernel+bounces-29544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B3830FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F46728C455
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE712C862;
	Wed, 17 Jan 2024 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4imAu3N"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9B28DCA;
	Wed, 17 Jan 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532843; cv=none; b=CzsVwGPVordeU3IoHehIzl/IxHlrK3qyKofuudYaHGLf6Sxa6b9tFW+gme4GFuqolS4Y4hz9x7YfVTlFO35icMGV7srT4M4eWTiZnmewjee+DLEYqlBvYLIw/jiXDJy2cpK2QJYhf5Db+eLWt5FqLG2TIpl63d8W0TYKHTaEmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532843; c=relaxed/simple;
	bh=RiiiCFCSg23bdODcmHVKYdCbg7Nx10zpVDFgao209n0=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=h4BxmEstxuH4CRy911oJawEPcPjXXuBPv0IZbUnUPWnlSJ1yB/o57GphPoVts9y7lxc8TcYvV+tPTv7VmzkofvW3jQFwMG6+AleVJa0tVaHY6zsLID1hhV3AMv42crIoddKVbqHFgSozdp0zb56AnnwGkYGD48fRY0v1vMPUxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q4imAu3N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4z//f4SWii73rhmNB7IdhlI7RbSfenJTKTaX55Qhiuk=; b=q4imAu3NSlhLHLEfxBINKlePAf
	EoW2oKIsUWSxyc0WEiV3W9N9j7vE9sGxXbVt+0UL5AxkvQcn5xvJ1Sy2R+LmuMJPgtuRd2qHPQ8kM
	p7/5G6sBOXCLfMXJdBQvKZCsjCm1RKQV5kmIm1TudfMVKpUFe41cBFQcIbxNJyu1ESZaxW/ojZ8cX
	RWntzG7KluBxBZzo06l7bhopvQIupwjEnw9iJV5CwPXAhuBCX5SrvDNgS0+ysKZE1vWN9tKdrvMQQ
	em/3TFg6TUbMnj6bxjvbKr5ezbAyzmOgO8X1/Q7nMLR5dTM5a0KD5uIWPMXqCkla/8NLDQjI9VUV4
	rUXAR+FA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0D-0011su-11;
	Wed, 17 Jan 2024 23:07:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 10/10] KVM: arm64: vgic: fix a kernel-doc warning
Date: Wed, 17 Jan 2024 15:07:14 -0800
Message-ID: <20240117230714.31025-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117230714.31025-1-rdunlap@infradead.org>
References: <20240117230714.31025-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function name in a kernel-doc comment to prevent a
warning:

arch/arm64/kvm/vgic/vgic.c:217: warning: expecting prototype for kvm_vgic_target_oracle(). Prototype was for vgic_target_oracle() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/vgic/vgic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -203,7 +203,7 @@ void vgic_irq_set_phys_active(struct vgi
 }
 
 /**
- * kvm_vgic_target_oracle - compute the target vcpu for an irq
+ * vgic_target_oracle - compute the target vcpu for an irq
  *
  * @irq:	The irq to route. Must be already locked.
  *

