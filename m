Return-Path: <linux-kernel+bounces-47911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C511845483
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB9C28AB9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0C4DA0F;
	Thu,  1 Feb 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjuBYTIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B43C468
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780885; cv=none; b=CTvEPyXYiqhNM63jn0l2btLE2nuFjadUig/9hBIlUGEo3IVNywWjvPgy44DR5WKHmcILHmnWmzjgYrGN8XvTi31AwEQ6xYnep/niJAbAF1Jg2J/NbmoQKIUMYcWJq/KU3ozyKeg+m0xT79OYzEShxXk5vDkN7RoYYcQVBPzbh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780885; c=relaxed/simple;
	bh=W8ueSTQV9H7E/wwgKuME47isVu3e6OuRVGwZ2kTJe4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWYRdbh0pP3IFk6Q+bfSrcarZ3dV85VWfeXsAeRb9wyVb1x5kaqKjO+ukdXD6ODLhHQgXjWcw8z279KA4GQIi2eYyjOJ13d+bUgBEoLGw5R0gNFHtyJlMoD9YGbxFDAY8g+/s96NwALWvqWs+uLmgwEDcrK7UFM5Q4e51e6GJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjuBYTIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706780882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FJgqeoCkyruSUGWxSYUKZ7d4Y/5G+4ikFi2lBwdoA7E=;
	b=FjuBYTIE9n2a00Z0z9nAsJ6P4NyqsDrK1xCdbdtzWlEMgtDsn/MtNKQgoDI2dRQTPNP1My
	hbEPuJte3xe59LIhUKovhOcDPhH3tnrRZdHqshieoXkpXjCLu2ok44ba9y63yyjDLSB8cG
	xDWlhri8KcIWpkTvHNC1CIR09CD6pLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-s17VHR53PCmLTjArLwOQjw-1; Thu, 01 Feb 2024 04:47:59 -0500
X-MC-Unique: s17VHR53PCmLTjArLwOQjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1238881C81;
	Thu,  1 Feb 2024 09:47:58 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.38])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1451C060AF;
	Thu,  1 Feb 2024 09:47:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Egor Pomozov <epomozov@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
	Sergey Samoilenko <sergey.samoilenko@aquantia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: atlantic: Fix DMA mapping for PTP hwts ring
Date: Thu,  1 Feb 2024 10:47:51 +0100
Message-ID: <20240201094752.883026-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Function aq_ring_hwts_rx_alloc() maps extra AQ_CFG_RXDS_DEF bytes
for PTP HWTS ring but then generic aq_ring_free() does not take this
into account.
Create and use a specific function to free HWTS ring to fix this
issue.

Trace:
[  215.351607] ------------[ cut here ]------------
[  215.351612] DMA-API: atlantic 0000:4b:00.0: device driver frees DMA memory with different size [device address=0x00000000fbdd0000] [map size=34816 bytes] [unmap size=32768 bytes]
[  215.351635] WARNING: CPU: 33 PID: 10759 at kernel/dma/debug.c:988 check_unmap+0xa6f/0x2360
..
[  215.581176] Call Trace:
[  215.583632]  <TASK>
[  215.585745]  ? show_trace_log_lvl+0x1c4/0x2df
[  215.590114]  ? show_trace_log_lvl+0x1c4/0x2df
[  215.594497]  ? debug_dma_free_coherent+0x196/0x210
[  215.599305]  ? check_unmap+0xa6f/0x2360
[  215.603147]  ? __warn+0xca/0x1d0
[  215.606391]  ? check_unmap+0xa6f/0x2360
[  215.610237]  ? report_bug+0x1ef/0x370
[  215.613921]  ? handle_bug+0x3c/0x70
[  215.617423]  ? exc_invalid_op+0x14/0x50
[  215.621269]  ? asm_exc_invalid_op+0x16/0x20
[  215.625480]  ? check_unmap+0xa6f/0x2360
[  215.629331]  ? mark_lock.part.0+0xca/0xa40
[  215.633445]  debug_dma_free_coherent+0x196/0x210
[  215.638079]  ? __pfx_debug_dma_free_coherent+0x10/0x10
[  215.643242]  ? slab_free_freelist_hook+0x11d/0x1d0
[  215.648060]  dma_free_attrs+0x6d/0x130
[  215.651834]  aq_ring_free+0x193/0x290 [atlantic]
[  215.656487]  aq_ptp_ring_free+0x67/0x110 [atlantic]
..
[  216.127540] ---[ end trace 6467e5964dd2640b ]---
[  216.132160] DMA-API: Mapped at:
[  216.132162]  debug_dma_alloc_coherent+0x66/0x2f0
[  216.132165]  dma_alloc_attrs+0xf5/0x1b0
[  216.132168]  aq_ring_hwts_rx_alloc+0x150/0x1f0 [atlantic]
[  216.132193]  aq_ptp_ring_alloc+0x1bb/0x540 [atlantic]
[  216.132213]  aq_nic_init+0x4a1/0x760 [atlantic]

Fixes: 94ad94558b0f ("net: aquantia: add PTP rings infrastructure")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c  |  4 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 13 +++++++++++++
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index abd4832e4ed2..5acb3e16b567 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -993,7 +993,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	return 0;
 
 err_exit_hwts_rx:
-	aq_ring_free(&aq_ptp->hwts_rx);
+	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1011,7 +1011,7 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 
 	aq_ring_free(&aq_ptp->ptp_tx);
 	aq_ring_free(&aq_ptp->ptp_rx);
-	aq_ring_free(&aq_ptp->hwts_rx);
+	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 
 	aq_ptp_skb_ring_release(&aq_ptp->skb_ring);
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index cda8597b4e14..f7433abd6591 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -919,6 +919,19 @@ void aq_ring_free(struct aq_ring_s *self)
 	}
 }
 
+void aq_ring_hwts_rx_free(struct aq_ring_s *self)
+{
+	if (!self)
+		return;
+
+	if (self->dx_ring) {
+		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
+				  self->size * self->dx_size + AQ_CFG_RXDS_DEF,
+				  self->dx_ring, self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
+}
+
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 {
 	unsigned int count;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 52847310740a..d627ace850ff 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -210,6 +210,7 @@ int aq_ring_rx_fill(struct aq_ring_s *self);
 int aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
 			  struct aq_nic_s *aq_nic, unsigned int idx,
 			  unsigned int size, unsigned int dx_size);
+void aq_ring_hwts_rx_free(struct aq_ring_s *self);
 void aq_ring_hwts_rx_clean(struct aq_ring_s *self, struct aq_nic_s *aq_nic);
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data);
-- 
2.41.0


