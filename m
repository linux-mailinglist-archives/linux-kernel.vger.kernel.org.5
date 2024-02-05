Return-Path: <linux-kernel+bounces-53890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247584A7B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D85282093
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAF12BEBB;
	Mon,  5 Feb 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTYaLnhM"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A712BEA4;
	Mon,  5 Feb 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163573; cv=none; b=OUpw88ANqNA7J4ZE3MTkS+StKRgudqL3kwSOjr7aYzv2FufBVMRAP0XYNfGa44hC1HTAsk6fpzR64SaW3c5ilKDDwA+ngdHeTrpuztsHZkYA7uvr+wB2xfLEp8nRe6S/leoTO2iS5bSJh/pQJEm0U0ZnGOcMDj8DA10qagMiwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163573; c=relaxed/simple;
	bh=SpXRXuGnMtRwA2NcE51fX/znF3QwnMp2SZRjBoEEXhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTu5eequhJh5KGz0Xsz9s06HUDMEej03xJDPlFHSQo3M+eKceBoWH2A0DiPetgm/3+9+ty5tJKYRqMmkOGk13onFxDsTp90b/3nJWlxOid5l/ipTGuerDJ47vc5swu9Y6N9AmCQRLsGtjusKjoL1L+5CP6c/fPpO0MWxZWau4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTYaLnhM; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjLLoTR+ir1vHIuy3hXsUuRK7GJSfSeb1z1mFbcs/pM=;
	b=xTYaLnhM62iIw9h5mlJHwn37PFD+85rp5V2iVlzDFkUm/hiGWhkq5JrHRt13ZXTLbc5Qqz
	cTHbzZadurpRL3NbkqdBkVzPCdxApb/tvOrNOsqUEmQ1SOFbq/dPloj4T6KJeTph2qziC+
	Z0L+ka/B3oCSICX1qvb2qZpVQDiV1Zw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 5/6] xfs: add support for FS_IOC_GETSYSFSNAME
Date: Mon,  5 Feb 2024 15:05:16 -0500
Message-ID: <20240205200529.546646-6-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/xfs_mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aabb25dc3efa..6d16203d5c1c 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -711,6 +711,8 @@ xfs_mountfs(
 	if (error)
 		goto out;
 
+	strscpy(mp->m_super->s_sysfs_name, mp->m_super->s_id, sizeof(mp->m_super->m_sysfs_name));
+
 	error = xfs_sysfs_init(&mp->m_stats.xs_kobj, &xfs_stats_ktype,
 			       &mp->m_kobj, "stats");
 	if (error)
-- 
2.43.0


