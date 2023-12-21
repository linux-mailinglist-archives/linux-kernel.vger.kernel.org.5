Return-Path: <linux-kernel+bounces-8057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4881B1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8031F24C26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FB4C609;
	Thu, 21 Dec 2023 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YocrqQag"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00854C3BF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2ead:0:640:1417:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTP id E8795608F8;
	Thu, 21 Dec 2023 12:03:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id V3KbXZTo50U0-LwUn3dXm;
	Thu, 21 Dec 2023 12:03:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1703149411; bh=kvyDArisowPEg0sMrU1swWXqZH47Ih9gEWW+BZaRFro=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=YocrqQagxP+LZ5CXxCo2s4V/XUhKdj/qF0ruGj8dZINEklS1snQpIKnkE3/herfOI
	 cdJQwyLhCBnsBEXdJQ2ErdJXC2NEWj8+WW0TjzXUEd4RU9+Trs3iUfCiDMrwODi774
	 KxAaBkKNyjfa72z3ZoVh8BohstluuBr3HCpXqyaE=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] watch_queue: fix kcalloc() arguments order
Date: Thu, 21 Dec 2023 12:01:21 +0300
Message-ID: <20231221090139.12579-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.0 20231220 (experimental)
and W=1, I've noticed the following warning:

kernel/watch_queue.c: In function 'watch_queue_set_size':
kernel/watch_queue.c:273:32: warning: 'kcalloc' sizes specified with 'sizeof'
in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
  273 |         pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
      |                                ^~~~~~

Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
calculate the final size, their actual order doesn't affect the
result and so this is not a bug. But it's still worth to fix it.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 778b4056700f..03b90d7d2175 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -270,7 +270,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 
 	ret = -ENOMEM;
-	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto error;
 
-- 
2.43.0


