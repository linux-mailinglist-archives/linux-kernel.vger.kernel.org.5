Return-Path: <linux-kernel+bounces-83558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C15869B66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0932836DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DBD14691C;
	Tue, 27 Feb 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVh+2k5u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C71386C0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049488; cv=none; b=jXNEHEGvZLHGnR+q0wnySIkMJLT1Oo/7IyxwxiBz0LvYuv4d9EjR7VYkkiC+rn5IbBgvnt7GlBGCMvY6gCmX06vbC/7QNgtK55kLaFg2eBWsKAfRSvKUS+o1EsKYa+boNffWamuwoT2yZElBrrLSbhJQ2eG1dj5fKjD/kB5jqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049488; c=relaxed/simple;
	bh=m8atfW3nBIl+dzhdJpoKOIZ/gL0HTKVc5kaXGpcmAJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUwtwiL8i/JKE/YVSjful1KIC754LL2r2EMBHlVSOHeEa4GzoBQi74f+hAAz4RP09ix59l1/AEh4VCikIM3waxvLQBqZcl0LIaV00M0ZClZ55R75ESrQW3U7cd4PPBycLvFegnbwHs+qEmuFIpi0rh7KFU9cv0JK+WNyeSKbtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVh+2k5u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709049485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fY+0b8Vv6KvNYU3uBxf+nKDNmKoZcXRJbPi/Ff45+Qo=;
	b=DVh+2k5uzM4CZfki3EFxGk7ihtYhQdg9JJWDKBrLr+CB/LWYDsjdNLv0LdvmlO59+tWuC2
	/1MZfF3mBUVobWCv60GK1puod06jqkMl23HtskRF5rsnxgl/K5RQ2L1A3UYb3Gj8zOXIIc
	tH34VC8Ns27C0zvGx9kANUThUWPFw5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-mf7YYoOkNZqLArlp8yPSFA-1; Tue, 27 Feb 2024 10:57:59 -0500
X-MC-Unique: mf7YYoOkNZqLArlp8yPSFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADC7585A589;
	Tue, 27 Feb 2024 15:57:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D3C81C060B1;
	Tue, 27 Feb 2024 15:57:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] virtiofs: drop __exit from virtio_fs_sysfs_exit()
Date: Tue, 27 Feb 2024 10:57:56 -0500
Message-ID: <20240227155756.420944-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

virtio_fs_sysfs_exit() is called by:
- static int __init virtio_fs_init(void)
- static void __exit virtio_fs_exit(void)

Remove __exit from virtio_fs_sysfs_exit() since virtio_fs_init() is not
an __exit function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402270649.GYjNX0yw-lkp@intel.com/
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 62a44603740c..948b49c2460d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1588,7 +1588,7 @@ static int __init virtio_fs_sysfs_init(void)
 	return 0;
 }
 
-static void __exit virtio_fs_sysfs_exit(void)
+static void virtio_fs_sysfs_exit(void)
 {
 	kset_unregister(virtio_fs_kset);
 	virtio_fs_kset = NULL;
-- 
2.43.2


