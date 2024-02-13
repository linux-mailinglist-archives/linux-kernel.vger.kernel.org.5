Return-Path: <linux-kernel+bounces-63623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F1853263
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB6B2285A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB745677B;
	Tue, 13 Feb 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAKGPl9d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76F56763
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832473; cv=none; b=BFall4EOo9upCKbMs3nNeGj6wHdLYzbkc7BI5FenIi6OKkzCEvbAyv4MQtewRJqfVzWdWGMTCAbENMY2Q5kaV/3FEIs6nsoHhvL2ndcBZfJRxXZdsOLKI3KUKJ9nwk3oH5vN0YIODc2aK2VhzURwAhVsxb8RK81rgPTY3JpOql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832473; c=relaxed/simple;
	bh=CdzJ7tlgmV7vHQNreg/mcFgOnHtMI4tMFptux7nMTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heiaw91IyVk2IXt0VdcDXDbmYzAy8ijnt079DJUUdOqPUGBPeYK80mX7c/PpiIRfAe5gtihtEJcyaGrs7pKBFHk5BEg3tTEF5VXSabWDboA/dfuE8pU0cY12AXsALcbBI3swtcpM57uT2zMYKE2jfLBMHgNyoBBbQQ/s8iZHXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAKGPl9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707832470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXAJ3RuPet5I6Ig8N3etuSJO6+znX1aFjcW0irspUQU=;
	b=gAKGPl9dV0GZLZ+ZY/Xp8TczqWiAK1PrWDX2I+24WfF9lTtNxeS3z+mmSEVcXIGei8e9sc
	QntArOjnFSSY3v4ZTMYWU6m6uSuqe1VYFiNiE9bgWT9Ox+IoOHi/9hYO9ixJG1kHXkNdPj
	27SvPXoNk47/AR5ttvVWkzk5VZi4EUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-E2zSnLL3O3GkQqq8v4X6Qw-1; Tue, 13 Feb 2024 08:54:29 -0500
X-MC-Unique: E2zSnLL3O3GkQqq8v4X6Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 003F11064BFB;
	Tue, 13 Feb 2024 13:54:29 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.250])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97C46112132A;
	Tue, 13 Feb 2024 13:54:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	stable@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1] virtio: reenable config if freezing device failed
Date: Tue, 13 Feb 2024 14:54:25 +0100
Message-ID: <20240213135425.795001-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Currently, we don't reenable the config if freezing the device failed.

For example, virtio-mem currently doesn't support suspend+resume, and
trying to freeze the device will always fail. Afterwards, the device
will no longer respond to resize requests, because it won't get notified
about config changes.

Let's fix this by re-enabling the config if freezing fails.

Fixes: 22b7050a024d ("virtio: defer config changed notifications")
Cc: <stable@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..f513ee21b1c1 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -510,8 +510,10 @@ int virtio_device_freeze(struct virtio_device *dev)
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
-		if (ret)
+		if (ret) {
+			virtio_config_enable(dev);
 			return ret;
+		}
 	}
 
 	if (dev->config->destroy_avq)

base-commit: c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
-- 
2.43.0


