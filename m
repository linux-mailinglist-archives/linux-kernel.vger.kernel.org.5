Return-Path: <linux-kernel+bounces-16860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA96824517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED041F2673C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D222420B;
	Thu,  4 Jan 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG5ZOQW1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CFF241E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704382680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9/vnf7ini+dqsZp2EUqBmVye1hh0Tl8Sv9ZPYE+NvYA=;
	b=iG5ZOQW13c3H5c2TciOyYklYLt0byXPfjf3cQp7hUSviHsIeQ3JIfpidvO1el8iQPr4yNt
	A77EucGmZe0kXShJ1aPifPbUKSAWA+hibXzCHkbRMynaQqotlKcaZ6/5lkQJuc5w5qXd46
	8Ijbe0EBY2IsPvph/r8m+kVvx2RmgLo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Mf5m6bnRMtSU1UawQ0qGpA-1; Thu,
 04 Jan 2024 10:37:58 -0500
X-MC-Unique: Mf5m6bnRMtSU1UawQ0qGpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DE7028EC10F;
	Thu,  4 Jan 2024 15:37:58 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 335CFC15968;
	Thu,  4 Jan 2024 15:37:56 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v6 0/3] vduse: add support for networking devices
Date: Thu,  4 Jan 2024 16:37:50 +0100
Message-ID: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

In this v5, LSM hooks introduced in previous revision are
unified into a single hook that covers below operations:
- VDUSE_CREATE_DEV ioctl on VDUSE control file,
- VDUSE_DESTROY_DEV ioctl on VDUSE control file,
- open() on VDUSE device file.

In combination with the operations permission, a device type
permission has to be associated:
- block: Virtio block device type,
- net: Virtio networking device type.

changes in v6!
==============
- Remove SELinux support from the series, will be handled
  in a dedicated one.
- Require CAP_NET_ADMIN for Net devices creation (Jason).
- Fail init if control queue features are requested for
  Net device type (Jason).
- Rebased on latest master.

Changes in v5:
==============
- Move control queue disablement patch before Net
  devices enablement (Jason).
- Unify operations LSM hooks into a single hook.
- Rebase on latest master.

Maxime Coquelin (3):
  vduse: validate block features only with block devices
  vduse: Temporarily fail if control queue features requested
  vduse: enable Virtio-net device type

 drivers/vdpa/vdpa_user/vduse_dev.c | 32 ++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.43.0


