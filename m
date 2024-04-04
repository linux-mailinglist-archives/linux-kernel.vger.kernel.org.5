Return-Path: <linux-kernel+bounces-131443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2E8987ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1181F23791
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A04E126F3A;
	Thu,  4 Apr 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RITkEaZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE28626C;
	Thu,  4 Apr 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234060; cv=none; b=br5bVmN7HXQysu/9tQHpAXHlRVRX8Cc06xiNOPCBDdtTMPoIVUmajNPeucsW9ZdQheym8zI/JI1ugj4iP0w8BDc+AFBK3DeVxJ2QVTZo7g/W8V5mAuBWiSGl9BvrPA5LEGaFU6Adb33ICGtJCr6XqnS9WjwKIi9jzyLlCzqriKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234060; c=relaxed/simple;
	bh=HM/5JA49Jt79PaOxisOklc2h4lFho/dJAQcXbp3RyLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5tuH6U7hFgbGuz9azT1HZyxg1DHfps1clY3zvOEAC7jzBHLvMSD8CY8+PfUxsS2xToxX9EuKdHGOeUlshxnLzSEw5SXTIm8eQhnSxXoJRbqlmQvw0p4dIX+qPWG71B7/Vw9u5emKa6AgJ81fTkA6yJ/i/xG06bpFTfwIQ7BtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RITkEaZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38EDC433C7;
	Thu,  4 Apr 2024 12:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234059;
	bh=HM/5JA49Jt79PaOxisOklc2h4lFho/dJAQcXbp3RyLI=;
	h=From:To:Cc:Subject:Date:From;
	b=RITkEaZ+av4z3murfWN+pchh5Hm2HRy0uOM/NRGkQVyocOZiYCmE19z2gi+E+Xm9u
	 EbsotRKFVqyzkhptj+gMiGWPhEl2tcyugDifM0URoNNOK8bSIkHYOa6TdyNb7SHm1W
	 2v/XQuiFdgTyy7/ZidugrvDZDiL3HNmW+OcUS/28lpJQsbdyOI0GJMLZmkYV40Eg0l
	 wZeibRpr/+OLW9b6ork32UAWsZRsrGAtq/xhBULGsgFpxzb8GOCAa49oB4bzQ0+N8x
	 hCWo+2nmlyTV2Hs3I3fj82apWbL/NYe/MRm92G4CSoF3FWXxXN9RUhEnxcv+1H4fXE
	 deLsshhxljTTA==
From: Arnd Bergmann <arnd@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs, cachefiles: include linux/bio.h for BIO_MAX_VECS
Date: Thu,  4 Apr 2024 14:34:06 +0200
Message-Id: <20240404123414.2675384-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added code causes a build failure without this in some configurations:

fs/cachefiles/io.c: In function 'cachefiles_prepare_write_subreq':
fs/cachefiles/io.c:633:31: error: 'BIO_MAX_VECS' undeclared (first use in this function); did you mean 'BIO_MAX_SECTORS'?
  633 |         subreq->max_nr_segs = BIO_MAX_VECS;
      |                               ^~~~~~~~~~~~
      |                               BIO_MAX_SECTORS
fs/cachefiles/io.c:633:31: note: each undeclared identifier is reported only once for each function it appears in

Fixes: 0d393b1a6699 ("netfs, cachefiles: Implement helpers for new write code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cachefiles/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 437b24b0fd1c..cc5505d4ddaa 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -5,6 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/bio.h>
 #include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-- 
2.39.2


