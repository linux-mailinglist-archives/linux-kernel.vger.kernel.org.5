Return-Path: <linux-kernel+bounces-104934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFA87D616
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EACD1F23835
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E6548FD;
	Fri, 15 Mar 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+PGrWOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F9481BA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537676; cv=none; b=XrUFJqw02LOCUZRmP+94GNKlkBGchoJeTDT8u13RjmVcx5INh9R7XynHdsjH4NSXINHu7lV1UXIZdY2oN6aY0qdLlrfUmZ7iPs2K9QIJ+9/cfnxaWW3JhuBjW/IfxTOIxcgt/TEh8eLR7f6rUNO/5z9rMRADhafGupoHDF78o88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537676; c=relaxed/simple;
	bh=Iij2KNt5I3VV8FPfKU4+LLHyyijdJAkGP9oZxOUj4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3V18g5YKxyuDfyAaX2LgGXJA8UWKmK76i2vcTzWw3H1aQSczMy4xOToE4dqOuhnXqsFborFY5mzHQk/oenfPyfYAOgpRIw4t06Fwcyvp7pE9GNsC2nFj3FOqA/f/yhA5/K4wFEQu36QIePFj03veZaZ3fmvOuzhARkeq+VMOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+PGrWOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710537673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uWWH3DahxJ2nBN/Bu4D0efrmCV07cU3Ea/yIHo4hP08=;
	b=P+PGrWOj6d9fvGeqo2MK935ywEdEScd1VJNTo07BtMgitWQteBpEoRCmfFkl6N/bNObu/H
	o1LsaebyMVTUgl1rnGxgg6fvqqrN0Fgu8Q1u70G3w1H4z4wMhVXUFCcHvClj4WGGA5zVN3
	usx9w046NyUG6FYvaxGKXrLJU59h2Lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-eCBD3m3rN-CyA72eU5p7kg-1; Fri, 15 Mar 2024 17:21:11 -0400
X-MC-Unique: eCBD3m3rN-CyA72eU5p7kg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F6B8007A4;
	Fri, 15 Mar 2024 21:21:11 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.8.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B20AC492BC6;
	Fri, 15 Mar 2024 21:21:09 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/dp: Fix incorrect return code in r535_dp_aux_xfer()
Date: Fri, 15 Mar 2024 17:20:56 -0400
Message-ID: <20240315212104.776936-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

I've recently been seeing some unexplained GSP errors on my RTX 6000 from
failed aux transactions:

  [  132.915867] nouveau 0000:1f:00.0: gsp: cli:0xc1d00002 obj:0x00730000
  ctrl cmd:0x00731341 failed: 0x0000ffff

While the cause of these is not yet clear, these messages made me notice
that the aux transactions causing these transactions were succeeding - not
failing. As it turns out, this is because we're currently not returning the
correct variable when r535_dp_aux_xfer() hits an error - causing us to
never propagate GSP errors for failed aux transactions to userspace.

So, let's fix that.

Fixes: 4ae3a20102b2 ("nouveau/gsp: don't free ctrl messages on errors")
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
index 6a0a4d3b8902d..027867c2a8c5b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
@@ -1080,7 +1080,7 @@ r535_dp_aux_xfer(struct nvkm_outp *outp, u8 type, u32 addr, u8 *data, u8 *psize)
 	ret = nvkm_gsp_rm_ctrl_push(&disp->rm.objcom, &ctrl, sizeof(*ctrl));
 	if (ret) {
 		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
-		return PTR_ERR(ctrl);
+		return ret;
 	}
 
 	memcpy(data, ctrl->data, size);
-- 
2.43.0


