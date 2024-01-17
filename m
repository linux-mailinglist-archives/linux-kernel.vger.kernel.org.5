Return-Path: <linux-kernel+bounces-29537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBB830FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E725B28A7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B728DB9;
	Wed, 17 Jan 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sqv8CQ31"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11022F17;
	Wed, 17 Jan 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532841; cv=none; b=S9kDCAWmz2Oc+2w7wFFPKNvoWlGySzjDUZliGQ6inWzRy/E+lpTXsx4NayTeYX2SO9+Zx6fljQ9sBDP76EgcPZ1S03yIhCpy02lwFdWLBkucoNdw4WaB0AV5JscZx+PmF8i9vJ5F6NCP3kfqk1vZQ2wigDoYRwQRVkY8MLILSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532841; c=relaxed/simple;
	bh=n2BhsFjGcr7MuBGXteubepVgpYIPmnI7f0uYF07S+ws=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=NFA+EJ3Edi6Qmw7suZWtP5DoJWFtJ60Alz1vlHuyIczkmW40iAGSJtiBHl8Sx3MIrrcXQSMHyTWV9gnWUfhj97v3el5VK5q1ukV4a9+rrgFrFWU4PCroeiMN5kb7spXpYGVL+vPxXRoif7lNq4CkCrf01tieBSzHw0Hy5iKnuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sqv8CQ31; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tL7JHTjwR33SLiqO2gdH0Yo2NTGGiSKZCN1Uyn0m5mI=; b=Sqv8CQ31VYBNhnIc0P7XixwtXT
	UCNNXnytKrLzNfYcp6PVfgpzgkK1JnH1NAImPVR5rgreMrkMZihTo/UJwut9gap69NUCNqJgn68u9
	pOydntKBU8khfOD2OebL/B6gKWtDotkgzZwysWHPecQfpJfnA/LvHZ6rKid/fqmO49qxIAAV2qa/2
	dZb63Uzw1ZN4O78teO2NwvYEXgsprzKOxgKXYOaZNXcXslic31f4+nVBrriz20JX9h2exO0SXDbmh
	VQjarR4Yhn/HYPHZ8koIbUdIbTW/qFemhve23Qgps8zpmwjUlafU0omnlDGq1/QuavHlpLs5FS62H
	zIubOWZw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0B-0011su-0O;
	Wed, 17 Jan 2024 23:07:19 +0000
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
Subject: [PATCH 04/10] KVM: arm64: vhe: fix a kernel-doc warning
Date: Wed, 17 Jan 2024 15:07:08 -0800
Message-ID: <20240117230714.31025-5-rdunlap@infradead.org>
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

Use the correct function name in the kernel-doc comment to prevent
a warning:

arch/arm64/kvm/hyp/vhe/sysreg-sr.c:109: warning: expecting prototype for __vcpu_put_switch_syregs(). Prototype was for __vcpu_put_switch_sysregs() instead

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
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -95,7 +95,7 @@ void __vcpu_load_switch_sysregs(struct k
 }
 
 /**
- * __vcpu_put_switch_syregs - Restore host system registers to the physical CPU
+ * __vcpu_put_switch_sysregs - Restore host system registers to the physical CPU
  *
  * @vcpu: The VCPU pointer
  *

