Return-Path: <linux-kernel+bounces-97676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D90876DB2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F4D1F226F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062583BBDF;
	Fri,  8 Mar 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsfhb2Ar"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAE208CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939172; cv=none; b=qqBpOUHNg+wkxx2q2I6JWrhIu3y9Wb52h/BzbfD/NLnF2ASOeJjYF82Z0+Bk/8sCY0vePm64+MOSNowWdmlW/pHaTRZYRpzV8rh1Rq7bxaXQEaYKnJtVfNaxP41mJmBWcBt2BDUcKrf1rPhHPjzk8gi1f9vGmTkZhDDOF7wT0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939172; c=relaxed/simple;
	bh=UgNCsPYDfPK8fXAwp9yH+lGepvO4l0WGBsuozUu4gBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJoTs4uiC1JmODynvVQb6ZzVvW+l0Ik81FFJ7x/1JVeoGpGAN1A1vzptvClMP3rge3/VlScygZG5unQ/TPhFyptkkiQuzYq8TnrjQPJXpKos5t9v7pbfNVgSzZTDMc23/w+2urEVgbUvNeo+JSSmzsUY3YVJdEbjL+tvLCh9kuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tsfhb2Ar; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709939169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDezgE//GekdRKrLiXezeVzaF0hQXhS702rH5dPLxcA=;
	b=Tsfhb2Ar/r8j9b5GQklJ30iyZo9dGWnKCzNNYET59KQH5v38C5I8anYVyHiQOec3K4EzQV
	HnplodpRAWFsvdrKwu03rxOLKSZ0IgHTVzQh66/602jjHN/R6K8eOY0pirbDRJd9IeHpr5
	eKt6MPnUAnD0f5qzt4cf87ySxdTgItY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-K1ZwyV4BPAqFCNLoksqkXQ-1; Fri, 08 Mar 2024 18:06:05 -0500
X-MC-Unique: K1ZwyV4BPAqFCNLoksqkXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E41C5800264;
	Fri,  8 Mar 2024 23:06:04 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.8.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5AA137F6;
	Fri,  8 Mar 2024 23:06:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com,
	reinette.chatre@intel.com,
	linux-kernel@vger.kernel.org,
	kevin.tian@intel.com
Subject: [PATCH v2 0/7] vfio: Interrupt eventfd hardening
Date: Fri,  8 Mar 2024 16:05:21 -0700
Message-ID: <20240308230557.805580-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

This series hardens interrupt code relative to eventfd registration
across several vfio bus drivers, ensuring that NULL eventfds cannot
be triggered by users.  Several other more minor issues were discovered
and fixed along the way.

Thanks to Reinette for identifying this latent vulnerability.  Thanks,

Alex

v2:
 * Add R-b from Kevin & Reinette (thanks!)
 * Remove unused hwirqs in 5/ and avoid unnecessary hwirq lookup in
   cleanup and init unwind in 6/

Alex Williamson (7):
  vfio/pci: Disable auto-enable of exclusive INTx IRQ
  vfio/pci: Lock external INTx masking ops
  vfio: Introduce interface to flush virqfd inject workqueue
  vfio/pci: Create persistent INTx handler
  vfio/platform: Disable virqfds on cleanup
  vfio/platform: Create persistent IRQ handlers
  vfio/fsl-mc: Block calling interrupt handler without trigger

 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |   7 +-
 drivers/vfio/pci/vfio_pci_intrs.c         | 176 +++++++++++++---------
 drivers/vfio/platform/vfio_platform_irq.c | 105 +++++++++----
 drivers/vfio/virqfd.c                     |  21 +++
 include/linux/vfio.h                      |   2 +
 5 files changed, 205 insertions(+), 106 deletions(-)

-- 
2.44.0


