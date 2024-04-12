Return-Path: <linux-kernel+bounces-142728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7328A2F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E60B22B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18778824B3;
	Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kb1oBwk0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2A5644E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928653; cv=none; b=upupkn8Xii5Z1enlYnnloFlv9YVc0cV1RJXdwxV1u0+VgtKAMBpVqEWF3L5EXWlegosmc9cJWbP4ZMyly2u/EtgHgcl5fAn7U9lfbIiW3chFev0mp+mPJ+XP6G93H0O//OKicFLLd39b4z1EOF34rHZDJmINpGm3LFBpXv1arrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928653; c=relaxed/simple;
	bh=dos5mFR7OGlo/0+OT1mBqy46jgg02Ze4GK+u8PA+3W4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ux4qfw/EV+YpftajZLOgRmsl76RyiqMIwXBp7Tq8lwE+rqVITJ34R6Gfdw4uxFhKtWKxcLimJts+QZsBA8YfEzeczzvc2hEJap0FQCDfco16HjFEG1Etbdl37TYsVXUViC/g9lUY9377tA4fhqzDLjI/hNdWBzg+rbqezJCshg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kb1oBwk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vN5LU15jD5iu/2/mvrypQik1qqqlfRZO/11n/IoWnz0=;
	b=Kb1oBwk0qu7CJFZiBeFAPVn+qwMMBc2bbQ7T7A85wSiAzIMocKDWVejNEwG2jkNKYE0ZZE
	p22a7OjvF6GyAvh8RFd0eaLmwdrVP0UIL0jW45kll3aVfVyyADUNPNBHB73tEbeLd8Pt26
	dpN3ccd1UBtp7ne6JN0lG+1zOa0jY8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-mnuFJhWMNgacB_b7a-sh5Q-1; Fri, 12 Apr 2024 09:30:48 -0400
X-MC-Unique: mnuFJhWMNgacB_b7a-sh5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A42FF104D503;
	Fri, 12 Apr 2024 13:30:48 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A74F40C6DAE;
	Fri, 12 Apr 2024 13:30:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 0/5] vduse: Add support for reconnection
Date: Fri, 12 Apr 2024 21:28:20 +0800
Message-ID: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Here is the reconnect support in vduse

Kernel will allocate pages for reconnection.
Userspace needs to use mmap to map the memory to userspace and use these pages to
save the reconnect information.

test passd in vduse+dpdk-testpmd

change in V2
1. Address the comments from v1
2. Add the document for reconnect process

change in V3
1. Move the vdpa_vq_state to the uAPI.  vduse will use this to synchronize the vq info between the kernel and userspace app.
2. Add a new ioctl VDUSE_DEV_GET_CONFIG. userspace app use this to get config space
3. Rewrite the commit message.
4. Only save the address for the page address and remove the index.
5. remove the ioctl VDUSE_GET_RECONNECT_INFO, userspace app will use uAPI VDUSE_RECONNCT_MMAP_SIZE to mmap
6. Rewrite the document for the reconnect process to make it clearer.

change in v4
1. Change the number of map pages to VQ numbers. UserSpace APP can define and maintain the structure for saving reconnection information in userspace. The kernel will not maintain this information.
2. Rewrite the document for the reconnect process to make it clearer.
3. add the new ioctl for VDUSE_DEV_GET_CONFIG/VDUSE_DEV_GET_STATUS

change in V5
1. update the Documentation for vduse reconnection 
2. merge the patch from Dan Carpenter <dan.carpenter@linaro.org> vduse: Fix off by one in vduse_dev_mmap()
3. fix the wrong comment in the code 

Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (5):
  vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
  vduse: Add new ioctl VDUSE_DEV_GET_STATUS
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  Documentation: Add reconnect process for VDUSE

 Documentation/userspace-api/vduse.rst |  41 +++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
 include/uapi/linux/vduse.h            |   5 ++
 3 files changed, 171 insertions(+)

-- 
2.43.0


