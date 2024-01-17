Return-Path: <linux-kernel+bounces-29542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39896830FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E893228BFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D192C6AF;
	Wed, 17 Jan 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pkx2RUf0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193328DA5;
	Wed, 17 Jan 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532842; cv=none; b=GF1krz7bgGSzML+Jwtlxgdg8JCfr+rRTJmVUteZ/3V0LtAf4uUzWf/kFcpMpGnc/wLK4pZpNS0Z0uZ7OZucFVm0o5QXCKGeWIqBE7rmh4XVFIXu/3JqErt7B7eMCcC6pAe5/4LK9jtq5Nv6+1xxL1HN6zw11/a8lvB87JXHbmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532842; c=relaxed/simple;
	bh=TySm173rxyhAdotDK7EIJbVdusDgJzeysg/S3YPerVA=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=QHPMyPIF93uBcwW/KjvUtzSWT1NfXweur4Ry1FYBwoXePtSRdpR2TcnpgWJ69KNbdJs7BzJoIO/HVcFST2QSovc8YXv+p9Szb2nz/Oy4h/RJiYwHhpE/bCI2yE87fKADv0F8NboD2sjtXOzCuzH0HxBNYMOwyKDLmNgZIkZZsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pkx2RUf0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KBv72L9EWa6OscyWF0/gK01Q4M4/AoY4DRCGn5aUvKI=; b=Pkx2RUf0B6Jagv6qaghzuJ1vRL
	8jw3ipu/hjZFqdfp5mFtDV2kbQreAwBbsozigWmFC+vY/C5VlLNcwA7agEwO/3uWhCcXYFVkAlXpg
	wW2bZL49WzxHGWY1ZJMH/Ba40qMyDKjpaSqGayHQz2WdBBvg7sJ+YW6OEuNu6CnDHh+MfOR3XXOfk
	E9D4IWUcf9N1+83a/8s/BeArV34JPQpHTHTwH3UWuJCgWDtYJbX7mdQrpGSE+DrTs3Wvwuxo3IONL
	90KfUG0HkQkrBA1DupXQFb766moo5Hn8R0sl4/ipzDQC5sGXkFGq6ApAiFy4rGfDld6JbQJ88AtA7
	msZ++Ddg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0C-0011su-1m;
	Wed, 17 Jan 2024 23:07:20 +0000
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
Subject: [PATCH 08/10] KVM: arm64: vgic-init: fix a kernel-doc warning
Date: Wed, 17 Jan 2024 15:07:12 -0800
Message-ID: <20240117230714.31025-9-rdunlap@infradead.org>
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

Change the function comment block to kernel-doc format to prevent
a kernel-doc warning:

arch/arm64/kvm/vgic/vgic-init.c:448: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Map the MMIO regions depending on the VGIC model exposed to the guest

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
 arch/arm64/kvm/vgic/vgic-init.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -445,13 +445,15 @@ int vgic_lazy_init(struct kvm *kvm)
 /* RESOURCE MAPPING */
 
 /**
+ * kvm_vgic_map_resources - map the MMIO regions
+ * @kvm: kvm struct pointer
+ *
  * Map the MMIO regions depending on the VGIC model exposed to the guest
  * called on the first VCPU run.
  * Also map the virtual CPU interface into the VM.
  * v2 calls vgic_init() if not already done.
  * v3 and derivatives return an error if the VGIC is not initialized.
  * vgic_ready() returns true if this function has succeeded.
- * @kvm: kvm struct pointer
  */
 int kvm_vgic_map_resources(struct kvm *kvm)
 {

