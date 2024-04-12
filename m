Return-Path: <linux-kernel+bounces-142820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1768A307A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7E41C20E67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9012D1F4;
	Fri, 12 Apr 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guw8o70F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A58664D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931732; cv=none; b=Mt3iyOVVYJ+jnGZD6ROF0bZHgLMXZss/THo5oVXkA7l1BKlpirMJcDNQijAPdYovQ881JFasCrhCtXxpc/j+oewAg5aMmEqujl/Lo4NUOSc1LMBehFjOCVjX5Xk4ZqANebBcoQhmGWVRF6l58smpk8A4PTdluamXPGrrvxix6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931732; c=relaxed/simple;
	bh=Phe+lYXoRi24QyGQuxCqNCGKvUUZ+0zh5Rap9SldaDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Owgp6luMiS+dZ8pcYJHIysm2tm8fGg/LyvLN24XNdgQrkIh01je3KkpstXcna8eyQzJidga8MkIvXuaWbiBauwxTjP4Xr4hl39mfx/RVtbzYSlGnZLzrjSt7zWzRO6nivP7MHOUHiLWIFX8Bef4gICxAhwQHKe17H7SjDxQzuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guw8o70F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712931730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfJ1VHTxISYLGq4mlbz2Skb/m7VY1n6kTTDVNpcpew=;
	b=guw8o70F/tdVBRO8ZzU/FGlfYr/PXYbvOYeKQH7Ym21dldbb88ABR6u0G19hq8I4yanYd5
	BiZ13+pd87AeS2m7jFLOhlMBOYIOFmetM0ms6lO0k5PtHJpmoBcrO9XHo4L6+PY3oXo6Or
	Nb006eI76s9KixeyETuQHnlfIy3OkhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-OoCH9gzXMWuEIstknxSGTQ-1; Fri, 12 Apr 2024 10:22:07 -0400
X-MC-Unique: OoCH9gzXMWuEIstknxSGTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8129F881E62;
	Fri, 12 Apr 2024 14:22:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3626940C6CBF;
	Fri, 12 Apr 2024 14:22:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 06/10] s390/uv: make uv_convert_from_secure() a static function
Date: Fri, 12 Apr 2024 16:21:16 +0200
Message-ID: <20240412142120.220087-7-david@redhat.com>
In-Reply-To: <20240412142120.220087-1-david@redhat.com>
References: <20240412142120.220087-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

It's not used outside of uv.c, so let's make it a static function.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/uv.h | 6 ------
 arch/s390/kernel/uv.c      | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 0e7bd3873907..d2205ff97007 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -484,7 +484,6 @@ int uv_pin_shared(unsigned long paddr);
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
 int uv_destroy_owned_page(unsigned long paddr);
-int uv_convert_from_secure(unsigned long paddr);
 int uv_convert_owned_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
@@ -503,11 +502,6 @@ static inline int uv_destroy_owned_page(unsigned long paddr)
 	return 0;
 }
 
-static inline int uv_convert_from_secure(unsigned long paddr)
-{
-	return 0;
-}
-
 static inline int uv_convert_owned_from_secure(unsigned long paddr)
 {
 	return 0;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index ecfc08902215..3d3250b406a6 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -156,7 +156,7 @@ int uv_destroy_owned_page(unsigned long paddr)
  *
  * @paddr: Absolute host address of page to be exported
  */
-int uv_convert_from_secure(unsigned long paddr)
+static int uv_convert_from_secure(unsigned long paddr)
 {
 	struct uv_cb_cfs uvcb = {
 		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
-- 
2.44.0


