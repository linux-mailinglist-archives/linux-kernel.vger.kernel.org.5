Return-Path: <linux-kernel+bounces-121772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC488ED72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6E1F350D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F22153589;
	Wed, 27 Mar 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyJhsudI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC0153578;
	Wed, 27 Mar 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562213; cv=none; b=PrdJBrAbFLHmwTGxaXRMOxj6mOTgd3o53e5sJOYgGSq42ODN+u47mghBZnF9Xo4TQsbtQM0ZcRUAgtSP9x2p2Gr7zfFNac9fMw3szBzPTagI3wD2lQqnKdmRltXNhXBJVbaS7Dvrhkfp4JXcTO4Bh4RwmVz6aoSEoASBR0jWrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562213; c=relaxed/simple;
	bh=81om+e8n4vrHpgDjOmkmoW483t3RenxrqBAsOHmYQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLayBXZ6xrhhZsdlH8nGEHQqj8PM9xD/v+uYh6vakms7VufLEZ01Ul2tTQTZPwHCK6tCk5edHvpTB9ZpksTsxMqpc7FsvvtAhDLErGJ/WrUc0tutR4V0M+YedGfL2iFRMSQV/BTZt36J7lvSj0uC4/c2IeyBDHMVvIC0F/Ncy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyJhsudI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04744C433F1;
	Wed, 27 Mar 2024 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562213;
	bh=81om+e8n4vrHpgDjOmkmoW483t3RenxrqBAsOHmYQXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyJhsudIqBxcsetwtVDJDjAzhnfjap4Hzg1pjrXZ5cCmQa1Vqqz7A0QOCTALf4FUT
	 4h90vDIO4lk4bJ3ZfqFOOin7pQoPPxGgVx5+5ih37g3RqMmJIAAQ23P33FgAMCTgNG
	 owTlNx7ttatG0969MEJhQNXwhFckhUWGYA9Xpn5ST0eiJHZe5iVVkXGvLmzedg1Nw+
	 EnUQjASGScYzvtYxv4m2NymSYBDaL/YJyewDAMBn6jDiU+A4Q94BAdlEz2DMRCeqs8
	 DYgBqeobMUj5CrCcvvTR5C4BGKr1oxMH30ypWlM0ck2IQcjld91pSdaMzITphk9ynC
	 w1YmFYlPSZ8Hg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alon Levy <alevy@redhat.com>,
	Frediano Ziglio <fziglio@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/qxl: remove unused variable from `qxl_process_single_command()`
Date: Wed, 27 Mar 2024 18:55:56 +0100
Message-ID: <20240327175556.233126-2-ojeda@kernel.org>
In-Reply-To: <20240327175556.233126-1-ojeda@kernel.org>
References: <20240327175556.233126-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang 14 in an (essentially) defconfig loongarch64 build for next-20240327
reports [1]:

     drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable 'num_relocs'
     set but not used [-Werror,-Wunused-but-set-variable]

The variable was originally used in the `out_free_bos` label, but commit
74d9a6335dce ("drm/qxl: Simplify cleaning qxl processing command")
removed the use that happened in that label.

Thus remove the unused variable.

Fixes: 74d9a6335dce ("drm/qxl: Simplify cleaning qxl processing command")
Closes: https://lore.kernel.org/lkml/CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index dd0f834d881c..506ae1f5e099 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -145,7 +145,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_release *release;
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
-	int i, ret, num_relocs;
+	int i, ret;
 	int unwritten;
 
 	switch (cmd->type) {
@@ -200,7 +200,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	}
 
 	/* fill out reloc info structs */
-	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
@@ -230,7 +229,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
-		num_relocs++;
 
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
-- 
2.44.0


