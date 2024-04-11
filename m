Return-Path: <linux-kernel+bounces-139767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8088A0779
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01631F25B56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFE13C838;
	Thu, 11 Apr 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1rREFgdx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3313C677
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812305; cv=none; b=gm7UZ9osyU0g8CQIRuWoOYVFh/aHd5CpwH/WxXkvRUIr/K1WKaY81cR+AEHnzhadN1bJDoL6vADXhAMrh7uULRsNmd9UXOjp1nfc0h4EQMcy9IAHT+lKU3WSU6s+QmBCSbPOYisZrg6BtxkCa7eyaK9N8JUxlHunRwBe1DsDzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812305; c=relaxed/simple;
	bh=INBV2mahBvEZ0pXdVK6kq2mH2wTkMLEIS7chTpd0RqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9Nvw4qt2uGgn6fnSR3NKZXUyQndOmiLEVVslysGzBvGR/0tC7Q+IIRt2KabzcYX7oTPV79Z0QL5DDg7rqbrhjKXif3mYAJS4nbI4KgQh87t5qLlcVWPzsVe3yKucYafkes8JBTYFf9WL9rfcfQ2pVn0asrMtPxe8v1XIqpZaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1rREFgdx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-417d029bee7so3530595e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712812302; x=1713417102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5ZhdZB/gpv+gPuYKJ564BUXU+lbyNInoIF4+Wr2Rh0=;
        b=1rREFgdxuOv6VjInu1xg2LvxbOS8XD7UhKZKErRRxBQ0SdUqQEQijrWbGgM9Mr1keg
         QbxwcbWj2SrTcOCN1sa9dZVeqTh5puO3OcOFcYcibeWhTgPBNdIkVLoAPh5DvQMZOyml
         nS5Q+EL3L98TYqXX37OKaD7by940WZyy4859rAKOJMuJCCUvOM74HROcIid2rPrtYrtj
         JW7M2oeY+4EgDYmGhG2r0pbZPa2iiKsEWOflVbRwMAWIe/lVsTHTtZ+C288rJp31D2gD
         xa8BUbyu9JubRbeGpplNw64vLW53Y7G5aqmnQutbMl7bB3HjcOAAnWoxa5UiAVny44j9
         39/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712812302; x=1713417102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5ZhdZB/gpv+gPuYKJ564BUXU+lbyNInoIF4+Wr2Rh0=;
        b=h7fmJvXhS69+CDv9Q6a4qED1LcnWs00xW5P53czaS34qJdzAEJNy4W1OpTZrselBoq
         VFS7gWTRZgYXzqQiHft8DRuLQ8EhEVvBzyGZv9JaYvpeOG/ZZGdxbI40tRbI1weo0/ux
         9ft1xrGIIamaO/px00VGWqKqGc6kZ1D5cgdVCR75ufigefVFX44G6Xi6PnHvUkcL7ylx
         ts7dxjDCyrJorOdVf0u/JmKXhD3hBmII7NJ74VyIeX2xpN/Rl4a4I7IOU+kbIQ358aOU
         y2MrCWcWmBdOBpFEzpVJKdiFj4yPqhuRci3Beqvq8IzA+3eP6QImNz1gEEcfF3cUiARF
         3VJQ==
X-Gm-Message-State: AOJu0YydOIaZmv88X4NlXHIIc5vccGXsSf8yGBCjoX8I3SZrQSeVWYeQ
	pW7edUNMm4mp5cogmRwpVdfqbEFCbIjX0ZRPB20lFT/W+FQZmpuTTbQo9KnfcZY=
X-Google-Smtp-Source: AGHT+IGFSs4+lFkJzhv15sz2leal19RrvvnFEMmW5D28SvBfMhGgBRbh9EdRGJYs/wX7rh2P3//G9g==
X-Received: by 2002:a05:600c:45ca:b0:417:4ff3:3872 with SMTP id s10-20020a05600c45ca00b004174ff33872mr2551640wmo.25.1712812302165;
        Wed, 10 Apr 2024 22:11:42 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:46c7:8900:15f8:24e1:258e:dbd5])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b0041622c88852sm4370190wmq.16.2024.04.10.22.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 22:11:41 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yan@daynix.com,
	andrew@daynix.com
Subject: [PATCH net v2 1/1] net: change maximum number of UDP segments to 128
Date: Thu, 11 Apr 2024 08:11:24 +0300
Message-Id: <20240411051124.386817-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411051124.386817-1-yuri.benditovich@daynix.com>
References: <20240411051124.386817-1-yuri.benditovich@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit fc8b2a619469
("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
adds check of potential number of UDP segments vs
UDP_MAX_SEGMENTS in linux/virtio_net.h.
After this change certification test of USO guest-to-guest
transmit on Windows driver for virtio-net device fails,
for example with packet size of ~64K and mss of 536 bytes.
In general the USO should not be more restrictive than TSO.
Indeed, in case of unreasonably small mss a lot of segments
can cause queue overflow and packet loss on the destination.
Limit of 128 segments is good for any practical purpose,
with minimal meaningful mss of 536 the maximal UDP packet will
be divided to ~120 segments.
The number of segments for UDP packets is validated vs
UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
quest-to-guest path but does affect packets sent to host, for
example.
It is important to mention that UDP_MAX_SEGMENTS is kernel-only
define and not available to user mode socket applications.
In order to request MSS smaller than MTU the applications
just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
no limitations on socket API level.

Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/udp.h                  | 2 +-
 tools/testing/selftests/net/udpgso.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 3748e82b627b..7e75ccdf25fe 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -108,7 +108,7 @@ struct udp_sock {
 #define udp_assign_bit(nr, sk, val)		\
 	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
 
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 1d975bf52af3..85b3baa3f7f3 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 #endif
 
 #define CONST_MTU_TEST	1500
-- 
2.40.1


