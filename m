Return-Path: <linux-kernel+bounces-36669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CB83A4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983CF1F2330D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A351863E;
	Wed, 24 Jan 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlD4W8ke"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE3182DA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086723; cv=none; b=TzjaWKCUZp06CQUO56XT5OLs21HmPpdVDoirdRrrEQeTxPrxWKY0jd3Ao6tPz6+NwwLby42/eu2ax71LKggtqMqhV3EXra+7McfCJl1Si/oYBaqbF9OgM29+0uYScrpA6K+Wy5x7IP9cCXU3s795HyjESJfkF1/kG/DFr3gJ0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086723; c=relaxed/simple;
	bh=pm9aMyhWNz9rm/sMj0oyg9mmTCbkXLENoPmkXenNn3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fC3sB4Q5k2gl07A1hIke/Fhc80F2wdtxBnVXTcTCRpYfxIBC3mRIp29cz1IIA7h+lm9xvD19LU4OZtjKE6BSa1LqEsFiTSFmBl9pGNXQDWpO/6k+aQgjYxXmB15UI11fVPIKOPMkPuGbTKxbCSufDUtWBD8Nx0RqaqgaljQekG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlD4W8ke; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2018187a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086722; x=1706691522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK0KBx9FD+Y1tESpbZmNKfn63bqMoyAe4iVd1hNTd0Y=;
        b=nlD4W8kepWzKECg4cPaDiWdjIaMZMAt8wWOpFBUfSBP97jEUcpgy50wGo+S5q/jUKq
         GjJVkbjOwxvYl0sXA+pfnd33bNhD/Vo7xJmReimGqDy5E4kT4yN+k2Sz8OVImpfJyzR4
         IkvumnBJik7asTQxYaWtCENVqx1fB3Ykmd8d0ikwTUhO9bw7PLmEOSubTDNyhGUMVbJd
         186C8KhlkMtDdfIP5lf8ZTWamyU8iIfkxv+4y4ObPe2Z8qtE2z8Cy8UNlNIK4iqO6TKn
         0o/uFbc7izvukHd8dRL8UUZxWj0L9wAQelmXvZX1CLAZNfAxtqnGHXt/oXk4KhcTs+sC
         hmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086722; x=1706691522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK0KBx9FD+Y1tESpbZmNKfn63bqMoyAe4iVd1hNTd0Y=;
        b=nRjxVdZbvBLO7FLBGWD5EKrS4Z/2qBITkptfeXLQElPHNC25QxTpEZlK7tsVPd4aVM
         6K5hlVND/rTOou2myY9XMqsvLBZk4tRs4MHNpevBoJ1/A2ogAXwUchimg6dj+KOp5JJL
         2su9Sdg32FbW6Y5HDR8Uc7EX6bP3BtfvUzCwMQyesQZU7ZT1pOwORhH1Q4pLSBPWCqBW
         D/OqOFL4EAJ52rZVXZVuA6iaPTI74mlUD/VsJUhle9YDNvR1fJVyd94zOvlGBecsH+nn
         WKYzZU8op1vGtOhpRLVsg6E3Prfl2x1Ku/v84Un6J1VjjxwZicewABvy9Z5ENReDyg9d
         wjjQ==
X-Gm-Message-State: AOJu0YyXuvTZQbiB+GjeRN+U0hq9sc5WjnjpSMQt2Mu10oEG6CFCYlAJ
	HEWvqKl3hJEfn3SYJGIH1BngE8HHFfz4JY8rHk1xSyHNoUULCoZ4
X-Google-Smtp-Source: AGHT+IGdbtmBHlh771/e7XW80WboOCEY8KIq0A7Cki/4uv3/prXelAx6n10SWNOjukoJlGlxbzdHJQ==
X-Received: by 2002:a17:90a:880b:b0:28d:1e38:88f8 with SMTP id s11-20020a17090a880b00b0028d1e3888f8mr4079930pjn.41.1706086721888;
        Wed, 24 Jan 2024 00:58:41 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:40 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
Date: Wed, 24 Jan 2024 16:57:20 +0800
Message-Id: <20240124085721.54442-3-liangchen.linux@gmail.com>
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

For the XDP_PASS scenario of the XDP path, the skb constructed with
xdp_buff does not include the virtio header. Adding the virtio header
information back when creating the skb.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b56828804e5f..2de46eb4c661 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (unlikely(!skb))
 		goto err;
 
+	/* Store the original virtio header for subsequent use by the driver. */
+	memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);
+
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
@@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		/* Store the original virtio header for subsequent use by the driver. */
+		memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, vi->hdr_len);
+
 		return head_skb;
 
 	case XDP_TX:
-- 
2.40.1


