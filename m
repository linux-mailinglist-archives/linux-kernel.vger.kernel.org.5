Return-Path: <linux-kernel+bounces-61423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E485122A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EA0285543
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365639AC3;
	Mon, 12 Feb 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5jm+8v/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FD39877
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737150; cv=none; b=D33gxQVtCJ09sOZn9EmzpNERudr2l3i0bahokCLUBdhIpyfza/k6ebeKu/eN9JwJ+CVPHBzP5gUdu2+6W0KvDqqH3wDaVDXlt7jHisPfQwnoQKshaD9FtzjCQ72Bfo9RAYjl8oldsmAx+TL0ZQMq9+WmV5QdVJq/OTLz2OSh4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737150; c=relaxed/simple;
	bh=4g4oiPC3x8fy5FEvIMXnSo4ptsk7ZrRn6IXmztKqK+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UpQ0hzWU09QY4t3PHDhAorDa/xFSO+Cgf3QUqI9WCEU0puztR60PbCszXFVmvQfKbbtLtkzHDp9otrbEWRUpyK4IQ0Z7ZAo7WK+UwVXkQihH08E0T/YSHSvX+/ygwSG4XJ5i5hAXw0P+EYgnK/n2udIzetoHEYjNYM9euoLFE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5jm+8v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9C6C43390;
	Mon, 12 Feb 2024 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707737150;
	bh=4g4oiPC3x8fy5FEvIMXnSo4ptsk7ZrRn6IXmztKqK+M=;
	h=From:To:Cc:Subject:Date:From;
	b=s5jm+8v/vxlalLNU1FTKvXIXGnrN6mDsipv8Fy7iwa6mpjlK2hr9GV+kOZq7cVuMO
	 6Tx3EdMCDju2jOOMkegn2lu3LqOI5VUfWGkwJFWrbYygEnzK4bRD/aWSL9SBr2Epnw
	 XRk+7gw3fY5zpVwaCAcz+8KHdIC96XKzvJnkq5Lxe4WdfGn+JCIKk8HR3ww/YGgv9T
	 NaBhbPcAnvdEwbw8NuwMWWEoHUl9xe7fGV55r17DsYVWWVgBHWB3I8csIdMAYLVSjk
	 MvRgYLg1ox+8NZKRjHFfjQAbnu7Q0c894kTvW3RaMDhdRFwIBNI7bUn175UQQ2uwhK
	 sTvhtXX0O1rAA==
From: Arnd Bergmann <arnd@kernel.org>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: dpio: fix kcalloc() argument order
Date: Mon, 12 Feb 2024 12:25:27 +0100
Message-Id: <20240212112545.1244685-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous bugfix added a call to kcalloc(), which starting in gcc-14
causes a harmless warning about the argument order:

drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
drivers/soc/fsl/dpio/dpio-service.c:526:29: error: 'kcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  526 |         ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
      |                             ^~~~~~
drivers/soc/fsl/dpio/dpio-service.c:526:29: note: earlier argument should specify number of elements, later size of each element

Since the two are only multiplied, the order does not change the
behavior, so just fix it now to shut up the compiler warning.

Fixes: 5c4a5999b245 ("soc: fsl: dpio: avoid stack usage warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 1d2b27e3ea63..b811446e0fa5 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -523,7 +523,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
-- 
2.39.2


