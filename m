Return-Path: <linux-kernel+bounces-115701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF6889720
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EFD1C306D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1938210A2E;
	Mon, 25 Mar 2024 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfqzenrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B213AA32;
	Sun, 24 Mar 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321694; cv=none; b=iOKVXJ4q3DOd+vjJLUEv4XwDJ3TSErM8eXw611/95rErFuOOhkcrhG2ItkHQX/znBG7DLPI49ucS9goFVVpB4C4jZ3ugkN8YZe/omzNyjtUBA/PZIpGBRybjgEiMSxoNYmQB4RrHl6SnJFJtgQRrR+w+NGNVlyMKowEiLMYHeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321694; c=relaxed/simple;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuGWHms2Tjozno+7e0Neil4gHPEjmuN6UH0prA80i3L3iXHrpxSI9xDXfKNBQOXcQA7xYv09PBMGHoYwQSwu8EcYSXd7J4kQNWK5GwJmdxoQPow+X8AsbmW62tE5E8yCIbHlWMW5fsuYykgyLgfeGGmwBFcWX4rpGYAD8+Lg0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfqzenrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CD8C433C7;
	Sun, 24 Mar 2024 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321694;
	bh=lh1tWZ+Q5ip5maxsWS3cRTsoCijckQtevMH31uUa3aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfqzenrqT5UvKV0nxfmArzwq3OgpFPSW5psssnZkjh7/pjc82+O319Qdr7bhr69Sp
	 xMNeE58wwjhoJEFCdiAdz2JgpHVCH1MG6nl4VcaA+uvHHpu3vuWyCLOrqITbkbDMmR
	 G2B0HHfcNa5urFAXU7qfM9g8kpxKEb2qRBdM/QcrWgpCjESjueEtnUecF7J2IMEvoT
	 QmduSfVeQwcm8CDQ69mz5ckKscfcgsQ87WLRwa8oWIdz+7+JTaMs6ATrohnSUMOTLp
	 BzxyE9vRdvuXJ5JIEZnBocmCCqIVIKTDTneaIwknR0VvydA40BGfTgZV25bHlqiJf/
	 1Xx7fZbs9CoHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 423/638] media: pvrusb2: remove redundant NULL check
Date: Sun, 24 Mar 2024 18:57:40 -0400
Message-ID: <20240324230116.1348576-424-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 95ac1210fb2753f968ebce0730d4fbc553c2a3dc ]

Pointer dip->stream cannot be NULL due to a shift, thus remove redundant
NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c74e0062684b ("V4L/DVB (5059): Pvrusb2: Be smarter about mode restoration")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index c04ab7258d645..d195bd6a2248b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -1198,11 +1198,6 @@ static void pvr2_v4l2_dev_init(struct pvr2_v4l2_dev *dip,
 		dip->minor_type = pvr2_v4l_type_video;
 		nr_ptr = video_nr;
 		caps |= V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_AUDIO;
-		if (!dip->stream) {
-			pr_err(KBUILD_MODNAME
-				": Failed to set up pvrusb2 v4l video dev due to missing stream instance\n");
-			return;
-		}
 		break;
 	case VFL_TYPE_VBI:
 		dip->config = pvr2_config_vbi;
-- 
2.43.0


