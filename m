Return-Path: <linux-kernel+bounces-96063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A668756AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61A91C21275
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98313AA22;
	Thu,  7 Mar 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eV2GjNTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B31386CB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838367; cv=none; b=AYlBsMcuJikQ23tWg3lcpEz2m+J2VS/aFl7Piuo1P56nNP6N0g+3zGcZ072YHBwSBHtgmpCETWoYLDg/yV2R2jj/BXPL6VbnoPbxT1noIP15wqhv4qcVlegjKgYugZQxoyP76QOpBZYCHrSF4/AqTn9gUHIMHshZdMjXQNQwWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838367; c=relaxed/simple;
	bh=JZz52JX16HZ+UtSl1eWRwEyq6yI1e9kFnFSNg89Zjkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieV3Sdll2ow7igCFm5PYlIacGi58JQeP5T6MQV/3Gj1qS6hb3On1LriYLhc885Bx9eChWrCgvXRF+xZy0FXoGx3kV4RNpOY3JJkcWA0mat974g15ooil/ImwT7BG0BUo5K1Lz422Vr6ARgbJDLbHivN//dkNCwJYU42ozbQY9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eV2GjNTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709838362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg00SltJpoNRIhc0Zd1SHPpVGEI2+YhR9NTH/1oo+rQ=;
	b=eV2GjNTsFL+dTMc3eK3FepLxOlx+n3hqe3sXXrxoONpCeV074Q7iej9Sx0+kOi1qH9kqC0
	7eixk2v+5oqeBY+4gFCwgxK9GLPRS556t3MNmSGURFf8SFc7PTsBBsj/Z6HX1+g3inYAwH
	yWJuuhQvMcjuDMWaliQEXy0bUfcmtN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-bXABBfJUNVGBfGntdYleAA-1; Thu, 07 Mar 2024 14:05:56 -0500
X-MC-Unique: bXABBfJUNVGBfGntdYleAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48A7185A58C;
	Thu,  7 Mar 2024 19:05:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD6AB2166AF1;
	Thu,  7 Mar 2024 19:05:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] mm/kmemleak: Disable KASAN instrumentation in kmemleak
Date: Thu,  7 Mar 2024 14:05:48 -0500
Message-Id: <20240307190548.963626-3-longman@redhat.com>
In-Reply-To: <20240307190548.963626-1-longman@redhat.com>
References: <20240307190548.963626-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Kmemleak ia a memory leak checker. KASAN is also a memory checker but
it focuses more on finding out-of-bounds and use-after-free bugs. Since
kmemleak is inherently slow especially on systems with large number of
CPUs, adding KASAN instrumentation will make it slower even more. As
kmemleak is not for production use, the utility of enabling KASAN there
is questionable.

This patch disables KASAN instrumentation for configurations that
enable both of them to slightly reduce performance overhead.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..fc0f9a63a61e 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -5,6 +5,7 @@
 
 KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slub.o := n
+KASAN_SANITIZE_kmemleak.o := n
 KCSAN_SANITIZE_kmemleak.o := n
 
 # These produce frequent data race reports: most of them are due to races on
-- 
2.39.3


