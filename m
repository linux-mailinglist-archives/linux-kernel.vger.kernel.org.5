Return-Path: <linux-kernel+bounces-120504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723D88D87D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F321C2596C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA12D056;
	Wed, 27 Mar 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvbdm01v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7332D045
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527111; cv=none; b=lELPzeqRZZm07igsCghMjbirc0A5hzg8TMddje1ZCeWHurJpbOQf3QDIS6WR3gzsQNGpcfVP1x9gXoRBFv1XLJ3tqd+vhTEkFtmSMs2eiDkbActZLpFNHMFFmk+gN53xBP9uYeotb7E4YPcrJZamWYnDM2kwIq8fWS4KqnDP/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527111; c=relaxed/simple;
	bh=W8JBIU8jFpcTbT3pbws5ih2vOCK54sF5tHI1oqWhozE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riqrfrBzDtsp4dm0QoWIhza7YkNt6XXAV07NwmLhjR6sGwWpeHGfcaboJ2DMdjGA0J2MQwCRPY5Z9hCjYzp5PmSgR5aQB1ayd2LBUlC+ldV8x8LXHtuAifoQ2EbN3Uqg9SrFdhbkMeJlMdTMS/65tz4JsKfqTv1FJ8Hn8npZNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvbdm01v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB76C433C7;
	Wed, 27 Mar 2024 08:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711527110;
	bh=W8JBIU8jFpcTbT3pbws5ih2vOCK54sF5tHI1oqWhozE=;
	h=From:To:Cc:Subject:Date:From;
	b=bvbdm01vzbUAGOgLAHOOU6utVAbuIY6DWK6MpRtBPd/0iUbKNK8v+tD2gvwfMqQ2f
	 6K0W4pkaIUDUp7igmNLuRc10VSp1XggQCGRb8KrAmkcUF3BkODWdaR8UcoVQLC6lEM
	 L0oevMZTdeL97xXMCXa8gH4rNlQTy1jg95Ti/Pwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] nvmem: core: switch to use device_add_groups()
Date: Wed, 27 Mar 2024 09:11:46 +0100
Message-ID: <2024032745-recycling-state-4c32@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 28
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=W8JBIU8jFpcTbT3pbws5ih2vOCK54sF5tHI1oqWhozE=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnMVw6FfNijauz4tzqpVlK4e1V041/HKbemK5b5sJgce P2lPONBRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkSirD/ILfyXckZLr/Xn6h GZvHOO1O29cqB4YFV/iv3qg6v5b5teek6f9O8t59M/mpAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

devm_device_add_groups() is being removed from the kernel, so move the
nvmem driver to use device_add_groups() instead.  The logic is
identical, when the device is removed the driver core will properly
clean up and remove the groups, and the memory used by the attribute
groups will be freed because it was created with dev_* calls, so this is
functionally identical overall.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2c6b99402df8..e1ec3b7200d7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -478,7 +478,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	nvmem_cells_group.bin_attrs = cells_attrs;
 
-	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	ret = device_add_groups(&nvmem->dev, nvmem_cells_groups);
 	if (ret)
 		goto unlock_mutex;
 
-- 
2.44.0


