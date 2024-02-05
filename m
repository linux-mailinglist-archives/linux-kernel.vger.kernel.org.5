Return-Path: <linux-kernel+bounces-54107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A171284AADF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364881F25A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC64E1AD;
	Mon,  5 Feb 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggoA92vZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B54BAA4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177317; cv=none; b=C7mHll0O+dSPJ3Q7tEFQRxbMrGrxgE3X0g1YHhdn3DsyoHVrjJxeNQR+TuVkWPef6wzLvBXxorl8Wr4xFN0Y+CdaugiQNKn6lYPB/BOZPhq4zR7Y95chapzWXgg6ijsd8ygaDp3I2mac3WZXbBMyhf2YaGzgUeJlDsVzWkICINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177317; c=relaxed/simple;
	bh=RCeuGw+qfyPj0dL0x8G1g1gkNuFp52X9i7h9BI/DiIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDGk2LIPxRhNNlNjJrWustf/P/sUTltK+0nG8uQgKUc9EaxRyNF+tp3SHp48U7NVGp+LaB8dxh2FgTie72YUVWI6PuLdE/Su1xwQeNIGF2C4scjRouzMpjLUF8/oHVEaiC+l5q0xPHkPTz8yS129eNfk2HjskMVGeAjaIgdbgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggoA92vZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707177314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXKNaLAXkFX+4eJ/GmG7ArIMhHKrCdx1mSkfjlmP4rg=;
	b=ggoA92vZS5aWCZcsgHNJdBVurb6J6T3db22RoJNCBxA69p8HX7Fy65hZsGB5UIXiBfKepS
	IsRbauCL02GDgwxfU+xvd5I9d7KHD3saO+kNW+e05+hLXFvzwTT2z2g8Mbp05QTKE9Kdr8
	ycJXtWPIl2Nfb//z1b7bFzpicKl0Vmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-h3rYFVZ5Oze82KcKwYddpg-1; Mon, 05 Feb 2024 18:55:11 -0500
X-MC-Unique: h3rYFVZ5Oze82KcKwYddpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6DC83B82B;
	Mon,  5 Feb 2024 23:55:10 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.77])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8399D40C9444;
	Mon,  5 Feb 2024 23:55:10 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yishaih@nvidia.com
Subject: [PATCH] MAINTAINERS: Re-alphabetize VFIO
Date: Mon,  5 Feb 2024 16:54:18 -0700
Message-ID: <20240205235427.2103714-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

The vfio-pci virtio variant entry slipped in out of order.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

I'll plan to take this through the vfio tree.

 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..e0060359a043 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23076,13 +23076,6 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/pci/mlx5/
 
-VFIO VIRTIO PCI DRIVER
-M:	Yishai Hadas <yishaih@nvidia.com>
-L:	kvm@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/vfio/pci/virtio
-
 VFIO PCI DEVICE SPECIFIC DRIVERS
 R:	Jason Gunthorpe <jgg@nvidia.com>
 R:	Yishai Hadas <yishaih@nvidia.com>
@@ -23106,6 +23099,13 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 F:	drivers/vfio/platform/
 
+VFIO VIRTIO PCI DRIVER
+M:	Yishai Hadas <yishaih@nvidia.com>
+L:	kvm@vger.kernel.org
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/vfio/pci/virtio
+
 VGA_SWITCHEROO
 R:	Lukas Wunner <lukas@wunner.de>
 S:	Maintained
-- 
2.43.0


