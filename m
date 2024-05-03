Return-Path: <linux-kernel+bounces-167347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F58BA84A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A141C21AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA214883A;
	Fri,  3 May 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCF1FeRh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3A1487E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723619; cv=none; b=Eg0Sxra9OIcnyNEU5mBGH1ovpQOVtCMV+yOjXjIx0FnswZq/WBrQX5PLCaOgqABl5FEY+8oSelLNI1CdP6xCln6JyV7jHVA068QE3nae2apkrNV25Zec9t/KdJmwiIzdO/Zp5hZg+4MlcR1fEm1YwS3Pc+xF3YVUHoz5by70uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723619; c=relaxed/simple;
	bh=XTfAo570ipDqa5PmAidNrBIOxSfaySsMHMjW3Y3DQVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evr/PxRpNgveAdNasbpZdjoGbgWU2CIzYdIyKEjPsbNQ1AGN4vMPntaN64C4iMqPw083rnvgOCDY6Wk81Z0pZn9+MDKOslRu/5vDt9XGv9VrnRcWSVzY/QVRXwLfd+RS4i33dAiyBVlhpKh0unFVbaqw2uWWWpVH5K275qtLrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCF1FeRh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714723616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z+zU3AeWmNst/4jBWwt/IVxOgw0orJOeFMMHxayccOs=;
	b=HCF1FeRhu23qUEWhbonRGgjq/kN2Jk3i4cIw/RLtMxIZV46UEgeHFYq5tdGL39lEVjXZGf
	7dWItITkxauopaspU5jKrQx+As9OxH5OF/4WDG8gbI5mHW9j9Cc7r734MM5WKwh3ZQVDv6
	YCQZUkUvj0fHAEJy7ZC4Xyd9ydJmciY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-IVHiuRcBO_eWr7E1No7rBw-1; Fri,
 03 May 2024 04:06:52 -0400
X-MC-Unique: IVHiuRcBO_eWr7E1No7rBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E2141C0314D;
	Fri,  3 May 2024 08:06:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D94D1C060D0;
	Fri,  3 May 2024 08:06:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2] s390: Remove comment about TIF_FPU
Date: Fri,  3 May 2024 10:06:48 +0200
Message-ID: <20240503080648.81461-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
so we should not mention TIF_FPU in the comment here anymore. Since the
remaining parts of the comment just document the obvious fact that
save_user_fpu_regs() saves the FPU state, simply remove the comment now
completely.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the comment completely

 arch/s390/kernel/process.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index dd456b475861..d8740631df4b 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -86,11 +86,6 @@ void arch_release_task_struct(struct task_struct *tsk)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	/*
-	 * Save the floating-point or vector register state of the current
-	 * task and set the TIF_FPU flag to lazy restore the FPU register
-	 * state when returning to user space.
-	 */
 	save_user_fpu_regs();
 
 	*dst = *src;
-- 
2.44.0


