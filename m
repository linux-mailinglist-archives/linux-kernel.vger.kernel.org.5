Return-Path: <linux-kernel+bounces-62625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564408523C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CAB1F2152E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BD5CDC0;
	Tue, 13 Feb 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZR+0XF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE25C8FC;
	Tue, 13 Feb 2024 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783613; cv=none; b=ACnMyzD6wc7jMl1XmJ13OFloMkomxHWInk0ZhyIo7LA8dHeyznJmB9NJbQR1xBxLvhDHqc5ncRi/YruyBYJP4Ss3i4e//s/h2VnUo2XNrYkEpbxIeoa3RWbku82yyRRAWw4ieBCXlFgTjqyY+eA2C592C3+A56ROQ5iZ/rJUyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783613; c=relaxed/simple;
	bh=I7nRm05Rrc8jVppMcnUrwhVUzVglvFm1ffpXBh29HME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVg11xAKBjSYl5Evbx2StaVl1kC5uN7I+C1PuW/NGnNpw7YH0H3G5tiJfjB0GocEpuZh2jG86DSrhn0aeqZonJ16MTVN7hgWHq/7ln6LWiGV5Zc0JPg2vJcTTOBCnTVO8qANJIIzz3+5p0MrcSmx3XsE3+IA0oK5+HB4wRsg7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZR+0XF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6ABC43390;
	Tue, 13 Feb 2024 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783613;
	bh=I7nRm05Rrc8jVppMcnUrwhVUzVglvFm1ffpXBh29HME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZR+0XF+yhOfWj/+abX01ertUjH98rgl7Vjj/owQ9YNDS9A8cpRONSDdJDzFPSNoC
	 9at7vZKRNXOr8MWr7xPyqOCT0DuCizXExNJD3av9qZQJhsqIsn0IKQiMYYAVwE71lq
	 22ogRLQzck/R5sD1qUyj/FozXGYaXn8WoSjJ+Ld6nfjZEnvoF3Z8ROWgf5qAgSvws/
	 +IXrw58J6JIcNIGj9n/p0evs2CkaYYB9PAjaSIpC9LbzonqhLmHI49fwrd5TH0YSiJ
	 6IrNA8dKd9k/uWxmaAsIaYZMJa52uoUR2L3MrnJ74kv/WhY2xofj8+M+K195I+gOiA
	 j9FrDRWXF3NTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 52/58] drm/amdgpu: Fix shared buff copy to user
Date: Mon, 12 Feb 2024 19:17:58 -0500
Message-ID: <20240213001837.668862-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit 2dcf82a8e8dc930655787797ef8a3692b527c7a9 ]

ta if invoke node buffer
|-------- ta type ----------|
|--------  ta id  ----------|
|-------- cmd  id ----------|
|------ shared buf len -----|
|------ shared buffer ------|

ta if invoke node buffer is as above, copy shared buffer data to correct location

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4..ca5c86e5f7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -362,7 +362,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		}
 	}
 
-	if (copy_to_user((char *)buf, context->mem_context.shared_buf, shared_buf_len))
+	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
 err_free_shared_buf:
-- 
2.43.0


