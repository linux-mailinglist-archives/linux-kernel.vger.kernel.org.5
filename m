Return-Path: <linux-kernel+bounces-111447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42D886C83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF79B2153A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EAD4502B;
	Fri, 22 Mar 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avp8i9QA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801AE446A2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112492; cv=none; b=OLYyo7cHp6/CuNnuT379zeu+LqVXoY+BtnrH3RnVpFnhD4QeG5VA8ySG5G2vciRyMpkXWzv44PyqSnj0UImNBQ4hRqaTaef2ewkOTbxjWMmmzmghiwVYqPAvi201FNiQGXstB5j09qmYtVOYz4mTtUFBLEla6GdnFI2IzkCp2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112492; c=relaxed/simple;
	bh=VKXZ5EiyC/sMfhPFARs9d2EI9ZmYp2NxpRRc4tFM258=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbpmP8CBV/VwH9lH3ATlpfu/jgBB++Ov5kIB58fy+is4ztGbQduZQI/a+Zje4aDkgwphXw+iVldYlLvriNaTWHDlO+DbnPxYMbEtZ7DXrw3+fRQlMtj5u1uFVFBuRxzQVNDsH2N5VQ0riaDzgtbgK6qktsR9Bwpxt4E+koWsLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avp8i9QA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEC2C433F1;
	Fri, 22 Mar 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711112491;
	bh=VKXZ5EiyC/sMfhPFARs9d2EI9ZmYp2NxpRRc4tFM258=;
	h=From:To:Cc:Subject:Date:From;
	b=avp8i9QABqS0tbhC4OSISqngSX7j2TBZ8uRtR48PjHP3iKXIYwsEL8qwYARpKdGAl
	 aKiRYg8OMWoNmYE2vOokYymrMgxSmEXTuNZu6l0bv8piNRemsxwRRvYPcVjYaCwKUa
	 uPLqM8c8/OTq0KeeTkarN4NAHwNIroWaes9u+ZC/iyLgxQ4lXmNQZ866rFVj6N+BA9
	 ou8jc6irw8YnVsLTgubLbPw3fbCz1UOedbsUz1mfeddvCdsYfkPHsaIzkNYWjQ4v+5
	 PQxYkBsDCBf15QHswHC70hSx1SGd16nGrG5LisEpZ5hTujgxCUaAHvh97Wob0Hwu6m
	 IgPCdwMTpY8+g==
From: Arnd Bergmann <arnd@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Donald Robson <donald.robson@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] drm/imagination: avoid -Woverflow warning
Date: Fri, 22 Mar 2024 14:01:09 +0100
Message-Id: <20240322130124.902165-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The array size calculation in pvr_vm_mips_fini() appears to be incorrect based on
taking the size of the pointer rather than the size of the array, which manifests
as a warning about signed integer overflow:

In file included from include/linux/kernel.h:16,
                 from drivers/gpu/drm/imagination/pvr_rogue_fwif.h:10,
                 from drivers/gpu/drm/imagination/pvr_ccb.h:7,
                 from drivers/gpu/drm/imagination/pvr_device.h:7,
                 from drivers/gpu/drm/imagination/pvr_vm_mips.c:4:
drivers/gpu/drm/imagination/pvr_vm_mips.c: In function 'pvr_vm_mips_fini':
include/linux/array_size.h:11:25: error: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709551615' to '-1' [-Werror=overflow]
   11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      |                         ^
drivers/gpu/drm/imagination/pvr_vm_mips.c:106:24: note: in expansion of macro 'ARRAY_SIZE'
  106 |         for (page_nr = ARRAY_SIZE(mips_data->pt_pages) - 1; page_nr >= 0; page_nr--) {
      |                        ^~~~~~~~~~

Just use the number of array elements directly here, and in the corresponding
init function for consistency.

Fixes: 927f3e0253c1 ("drm/imagination: Implement MIPS firmware processor and MMU support")
Reviewed-by: Donald Robson <donald.robson@imgtec.com>
Link: https://lore.kernel.org/lkml/9df9e4f87727399928c068dbbf614c9895ae15f9.camel@imgtec.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this one last year when the warning appeared, it looks like it
got lost in the meantime, resending it unchanged.
---
 drivers/gpu/drm/imagination/pvr_vm_mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index b7fef3c797e6..4f99b4af871c 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -46,7 +46,7 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 	if (!mips_data)
 		return -ENOMEM;
 
-	for (page_nr = 0; page_nr < ARRAY_SIZE(mips_data->pt_pages); page_nr++) {
+	for (page_nr = 0; page_nr < PVR_MIPS_PT_PAGE_COUNT; page_nr++) {
 		mips_data->pt_pages[page_nr] = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!mips_data->pt_pages[page_nr]) {
 			err = -ENOMEM;
@@ -102,7 +102,7 @@ pvr_vm_mips_fini(struct pvr_device *pvr_dev)
 	int page_nr;
 
 	vunmap(mips_data->pt);
-	for (page_nr = ARRAY_SIZE(mips_data->pt_pages) - 1; page_nr >= 0; page_nr--) {
+	for (page_nr = PVR_MIPS_PT_PAGE_COUNT - 1; page_nr >= 0; page_nr--) {
 		dma_unmap_page(from_pvr_device(pvr_dev)->dev,
 			       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
 
-- 
2.39.2


