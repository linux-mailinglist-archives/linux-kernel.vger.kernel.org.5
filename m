Return-Path: <linux-kernel+bounces-44508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE4842321
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F33B2BB31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405366B4C;
	Tue, 30 Jan 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zhe7aujY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE28664A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614079; cv=none; b=Zs0w514ZQekVXl87tH0BMbkdAVhmrr379izf6PZZwzS+A+arWDpJBDUUYYX2OGY0ejAGrD04g8Iz3/X9UnSpGteUvPRZSVPd/kHjho37TcDy9MJxcaaN2jg993lS4juaQo5vQCCYkbgbn+THfljThzUYs74V+P2LXuQ0sBmGLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614079; c=relaxed/simple;
	bh=VJ3WxFyUH1QX/R2FezaIZrc9SHd0VxU+WMrUCCCzWbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E5W0CeLQ7cFLJidXSK9TZCct58eRIqmoIHjnYkQZIoG1CapqtBR9rhqsz3CaKUPcfkvt+lPrwKI18K8Kywf6VVWLoZS2EDaMH6HrQlFNFf0EeXfTEthMZuxp75uXefaITCLHMH11j45OAqs/zp+PaYBsMSTphqKseCOj0rCVHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zhe7aujY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71cb97937so20871575ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706614076; x=1707218876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFz/ioS5pMtmsywy9UOLGQH2uroA4Qw/qVk4L7fINX0=;
        b=Zhe7aujYvlLHVtXJZ3kv02iCcmFKPV5YO9MbmC0Mk12po2UQlDHCIGXR+EjbhYwQLU
         Wa6IatPOH2E73/nhTv8SCStzr8X58TvEgcnKDd9kOn4uVIIDtbH8NTdtR9Jg1WSEOhMh
         rmJZuCyJ+qS9UDHBu/miZ/kDCu1+7+xbK8PwDsK5RqzJi1Jgb+ObXi8T9KnpdSewo0Uq
         4eFeSd348K4Q3lRNCH9aQmZLwREmG6G534N/sQNvbyf7LgXMHkw/uhhHuKLErvmre5yg
         /5WvLUMAgIZUhLxgmOf1gHazivLfcDnCp6wXI51bKvcgPiG8ons+6yNYHmK6VbAMQ7JL
         bQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614076; x=1707218876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFz/ioS5pMtmsywy9UOLGQH2uroA4Qw/qVk4L7fINX0=;
        b=Exs/RVrKvuc0bMQeEZH8f9/kZwxOaKSo9CGZiLsu61Qe07TwptyZR04a9QSbLFO8YM
         1GSh8mgU1cRBE0GEehcSaf0MSf0iAUn2jWbQzOeY5CQC4hvS9VSdBitanIjtKFr+8f4o
         V/F2ZmnbdBtwyjM3tijZf6MUuvAt+qCKN09ZVvyBpqkuqeoO0ztIZWzOQVf58NlmlKLt
         iuyU9LNwsapD36bEN+jbN10l1ZO+PdSoQUEDQLAXXsx7KDPNrZUkEbW2XniabUqskd5l
         1CLAAfe55vmxowttLWN4TQ+GNlcsHd0G1lIAmFqB1pWen/rhCQh89GuwSeFCB21KpHgp
         4Nhw==
X-Gm-Message-State: AOJu0YwBSJUJzSjWs0miKCP84roqxpS8GeLkaVUJ7IskgtZ1AsSOrC7s
	F1mALiLHPpKu3Q/tCOD73g2tld2IOxFB60E/skpEzvB7HWvTU8ls6lTGaYnXbAA=
X-Google-Smtp-Source: AGHT+IFxYQYsZlp0TH8j7NTAhzYbg+/UE/MPq1RYMFL1zOTZBo9xa9ES0Z1wEP85nypj79LLuQ20dw==
X-Received: by 2002:a17:903:2692:b0:1d4:4e13:6b59 with SMTP id jf18-20020a170903269200b001d44e136b59mr4044993plb.45.1706614075892;
        Tue, 30 Jan 2024 03:27:55 -0800 (PST)
Received: from always-x1.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id jz6-20020a170903430600b001d74502d261sm7002041plb.115.2024.01.30.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:27:55 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com,
	jasowang@redhat.com,
	herbert@gondor.apana.org.au
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	nathan@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Date: Tue, 30 Jan 2024 19:27:40 +0800
Message-Id: <20240130112740.882183-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof(struct virtio_crypto_akcipher_session_para) is less than
sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
stack variable leads stack overflow. Clang reports this issue by
commands:
make -j CC=clang-14 mrproper >/dev/null 2>&1
make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
  virtio_crypto_akcipher_algs.o

Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..de53eddf6796 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 }
 
 static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
-		struct virtio_crypto_ctrl_header *header, void *para,
+		struct virtio_crypto_ctrl_header *header,
+		struct virtio_crypto_akcipher_session_para *para,
 		const uint8_t *key, unsigned int keylen)
 {
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
@@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	ctrl = &vc_ctrl_req->ctrl;
 	memcpy(&ctrl->header, header, sizeof(ctrl->header));
-	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
 	input = &vc_ctrl_req->input;
 	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 
-- 
2.34.1


