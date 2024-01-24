Return-Path: <linux-kernel+bounces-36668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D183A4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1891C22FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48117C9E;
	Wed, 24 Jan 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwOz4IOU"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566DF17C6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086720; cv=none; b=aLipYiNJ2jSt0pssNAiQT8bABJroqKgK7oZBocGVY2h4qo7lzlYHtE+YvMvorkDZbaikDQ6enBiEDN9v02FFQl3/EKV0WReeGcFtUKnNl9PW14VDumVSQs/QrtNtULfPd80eK4chCk6kUlzwrW1j5iGGF1V4RoaIg/N5h2Ljuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086720; c=relaxed/simple;
	bh=og/4jZhQQp7y8j0tIvax0Xzi48W/KUOVqjDS1vcX2Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nH6bxMUXaiEcfz0nEDYt0etljMKnzFmSy7okeveh1xnrWkqK1Ii4FFxC6dlcPnhUw+6mX1ycnJR2JczkCAfCan8oVCKfs0uQT1Ugrrd0377UerMllJ/g3jDdYiOYrUfs5hM4cfIqenTxLUV0YHT21nHo/sZ0vxcRbCp7JoZx4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwOz4IOU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290617c6200so1974792a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086718; x=1706691518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPu6P60AtBzEJlySRcvQE2oYJV8KpvDM6ODg18dewI4=;
        b=UwOz4IOUauurk99hSrorKYBvmOgSvFSUIpT+pizqZHVJYVef0mnRfjRr6dhcLR9EI5
         8a9cwIhtgp///XId1jBL66nU4UEA/4oiOx73PnCtAoszqLC0B0nyNTOnIWThSthSQdVp
         w4yR1UVqS3Khoh08Hao7BMSRvAJptk5ZhIEUujKFZs7sdtoDnUWm/5J1BR1cWdJBvDhG
         d1IynuLpYAgDNi3jjOnJGMgosJix7GB+rvx6CP8XxYWyXnwfHAD5wq87PT6/koahg21C
         SiWb2jdfHYnNrBiySfnyzq92wUm7zkAIKpoxL4lP/KwCox27W+Vdtlir+4aLpymqp80T
         l9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086718; x=1706691518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPu6P60AtBzEJlySRcvQE2oYJV8KpvDM6ODg18dewI4=;
        b=wF19RRXhS/Ri33D3a9fil9lOgQM7SMOsi8KDx5cc6FEmDDuaEm5JerJO51vTftyFhG
         OlFoDal9cmpCbRIYTeBYtUVnKwWITsH23nM528iLhkpGD4H/JeNdRH5h6so6WH+v7/Rl
         GnCKhCm9XojH3BJGc5vOjNSiYmjSK2HZblVU2q3FUX2wiNEesApwTenFQCZHYW95Ctfz
         yj9aJ4nOdh+t2or0cAv/6vG4xCsDlINaYGTMH3FNoQsiV3qghuejLJ7LGAld7QmR1UUG
         5PVGCQPJm48E6dxBZL/KZFahy7gg+HE+0SFVulbNY6gC6PKg4qaKPKBAcvvgfVdfbve3
         Lnvg==
X-Gm-Message-State: AOJu0YxSwZBMk9mwOozTFJuRcbtUC0Uu83YqxrY3uL+YXZ2v+E21Nzf7
	tRW2wsRSFw+O1DpoYuO1IneKoMqpAMp0k5c4vhF4AWlR86/uAtVn
X-Google-Smtp-Source: AGHT+IGtaFk86gI0X1es3cazO+4bzDFE1/1zDKanQ1edDEL19O1uyHYitentoQwv3rAZxhz4ey3lCw==
X-Received: by 2002:a17:90a:ba8a:b0:28e:84eb:2958 with SMTP id t10-20020a17090aba8a00b0028e84eb2958mr3190942pjr.76.1706086718519;
        Wed, 24 Jan 2024 00:58:38 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:37 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 1/3] virtio_net: Preserve virtio header before XDP program execution
Date: Wed, 24 Jan 2024 16:57:19 +0800
Message-Id: <20240124085721.54442-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124085721.54442-1-liangchen.linux@gmail.com>
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xdp program may overwrite the inline virtio header. To ensure the
integrity of the virtio header, it is saved in a data structure that
wraps both the xdp_buff and the header before running the xdp program.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 43 +++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..b56828804e5f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,11 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	struct virtio_net_common_hdr hdr;
+};
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -1199,9 +1204,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
+	struct virtnet_xdp_buff virtnet_xdp;
 	struct page *xdp_page;
+	struct xdp_buff *xdp;
 	unsigned int buflen;
-	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	unsigned int metasize = 0;
 	u32 act;
@@ -1233,17 +1239,23 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp = &virtnet_xdp.xdp;
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	/* Copy out the virtio header, as it may be overwritten by the
+	 * xdp program.
+	 */
+	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		len = xdp.data_end - xdp.data;
-		metasize = xdp.data - xdp.data_meta;
+		len = xdp->data_end - xdp->data;
+		metasize = xdp->data - xdp->data_meta;
 		break;
 
 	case XDP_TX:
@@ -1254,7 +1266,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb))
 		goto err;
 
@@ -1591,10 +1603,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
+	struct virtnet_xdp_buff virtnet_xdp;
 	unsigned int xdp_frags_truesz = 0;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
-	struct xdp_buff xdp;
+	struct xdp_buff *xdp;
 	void *data;
 	u32 act;
 	int err;
@@ -1604,16 +1617,22 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	xdp = &virtnet_xdp.xdp;
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	/* Copy out the virtio header, as it may be overwritten by the
+	 * xdp program.
+	 */
+	memcpy(&virtnet_xdp.hdr, hdr, vi->hdr_len);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
 		return head_skb;
@@ -1626,7 +1645,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(xdp);
 
 err_xdp:
 	put_page(page);
-- 
2.40.1


