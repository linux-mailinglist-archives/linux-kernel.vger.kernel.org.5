Return-Path: <linux-kernel+bounces-55980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D484C478
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F320B26F23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7A1CD26;
	Wed,  7 Feb 2024 05:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm0zgVW9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803C1CD1E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284833; cv=none; b=DmMuy1k3axayM0Bu7WNEpGoD6oGVr4LW49DIm1y2PCaDDixh+r8a6HtpoVInuB1ytDzSV6rFEl2NGlsCqKBfMBlDH5+sv0DUfW9itHZfV1fPDQ2LuNfOqJvgVPR2EJLyf/mFCIpUR8yJIKl9H7Ot0skMibAzCil1fBTTjiWT7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284833; c=relaxed/simple;
	bh=mpSx7v17lWYWp3+GRrVAszqBH9MUhZzyCqu7z5sqqdQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Bu6PefJl5JyJDhXtQUZLjLBFm74ragAxeePrAbWm8sul94aDfe01DEFnT3sfeXnPhZY1cblyGetJnbnv1eAs2o9+CAipH9mXZVVPiFq8sGBzU+IbXLnNBTQohqrCtMOVwpgWL2n2Bv0/wg7G/QUoF+aecLfFY/e38vsOO27dxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm0zgVW9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OxN1jaJo+G98/fFpgDdkFoeRweqHUWYF3iMfC1LGZRw=;
	b=gm0zgVW9Q6vBq9+cd9V19VQOAmJdvY9bObTg4pMYD2/2rxeV3YGF+Q4ZjMuWjCMcXPFltW
	4z9T4mCuNvyuI+XU5Pev7jJx84SSvjACyEjHVCAt408LWfby/UY0YN9fSGtyhGnAsESPJd
	EiO8Qz5SAqFfLiPUUsGjcUiOO3elybI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-rTp5DMKoMEetzY_46rPvCA-1; Wed, 07 Feb 2024 00:47:08 -0500
X-MC-Unique: rTp5DMKoMEetzY_46rPvCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4431683B8EA;
	Wed,  7 Feb 2024 05:47:08 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73BFFC1596E;
	Wed,  7 Feb 2024 05:47:05 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 0/5] vduse: Add support for reconnection
Date: Wed,  7 Feb 2024 13:43:27 +0800
Message-ID: <20240207054701.616094-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Here is the reconnect support in vduse,

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

Cindy Lu (5):
  vduse: Add new ioctl VDUSE_DEV_GET_CONFIG
  vduse: Add new ioctl VDUSE_DEV_GET_STATUS
  vduse: Add function to get/free the pages for reconnection
  vduse: Add file operation for mmap
  Documentation: Add reconnect process for VDUSE

 Documentation/userspace-api/vduse.rst |  32 +++++++
 drivers/vdpa/vdpa_user/vduse_dev.c    | 125 ++++++++++++++++++++++++++
 include/uapi/linux/vduse.h            |   5 ++
 3 files changed, 162 insertions(+)

-- 
2.43.0


