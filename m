Return-Path: <linux-kernel+bounces-74101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACB85CFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A271F24F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC83B7AC;
	Wed, 21 Feb 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GL2D5v0S"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882E3B193
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494208; cv=none; b=EOXS9Ctp/1boTXuUXevKyKHaCiJGS/XEVqz7gRAyAxTCopRvYeijz/ZIqXJc56S2GRFxFq1E1RTjRiXaLhAT5rGPOD828BQkowkzWHDYtaWrH+FsKHVxVozM43ftjx3Ey95zizCKXzQI1Hncau6Lb831HTdd497awuvMKRL5NfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494208; c=relaxed/simple;
	bh=RxF9w33LgnXLTuXV5O9RLdzK9dXUqE5MSbsOmdxxwVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCtyuJ9AtPEq0qAr2LfMpcymzPEBhIb8DTh11NsRtvGBErFjvtc0LLrOwikdEdJEcr5pYOZIH8AIMDWh/87g2K6hL3Lsl+fwo02TWh7PlL6UI0ozWHMTF8ZeJY9SvJTICvfDey8912UdZLwLlukhiFhkK2SYw5U2sWV2iTNBVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GL2D5v0S; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708494204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7/gBwWxFbIZwFC+F2czZFaZoLMKZvcePyaMRonjua4=;
	b=GL2D5v0SC8vLCvny+w0lysq1H7+eVYaJPjgBXHDAX31SpwfBHeusS509F4eACvmVOuX2oW
	YZQOwMa3/zFkcg+V/vPyOoDP+9UuhCmyIp2XJVxwtXOjQ3Cs4Ip3o/VYERU1asvwz4SbZF
	cnqOWEIcewTFCBKCM25xdIFUmrmg9AE=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 03/10] KVM: arm64: vgic-v3: Iterate the xarray to find pending LPIs
Date: Wed, 21 Feb 2024 05:42:46 +0000
Message-ID: <20240221054253.3848076-4-oliver.upton@linux.dev>
In-Reply-To: <20240221054253.3848076-1-oliver.upton@linux.dev>
References: <20240221054253.3848076-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Start walking the LPI xarray to find pending LPIs in preparation for
the removal of the LPI linked-list. Note that the 'basic' iterator
is chosen here as each iteration needs to drop the xarray read lock
(RCU) as reads/writes to guest memory can potentially block.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9465d3706ab9..4ea3340786b9 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -380,6 +380,7 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
 	struct vgic_irq *irq;
 	gpa_t last_ptr = ~(gpa_t)0;
 	bool vlpi_avail = false;
+	unsigned long index;
 	int ret = 0;
 	u8 val;
 
@@ -396,7 +397,7 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
 		vlpi_avail = true;
 	}
 
-	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+	xa_for_each(&dist->lpi_xa, index, irq) {
 		int byte_offset, bit_nr;
 		struct kvm_vcpu *vcpu;
 		gpa_t pendbase, ptr;
-- 
2.44.0.rc0.258.g7320e95886-goog


