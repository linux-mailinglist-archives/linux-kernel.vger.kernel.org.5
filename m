Return-Path: <linux-kernel+bounces-149728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847A8A9517
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A242820D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181B158203;
	Thu, 18 Apr 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N52Lm3VK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132A154BFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429281; cv=none; b=W6h/eHhJLkYWFyZ7+mU94/3VCSY94Jc5gkS++V3KPpxjZGGMAaZdYpLGcPRzamKT2Tzl+VWQpYMSzMnc8FCIGYW4ZllkhlNhhZKYIye0gw2IbvkUlOlG4ki78Gyt12wHVnrKnLWnG7cHZUywER6hJrVxUknysuxyxz5bqkrqNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429281; c=relaxed/simple;
	bh=mm128Q0AdH9Dvjnv7b4cIuV9GNgaiwIadPzWSTcvOcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yl8gO1Hbus9JDwzKQ2y7idVuFeClUmMqo4iYqAIh4JWrrMW24zv++puAbkYOEMx+ZFyVWhjP/T9aD7aCTY3t8tjWnV1/DiqW8pD/K4SY1uvXEHTRlgFZ185yKvcia6BjHjXIlIqBTr7OqrNv5ZnLAc0RKfvziRI/Qm1XqKAoGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N52Lm3VK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27BC113CC;
	Thu, 18 Apr 2024 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713429280;
	bh=mm128Q0AdH9Dvjnv7b4cIuV9GNgaiwIadPzWSTcvOcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N52Lm3VKCcPqN8tpR+YRwXPxacUTwpSH7L5eIq8LmosIjo2h9ddpVSOEiTM5T2f2A
	 3FgFn49pZ3SLKFYM7D8duH70vvbHUp6ZSRImwhow7yAWN3FEeemiMuqwF36fC2WemO
	 Lnm8Cb/KJ7ZW+hqqMP2eLIwLT3e3MEQrCPTC4d+8x0uxn5LcVjT3RASL2y0wD83yia
	 tPD+VrkBAUPN/Pc3cMnhqspqWNlt0OwOpUYtlfFhJnIZgpuRlY5LlnGhtee6WKeXSI
	 NC62QK2VIBu9tOT6sRywsZDV7GvnO2dGN394AiOT1F3Se4UmDRiq+UhYQA6qSEx4NL
	 68X2MQ7ogYl7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Martin Leung <martin.leung@amd.com>,
	Mounika Adhuri <moadhuri@amd.com>,
	Roman Li <roman.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: fix graphics_object_id size
Date: Thu, 18 Apr 2024 10:34:03 +0200
Message-Id: <20240418083421.3956461-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418083421.3956461-1-arnd@kernel.org>
References: <20240418083421.3956461-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The graphics_object_id structure is meant to fit into 32 bits, as it's
passed by value in and out of functions. A recent change increased
the size to 128 bits, so it's now always passed by reference, which
is clearly not intended and ends up producing a compile-time warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c: In function 'construct_phy':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:743:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Add back the bitfields to revert to the original size, while keeping
the 'enum' type change.

fec85f995a4b ("drm/amd/display: Fix compiler redefinition warnings for certain configs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/include/grph_object_id.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/grph_object_id.h b/drivers/gpu/drm/amd/display/include/grph_object_id.h
index 08ee0350b31f..54e33062b3c0 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_id.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_id.h
@@ -226,8 +226,8 @@ enum dp_alt_mode {
 
 struct graphics_object_id {
 	uint32_t  id:8;
-	enum object_enum_id  enum_id;
-	enum object_type  type;
+	enum object_enum_id  enum_id :4;
+	enum object_type  type :4;
 	uint32_t  reserved:16; /* for padding. total size should be u32 */
 };
 
-- 
2.39.2


