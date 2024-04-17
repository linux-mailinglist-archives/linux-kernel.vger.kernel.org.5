Return-Path: <linux-kernel+bounces-148158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519158A7E78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832291C211B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCF127B57;
	Wed, 17 Apr 2024 08:40:10 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BA9607EF1B;
	Wed, 17 Apr 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343209; cv=none; b=kzB1gYr1ABQu1uQQIPdTTSJRVR0YcpBfwkgj5XBetPPTVbEKPUPIl+7yuejNmdw4u76o/gO81SCQTpoIE4vJuM84mBdilwk/31LxYf8Up59Vw5/gNCrxF3fVII1PoX70ElT/z+4srOiZn0k16DCIcDbbWg+InZbLWR/PRSF/I6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343209; c=relaxed/simple;
	bh=bkdtrhw2AnU57Efat4BsX7bkcfARUcoIOhyRCKyW95E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJY5sH6+eVR9vC0sK5CRQUqGW+YJiA9kdiYxSJ1852yluY4f1YfwqZERfUV4uHgC0rS4wa/3YAttUOFOWBszFLVQGMeXJjqBttbRIpmZ9GVVgKu4PcYb8+3CsS7lr5eoEN8gWNOZsSbZ0UoGE/FHUmffC6kIOb+gO09CfFdZBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id BBB506061BF4E;
	Wed, 17 Apr 2024 16:39:47 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	bskeggs@redhat.com,
	airlied@redhat.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/nouveau/disp: fix an error problem in nvkm_uconn_new()
Date: Wed, 17 Apr 2024 16:39:21 +0800
Message-Id: <20240417083920.2256027-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang Static Checker(scan-build) Warning:
drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c:line 215, column 4
Value stored to 'ret' is never read.

Return the error code rather than zero when 'conn->info.type' has an
unknown type.

Fixes: 8b7d92cad953 ("drm/nouveau/kms/nv50-: create connectors based on nvkm info")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
index 2dab6612c4fc..6a67d307bf79 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
@@ -213,13 +213,14 @@ nvkm_uconn_new(const struct nvkm_oclass *oclass, void *argv, u32 argc, struct nv
 		default:
 			WARN_ON(1);
 			ret = -EINVAL;
-			break;
+			goto err;
 		}
 
 		nvkm_object_ctor(&nvkm_uconn, oclass, &conn->object);
 		*pobject = &conn->object;
 		ret = 0;
 	}
+err:
 	spin_unlock(&disp->client.lock);
 	return ret;
 }
-- 
2.30.2


