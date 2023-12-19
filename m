Return-Path: <linux-kernel+bounces-4521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB8817ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E581F23929
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CB17CF;
	Tue, 19 Dec 2023 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWmjYB24"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6163A;
	Tue, 19 Dec 2023 00:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7ACC433C8;
	Tue, 19 Dec 2023 00:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702945588;
	bh=7NEFQ8R3rBkXCqeCCvEjVFHOC3Fz0I3oIIJHg+yuvj0=;
	h=Date:From:To:Cc:Subject:From;
	b=JWmjYB24TEa+UDi07pE7PXCdzt9C2b35c1LndtSIoxerQbe9EeA/6P0hsImCXPR4T
	 hSeh8mYPIY8L+7Qt4kfT0H31V+67XUKLQ/qOirLVzbiJvVpdldHcra6DGtTT23W2Wb
	 PGEiJkyq+Aem+hREwVvTX6tJUOnKngN6VOnkUDwjm+SHOBjBc6IEKmUqhzAb0QOKlA
	 /USL+uFtoejY64WHXsbKEF/HYpJHW/yqvOprJdR26+oB+iimV7p6tteOEeQ4DSyNit
	 l6OonzamS4j1hvoZElPOfM8FOl8e6uoyKrJrKJZWQct1+CUX6RSUxgds54SLAIWrlJ
	 gsEAlStkNpXUA==
Date: Mon, 18 Dec 2023 18:26:26 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] bcachefs: Use array_size() in call to copy_from_user()
Message-ID: <ZYDjMgyrFYhOsazc@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use array_size() helper, instead of the open-coded version in
call to copy_from_user().

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/bcachefs/chardev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 304ea619a888..22a52bc8406b 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -360,7 +360,8 @@ static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_a
 	init_waitqueue_head(&thr->output.wait);
 	darray_init(&thr->output2);
 
-	if (copy_from_user(devs, &user_arg->devs[0], sizeof(user_arg->devs[0]) * arg.nr_devs)) {
+	if (copy_from_user(devs, &user_arg->devs[0],
+			   array_size(sizeof(user_arg->devs[0]), arg.nr_devs))) {
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.34.1


