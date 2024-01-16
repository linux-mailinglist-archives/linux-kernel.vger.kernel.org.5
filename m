Return-Path: <linux-kernel+bounces-26636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A7782E461
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A8B225AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8491F511;
	Tue, 16 Jan 2024 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivcBdZDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1906FA7;
	Tue, 16 Jan 2024 00:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE3EC43394;
	Tue, 16 Jan 2024 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363993;
	bh=PEi7ePy+NHPWE6eAsuMtDLWgpaQVPFLu7fiKPuFVUBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivcBdZDwXdF/VdPsmDj61+ADQqgZUaz0Ag1J9sTOFqlgVEjbPFihsLF9qNs8mJ2FF
	 iIXPGTS7isYGaLDHOk98FuCWRMZNoy8a7cnPOoKzImn73JMe8bfzfjFq51HY3WKmwE
	 PZ36QVGop0Z+yO3y4TkwjhVdG5wSpe9wYGFCt/YcQjlmRHGUqlhzO+LEkTiwGGSXi7
	 tGMORFQNmjlRUzQCtFb/I3eyM8vjMUib14ibaA9YbzjTNqG0KezjujtKN2dGkTKX6s
	 nqCnGPI9sbxBLsKKhgAx8tu3dqwcWGH3xEERczL1cwrj2gOIyBkfARQKgoRZWt2OaL
	 50UsF5IZh5/tg==
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
Subject: [PATCH AUTOSEL 6.7 03/18] platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
Date: Mon, 15 Jan 2024 19:12:45 -0500
Message-ID: <20240116001308.212917-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001308.212917-1-sashal@kernel.org>
References: <20240116001308.212917-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 091fdc154d79..6bf6f0e7b597 100644
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


