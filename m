Return-Path: <linux-kernel+bounces-112913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDAD887FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8551C21179
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466636CDA7;
	Sun, 24 Mar 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEWWheiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763366BFBF;
	Sun, 24 Mar 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319724; cv=none; b=khqTzxz5BG8Xb/XSgoNouS9nVA9Vk/oFtbG+cp5rJnBF560qaQSFeBTSCIkFsC/7I5nJ8YBzStem2BwvgfSn4QOGcXGJAIxhWkyH4PltVaB3mj4NEsPGulkA2tdjYRBQdDuHe0q9i/VbBjcFlFWlWGlUPvGhElUYAtGv7XriU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319724; c=relaxed/simple;
	bh=A9hhnNGKNJQvbzqjwj11sc2xcTjo7vfpsW+pBYyE2/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6jQiOr0DSdomLskWaBCj9zH1dT6XvmeY8kceHoK6MMsCwHIxTaK44J8YzGsPrIRPxJ541LaJB3AAHkK9Kwa9mFTucPVcSxt5YlpHpr9EnLsXt8IDLfiH0D/uqzoCJV1V8MPbbd7hwUORlBGEPcNUB5zRGZITDH4APYcbsLHGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEWWheiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9A7C433C7;
	Sun, 24 Mar 2024 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319724;
	bh=A9hhnNGKNJQvbzqjwj11sc2xcTjo7vfpsW+pBYyE2/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEWWheiW6txc+xSEbVqe5FmchDSWK3vdqL2uDTRolvCrsJIXoylb2cXX7MX2d+qLI
	 z5LCFL/shzVXyr0YBTsKfFW3YdQxY8wyha/drPADn/c/On1b63sIsW+oKBMZVDTfnT
	 QRU0ODPP57sMuhZEHX4x5arbgw8QMXW9if04p1uo/9avDD5SFY1LfX6Qa3/aTzkHSI
	 KwgloABaTjLko7dDJ/UEK8tWeByngqvVEecFrb/aMJQPE8e+4j0EEvbKG/odIrNYgJ
	 XPajJ6MMnvr9VBFmcVHThz56facv2fINyCdEXsju8z/WwsJJc8qRpEdcWJ/F+rWn7W
	 O5CXYjn1T/cmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 026/715] kunit: Setup DMA masks on the kunit device
Date: Sun, 24 Mar 2024 18:23:25 -0400
Message-ID: <20240324223455.1342824-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

[ Upstream commit c5215d54dc10e801a6cefef62445a00a4c28a515 ]

Commit d393acce7b3f ("drm/tests: Switch to kunit devices") switched the
DRM device creation helpers from an ad-hoc implementation to the new
kunit device creation helpers introduced in commit d03c720e03bd ("kunit:
Add APIs for managing devices").

However, while the DRM helpers were using a platform_device, the kunit
helpers are using a dedicated bus and device type.

That situation creates small differences in the initialisation, and one
of them is that the kunit devices do not have the DMA masks setup. In
turn, this means that we can't do any kind of DMA buffer allocation
anymore, which creates a regression on some (downstream for now) tests.

Let's set up a default DMA mask that should work on any platform to fix
it.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 644a38a1f5b1c..9ea399049749e 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 
 #include <kunit/test.h>
 #include <kunit/device.h>
@@ -133,6 +134,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 		return ERR_PTR(err);
 	}
 
+	kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
+	kunit_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
 	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
 
 	return kunit_dev;
-- 
2.43.0


