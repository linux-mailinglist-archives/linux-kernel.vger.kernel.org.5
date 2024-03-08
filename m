Return-Path: <linux-kernel+bounces-97682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0E876DC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023D81F2153C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506E4DA06;
	Fri,  8 Mar 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDwwbYJl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8494CDEC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939179; cv=none; b=F0cXyD0mrHfMYNt25mRLDK+rlaWb0PhO143sBcZMA+bWwFYXnC/ZYYcdptyXvPHim76a1elQh7Z8+Y2dDj4+UtcSMsVJfFvqdO8f4duWGoB8hR24N/PprXklbJn1a63H9wLUx1fuJ6YvOMjm2WYmz0xlkWUgLMAC9TFaOB4pig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939179; c=relaxed/simple;
	bh=xe/gkZ/Xvg/uXlto0Dtj8eqOvEjluTFaDYjfd6lHxrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owjgkSdM4W3VZegVvT9S4Af7lT50pJsfYgK8ORMu+A6fyewBbW5yi6zT1qJ8Zuys1tUwCUhdj2eMQ9tytsgLuWprMNVjXE6Vl+clgGHUcDhqq29VbE01N4ey56S2TrfHFRujjzx3a1J30+1cYw8pRRzGzbIoaDfVW7qKurOn7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDwwbYJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709939175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dEKfErNXa51Ijqh6RZq2oy2pBONTNUJTZpcaMjJ9JU=;
	b=LDwwbYJl23kPdgPzkwQZx80azGl4pzvjIk2jKMPCxmKsE819Dp85PAbY0YJvbJn9BzyU4d
	jFU/qVLjJtQHOq7YxwHeMCgDHhpIGDQmLn4Hz/nSBp5sUk2xhbtZTP1ARIe9zIknDHCZSu
	ANsj9taBiDPEO5CK3ec/vcuI7OPDckI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-AtEUu7PaO76Jg_z-aNWO4g-1; Fri,
 08 Mar 2024 18:06:12 -0500
X-MC-Unique: AtEUu7PaO76Jg_z-aNWO4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A37EB3801F50;
	Fri,  8 Mar 2024 23:06:11 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B69F47CB;
	Fri,  8 Mar 2024 23:06:10 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com,
	reinette.chatre@intel.com,
	linux-kernel@vger.kernel.org,
	kevin.tian@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 5/7] vfio/platform: Disable virqfds on cleanup
Date: Fri,  8 Mar 2024 16:05:26 -0700
Message-ID: <20240308230557.805580-6-alex.williamson@redhat.com>
In-Reply-To: <20240308230557.805580-1-alex.williamson@redhat.com>
References: <20240308230557.805580-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

irqfds for mask and unmask that are not specifically disabled by the
user are leaked.  Remove any irqfds during cleanup

Cc: Eric Auger <eric.auger@redhat.com>
Cc: stable@vger.kernel.org
Fixes: a7fa7c77cf15 ("vfio/platform: implement IRQ masking/unmasking via an eventfd")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/platform/vfio_platform_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 61a1bfb68ac7..e5dcada9e86c 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -321,8 +321,11 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
 	int i;
 
-	for (i = 0; i < vdev->num_irqs; i++)
+	for (i = 0; i < vdev->num_irqs; i++) {
+		vfio_virqfd_disable(&vdev->irqs[i].mask);
+		vfio_virqfd_disable(&vdev->irqs[i].unmask);
 		vfio_set_trigger(vdev, i, -1, NULL);
+	}
 
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
-- 
2.44.0


