Return-Path: <linux-kernel+bounces-112921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB2887FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070781F21723
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337456FE1A;
	Sun, 24 Mar 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK2DYiwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767146FB80;
	Sun, 24 Mar 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319733; cv=none; b=X6ZIGT4pz3dFVf4VEiQPhr3X+1VP6UJ3rooXRQtyxRDY5rTd8cE+Z3YlaPgupRzxKym2qQeUnm+ybZ35BaxFCdDZsBzJboCmUTFhfS6uBPIlVjERudIZnSljvX9LYC8DAV+th6Sd8AIMsc9oIJHJchUG4KypKmknyIdPHrJQVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319733; c=relaxed/simple;
	bh=UObW9I6bfIlw9H+IP5DBPRyzBWISzkmfqE7NiZ/xRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zhg34yLr1VzvlZwoYsPnKh1FW0LK9Eckp1zB3wn/a0bE1PBbkqzPcTOxe4UNOH3gncfZevv6LbFfqZMrdcK4BgSe443jKbqB9aYpFsXW3ZVRgdF4V9BcNtdbyCjIUkD91mQo1ttJrNPCkxCJo8sJCrabpliU7kfBZ7p3JL8BUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK2DYiwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7125BC43394;
	Sun, 24 Mar 2024 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319733;
	bh=UObW9I6bfIlw9H+IP5DBPRyzBWISzkmfqE7NiZ/xRH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK2DYiwY2bIsFCTbpnEMYc2LG5Lz4x0rGNy75TfnP2YGiBhownskLDnb4K0wRd76b
	 7cDLCz5FP5dD5Oj8daMUYocV9ND9Li0Jr+I/0vM5oIEEKdwcuYL8DT2T0LAGJAKo84
	 hdRTTe33Cx/Zi5JgsDWrf5HNLGry9cOlcfqb9vrGqnOoE2iUqSwkFBvp1zSUfBMQ/m
	 TeB4CrN3Hjhd2FSooLPQcMU4iHawrn3F20MVUnkwraMbLHdOB1jXwAre5K1aXVLY6E
	 a3h3MFpoxPuXEnyXsIQcGAXC/0HG4Xg0FdQLtQQm3AK757ieleNJl4zf5/miv47tds
	 r5FSdyOlPcSZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 034/715] drm/xe/tests: Fix printf format specifiers in xe_migrate test
Date: Sun, 24 Mar 2024 18:23:33 -0400
Message-ID: <20240324223455.1342824-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit 689a930b93c5c20294df5da0407df361c5412eac ]

KUNIT_FAIL() is used to fail the xe_migrate test when an error occurs.
However, there's a mismatch in the format specifier: '%li' is used to
log 'err', which is an 'int'.

Use '%i' instead of '%li', and for the case where we're printing an
error pointer, just use '%pe', instead of extracting the error code
manually with PTR_ERR(). (This also results in a nicer output when the
error code is known.)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index a6523df0f1d39..c347e2c29f81f 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -114,21 +114,21 @@ static void test_copy(struct xe_migrate *m, struct xe_bo *bo,
 						   region |
 						   XE_BO_NEEDS_CPU_ACCESS);
 	if (IS_ERR(remote)) {
-		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %li\n",
-			   str, PTR_ERR(remote));
+		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %pe\n",
+			   str, remote);
 		return;
 	}
 
 	err = xe_bo_validate(remote, NULL, false);
 	if (err) {
-		KUNIT_FAIL(test, "Failed to validate system bo for %s: %li\n",
+		KUNIT_FAIL(test, "Failed to validate system bo for %s: %i\n",
 			   str, err);
 		goto out_unlock;
 	}
 
 	err = xe_bo_vmap(remote);
 	if (err) {
-		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %li\n",
+		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %i\n",
 			   str, err);
 		goto out_unlock;
 	}
-- 
2.43.0


