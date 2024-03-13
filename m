Return-Path: <linux-kernel+bounces-102094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C187AE58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09149B22AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64018D3D8;
	Wed, 13 Mar 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNnWjLFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58759172;
	Wed, 13 Mar 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348479; cv=none; b=SOn9JYrq9CtUOm+fEtubhV2JkQ3eW4NXHkVgre+xaIDnx9sgDD625UMEAy2BE6kEpQ1gBlfo9Y8qoQL1hgI/e3lSbP1msmmtZ3OvFWm1hkecHUvJlbf81/ON8oVSyjxTaJ0ObDfKYHBfa+CAwdmPWtB4mmoB0ktcKhO5MtVKAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348479; c=relaxed/simple;
	bh=nn5a3Fq9a0BrlTENyoAijgRD2DIHNw/iyg0oC7+hBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRvbq5VjINzPpbDVHAATJ4hnPp95KsDJBkN55NCeuWkJsKQ4zvoif570YOs2j76y+hqFoN0OMZVsTOE/EeKpFu+XfyUsqg+TLOKIiXAm2TR1HroEjjZuVnu1p+6/u0QENQjEvePbST/AsDtftU9FTCKptrPIMZxGwxQ1/l0eJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNnWjLFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1689FC43390;
	Wed, 13 Mar 2024 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348478;
	bh=nn5a3Fq9a0BrlTENyoAijgRD2DIHNw/iyg0oC7+hBpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNnWjLFo+3Ds2Ag+ozkEefmSfvywGz39ZI3myvR5TvL+V18Mpsj0oJXDKSzZLlRY2
	 u9x2r45TGllbeDslxEPM2/0wlDLCII/2m+J2ZLH7zE7ZpdX+HStt2oxs3cz7W4RMXr
	 aSi2ZcOJa8VTvEdmqhNLLiGEP58DibZnZrZuiJ3Te4rSDu/BZMtScjsei/916MAQkB
	 f8b3c8KWe6x4mIO2gYqVJM9krGCvwkU6QlMpgykgnXAsb/pB8bcs4bwcBpGt4oyVUE
	 2t3bEcPeVWA1bN4JkvdwQYvyXUatxou/7VxEjGOy3YOOYzYPIq8KZdcVnYjovFzJdy
	 G8mBuZmad8eyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ansuel Smith <ansuelsmth@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 68/73] regmap: allow to define reg_update_bits for no bus configuration
Date: Wed, 13 Mar 2024 12:46:35 -0400
Message-ID: <20240313164640.616049-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]

Some device requires a special handling for reg_update_bits and can't use
the normal regmap read write logic. An example is when locking is
handled by the device and rmw operations requires to do atomic operations.
Allow to declare a dedicated function in regmap_config for
reg_update_bits in no bus configuration.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20211104150040.1260-1-ansuelsmth@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 1 +
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7bc603145bd98..8f39aacdad0dc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -842,6 +842,7 @@ struct regmap *__regmap_init(struct device *dev,
 	if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f7..d6f0d876fa424 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -289,6 +289,11 @@ typedef void (*regmap_unlock)(void *);
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional callback that if filled will be used to perform
+ *		     all the update_bits(rmw) operation. Should only be provided
+ *		     if the function require special handling with lock and reg
+ *		     handling and the operation cannot be represented as a simple
+ *		     update_bits operation on a bus such as SPI, I2C, etc.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -366,6 +371,8 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
 	bool fast_io;
 
-- 
2.43.0


