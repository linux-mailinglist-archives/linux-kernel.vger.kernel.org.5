Return-Path: <linux-kernel+bounces-49818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44C846FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B331F299D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B9140760;
	Fri,  2 Feb 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Lxb87qz2"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41914199F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876021; cv=none; b=FKhUbuw5r+AvOCIxin7PD3Z+pXo64dGusul+c5mBxh5lSMSrJVyVuR7FND6L8OynUcuBO9zx2zimqsExW0jrTzXACzKhFUqMtxzjC1SmLir43+u6aIh5wYPDJ7J4x97spfXt+e+NMfJNmUr/NB0GKQLpw5GNDFds4hM1+/cH8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876021; c=relaxed/simple;
	bh=/MYz96hTgmyfUKN8lIz6Wn2kXH/W5xiuldsDugYBDUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gO9rb3nXrQhYs+WrLACGRHyOwMuffPkvV6DQyXN9Z56hmFqGuA3W1/8nvJqWjlGYJK6DE3lkGXRi9io9DFscKQaPI8DeC78y14d0GkMmFlfU10xRfOqSCOvNpGev9lZPpx5BzS7kiVelPxLZO/vFFTfKLcbdaeuYSIPoAryDnbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Lxb87qz2; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.19])
	by mail.ispras.ru (Postfix) with ESMTPSA id 96CEF40F1DFF;
	Fri,  2 Feb 2024 12:13:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 96CEF40F1DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1706876014;
	bh=eA0x4JCi+JyPKsZLcRH52SdlMvZD8FLMA9pRbfG8Ano=;
	h=From:To:Cc:Subject:Date:From;
	b=Lxb87qz2ETojmszILfllYWsjKulf2HoQQ2pH6pW1jgMjUGenElWZsVzl45cgVNr0A
	 sKxOtGaCxs/8+lsr8G8Fwr5zE+9VuX8VECkEA73KVIdeY8bzX/DR467QNniwXGxZpO
	 /gAcpDzTDCP4pBUQGJNaZfLK9QUckjgxYFbVLh9A=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com,
	syzbot+a83dc51a78f0f4cf20da@syzkaller.appspotmail.com,
	Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] fs: 9p: avoid warning during xattr allocation
Date: Fri,  2 Feb 2024 15:13:17 +0300
Message-ID: <20240202121319.21743-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An invalid server may reply with an xattr size which still fits into
ssize_t but is large enough to cause splat during kzalloc().

Add __GFP_NOWARN flag for the allocation. It seems client side can't do
much more about sanity checking here so it's better to return ENOMEM
silently.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 85ff872d3f4a ("fs/9p: Implement POSIX ACL permission checking function")
Reported-by: syzbot+56fdf7f6291d819b9b19@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000789bcd05c9aa3d5d@google.com/
Reported-by: syzbot+a83dc51a78f0f4cf20da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000086a03405eec3a706@google.com/
Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/9p/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index eed551d8555f..e19a46192d2e 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -29,7 +29,7 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
 
-	value = kzalloc(size, GFP_NOFS);
+	value = kzalloc(size, GFP_NOFS | __GFP_NOWARN);
 	if (!value)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.43.0


