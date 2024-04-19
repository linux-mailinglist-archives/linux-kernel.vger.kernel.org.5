Return-Path: <linux-kernel+bounces-151467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFE8AAF43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E77C1C22313
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAC12A14A;
	Fri, 19 Apr 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4ok1DKx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BED83A14
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533127; cv=none; b=jWEOs4c2aMi5Iy6tU534AeM50M2PaNGxcks+bxqIuUd4791yhaRO7TkrUusxTSKwmTiH0PIH0yhm9NLsmJ8zdKM+CoWvV8OUMAvK0FfZxdo3W8LihvapHRswjmAj03QIjQPU7h9nevSV0kBbTx2HwDGrnTpo+YoDcfZGqWG8X/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533127; c=relaxed/simple;
	bh=zmdkTFihWpy+XhiLb7Ai9Fv3Kxr9kNr6UrAO97Mor0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVY5DIR3CsuLmvAK+zBjASs83qOV4YftTB43yx+k2G1jVzENs/JB1MAdIm8OtZEcvr5I2MCm5nPOwHrHedfdqfXKLBkJPEff2Ph7fIKQJo4hwOchM24Rim1OA3RIa+JQ1e/6InsKY6gJ1t9vBHZJ0nmh6kCE8gyC1Q68hBALe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4ok1DKx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713533124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKFWmD89ZfxI3WrGZY3k5MGYxU+9FObI37ylz+l21us=;
	b=F4ok1DKxR9Klf0PXKQsyjF8Ij+v8XB76cl+rOY92vtlHqfrxEDGdxDeJopdX2W/T+rPAiI
	gZ+rCD9KQgls05yO/TO4DMYrHXCItf/UgA9l0woXcSDAzDu6EqVFhwoGz4jzPfanu9lp9k
	LuMvbpKFlYetw5FHA7dQDPx4dXMbdAQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-xs4GAnh4PMSaDOM1y3cvUg-1; Fri,
 19 Apr 2024 09:25:21 -0400
X-MC-Unique: xs4GAnh4PMSaDOM1y3cvUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDD952820B78;
	Fri, 19 Apr 2024 13:25:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02C1F4EA71;
	Fri, 19 Apr 2024 13:25:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v4 2/2] kunit: avoid memory leak on device register error
Date: Fri, 19 Apr 2024 10:25:02 -0300
Message-ID: <20240419132504.9488-3-wander@redhat.com>
In-Reply-To: <20240419132504.9488-1-wander@redhat.com>
References: <20240419132504.9488-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

If the device register fails, free the allocated memory before
returning.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
---
 lib/kunit/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 25c81ed465fb..d8c09dcb3e79 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	err = device_register(&kunit_dev->dev);
 	if (err) {
 		put_device(&kunit_dev->dev);
+		kfree(kunit_dev);
 		return ERR_PTR(err);
 	}
 
-- 
2.44.0


