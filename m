Return-Path: <linux-kernel+bounces-115509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF36889C03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BE81C32DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706B237B76;
	Mon, 25 Mar 2024 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E926Ogxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101D1EC642;
	Sun, 24 Mar 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320953; cv=none; b=oHvVUf1GwEOQmn0iBpmdX7kicb5nCuRfiROu5fcEyc8/VNuuFyiFh6ZcQMXISENx4qOuoT9AiiP3rAfa4L2N3IFakkF7zOUWhbCxfYzvF9c5NfrqSUYbDTaErMehL9lnnSwQG/BvuAPmt0M/1wNeaalC3oTTtBuqpfcI98srz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320953; c=relaxed/simple;
	bh=EUd3H01z/g6e+KfDNp6I74U5/lYNo/7jxkXAtx9zt4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpiD0YkiJv7IhPT3u5WdmK2OKFSMArgc0dY36yVdjRr/iJsfLXbu7DM6hjYC9ciZIAmeX7Vv1jozODoOvhcM0+xxlWn5/y9AReciSCm5i+uf7Bk+Tsvh3MF+isDicf2yV0d7U9OETTcJdhqZ0BvvNvyyeP+e8NzZmKyjvV7TsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E926Ogxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC52C43394;
	Sun, 24 Mar 2024 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320952;
	bh=EUd3H01z/g6e+KfDNp6I74U5/lYNo/7jxkXAtx9zt4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E926OgxqxeVUK/7KBnaN3+YMEkUDoZWpc5lT60TDST25CxiGRMgIgEWuiAdNw4gMT
	 8kVSd/j/w/oDuuIRiQ8UJsNAf7FBO+FZiXT6HHnkZb2rw6Ioyc3d60waFrkUjKepaC
	 rHz3yBa7AEFQSikwvW6BZSEHsDqC4HRF9+PUFwUKhXaGGRtu9rV1O1QCowaU9k2j/t
	 OHZPaxhLJoo50Gh8iQoU62K5/x0461/mpoNhs3QNl/Haaui2fXI2+dAdMlYIvH6F8c
	 7uyR5VHE21jHthjOs/jCEKFHEGO0RMnDMYPZMT/3+0haU8lF0Nno1ChtBwxtDkqKkn
	 x3P1X8lPJAmkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 516/713] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 18:44:02 -0400
Message-ID: <20240324224720.1345309-517-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 7cf1ad2fe10634238b38442a851d89514cb14ea2 ]

Missing break statement in the ATOM_ARG_IMM case of a switch statement,
adds the missing break statement, ensuring that the program's control
flow is as intended.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:323 atom_get_src_int() warn: ignoring unreachable code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: Jammy Zhou <Jammy.Zhou@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c221000782cd..1b51be9b5f36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -313,7 +313,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
-- 
2.43.0


