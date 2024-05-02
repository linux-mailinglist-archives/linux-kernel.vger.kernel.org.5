Return-Path: <linux-kernel+bounces-166782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901888B9F72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5133028A224
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9C171060;
	Thu,  2 May 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AR8uV/Vb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED16FF4F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670737; cv=none; b=ChfgJpdNjfIqBAxo8ZzTNwAaSBkFwu49zZ4DluchAYZ58SZdQaWEXZn9IJl9QukPCqn6AciMIQEGswdpGbTMbliwMq10g2hJFchYcs8YGV1MnY6IBkVpHAKAsfavWR/0aArdBXEbCC7upy+SiMzDFTcL2mjlf+ysPlhxUCHBHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670737; c=relaxed/simple;
	bh=9sK3cgXcw0kGGdqcttliMVoT7IUpCFpfEgwKdV1yFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIYfpf27hUfCEvwEueLwMfw3yU6pacbGe77mm9xDV4AQ8e5rJX1aHUMKWuUaP4VoSegDS0hQ3QMEnLwS4pmdXa/rJ1dyx1H7/vxXMji9syaL+LgDWi13/42KBUms84/mh2zmjnrKr/2svbg1B4yXH7Y37YcuXgK5SHw0KbLFb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AR8uV/Vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714670734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBG6GaiLjRiP4gKHlRkscXOFUfjsp8h8LuC83O9Byb0=;
	b=AR8uV/VbRHENkibzJHVhCFbVM2kKNW44or7dNniKa63Hq1+qhXK9ISCusoec6RCcvQ/TVf
	XreHqSGNKFO9Ns0Nid1C7izYKZt8V9Ed80r0sf2xXBMFfK9MWtv0gQECnl5pMR6HWFFzM6
	UCGzOTE/Ogm+l5YKMf24xkSCdObTI60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-xluJ9S7dP_ClqJymeEvQpA-1; Thu, 02 May 2024 13:25:29 -0400
X-MC-Unique: xluJ9S7dP_ClqJymeEvQpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1447F830D37;
	Thu,  2 May 2024 17:25:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9C7CC15771;
	Thu,  2 May 2024 17:25:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390: Remove comment about TIF_FPU
Date: Thu,  2 May 2024 19:25:27 +0200
Message-ID: <20240502172527.56835-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

It has been removed in commit 2c6b96762fbd ("s390/fpu: remove TIF_FPU"),
so we should not mention TIF_FPU in the comment here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index dd456b475861..3e7df2e579f1 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -88,8 +88,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
 	/*
 	 * Save the floating-point or vector register state of the current
-	 * task and set the TIF_FPU flag to lazy restore the FPU register
-	 * state when returning to user space.
+	 * task.
 	 */
 	save_user_fpu_regs();
 
-- 
2.44.0


