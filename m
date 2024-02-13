Return-Path: <linux-kernel+bounces-64077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797A8539DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FE1C21F29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774AB60DD7;
	Tue, 13 Feb 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PROIWODE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AD60DCE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848697; cv=none; b=G1BdnUQSAM8OK3fOx+S/eWnsBlQ4WHGpZdXQ9yZLCPURyNgw4uazkc5lg/G/PNUz+Gg6O9X3P5GlDZbyQaUi09CJX6LQ4jb39Kcj//8wYqz3g0OWtJHqrVvpbBX+mm/nYnSoPLH3ZE4JADgvKqkKTJEyMsHFsMCnMFU2bNWIbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848697; c=relaxed/simple;
	bh=xNe4rvigIDdiz86ntX0XKJVb3S5877ZvE6xU/3SDiXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MTD3uU53G5ynHhe/j76FTMuyiEauoDn/L/bdQ440jta4iM7lQcVVOMAKjCAXCrNuYovT8tQWrhf0xQFBDtE0PFu4WcKzSwHdk0BVGogsnsHr6PPt8a5nQFguujsiMBbYn87XmXsw6odL2aZQuJu+VxCMc7OAsiLjA2R9ib9TCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PROIWODE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707848695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bMTfbhuWj6UnNZL3Is+fIHua86/r90O7KAifCJJu4B8=;
	b=PROIWODEqhrDzqr/drc7U+wPTLs8TxMV4nYhU5GAX2doX0eMHDtlNgMyIkEAwFRAZb+Hkp
	G+qQKJ9JzZfEAHI2laWOUyVdE+AKaNMaWsf8crtHsgrJ+6ZAd/v/0NLYW9CEM1s7xPfXX9
	T2OhqFnVJONdmfRV/vCYEe1Jyuriq9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-RgK2ALvQP8eOJjMuLxstDA-1; Tue, 13 Feb 2024 13:24:53 -0500
X-MC-Unique: RgK2ALvQP8eOJjMuLxstDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CE89106D0C2;
	Tue, 13 Feb 2024 18:24:53 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.199])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDDE2166B31;
	Tue, 13 Feb 2024 18:24:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Jason Wang <jasowang@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	virtualization <virtualization@lists.linux-foundation.org>
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20add=20Eugenio=20P=C3=A9rez=20as?= =?UTF-8?q?=20reviewer?=
Date: Tue, 13 Feb 2024 19:24:50 +0100
Message-ID: <20240213182450.106796-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add myself as a reviewer of some VirtIO areas I'm interested.

Until this point I've been scanning manually the list looking for
series that touches this area.  Adding myself to make this task easier.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61117c3afa80..d0789ecc4f70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23219,6 +23219,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/block/virtio_blk.c
@@ -23237,6 +23238,7 @@ VIRTIO CORE AND NET DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
@@ -23277,6 +23279,7 @@ VIRTIO FILE SYSTEM
 M:	Vivek Goyal <vgoyal@redhat.com>
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Miklos Szeredi <miklos@szeredi.hu>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
@@ -23310,6 +23313,7 @@ F:	include/uapi/linux/virtio_gpu.h
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
-- 
2.43.0


