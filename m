Return-Path: <linux-kernel+bounces-68130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8268857647
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E016B23E92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514901EB33;
	Fri, 16 Feb 2024 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTepzBhp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F01E888
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066463; cv=none; b=uzob/XqlOWCw28YPiZKMsX72OVILz9yYuFBdfGztJBQ7XuJ7LvpSufFDGKdZGRt0l8GX5ehbmXqr+9MCVnoz9to2A6T8JVeTF7S1D3tqqq3ccrc+mMIClUNXJ0a1TRySNUmc6ZjqFmg/1ARxrjq9r/6N6mtTa5apCCFXlH7btWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066463; c=relaxed/simple;
	bh=76rc2RXrSGYrSj0C5tpAcUBDgwB+L+6GnchV2Cb1TXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RylIRBoBUqliHGvDasJpmvcKr1Txpvy5pcA4X9zJ9zpHY5OuZSnWBoydrmQLYKJ1zzVyeK8W8NIFlctPv12777qkJLuur+f7etj9av/decAX+6sp+3ehmOq1d/BW83hY3mJKIvkvO8WQonGG63Yn+iAtNKjE/RDGlSepXAYhjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTepzBhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477CEC43394;
	Fri, 16 Feb 2024 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066462;
	bh=76rc2RXrSGYrSj0C5tpAcUBDgwB+L+6GnchV2Cb1TXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTepzBhpub0N6GDHAWQ92fg6hamVDAWFkhi1H3OtEdwVXR6BNgFJkIPVRVIhczNtY
	 ONzylcaA0wElfNFJcdsPuk0mkKJNZDECU+nYLVaAlA4GAyU6pQbIaIXE6ClA0wSeR5
	 oC/eBD0nRHX5kZ3wPgWaVZqYwtLBaa4z6OrnVatq7GWMoN84XmAupCV/BadcabFxVV
	 D662aciGIIKh06bobhx5cHhSObz3FGi3TC6b0Cm5z2SV7asXpY4IFYWoeI5y/OkhA7
	 bEiwXCwZnbh+F2O4Lg9k6m/BfLwyF+I+eMm97cAh1nrU2UBbLHoLnd9hI0XzuEJ4lo
	 AVYPt998gh00A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 16/21] drm/i915: remove intel_gvt_irq_info::warned
Date: Fri, 16 Feb 2024 07:53:21 +0100
Message-ID: <20240216065326.6910-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_gvt_irq_info::warned was never used since its addition in commit
c8fe6a6811a7 (drm/i915/gvt: vGPU interrupt virtualization.). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/interrupt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
index c8e7dfc9f791..336d079c4207 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.c
+++ b/drivers/gpu/drm/i915/gvt/interrupt.c
@@ -40,7 +40,6 @@ struct intel_gvt_irq_info {
 	char *name;
 	i915_reg_t reg_base;
 	enum intel_gvt_event_type bit_to_event[INTEL_GVT_IRQ_BITWIDTH];
-	unsigned long warned;
 	int group;
 	DECLARE_BITMAP(downstream_irq_bitmap, INTEL_GVT_IRQ_BITWIDTH);
 	bool has_upstream_irq;
-- 
2.43.1


