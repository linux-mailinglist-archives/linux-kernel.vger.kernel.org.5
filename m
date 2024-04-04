Return-Path: <linux-kernel+bounces-132264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F6899234
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749CC1F2333C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8413C68C;
	Thu,  4 Apr 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXAZv0Y0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5A13C3CD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273870; cv=none; b=J+//XzSw45NEbwlK0AdFyHfllVfmORpHCDERNrho2UXTbfbcLOUWl9Z66qljBwrNYukr97XcSxoIMvTrp9JPeHDSKA4lLmlrwMkvGJSLhPir7hNz9LzVrwCt86b1I37xTLzRx4B6EwxPGmI2vHz0WHPUVB0A1p5VMF+CkeRQSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273870; c=relaxed/simple;
	bh=WcJWrWJTEgUMIOPaDLKTAVkcya3IzINrlG4fX0PdNjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFdE7GbrGIXjPQNA/bC6yW1jlcbk+qjGdGfyDltoXT1aSGXWWACoDrT+cajtJLhXrZk9dxCKTDC4tYl/zKr2OdsvFgqrFxIH5+wMg37wF1LrwehcQf1Jkof3Ev6S1TRLAPPX83rt2dceKaz8Szy2OVe1Hhh5pJ4rsw3EwMJrFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXAZv0Y0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712273867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ypcfm8f/5CHd95kPjs/R9gdMDLtVxLsgq1JjJ/htFQ=;
	b=NXAZv0Y04lqcVoSTxWBkv1RrpPXzgG7kr0EuYx8s6QuK6j0gxXRuuoAX29WaVqkAf7Qy/i
	UbFZJ2/hsYz7n9bwTf7Y1NbJiShSi8sYZ+j7aKS1thP8hsideY19p7+E/54lfC9Bqljzxo
	GCYJddzzGHzkwvYEvHp06XX1qMwWyCA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-6pLPrQW0MIqKHr5AwYWBFw-1; Thu, 04 Apr 2024 19:37:41 -0400
X-MC-Unique: 6pLPrQW0MIqKHr5AwYWBFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E8858007A3;
	Thu,  4 Apr 2024 23:37:41 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9873F8173;
	Thu,  4 Apr 2024 23:37:40 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/nouveau/kms/nv50-: Disable AUX bus for disconnected DP ports
Date: Thu,  4 Apr 2024 19:35:53 -0400
Message-ID: <20240404233736.7946-2-lyude@redhat.com>
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

GSP has its own state for keeping track of whether or not a given display
connector is plugged in or not, and enforces this state on the driver. In
particular, AUX transactions on a DisplayPort connector which GSP says is
disconnected can never succeed - and can in some cases even cause
unexpected timeouts, which can trickle up to cause other problems. A good
example of this is runtime power management: where we can actually get
stuck trying to resume the GPU if a userspace application like fwupd tries
accessing a drm_aux_dev for a disconnected port. This was an issue I hit a
few times with my Slimbook Executive 16 - where trying to offload something
to the discrete GPU would wake it up, and then potentially cause it to
timeout as fwupd tried to immediately access the dp_aux_dev nodes for
nouveau.

Likewise: we don't really have any cases I know of where we'd want to
ignore this state and try an aux transaction anyway - and failing pointless
aux transactions immediately can even speed things up. So - let's start
enabling/disabling the aux bus in nouveau_dp_detect() to fix this. We
enable the aux bus during connector probing, and leave it enabled if we
discover something is actually on the connector. Otherwise, we just shut it
off.

This should fix some people's runtime PM issues (like myself), and also get
rid of quite of a lot of GSP error spam in dmesg.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index fb06ee17d9e54..8b1be7dd64ebe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -232,6 +232,9 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	    dpcd[DP_DPCD_REV] != 0)
 		return NOUVEAU_DP_SST;
 
+	// Ensure that the aux bus is enabled for probing
+	drm_dp_dpcd_set_powered(&nv_connector->aux, true);
+
 	mutex_lock(&nv_encoder->dp.hpd_irq_lock);
 	if (mstm) {
 		/* If we're not ready to handle MST state changes yet, just
@@ -293,6 +296,13 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	if (mstm && !mstm->suspended && ret != NOUVEAU_DP_MST)
 		nv50_mstm_remove(mstm);
 
+	/* GSP doesn't like when we try to do aux transactions on a port it considers disconnected,
+	 * and since we don't really have a usecase for that anyway - just disable the aux bus here
+	 * if we've decided the connector is disconnected
+	 */
+	if (ret == NOUVEAU_DP_NONE)
+		drm_dp_dpcd_set_powered(&nv_connector->aux, false);
+
 	mutex_unlock(&nv_encoder->dp.hpd_irq_lock);
 	return ret;
 }
-- 
2.44.0


