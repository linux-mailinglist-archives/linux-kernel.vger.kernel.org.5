Return-Path: <linux-kernel+bounces-94584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFF8741C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DDC1C23181
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31D71CA8D;
	Wed,  6 Mar 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWudwzvn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E81C6AE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759710; cv=none; b=kBaYIPlo+f5m1L6+kCXa7ydComIc5itZ0iU4cy+0PK7x+ZNudw/R07LKOeaMyrVgQ2nhCNZOXxaDnDvs36EmKvl6mPsTU/vGk17UH87RLuGB6bs7uDQg87jVhYzn26s5ZFhYuxvPfKETsR4lRRAZf6+CYFC+0ZBmFg2oQXVI22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759710; c=relaxed/simple;
	bh=dSVU1B/QJjt/W88x1rG/V9ZIu+ncfuekn31A2r07ngg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcQyRWPOWhB5bE2uqwUcd+IKidI9cLg6ILpIWGxzl4xYUfvId4KG9N5DW1KKqm/5k3bNyrBsP1iZ8VChv5h5d/67V1sXyQTati7hnzFbjUhEdL44ebZdJITVqjRaoum+J7R6/MDBsUPuPNdythyzgQ2jf8ADHWcoHR/h61CSSAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWudwzvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709759707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WttmPitBsNM9Jh4S0C3++DVJj+i9Oa9tOATpD8c/j38=;
	b=FWudwzvnIf5MlEYs2jAVkJo4RF5ROXUbji73r/cJE8Eyi+CXTbo9whuTwCUEg6q5loSHEQ
	pMApBXm0HvjRIlIw6n0CMAa8Zfn4OKOYWtq4UXGnDsiQ0Pdx1hyaJjukFRUOlFi+4It4OL
	OAxR+W5M5cquG2U8rVk4b5tlXw7TV6U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-1koqFQVMN8-9YuTF3SVR4w-1; Wed,
 06 Mar 2024 16:15:01 -0500
X-MC-Unique: 1koqFQVMN8-9YuTF3SVR4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436F228B6988;
	Wed,  6 Mar 2024 21:15:01 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.33.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5268637FD;
	Wed,  6 Mar 2024 21:15:00 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com,
	reinette.chatre@intel.com,
	linux-kernel@vger.kernel.org,
	kevin.tian@intel.com
Subject: [PATCH 5/7] vfio/platform: Disable virqfds on cleanup
Date: Wed,  6 Mar 2024 14:14:40 -0700
Message-ID: <20240306211445.1856768-6-alex.williamson@redhat.com>
In-Reply-To: <20240306211445.1856768-1-alex.williamson@redhat.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
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
Fixes: a7fa7c77cf15 ("vfio/platform: implement IRQ masking/unmasking via an eventfd")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/platform/vfio_platform_irq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 61a1bfb68ac7..a311d70c695b 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -321,8 +321,13 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
 	int i;
 
-	for (i = 0; i < vdev->num_irqs; i++)
+	for (i = 0; i < vdev->num_irqs; i++) {
+		int hwirq = vdev->get_irq(vdev, i);
+
+		vfio_virqfd_disable(&vdev->irqs[i].mask);
+		vfio_virqfd_disable(&vdev->irqs[i].unmask);
 		vfio_set_trigger(vdev, i, -1, NULL);
+	}
 
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
-- 
2.43.2


