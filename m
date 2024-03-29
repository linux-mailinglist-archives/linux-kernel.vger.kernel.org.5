Return-Path: <linux-kernel+bounces-124850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1DE891D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E021F242FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B81BF20B;
	Fri, 29 Mar 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCwAt0TZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBD1BF1FA;
	Fri, 29 Mar 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716289; cv=none; b=Pn36KAn1OrkVbvyowGuoRdEhY4d5+xCiknp0jXTl0Avo1cKvfAr1h9ehhgri2L+8Mm1nQce6KpsMuXie+0hPLv32z8RksKMJigX0zSaLW8a09zfs0DX9nJs471Iw6OjIpDj6kvc1yNoY3dTyX+sC4KKlNy3okyDGsaxmJOiK7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716289; c=relaxed/simple;
	bh=ch8YjyWB1RWFmmfpIP5tddcgDn4YJeWGhzIDm7eEsD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D34mjS+j0mvuoaREQBOJq26FtNaxYerWPFBCqxasgmoRKoDD/gAbLibv/DCpN/vJvB1vbmNCKv71Y3HyHbCxuRLtZwp2Eeio4UsbXSkMcX5Qmktfda2nOkWxf2tpcOJUApUUO8sE5pNpo0qiFilIGI//oyfFR92uI2k7pyjbT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCwAt0TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C12AC433F1;
	Fri, 29 Mar 2024 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716288;
	bh=ch8YjyWB1RWFmmfpIP5tddcgDn4YJeWGhzIDm7eEsD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCwAt0TZ2YspIaHMxiF6ehusGvhEo0WkDAoeOB75YWsOCd/GW8uBTCxPX8r7jzeBs
	 lofRWCT3aio8LzWoi3zI0w0cpqfj3FXnDICMTDUkgWRv+o3WzRqWclCgv4ZpsuHrLS
	 wvbK1IY2MgPjYg04vauqZu+49TWDEaujpL9n3X0LiHW2oCXkGkayCF9b7kpR643T6e
	 RIqrT/HxdxhBe14C79TRM1x1d53MCG+3KJm3IoeSYG4d91FmBAXedX9H5P9m6aWykm
	 M/O+fMu0sMy2fL29QNAJ73BIxdne94acAkAWjkRmpg+ark2CoZ+6eS1XRTNFaqkibN
	 E9i3cgXaA8IPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Koby Elbaz <kelbaz@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ttayar@habana.ai,
	obitton@habana.ai,
	fkassabri@habana.ai,
	dhirschfeld@habana.ai,
	osharabi@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 41/75] accel/habanalabs: increase HL_MAX_STR to 64 bytes to avoid warnings
Date: Fri, 29 Mar 2024 08:42:22 -0400
Message-ID: <20240329124330.3089520-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Koby Elbaz <kelbaz@habana.ai>

[ Upstream commit 8c075401f2dbda43600c61f780a165abde77877a ]

Fix a warning of a buffer overflow:
‘snprintf’ output between 38 and 47 bytes into a destination of size 32

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 05febd5b14e9c..179e5e7013a12 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2508,7 +2508,7 @@ struct hl_state_dump_specs {
  * DEVICES
  */
 
-#define HL_STR_MAX	32
+#define HL_STR_MAX	64
 
 #define HL_DEV_STS_MAX (HL_DEVICE_STATUS_LAST + 1)
 
-- 
2.43.0


