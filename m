Return-Path: <linux-kernel+bounces-112236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314C088773E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01292823A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E498F5B;
	Sat, 23 Mar 2024 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="HxbItX1E"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94446A0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711175986; cv=none; b=pXR8F4rJFjGABrWugxN/SYCJvtHC1K5+1yJ4eT8DekOb7OZUqJWsu+g4APsHlyfxoDqeuzOPIOkcUiGS8EdHAQXLt03leKNBeitArFnzDev4w7WiKWBVi2uLwuhzbjlwGJWz1k2Fpl0Wxz6o3g2CeqN6T646MAMYQnVh1NyK4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711175986; c=relaxed/simple;
	bh=8Ru1KtR1m4ULexCA5WK3GVpaEyvcpR5jkF1JflcEVtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aq2tQSGiZbQNYKBxkZlYwL5pq5oYUOWBMb1DblnQA1ZpZzzIy9b+11g/8mJJuEfuFZmj0NF0ysHinvIk1aWJe5aKL/T4x3blHf+jsmKGav2u+/RJf18SeORQArVcUCrqFeaNvIj9WNk+TJJwIkofM/VfyG6mgkZW6YBRdhjz8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=HxbItX1E; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 639811C1413
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 09:39:38 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1711175978; x=
	1712039979; bh=8Ru1KtR1m4ULexCA5WK3GVpaEyvcpR5jkF1JflcEVtQ=; b=H
	xbItX1E7eNLuKU8HAcFtn+KjHLExvv1PNbmvQsMs6QYFmAHym9arCs/tsIfjOV4Q
	mLFdht/gwHOCPfz2vdyignBhtag/DWqVquG+TqaMgNHkhklD01R2NrFsLN4Fz+GE
	UEY3BFvx5IB1rTa5XiH+zEC+xYn9Hy/YvQyhBY6UJI=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0pRISDQqobYK for <linux-kernel@vger.kernel.org>;
	Sat, 23 Mar 2024 09:39:38 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 1C6961C11FE;
	Sat, 23 Mar 2024 09:39:35 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Karol Herbst <kherbst@redhat.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH] therm.c: Adding an array index check before accessing an element.
Date: Sat, 23 Mar 2024 09:39:33 +0300
Message-Id: <20240323063933.665695-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to access an element at index -1 if at the
first iteration of the loop the result of switch is equal to 0x25
Added variable checking.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
index 5babc5a7c7d5..78387053f214 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/therm.c
@@ -180,6 +180,8 @@ nvbios_therm_fan_parse(struct nvkm_bios *bios, struct nvbios_therm_fan *fan)
 			cur_trip->fan_duty = duty_lut[(value & 0xf000) >> 12];
 			break;
 		case 0x25:
+			if (fan->nr_fan_trip == 0)
+				fan->nr_fan_trip++;
 			cur_trip = &fan->trip[fan->nr_fan_trip - 1];
 			cur_trip->fan_duty = value;
 			break;
-- 
2.30.2


