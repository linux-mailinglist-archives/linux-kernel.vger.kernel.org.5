Return-Path: <linux-kernel+bounces-26654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907FC82E495
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA901C22525
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207481CD28;
	Tue, 16 Jan 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cReZlMhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9481CD19;
	Tue, 16 Jan 2024 00:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AA1C433F1;
	Tue, 16 Jan 2024 00:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364032;
	bh=IdLQpGRsgus/uzb8ZIAVFMwnfGC8MOAkA+1X7UHqYvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cReZlMhPNmJwsaJblmFbiqx64m1DqhE7IRfBefMG1trF6KpmAzE0oVUcEHnovAbto
	 MhqftAYXp9/PlwezcMiGnDcBDgybgLIUl8rJUvGKzyqAEeCJYZTuN9V7KVU6przweL
	 JHiCtauXcu5wu/KuXAg9i8pB/SwkXyDJ8Q6T96ObhEUj2jdzvGfhc1ToTXllCc/kdZ
	 mzafw/ukDvFMpwp4pZoo4ml1kEfaiTkG537J4psay9MJ7mixfMAp4VRoi5iUkcS5uG
	 EcKfluSviIuvW98m//aaqBWSF0uhyJi9DXEnXihZKH7Z8ZMCj9tSQzQFIc211t4A96
	 YZ2Fj5Vb/7YfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Avadhut Naik <Avadhut.Naik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	bleung@chromium.org,
	tzungbi@kernel.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 03/14] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date: Mon, 15 Jan 2024 19:13:29 -0500
Message-ID: <20240116001347.213328-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Avadhut Naik <Avadhut.Naik@amd.com>

[ Upstream commit 0706526ec7704dcd046239078ac175d11a88a95e ]

The debugfs_create_blob() function has been used to create read-only binary
blobs in debugfs. The function filters out permissions, other than S_IRUSR,
S_IRGRP and S_IROTH, provided while creating the blobs.

The very behavior though is being changed through previous patch in the
series (fs: debugfs: Add write functionality to debugfs blobs) which makes
the binary blobs writable by owners. Thus, all permissions provided while
creating the blobs, except S_IRUSR,S_IWUSR, S_IRGRP, S_IROTH, will be
filtered by debugfs_create_blob().

As such, rectify the permissions of panicinfo file since the S_IFREG flag
was anyways being filtered out by debugfs_create_blob(). Moreover, the
very flag will always be set be set for the panicinfo file through
__debugfs_create_file().

Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index c876120e0ebc..4428dcbd2a68 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -454,7 +454,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	debug_info->panicinfo_blob.data = data;
 	debug_info->panicinfo_blob.size = ret;
 
-	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
+	debugfs_create_blob("panicinfo", 0444, debug_info->dir,
 			    &debug_info->panicinfo_blob);
 
 	return 0;
-- 
2.43.0


