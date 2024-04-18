Return-Path: <linux-kernel+bounces-150151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D38A9B07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71751C20AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4477A161331;
	Thu, 18 Apr 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b70u+pPO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563215D5CC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446290; cv=none; b=ZomWyYdj8h7SxSbc1edkeY0ZLIe7vK1uVdFoqXnNXKPawkNxINmMPEvn7vhvtzjbgZ6mDKno4VmMFFYncISJVPLS/WrHbeBuEfQsFQTH+p6ZVOI5zuUSCa3C/cU6yYXQG1Ut9oi0i7SVpLzN1jMoxC6MuRyTRhZP2q13aKAEW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446290; c=relaxed/simple;
	bh=nXM+CC7tSgd1SU8pAldhxaauEOPwaBJ/aoBUfDLRb5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBk4h8rFsyjGrJPn84jJVTuxv/7fJit4o3FQ1CSqK5xQL07GFHNbt+3ojPX7jpNpUnxXPCjAYnh9lADmataRdD2tsWtsyRmT8Crf9kXG2ikATdtFPFHrS1O0OlvctxdsHjSg9cDY9Nd6cjfc9eIyVYdAbRa6U3CcyBa0E075ojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b70u+pPO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713446287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrDuSMKVIPvxaoWUO2lKmOmdU2n/2aiR3bt/iorklfM=;
	b=b70u+pPOS9MRFPkKHt1PCJDcWChOgQpasO1VFTPUTGWOOK7Dd+lqRULaZt3yDMMcSA4qN4
	MoZi4smnEwZ38UqpJPVxF9AeOVaLQDS77rKz821EM8NXct2i4vyFHHxv3H1Bg3Jh78yjfY
	VbyEF4tozxIELVj8MJwIUuUG6+9E3A0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-OykGZIxpNRCSTuIjaNnQqQ-1; Thu, 18 Apr 2024 09:18:03 -0400
X-MC-Unique: OykGZIxpNRCSTuIjaNnQqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1810B800CAC;
	Thu, 18 Apr 2024 13:18:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18366C271A9;
	Thu, 18 Apr 2024 13:18:00 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 1/2] kunit: unregister the device on error
Date: Thu, 18 Apr 2024 10:17:52 -0300
Message-ID: <20240418131754.58217-2-wander@redhat.com>
In-Reply-To: <20240418131754.58217-1-wander@redhat.com>
References: <20240418131754.58217-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

kunit_init_device() should unregister the device on bus register error.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
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


