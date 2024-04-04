Return-Path: <linux-kernel+bounces-132265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF66899235
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B88289FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CE13C697;
	Thu,  4 Apr 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAz4JB/2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEE13C66F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273870; cv=none; b=MVVts4Es4H/MdIYmgwq7A2yeIma5p5KaftQJhNkVl6AJ6CkQyRXZl4f0ZwPccjsJiF+8Ar8PbcJJQ+YmaXtW3BK57h6yTUXyUVkS2mIKSr+65piL29XVgAMWBoDbETjqkfFoRv4qxG0RQFbvNQl/PXYFoXhYOzqSIPqbg7XqhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273870; c=relaxed/simple;
	bh=LpKJp577/TjDusKjKLzpsZI2h6/FFOW3ygGeMD9cx6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+YIrshggG0RfXvoWy6OjPHdH+jwuqakB7y3LiJiKxC7ZV6nKpm6xlDrFNh7+OHscw7kW7C9BfMBt0VKpBLDER97r1DtOxNVjaIyNubs4COgu30Pq2erGnp7N4lu2hkmZfxnYcSBz147nJQMtw46BQqjQKT/OsoCm5lnObl+bAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAz4JB/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712273868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UH0SdUkY0Y7wcvIlBfPcVRXDNk9BBU7t+uEZjzSWyug=;
	b=CAz4JB/2h9/OwDG3y4uqcvVsWHlgZuRkz7qlFCYqobchm4R65eANxbP/1vZA2K1436NB2V
	//OVk421+ozTGUdW6ryn99YPCeNbUqPHD8IwFtRi/D3rB6I8rjnchXs7cs3bjBbwhgxPkm
	B6X+8MHJ+IDd4sz4p9GOrPIM7Ix/RB0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-EqSQlcGjNlGdio4Ofq0TTQ-1; Thu,
 04 Apr 2024 19:37:42 -0400
X-MC-Unique: EqSQlcGjNlGdio4Ofq0TTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 610D33C0219B;
	Thu,  4 Apr 2024 23:37:42 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB34D10E4B;
	Thu,  4 Apr 2024 23:37:41 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/nouveau/dp: Don't probe eDP ports twice harder
Date: Thu,  4 Apr 2024 19:35:54 -0400
Message-ID: <20240404233736.7946-3-lyude@redhat.com>
In-Reply-To: <20240404233736.7946-1-lyude@redhat.com>
References: <20240404233736.7946-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

I didn't pay close enough attention the last time I tried to fix this
problem - while we currently do correctly take care to make sure we don't
probe a connected eDP port more then once, we don't do the same thing for
eDP ports we found to be disconnected.

So, fix this and make sure we only ever probe eDP ports once and then leave
them at that connector state forever (since without HPD, it's not going to
change on its own anyway). This should get rid of the last few GSP errors
getting spit out during runtime suspend and resume on some machines, as we
tried to reprobe eDP ports in response to ACPI hotplug probe events.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 8b1be7dd64ebe..8b27d372e86da 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -225,12 +225,16 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	u8 *dpcd = nv_encoder->dp.dpcd;
 	int ret = NOUVEAU_DP_NONE, hpd;
 
-	/* If we've already read the DPCD on an eDP device, we don't need to
-	 * reread it as it won't change
+	/* eDP ports don't support hotplugging - so there's no point in probing eDP ports unless we
+	 * haven't probed them once before.
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    dpcd[DP_DPCD_REV] != 0)
-		return NOUVEAU_DP_SST;
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (connector->status == connector_status_connected) {
+			return NOUVEAU_DP_SST;
+		} else if (connector->status == connector_status_disconnected) {
+			return NOUVEAU_DP_NONE;
+		}
+	}
 
 	// Ensure that the aux bus is enabled for probing
 	drm_dp_dpcd_set_powered(&nv_connector->aux, true);
-- 
2.44.0


