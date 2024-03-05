Return-Path: <linux-kernel+bounces-92220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB11871D01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E4C2859FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911958ABA;
	Tue,  5 Mar 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XBkOqmoy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCC957321
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636911; cv=none; b=dJzrcV3QeNLcnI69Zlsd103Va/rksOzFGFIvzbqQtCk22jL/Nt6oD3naIX6w6Apqz0YkTUcd0RcOdvMvFstAFTYG4HULSMSV2uD41d/Ezw4W7rWqNNYdY2Aw7iLUqKO4xgzCsITLDdT/bjmDUc8NHjxOyLEqUxjjBZ8CsOoNGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636911; c=relaxed/simple;
	bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWc+sCHs/lRntXNObb3zPX6pxhXvDJdfuHFkmxF+hWMUfzbHXQKfsTlrQqXrohuQyMQSN2uSrNO3QWYd9qsFL15/TQ2yrTaWHaxyyO+f/4P+yLGWuJih0ErSlwuYVVWtsaDr4RW7xpf2Yr/ZhuYD+h9JsI7xJXggKDfWcedEyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XBkOqmoy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so338880f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709636908; x=1710241708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=XBkOqmoyLYJ7y+GW5bf3b56XKA5JAPM0QBc3ZM2TSaJ0xYuY7r7loY88QscPFSW7e8
         sEhvEvUva+A9/iPqqBT/a990OQPn/mXLCpbT3kwT0DO+jEZ5/9DemjkWbi+ghr9OEEjz
         LR6pwcnhxmgW69zaX90KP5VS/U3KT45ycDPZt0tLibte58A+5bkWTpUlbdLmN5M75+tU
         zoeRanJGAoHMOB36p/1MApyJb769D8RzaWUhDJY05qf/507B/7gcraUgxWo62FEAfqAX
         UHp9TcpBXTyFcu2wCjzJBvFKqS1Km+fP04NE4+PK3LXRtX7TO23PsciKpx8g7mevBpOw
         YsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636908; x=1710241708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEaZoF9mx7Xkycbcd21LmA2/00TCeHKVbh1e2Dzr7Vc=;
        b=jqNVRvnAEcmt+64gXCgOk7WRANxcfZQFb49KNYEwVovPJRqAe9uxiZ+2CbO9wkcFsE
         bcM8/KxNJ12JlHrBm2hkwCZbhVrRJTw298n6cnmdvwnMVPWC/+vt0Z+89f8hrlEa1qNg
         WYDfe6Daf0kk4yONPsAyH7B37KjdwiNLfKJ/H2r7APHeoPGrsvbAKIhfHXgcs1VRxw/W
         f/W7uZGaMJyO9ebVzBa5+ATPK7sLXi5ToZu/fBje/UoEnsmrXhhSThYA95E3tyEX7etJ
         9S5BqKIFAt/H/aY1m4VAHeiv/7zLWBzWiieCztolUZOraJHEQ5DrcDe0YUU/zfQaiQWV
         zfIA==
X-Forwarded-Encrypted: i=1; AJvYcCUhsTZkzzhMYZkphrooWhkrqfIW5PBWFac1vvuRdxJJoLfTa3uHjXF6IDho/dsIpHj9M6l0YjZ9SI1pj+a1Q3xpg69XR6lEfOe97buy
X-Gm-Message-State: AOJu0Yw9zohFr5DmLErxyndfEbr+LIS9hd1/dAWPGLBYUxgH2h5547ns
	WDVpIkV/s1XLc3sBt+1FeSEdD8H1NIJNEPciBQcbaSvpFgWMf6AQRRceeA9REtE=
X-Google-Smtp-Source: AGHT+IE9UuSurqoXqrMGlUzmaVAS5zp1obFuVFAEL0FLf8GIm/g3hMOXZyErpfk1zJpIMEuMGX/ehg==
X-Received: by 2002:a5d:4047:0:b0:33d:61fe:6ca3 with SMTP id w7-20020a5d4047000000b0033d61fe6ca3mr7985438wrp.26.1709636908019;
        Tue, 05 Mar 2024 03:08:28 -0800 (PST)
Received: from [127.0.1.1] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm2190993wry.66.2024.03.05.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:08:27 -0800 (PST)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 05 Mar 2024 12:08:18 +0100
Subject: [PATCH v3 1/3] net: ethernet: ti: Add accessors for struct
 k3_cppi_desc_pool members
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v3-1-5d944a9d84a0@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709636903; l=1852;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=jlmDA8j5BPsGTQCQEi11/ZrPzSbTV7KDqXuvMXnrWBo=;
 b=dfeer2o0y3GGm8RrN/JvsU55HT41wNQJYnV7qThO2EEG4VL5/5uFU+kGT7yuR5zglIGMB/bAo
 RDemmHF2XC2B5I/tvt6x8yUrU26eWs0i6goZX8R4eJai/yp7iJrzvFc
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds accessors for desc_size and cpumem members. They may be
used, for instance, to compute a descriptor index.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 12 ++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 05cc7aab1ec8..fe8203c05731 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -132,5 +132,17 @@ size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
 
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool)
+{
+	return pool->desc_size;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_size);
+
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool)
+{
+	return pool->cpumem;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index a7e3fa5e7b62..149d5579a5e2 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -26,5 +26,7 @@ k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma);
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool);
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
+size_t k3_cppi_desc_pool_desc_size(struct k3_cppi_desc_pool *pool);
+void *k3_cppi_desc_pool_cpuaddr(struct k3_cppi_desc_pool *pool);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


