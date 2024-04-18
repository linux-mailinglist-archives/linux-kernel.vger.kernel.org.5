Return-Path: <linux-kernel+bounces-150444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C28A9F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B3B1C23591
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853F16F90F;
	Thu, 18 Apr 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2qcoKqb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64216FF3E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456059; cv=none; b=QuOeUNPbI8Of5PIHpraM3vwOpzyelA6Ye5fyRWagOHyzUIy0lmSZmNZHvm6ps7WgM6/vRjTaelYqyjGwzyC9A2ONbUuSGyBFcYfApoZ9tzzIAnJYKqwLl0PykL/OCsnpit52DacxJeIXnDMJojep7bjUfHA1JU1Z7ui9Jri3K1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456059; c=relaxed/simple;
	bh=zmdkTFihWpy+XhiLb7Ai9Fv3Kxr9kNr6UrAO97Mor0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQcxTOB30Blqe/jcZsJLLU5YqIyDgMy4p9RDYeFdasPYd1sWtCYbkhFFVN1IOW9d5HxPvIJUPOQzY/BHsPTjBfcvBXc/W7+iSyyJoFdDpOTZSsk1rn4Z2VppmN1OJhIVsdyCDwilygGFs2Xfv1ZbW6xvak76pmwW6cnZJRKDpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2qcoKqb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713456057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKFWmD89ZfxI3WrGZY3k5MGYxU+9FObI37ylz+l21us=;
	b=J2qcoKqbnfxy9dCuHYNMWSZOMrkDzjYL3vn1zo6tgkrpPu+H1tplc+KIeg0Z7WxNcaBoAM
	fax83QJpUFcEK7Xdf3iG2PDbp3v2IIiml1vdQMJUsX/WmIJLEUZjNib1TriIvuRhzD+oYc
	5TJyJWkK2g5w6UgGEJxLwztbvViGDd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-b6Jn_hWvPCKELTvVladVDA-1; Thu,
 18 Apr 2024 12:00:52 -0400
X-MC-Unique: b6Jn_hWvPCKELTvVladVDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F244E381645B;
	Thu, 18 Apr 2024 16:00:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B98740357A7;
	Thu, 18 Apr 2024 16:00:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2 2/2] kunit: avoid memory leak on device register error
Date: Thu, 18 Apr 2024 13:00:38 -0300
Message-ID: <20240418160039.69993-3-wander@redhat.com>
In-Reply-To: <20240418160039.69993-1-wander@redhat.com>
References: <20240418160039.69993-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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


