Return-Path: <linux-kernel+bounces-55985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0184C47D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B92F1F22D66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE2200DB;
	Wed,  7 Feb 2024 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flQ3DrS5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF96200A8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284872; cv=none; b=ohQPa59raDocByFa2rZTX2m/VEeqD7ArJvfhBbumoUCf2Hx3GKEp5tP/B2DwYfj/MKuoCdwXRQY0nHbHhAfu8iTwdCVwj4NW2/+Hia9ouwENe8a0PY9wHw6uzQmr7X5P9eCxYoEvD/UTJD4VvTEpsCQqxHEVx0s6SI+sov8BkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284872; c=relaxed/simple;
	bh=6uX9zfQ8cQJ8WnngTxHu/ne5naJ+QAafInm6eyaxJy0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs2sFLY1F5GkGSBNB32ScPaSvYjbQbPbO8oQz12+4vcN1A1LWlSCUziI+xXqBe71MNkrLNrbWMEJa27OOippbBIFNSAgT698BVir7cLz1kPjz8mUhexEfxMGbrAZ7lyRN9eb4LdPWiWtATryFlUJO2HMj4i9OOjVcoGYwop5e5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flQ3DrS5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxvyLlwFPrOAb4E1s475cmzm9HXLhSgjIXU0tbGtRvE=;
	b=flQ3DrS54ZCp8VW/C5iohqfH+ufwKd3U+3uuU+lpCH3CxRRSrcDQQC/qjhwbXI5bj/GdIr
	d9uhc7xY2vHc5IcpdKdvdv4wzOI3qVG9hEO5VnJXHMDW/vxuW/+kCSicf6Bokrj1fyC4d4
	Nl85h+naRLbd26T5kXR8AuGK4YXKO6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-f3trEO6NNI-I9I6uYGLkcQ-1; Wed,
 07 Feb 2024 00:47:45 -0500
X-MC-Unique: f3trEO6NNI-I9I6uYGLkcQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76D903811F41;
	Wed,  7 Feb 2024 05:47:45 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECCD7492BC6;
	Wed,  7 Feb 2024 05:47:42 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 5/5] Documentation: Add reconnect process for VDUSE
Date: Wed,  7 Feb 2024 13:43:32 +0800
Message-ID: <20240207054701.616094-6-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-1-lulu@redhat.com>
References: <20240207054701.616094-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Add a document explaining the reconnect process, including what the
Userspace App needs to do and how it works with the kernel.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 Documentation/userspace-api/vduse.rst | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
index bdb880e01132..a2be85e0e516 100644
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -231,3 +231,35 @@ able to start the dataplane processing as follows:
    after the used ring is filled.
 
 For more details on the uAPI, please see include/uapi/linux/vduse.h.
+
+HOW VDUSE devices reconnectoin works
+----------------
+0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
+   If it does not exist, need to create the instance.goto step 1
+   If it does exist, it means this is a reconnect and goto step 3.
+
+1. Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
+   /dev/vduse/control.
+
+2. When the ioctl(VDUSE_CREATE_DEV) function is called, the kernel allocates memory
+   to save the reconnect information.
+
+3. Userspace App need to mmap the pages to userspace
+   Userspace App need to map Pages 0 to vq_number for vq status,
+   Users can define the structure for saving the reconnect information themselves
+   in the userspace.
+
+4. Check if the infomatin sutiable for reconnect
+   If this is reconnect:
+   Before attempting to reconnect, The userspace application need to the
+   ioctl VDUSE_DEV_GET_CONFIG,VDUSE_DEV_GET_STATUS,VDUSE_DEV_GET_FEATURES...
+   to get the and confirm if these information are suitable for reconnecting.
+
+5. Start the userspace App.
+   While running, the application should store the relevant information about
+   reconnections in mapped pages.
+   When calling ioctl VDUSE_VQ_GET_INFO from the userspace APP to get vq information, it is necessary
+   to check if this is a reconnection. If a reconnection has occurred, the vq-related information
+   must be get from the mapped pages.
+
+6. When the Userspace App exits, it is necessary to unmap all the reconnect pages.
-- 
2.43.0


