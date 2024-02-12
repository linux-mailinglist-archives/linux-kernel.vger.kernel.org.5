Return-Path: <linux-kernel+bounces-61415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23938851216
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DA81C217C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537A38DDD;
	Mon, 12 Feb 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CygLBY8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC438DE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736956; cv=none; b=ciE7GevXyaGfdfv0bubCdmuz6514QIXzmdOiGrNFQl67CRqYI2MnIJth7HJarDXi0Z38qroZus6SzDDfXp0bp4racWwfUOwWArern1+bum8yf57EULXW6VgElU5UtizGNdDEXacApw01en4KycEd5jwWDvnJ2JqeAgenaok85Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736956; c=relaxed/simple;
	bh=4C5nZGco26sonFA2eNFl58Z2ow6XP0jrBTogGeyvF7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCem9RjHWqILqkinwLResYyiLigh2tQkaxKj7PYLQn0dHXwAFNuvFOzjkkg/UUeq94I5/Zw8YicD19SHUv4DUMuuOoBKLkHEr3Hw1pX2hab98YqsDuhYN6mPcAepMGMfQP4aCPtHqMfQ2sczTXTfN41swTg6zYso5ol4I4qWk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CygLBY8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EFDC433C7;
	Mon, 12 Feb 2024 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736956;
	bh=4C5nZGco26sonFA2eNFl58Z2ow6XP0jrBTogGeyvF7M=;
	h=From:To:Cc:Subject:Date:From;
	b=CygLBY8XhV8HOEbO2Yhqk49rWMjOa8t2XLVwB952Zz4Bn5kxp5qwPCPwj6HZhry+M
	 ONK37SaoxMjxxOqj6C4rHrZzvJp/ArzDLuID/k7Ii2qYxHlnmZ7Y022pDFbWlcEq2i
	 xaYEp2k8aUx4AkjEA4ekWKpu+lqThQHgBVjee8XR4SI3IJVazSwqTit59Mhqt60bs7
	 ZqpVppMJxzsAiodFBPS9eJ3C+3oDXxa/00VxMMGxnPpkfVU9t7QfG7XwQUR0JmP9Jx
	 rDGkdxt3oHqtyzYakpPU2f085hoUlMnvvb3VDUNrmjscFJAe4gkI+/yMqEj0h+mfb+
	 6xwEdiygBPvKg==
From: Arnd Bergmann <arnd@kernel.org>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dave Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nouveau/svm: fix kvcalloc() argument order
Date: Mon, 12 Feb 2024 12:22:17 +0100
Message-Id: <20240212112230.1117284-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The conversion to kvcalloc() mixed up the object size and count
arguments, causing a warning:

drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_svm_fault_buffer_ctor':
drivers/gpu/drm/nouveau/nouveau_svm.c:1010:40: error: 'kvcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
 1010 |         buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
      |                                        ^
drivers/gpu/drm/nouveau/nouveau_svm.c:1010:40: note: earlier argument should specify number of elements, later size of each element

The behavior is still correct aside from the warning, but fixing it avoids
the warnings and can help the compiler track the individual objects better.

Fixes: 71e4bbca070e ("nouveau/svm: Use kvcalloc() instead of kvzalloc()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 4d1008915499..b4da82ddbb6b 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -1007,7 +1007,7 @@ nouveau_svm_fault_buffer_ctor(struct nouveau_svm *svm, s32 oclass, int id)
 	if (ret)
 		return ret;
 
-	buffer->fault = kvcalloc(sizeof(*buffer->fault), buffer->entries, GFP_KERNEL);
+	buffer->fault = kvcalloc(buffer->entries, sizeof(*buffer->fault), GFP_KERNEL);
 	if (!buffer->fault)
 		return -ENOMEM;
 
-- 
2.39.2


