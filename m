Return-Path: <linux-kernel+bounces-36670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A3E83A4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CE11C21C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C018C3B;
	Wed, 24 Jan 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQSOiGCL"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB618AF4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086727; cv=none; b=Kra7PF0iwHK0HHsCacfsKr0MpZkriqVppKyptZxJTk8rvsCVbQGYAtpHIxU8H21fhzZndmL1KNHaOhnb1P7xRRLMtO9bW6rdgyq4vLJCX5Rg6HxVMbqaVX0m7/poZ7HVWl1Tem1981P8gEvh+hQp7EfrIJoafcm2WHyz+d5kct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086727; c=relaxed/simple;
	bh=e83VYaOS+ohDX9NqoEmbl86kN06hJQqQLEN1Cb5MMwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4sDoyBtQIGQyd/Z2fBZwmEYTEbn7dIH9ZIoIK5vUvDtYyKWCELb2POYzuOEwWVeWr7Pm6Iwp6NAFddO+n6j8WIO5gw72kIx4gZ5EaZlc5yhuZl+LKvRHi7a0Ykj5mSrs70360RAnV8lP/TuUbfu5iUuSbPc0jfL4kqgXt04nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQSOiGCL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2901f9ea918so2776074a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086725; x=1706691525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCaG2FhLI+ULzJLYRzk2AkDEJ54d7JQsIyeO5H61ju8=;
        b=gQSOiGCL1lWkWvKcBJWgrWLyy/E4QawIZ6uQq1qT3Tp6p8ffUKypOvQNgOQW2ZU5SL
         OipukLKtD0wXCgFd1a8dNoihCiVDaRSPcbHBnThUZkc8mwJrkdC9OfxLGslRPH3bDo54
         wcO4XOPq2yN9djThvQ8uLO5DCid4X6WLfyf+d1ny7DCcsAyR5dETOlDuz/0x7+UqBGP7
         /XHqMHfOSP+znXhjOn5J7pzUVMiRFvzFWxHOrX+RY7eky9oGM3EmGlFDMc/ycgPFAq2f
         PiD5ismvOMwnaXToJv1ik2yujNmUAZDBeytdGqCdvXkkxRIEOG0hRTd0GP8pL9YK0ORp
         O4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086725; x=1706691525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCaG2FhLI+ULzJLYRzk2AkDEJ54d7JQsIyeO5H61ju8=;
        b=p2H8FtNhuG2rChrqKaX53NDsMPWcvT+Uk5kfwFe8W38P228+rZNTN6NkXIRHqKByC8
         ieuX8OwzcYSGHOuyVim44cPzoXx4bz+RaC/CHvny06OQlsebyTvOYKAOWshsTjM8Imaw
         HoQSIIgW86QjJ7ecCFoj2kl3tQa49vatsMW/OXndLKHMg/qRVrXdDhDTt4+IQYz/7P9f
         bcZswmkoadsVCdvHHKYP9OSYXgGHRePGDz0RdHnj0bq/KCod7Gj75y/cw2TWkLjFhZR6
         NfjalcLc1tKTKRjmm11Ni6WUbdd9HDUiss5cCSbYgvVc+060kzsSBNYHroOMv3MYSPjM
         aWGA==
X-Gm-Message-State: AOJu0Yxn7bX2wi68Au3sgkCEb9tROn6zb7HsAx1iKW+Vtz0P4z8YGNXi
	T64C/3H1a/oUpR9c/rSWik+X76dK6H96U3IWRanI7yiTGKSH5WT44/OF/3kk
X-Google-Smtp-Source: AGHT+IFPGrGWhb1Ny8AdbAA6Fc5MnoDmXHW5eNVLBfnh1MQ27z1kg/juqZ0/OXtEEa3QE6CQbT4kXQ==
X-Received: by 2002:a17:90a:e557:b0:28e:3817:5844 with SMTP id ei23-20020a17090ae55700b0028e38175844mr3326022pjb.42.1706086725407;
        Wed, 24 Jan 2024 00:58:45 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:44 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 3/3] virtio_net: Support RX hash XDP hint
Date: Wed, 24 Jan 2024 16:57:21 +0800
Message-Id: <20240124085721.54442-4-liangchen.linux@gmail.com>
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

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing XDP
hints through kfuncs to allow XDP programs to access the RSS hash.

1.
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2de46eb4c661..ed6a4aa3fe04 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4604,6 +4604,58 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+
+	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(&virtnet_xdp->hdr);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
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
+	*hash = __le32_to_cpu(hdr_hash->hash_value);
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
@@ -4729,6 +4781,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1


