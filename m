Return-Path: <linux-kernel+bounces-38377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02F83BE81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE81F22B02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6D1CA89;
	Thu, 25 Jan 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioOa/ID1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398771CA80
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177967; cv=none; b=slUPYhox+YskJhmZ8c+wjIAU7ta0xp6DCMHN2dfbvAiXK9nJj/gf0DVkyKSjlpzUlxXTaQfiEq+smIUbboFTc7HtfRTeNy4bdEaDKTndjcHWQpC4mrOnQBwLNSxVCKXO51sO04hDJvMYl9JUhaPYHS+ufea5WSn+UUs5SImAH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177967; c=relaxed/simple;
	bh=hE5xFIUQ4PHRjUDMHfJgA1f0UCIs24/GjLNsgi3xbLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dZb0nksNCtlIljLWZggxqjexXd8vYBTSmKaA2FpuWjk7jKUYB/bOUyalcHCosXUMBLGab04o07DYQpoc1ExQ8798hmcC0oSJ/4Pf4giW+y69NfB/+Pl4jbGAOtkM/vrv8IQ3wBiO5AV32x20IPgR14YY4WeqElOSQK1pTE0JQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioOa/ID1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7858a469aso10618555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177965; x=1706782765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfoTf/pNUqDMOG+odoDF+tGW4cWN9ShhMkF37xIQK6o=;
        b=ioOa/ID1WrG0PmWWuCZiRAFMZxw1WuEjRn5kg+fId1ozmmQKJUQToC75TzcL/4TGim
         us4FxVbbtBkSnsEWvCrIcIfJdVEq3XLzqRndV/YfL7aLL2LkOFfmVBICYm4BGEIj1MX0
         Uvt40VUhwGXjmu3OUuyrBqGNvkMUPgpFfYwe6DzBlOnwuqG72J3vGmP14uni15M9JYvD
         zcLyDQdNS6ATiIZIlhZvGsRBNvDUeVF4uBUyFyKvbd78BQ4wdEwQHdzB9XiiZDJjS3yZ
         JtEyGN1JE7zbqXledCE1HCFrnX/FCyBdQI3FSnzJMeKpVUX1iSuI6mg2roZwvsy0zRKV
         we1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177965; x=1706782765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfoTf/pNUqDMOG+odoDF+tGW4cWN9ShhMkF37xIQK6o=;
        b=TlJASqRblO4qCF8kIqR/gYXfED3oTvAX1DA3wCA5lOy+7kk8xbLd5uodOtIUjGtK/D
         HVQTitEm5lu+4qTuAFV+Z9OzbcQIO8rJiqKJp7/flT8E40Hm3ne4txtG5ceJYHULMkAS
         CxkyAdnqwIU6P2WuW2asn+yXUPRztv5DZoNv/0k+1ykELQBCOc4TicXsCJ6tKdrhj+kP
         4SrZ2a2NqXqIn8h0+NpML87wypZ4BiJFaEeSHTK7DTTItUcR2YMCxY9Y1EmHVYcUCwo3
         sNr45yDC8wZJ18r9i1BX4r1hT8hDsCYPdlXeXhrJvQTNK0wI5rEwICOpykE44ly4/ZWo
         QrZg==
X-Gm-Message-State: AOJu0YxfmAF+I48BAw5ATi9liwX9MW7Dbfl06JTdxwUTjU7tYvJmtgVr
	rS5h8iM9rPU/7FY2cmD+JaRNh7X1tLij28IVR21cJTtIpJXWW5gN
X-Google-Smtp-Source: AGHT+IHk0njQQrZP5z7OFk5FXN3BHZ0SZ2HvfxrSC+RKWKm/c3czuPnQFrVhrTZkEEqUW3PaHIvTzw==
X-Received: by 2002:a17:902:e80c:b0:1d5:bc48:c0fa with SMTP id u12-20020a170902e80c00b001d5bc48c0famr763320plg.0.1706177965344;
        Thu, 25 Jan 2024 02:19:25 -0800 (PST)
Received: from localhost.localdomain ([45.58.187.66])
        by smtp.googlemail.com with ESMTPSA id 12-20020a170902c24c00b001d770328a05sm3904913plg.36.2024.01.25.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:19:24 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v3] virtio_net: Support RX hash XDP hint
Date: Thu, 25 Jan 2024 18:19:12 +0800
Message-Id: <20240125101912.60346-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing
XDP hints through kfuncs to allow XDP programs to access the RSS hash.

1.
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..0c845f2223da 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	u32 hash_value;
+	u16 hash_report;
+};
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 	}
 }
 
+static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
+				     struct net_device *dev,
+				     struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	if (dev->features & NETIF_F_RXHASH) {
+		virtnet_xdp->hash_value = __le32_to_cpu(hdr_hash->hash_value);
+		virtnet_xdp->hash_report = __le16_to_cpu(hdr_hash->hash_report);
+	}
+}
+
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
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
@@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp = &virtnet_xdp.xdp;
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
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
@@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb))
 		goto err;
 
@@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
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
@@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	xdp = &virtnet_xdp.xdp;
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
 		return head_skb;
@@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(xdp);
 
 err_xdp:
 	put_page(page);
@@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
+
+	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	switch (virtnet_xdp->hash_report) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		*rss_type = XDP_RSS_TYPE_L3_IPV4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = virtnet_xdp->hash_value;
+	return 0;
+}
+
+static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
+	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1


