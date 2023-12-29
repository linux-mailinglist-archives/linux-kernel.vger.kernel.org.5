Return-Path: <linux-kernel+bounces-13062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B081FF26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DC028242D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA511183;
	Fri, 29 Dec 2023 11:29:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE110A36
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.91])
	by sina.com (172.16.235.24) with ESMTP
	id 658EAD7D0000196D; Fri, 29 Dec 2023 19:29:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67760845089297
X-SMAIL-UIID: A047209F4E7143C795FCEBC335F6BB0A-20231229-192904-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
Date: Fri, 29 Dec 2023 19:28:51 +0800
Message-Id: <20231229112851.2000-1-hdanton@sina.com>
In-Reply-To: <000000000000f4faa2060d83f582@google.com>
References: <000000000000f4faa2060d83f582@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 12:51:18 -0800
> HEAD commit:    5254c0cbc92d Merge tag 'block-6.7-2023-12-22' of git://git..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d5fd6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -287,6 +287,7 @@ void drm_file_free(struct drm_file *file
 	if (dev->driver->postclose)
 		dev->driver->postclose(dev, file);
 
+	drm_prime_del_handles(&file->prime);
 	drm_prime_destroy_file_private(&file->prime);
 
 	WARN_ON(!list_empty(&file->event_list));
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -76,6 +76,7 @@ void drm_prime_init_file_private(struct
 void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
 void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				 uint32_t handle);
+void drm_prime_del_handles(struct drm_prime_file_private *prime_fpriv);
 
 /* drm_drv.c */
 struct drm_minor *drm_minor_acquire(unsigned int minor_id);
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -185,6 +185,27 @@ static int drm_prime_lookup_buf_handle(s
 	return -ENOENT;
 }
 
+void drm_prime_del_handles(struct drm_prime_file_private *prime_fpriv)
+{
+	struct drm_prime_member *member;
+	struct rb_node *rb;
+
+	mutex_lock(&prime_fpriv->lock);
+	for (;;) {
+		rb = rb_first(&prime_fpriv->dmabufs);
+		if (!rb)
+			break;
+		member = rb_entry(rb, struct drm_prime_member, handle_rb);
+
+		rb_erase(&member->handle_rb, &prime_fpriv->handles);
+		rb_erase(&member->dmabuf_rb, &prime_fpriv->dmabufs);
+
+		dma_buf_put(member->dma_buf);
+		kfree(member);
+	}
+	mutex_unlock(&prime_fpriv->lock);
+}
+
 void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				 uint32_t handle)
 {
--

