Return-Path: <linux-kernel+bounces-31726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18D1833307
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DBB1F22A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569EC20F8;
	Sat, 20 Jan 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HSIL+65R"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A01FD2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733944; cv=none; b=c4JZOpSjDEhq46jFhGq9Cy9KkHBguxmkw93fo5ZXXahG2Oyn69fMv2XnOb+yMs7RsrAv5sRICnFSoOwAW7upUp4yJDBWj4bXN1lCi3JGPOqrJNq9hlccWS0RmvyDzNPFm85U1xN2m7xWpFT9KDi8hew60wuhU2wMg9tc7OQun6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733944; c=relaxed/simple;
	bh=iLUdhhWo7aaI6NNBGbzsfYLNbVys8tgyc3bVY56Gjik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ul8IapEfiNV6yzg7iHuaU44I1OhyHUfm+nHMTvrHD/9dO07Q0SvICwj74uA+zAMn8ivkx0p9hhA6Qvp+5/FIlRTDenQpqND05/EVoI1+jiKzxgc0cspMvKLReVwHAB3ey4ZX/367UPbgpRAERWh1wj+uwM11a7AP5hLeJ0sJ+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HSIL+65R; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id R5JcrkgoYBejiR5JdrgS2l; Sat, 20 Jan 2024 07:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705733933;
	bh=swo29GFzf9xHjPXqHApVp1CpCySEKUtAyuh+ivXKxUQ=;
	h=From:To:Cc:Subject:Date;
	b=HSIL+65Rtj5Jv/agCYAK7LGEEezmUGxhWlpnklfHBQzQSvkYCVoQY8tEzYKv/hvN4
	 5ZuhOgIzYgV/GlzzYRLJZUrAB/nUqZ0LydGQMlLNyBV3ei0Hyap9Zfb/27JAgrTc4c
	 bruPR+pQJw2oiWZ8ov+4owF5XS60KWO4l+c5nysTCk4PRCv41fPFOoMfLUO5jLHzM1
	 92j2radxR42JzL3myOoXxgtKf8I3uBaF0qv9WZHGw67b+i6lWu8yJPxgI+p1mudX76
	 +1t2pR3x1zIj7zo8E1OnmmZpE9zcw4GoommMUUPbSrMFJoT6TnpMgDxvxYiS0Exx1f
	 J5riGI+tz7y4Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jan 2024 07:58:53 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] platform-msi: Remove usage of the deprecated ida_simple_xx() API
Date: Sat, 20 Jan 2024 07:58:46 +0100
Message-ID: <fd87836efa894aee0ae43e767369c85a2ee7e1ff.1705733916.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/platform-msi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index f37ad34c80ec..ca48d1f60865 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -172,8 +172,8 @@ static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	if (!datap)
 		return -ENOMEM;
 
-	datap->devid = ida_simple_get(&platform_msi_devid_ida,
-				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
+	datap->devid = ida_alloc_max(&platform_msi_devid_ida,
+				     (1 << DEV_ID_SHIFT) - 1, GFP_KERNEL);
 	if (datap->devid < 0) {
 		err = datap->devid;
 		kfree(datap);
@@ -191,7 +191,7 @@ static void platform_msi_free_priv_data(struct device *dev)
 	struct platform_msi_priv_data *data = dev->msi.data->platform_data;
 
 	dev->msi.data->platform_data = NULL;
-	ida_simple_remove(&platform_msi_devid_ida, data->devid);
+	ida_free(&platform_msi_devid_ida, data->devid);
 	kfree(data);
 }
 
-- 
2.43.0


