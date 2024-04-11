Return-Path: <linux-kernel+bounces-140947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A38A19C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C030289009
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564A2101AE;
	Thu, 11 Apr 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UDeU+LtM"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB4210190
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849803; cv=none; b=sQNLzrp7pPkb0RYYU2SAuCE8tIJVhzF8ezW/jNsnEn/XfZEr1+5IcHOgtq7ZcxgQ766qdiaZ7RmbVeHtT9Chw0vE/lqlPT0CQrygaaE4KV9fH3iETp75xQz6KyWg4aIPtFFKz9U1JSiI0sOTZ6ETBXL22FIbZSR/uQBppGApwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849803; c=relaxed/simple;
	bh=jxZ++vzschG/6E+J4D7CtFyNOzxPZ8UL7V2oGXKrB1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzDDRljGfN8VT22/nGwk5MPVYzKj5I8rP5TLjZkKXsssO6g9hQDHmUtt+iD/b3hN+IuDz9WSLcEamplZzG+VTro1CBMhZljjDJluaTKY7S5kGIyF/EvLMz+d8ZqMQppuXg0YLtfbxEUb35RLJJRT0S6P/vcoAEiCmwRpiQPuCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UDeU+LtM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16170639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849801; x=1713454601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGUvO4zd3WyI8Wwbfm4HcSUX/gc5O9QdnbNBe/njWD0=;
        b=UDeU+LtMp078eTNIPafPmRP+m3HfbhKaCTF0i3pOGl1Ww3mQCh2Qe2TwFf/u8geKjV
         i934EfAAbrnbddYepBv7U/roLCAKy+zdHwYeBhUcpq17By6vm7dlyCmPdDnjFEFN9hu9
         t1LFj7Ar3zQbUAhO9So48z6PcqKw8x6BVoFC1KBhd/0CTeakCZ+PZE7Hg2nisWRrLsaj
         Ce7d/EaQrI7gy0vWoFb7T91J+QxVct8NZDteOsoxV8QybipHy2srI+9QfHjk9EQoUhyC
         ekioD6uV+399HtRFoGE9Vj5v/EVGqW5jEyzWQDdZj0w4dgzJdzXVv6wcqQKRcWLX9kWS
         I7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849801; x=1713454601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGUvO4zd3WyI8Wwbfm4HcSUX/gc5O9QdnbNBe/njWD0=;
        b=t7+BJUgKbSVCqnOgZRtS0+fHXkb9vZQL59ZDfyIjeznCYv7zlxx+gvpIJaeo+gZAV/
         OaSQmTubxIJEKpy4agqPrhKcwnpwUHzjh7tBKtkVsUYb9RMOHjZ6ZxZpSCvRd8w8yXKV
         hYCxR7Usd2pMueTEz6CKqRWzxa4Ssb4zWTYPedmiLpCk0b+iy5FnyTTnhv8kuL44ztmp
         QVqGuGCTfy3Fv6gZXh9f446oXUz8BTvBOD3btqv1Hzv+35oymfqh099bbLeU61cIOZVk
         q+uN7EhpzEghCuwpwny6I0rcNpA98p6jYsQgH+pRztezT+D/Osqjo1QvHJpp17E83YAX
         r5Cw==
X-Gm-Message-State: AOJu0Yz/fjuFAvlvFBttjKamxr5nCyGx7MtL/+za+BGNpvIFUJHpKhGv
	4hUcmJPbJgVzrGOIByE0Lr3yewpYE6WqijIzK3oqKRD6LRXebfzEksL051+cJGzTJb8XuvM+GAz
	w
X-Google-Smtp-Source: AGHT+IHkDrSXh4o9sOO71DHiOQXpOEdbmizuKByZRr7+PwXdgdK8YUlxA8bgOnEeNPm9OrPtjHW8dw==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr186265iov.2.1712849800593;
        Thu, 11 Apr 2024 08:36:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 178/437] soc: sifive: ccache: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:18 -0600
Message-ID: <20240411153126.16201-179-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/cache/sifive_ccache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 89ed6cd6b059..bcb6691f8f7c 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -71,12 +71,12 @@ enum {
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *sifive_test;
 
-static ssize_t ccache_write(struct file *file, const char __user *data,
-			    size_t count, loff_t *ppos)
+static ssize_t ccache_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	unsigned int val;
 
-	if (kstrtouint_from_user(data, count, 0, &val))
+	if (kstrtouint_from_iter(from, count, 0, &val))
 		return -EINVAL;
 	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
 		writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR);
@@ -88,7 +88,7 @@ static ssize_t ccache_write(struct file *file, const char __user *data,
 static const struct file_operations ccache_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = ccache_write
+	.write_iter = ccache_write
 };
 
 static void setup_sifive_debug(void)
-- 
2.43.0


