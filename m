Return-Path: <linux-kernel+bounces-84382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2DE86A618
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC901C23549
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B79442F;
	Wed, 28 Feb 2024 01:44:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5F4400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084691; cv=none; b=Td/gVadVheAXtT7+zbufhlJ9OFF9ejNdO1tDgNLO4hrmAS7OpT7b6w510xOzo5vfKXYEQ6EAZ4MXRC9Qa4rTmrNPwF4XBT0h0kLDd7fbFJiN+OnP0NIKMYZ+QYNiauZwnxlnS1CHeRBkAj+fdAs0N2Iqy9u5u3T1RzmeTC3Ke1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084691; c=relaxed/simple;
	bh=8ZheHfrSU54qvFXbtTA6yJgjr8hUzFqP9Qq4JNTJYXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8gNBBKyuyAs2pAROhqJ3AUxTqsnDxMIiDitemEHBFDvUqfyGulQsVpkgVzz12n0Q/WeBbtg7Sb7KxMEXEQ82PLD9qUVNmXYvvY/QcdYZOAFPDTCqFi++Wr0kuQUe8OS8CRPGSKegA5WNkW1ox1bV+NR5E7lgZojo+eobAdan+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e372564b6c6346f5a530e4e7c953ba67-20240228
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:88b45a86-72ae-420f-8cae-71d289904034,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.37,REQID:88b45a86-72ae-420f-8cae-71d289904034,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:494be480-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240228094440JA95B6XN,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: e372564b6c6346f5a530e4e7c953ba67-20240228
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1595601688; Wed, 28 Feb 2024 09:44:37 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/amdgpu: Fix assignment errors in 'si_common_early_init' functions
Date: Wed, 28 Feb 2024 09:44:35 +0800
Message-Id: <20240228014435.7234-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uvd_ctx_rreg/uvd_ctx_wreg correct value requires function pointer.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index a757526153e5..455d49f7bd9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2032,8 +2032,8 @@ static int si_common_early_init(void *handle)
 	adev->pcie_wreg = &si_pcie_wreg;
 	adev->pciep_rreg = &si_pciep_rreg;
 	adev->pciep_wreg = &si_pciep_wreg;
-	adev->uvd_ctx_rreg = si_uvd_ctx_rreg;
-	adev->uvd_ctx_wreg = si_uvd_ctx_wreg;
+	adev->uvd_ctx_rreg = &si_uvd_ctx_rreg;
+	adev->uvd_ctx_wreg = &si_uvd_ctx_wreg;
 	adev->didt_rreg = NULL;
 	adev->didt_wreg = NULL;
 
-- 
2.25.1


