Return-Path: <linux-kernel+bounces-13305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC441820345
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B62B22183
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004F257F;
	Sat, 30 Dec 2023 01:59:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7E1364
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.29])
	by sina.com (172.16.235.25) with ESMTP
	id 658F79850000462F; Sat, 30 Dec 2023 09:59:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67179434210268
X-SMAIL-UIID: 316C6D83C875421987D6DE49A85B6001-20231230-095935-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
Date: Sat, 30 Dec 2023 09:59:23 +0800
Message-Id: <20231230015923.2190-1-hdanton@sina.com>
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
@@ -106,6 +106,8 @@ static int drm_prime_add_buf_handle(stru
 	get_dma_buf(dma_buf);
 	member->dma_buf = dma_buf;
 	member->handle = handle;
+	RB_CLEAR_NODE(&member->dmabuf_rb);
+	RB_CLEAR_NODE(&member->handle_rb);
 
 	rb = NULL;
 	p = &prime_fpriv->dmabufs.rb_node;
@@ -185,6 +187,27 @@ static int drm_prime_lookup_buf_handle(s
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
+		member = rb_entry(rb, struct drm_prime_member, dmabuf_rb);
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

