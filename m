Return-Path: <linux-kernel+bounces-140758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5818A18C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A470D2869CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D918021;
	Thu, 11 Apr 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MLiTucjT"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A214012
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849497; cv=none; b=DEHQWORCzoWjPFY1BRbYgFM8PD1xHCa18iG1Qr6VfUsVlOVHRlGH17e6hQz2dRC+KXftiOrursLtDqTiXnEyKiVby7l4Q8cd39cH+uOYx1ypSW9ifIDdHnNgVJAdbeeIvM6dYEjqVczHHzc6lFS52z5/GElpWNIgRzDxwLLiBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849497; c=relaxed/simple;
	bh=cxewkZyxRElYmBVpDBfnzLzE9Qi5Af8AY4SLKQB4suA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOH4HaqEG7+OXohWipOJFkxWzxRjU5bDOsawEASjE25REGCGWasL0q6VIuntDe9EcjeIvE/VWCfpWvNvJElPnNNVe6sGD+kuJ4h1sIWy5DZ/wFXpOvC48DFpe2jwNQnPvDgGgNELrMPPA1WBqYuwaxIApt4Et7dczT2RzgXS720=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MLiTucjT; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso81829539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849493; x=1713454293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF7rljSyWSXVyabtJWrttCeWBftBj9OG2VAhwMADVj4=;
        b=MLiTucjTPhCwJzW9rX0LyKeyiRyQUbPdoxj9gdxUu77bbcfASnAxVUJpRMvGtk/0gQ
         hT8qihVirZS91vexQSXDN+Mm5a+mA65PKuhOQBVJNyhjOCE6qfNr07qqJmAnU8p1nKBY
         /TYquLI4dnbJqpS8x4t9jKEztfTjLKhUVK/gI7LlfqPGaPaZFHLvLFLuwlH/K9thYW24
         qBe2oZlnB3y4wj3TlCoJojSJ7qVtPxKULDNFsuniORoon4l9ax+0mc/m5xVKSfg+Q1Sl
         oe/T9jvtrQYAxswFtHcxR7LAgoyFNNcvdbkJDt5TpfIS0ygphWFP+pUjhBjN+AQ8SfQL
         D4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849493; x=1713454293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF7rljSyWSXVyabtJWrttCeWBftBj9OG2VAhwMADVj4=;
        b=XPxr9HjCEL+BRndQKIJ98f6Djwo881UIRJfAUvl24c1g2odS5BnlWvEk8glOhB/Mq8
         WPXH7V85P+I4x7KyTrkqe8dYkHqVOA9fXpZt9KPooXECGxJdGPO5M3DSCyJi1nBl5uyF
         N9F1jf/gUpe0CuyX2EDknKRu7dxqlIbh7X/EiJsGMyJC0XmMjsVEF94X81eZ95hZCuPA
         yWKuXYUslTLuiu1UPCZpXGMKtwtonrGnGnAxuja1AwQb2Fq0VuIcZQ0jZTuojL2EskgN
         1YXJ7UD4Mv5TFHpArM96OyAtJfWU8Ew5ihyEzkW+/4li9nudf6YATsV/bV+W2c0JiNG0
         Djqw==
X-Gm-Message-State: AOJu0Yz/wQdPoptGEBYdPtzg49yNbYSn0MCtPiQhTl4oSVpGPLWUyVCy
	x+v+4zpp899r6oBgXdieh1QfHjLWPA5vPTcfJYd8ayhSxyF8Q9dc/6ip0qXFCMolQYpKObKF6Tn
	6
X-Google-Smtp-Source: AGHT+IHL07y7tk9NAT2xCfJWz8ws6u5vrK5l9/JHjQwJXCuH/jjbMnQXq3p3+2diesUY/1sdOfA4yQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr170561iob.1.1712849493038;
        Thu, 11 Apr 2024 08:31:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 003/437] fs: add helpers for defining read/write iterator helpers
Date: Thu, 11 Apr 2024 09:12:23 -0600
Message-ID: <20240411153126.16201-4-axboe@kernel.dk>
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

To ease conversion for drivers, add helpers that allow a driver to simply
wrap their existing read/write file_operations hook and turn it into one
that is appropriate for ->read_iter() or ->write_iter().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd862985a309..72de0b1d5647 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2141,6 +2141,22 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
 
+/*
+ * Drivers can use these to ease transition to using ->read_iter() instead
+ * of ->read(), and ->write_iter() instead of ->write(). Ideally these will
+ * go away one day.
+ */
+#define FOPS_READ_ITER_HELPER(name)					\
+static ssize_t name## _iter(struct kiocb *iocb, struct iov_iter *to)	\
+{									\
+	return vfs_read_iter(iocb, to, name);				\
+}
+#define FOPS_WRITE_ITER_HELPER(name)					\
+static ssize_t name## _iter(struct kiocb *iocb, struct iov_iter *from)	\
+{									\
+	return vfs_write_iter(iocb, from, name);			\
+}
+
 /**
  * enum freeze_holder - holder of the freeze
  * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
-- 
2.43.0


