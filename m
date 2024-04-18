Return-Path: <linux-kernel+bounces-150785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E88AA490
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9F31F21684
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDC199E99;
	Thu, 18 Apr 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd3YOWj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B653199E88
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474174; cv=none; b=UBouN2iZr3rV+cAGoYtCIchvMWHFfDb21B5nVDj3iRtn+CT/fTp5Euoa2MWeDb9ifqiebNBfGnUisHzR0RYqYIzr1dya1i+SwXaiIa1+7xkY5QmaToqxGpX7kGj1MyJUK41Yu26GUi6X2u8kxDfjzlwkcWiDiOLzMy8ja3KKOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474174; c=relaxed/simple;
	bh=k7cNZQtqSrlv4JeV2BTf4vB+rduDV353rBwxNmUmz4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRG0Fdt6J5uO8CaKlA3knTNeQUZ38C6ByuI0WgpnNPuq/a0PM49tyQrXoFrP8LSBGW8EXNUMb3RUCJ6/VOAcG6UzmTb8eop0PxU9kyXN00In0CzzcrR2eMk8XJCkYkxbdoI3DFcZPZMWUdiZqaAqnFOBkBC1nXEdK8MWmfFXKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd3YOWj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713474172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGwLf/zGdjbS5m+0XqbUt5N2AjYYBbBkI6NTUeaiDj4=;
	b=bd3YOWj3kTopdE05oYsLh3r7KTzSBAI73nf0Vjp9D7H5CRsHdkd8V9GzcVhSwDS1RpmO4o
	tQbcHmpFMQavuDz89Nwm9dVtdDdScKXsFyUyQWlN+6zqgvjV9qq82TOCgz2B5yfTdbA/4m
	8KCUhPtD4cliR/COVOvQpG4Il5OeC/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-tjLOU_fXNCGZ8R2giiE72Q-1; Thu, 18 Apr 2024 17:02:47 -0400
X-MC-Unique: tjLOU_fXNCGZ8R2giiE72Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 429D918065AA;
	Thu, 18 Apr 2024 21:02:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4C1140BAA2;
	Thu, 18 Apr 2024 21:02:44 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 2/2] kunit: avoid memory leak on device register error
Date: Thu, 18 Apr 2024 18:02:35 -0300
Message-ID: <20240418210236.194190-3-wander@redhat.com>
In-Reply-To: <20240418210236.194190-1-wander@redhat.com>
References: <20240418210236.194190-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

If the device register fails, free the allocated memory before
returning.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
---
 lib/kunit/device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 25c81ed465fb..bc2e2032e505 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -119,10 +119,8 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	kunit_dev->owner = test;
 
 	err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
-	if (err) {
-		kfree(kunit_dev);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto error;
 
 	kunit_dev->dev.release = kunit_device_release;
 	kunit_dev->dev.bus = &kunit_bus_type;
@@ -131,7 +129,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	err = device_register(&kunit_dev->dev);
 	if (err) {
 		put_device(&kunit_dev->dev);
-		return ERR_PTR(err);
+		goto error;
 	}
 
 	kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
@@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
 
 	return kunit_dev;
+error:
+	kfree(kunit_dev);
+	return ERR_PTR(err);
 }
 
 /*
-- 
2.44.0


