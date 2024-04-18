Return-Path: <linux-kernel+bounces-150784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378C8AA48D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983B71F21441
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE9194C97;
	Thu, 18 Apr 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF/cE2Qu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E7194C80
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474171; cv=none; b=ferYinOOyn5EmB1Hx7Zvh/XCw+TOtZuh6FSsTxB69N7TKHAH35dybr8urOurB5kUKHiiRM2iKgUqsMIWv/+o7tnjHum1AmR3nWIqU30n0D/aQ15AC2Yg+5uHl5xg109ynsuNzTnM+cxw6bz2psHoezCb2XynotLoigjdYr7UVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474171; c=relaxed/simple;
	bh=RkC57Q7UJKwDbV5ZOymkImc73C43dsfw8U713gEUT98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYrSfvkpvSfXiEnRI2txCR70BbNotaDmqUkKlHRR/ZmIy5GeFSXwAWaYI12+VNyWJ3gBeQcS/5MOMHL4ZyfN+r50GdrPDZkQzecqY+iOx79Yp0rIBzcYyrhDPNY4QUP9KCzxMW+r7e+J5aEzJ+o8Xo+VScRUaZmHTqESumDWxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF/cE2Qu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713474169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OquLsmPZLgQdNvdRfcQqVZOgi9jZ8SYqH65xHdO5f8w=;
	b=LF/cE2Qur79TqoO8xzmEqwcYJxHHe+c5maCqiLZX4URnFFbYUKVMIOQZEjJXbFPOhvfA6o
	7WX5MnJMy034NWY2ZxmWcJOuumlv5n3ji3aOfYV61gpJ1uGHlssROsDoIR+J8BJVJ5snkv
	BKCPO4G1YSpUaPV22vh/92VNHFLOMwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-DxhA7QUEOyePso0vqAbdvA-1; Thu, 18 Apr 2024 17:02:45 -0400
X-MC-Unique: DxhA7QUEOyePso0vqAbdvA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4979218065AA;
	Thu, 18 Apr 2024 21:02:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E8302488D81;
	Thu, 18 Apr 2024 21:02:41 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 1/2] kunit: unregister the device on error
Date: Thu, 18 Apr 2024 18:02:34 -0300
Message-ID: <20240418210236.194190-2-wander@redhat.com>
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

kunit_init_device() should unregister the device on bus register error,
but mistakenly it tries to unregister the bus.

Unregister the device instead of the bus.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
---
 lib/kunit/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index abc603730b8e..25c81ed465fb 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -51,7 +51,7 @@ int kunit_bus_init(void)
 
 	error = bus_register(&kunit_bus_type);
 	if (error)
-		bus_unregister(&kunit_bus_type);
+		root_device_unregister(kunit_bus_device);
 	return error;
 }
 
-- 
2.44.0


