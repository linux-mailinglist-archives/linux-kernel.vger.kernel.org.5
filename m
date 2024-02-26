Return-Path: <linux-kernel+bounces-81241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1F867278
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7571C29249
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA7208A0;
	Mon, 26 Feb 2024 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9yTQ6Li"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304B1F944
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945238; cv=none; b=gt6qcSozlC80cMISfhJ0yvH0PnU7/z2HsRErmrfZNzqwSdHswmkJXgJIWO2S6X6ladC9GSvJ8YvEFcBNiFJJZRIZcvRpotPdgoPQEM3oNlUqMQtLruPQ6sXPSeIG6oKveBcyOX2GlQvUJ91glnYspp8ZBUJ4twtwwifMUyom2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945238; c=relaxed/simple;
	bh=wWFyVjozQYpVCP8urk9INuN6JqujyjBxdhhCCLloSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gh7yzwIcjPgIpx/gpX9PLS6krtQj9YnE1bSKPCB3nhuRfQgrmJblcYl/e6PoFdAU8JQ7Ju9Nmu/wD5D6thUwXtBRoKK4+0OXsMqXEaH2QXWi2B96NJ76aChVSnYE/KED3xECCBZjShSqe2q7f5u+fyz3Nn3SAURUCu05yxhz1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9yTQ6Li; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708945235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7fb8qhMyQWkNKGZ69wxb0HTmiSSDFyd3jGrND6S725A=;
	b=F9yTQ6LiaRUbUPAzADx1sBUsP0/4JJB2Ojt6ocb1khE1ACfJoLIx+Ctopd+m0A2xaFZzvJ
	qWruXdHybeZ9/zIgDpWQ92nGygqLFUQf+E3w108YoiHmTjxc2CPL9I8vAl5aGVlFFRHRai
	7JcQAb3DF1PN/E4MjLqxANxx9xjIrgo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-UR8lwD_8ON-JexU-ni44wQ-1; Mon, 26 Feb 2024 06:00:34 -0500
X-MC-Unique: UR8lwD_8ON-JexU-ni44wQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412977dd5a1so7303555e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945233; x=1709550033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fb8qhMyQWkNKGZ69wxb0HTmiSSDFyd3jGrND6S725A=;
        b=mQKXhQiFJ6HPT2ygT2BFOEP/7vtnBdAwwwCjM8NRRyYHMCKYgORLVAWxs8xPW0CoNS
         1/+j0TBQyJpYnWuEZQEJu2H9dUfmKMnwp2Npb6tUWFULo38ZY5FIQHn3MjpD4VIfd7eo
         QXVrOoNQJ+Jj/oJJiB5Vq8a9pMwYQtZftK9hZqYHxaQOnwe30d8NArUKhLg4aPxxeTKH
         AjJJ0MFVzUgpWpJh9nRQ8ZNM4BXHcUJ56xeebkwrOAbd2NNiY8RI8nKq6XenyfRFf3ub
         moQ1trmLFlVtKbzKmkv4paRQxLZnIMFS4v4VOP49PpDOqmRR+YwQs93qS5vCcDmyNzH/
         EhMg==
X-Forwarded-Encrypted: i=1; AJvYcCW4xD3VdCgtCh7AnZFPpKg/p9gGlE+VEbZzvD+NhUZkbt1mTQq7Q4vAYob59qKcjmr0iTBd9eyq8XaF7VE8KC8pMmrsPgfChcYUzXoV
X-Gm-Message-State: AOJu0Yx4gc/hABPIppW1rahsCx2l9Q4nzXi3J1hYVjA+URAU9UtvgERY
	oY6tbJrHWDZy/u9iiVq1pZ1ComOhIjwLqj65AoxGJg8oiI8NKkSXZNBq/8As4n5ih7ZgidvETtI
	35JTaHFGjviy8TCTGHaM4Gz0Up0muYggSCwcgtyykJ1juTZ8RIkEmgVZn73pb
X-Received: by 2002:a05:600c:34c7:b0:412:989a:f6f5 with SMTP id d7-20020a05600c34c700b00412989af6f5mr4897726wmq.38.1708945233173;
        Mon, 26 Feb 2024 03:00:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsaJaZApkXnvNVxhpqzjSveNDzIfwy1pLjTKBTKYns49hQffucMV+7Jcfbr8ymuqx+Tc/ISQ==
X-Received: by 2002:a05:600c:34c7:b0:412:989a:f6f5 with SMTP id d7-20020a05600c34c700b00412989af6f5mr4897708wmq.38.1708945232843;
        Mon, 26 Feb 2024 03:00:32 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id jt2-20020a05600c568200b0041290cd9483sm11620043wmb.28.2024.02.26.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:00:32 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Marco Pagani <marpagan@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/test/shmem: set a DMA mask for the mock device
Date: Mon, 26 Feb 2024 12:00:27 +0100
Message-ID: <20240226110028.28009-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set a DMA mask for the mock device to avoid warnings generated in
dma_map_sgtable().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 91202e40cde9..d691b29a4312 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -341,11 +341,15 @@ static int drm_gem_shmem_test_init(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm_dev;
+	int ret;
 
 	/* Allocate a parent device */
 	dev = drm_kunit_helper_alloc_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
 	/*
 	 * The DRM core will automatically initialize the GEM core and create
 	 * a DRM Memory Manager object which provides an address space pool
-- 
2.43.2


