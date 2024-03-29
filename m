Return-Path: <linux-kernel+bounces-124307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EB89155F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD0AB228E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67039FD3;
	Fri, 29 Mar 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WwOJgg9e"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521572C6AA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703240; cv=none; b=MeG2qpvaQKB8U8E2eN48bZJxUE+ygce6SvHVVxtVmaNwPpCvuDCSFifNdCa21cFi9qKsPtwWylJOREQVAn+PTzAz4ralA4dCr2ySXvYlzJANHLRgCSYykzukyj8iANnWU9tU2l6Bli5eBBTqwSbN8Fcfg7eiBfA/4axl1NkTGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703240; c=relaxed/simple;
	bh=It/GX+ReBBYX1AKiBl4D9EMBAtHpYKikCFSIkseXHaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXQgJg9TIiUERe4IQxsQ8XjdoPQdX7Ho6kbQ+zjmdSVeIpVGV0yfE74XZfG14XUbCf16CfxKlL97pl1ynHUfqMYWljgvkdtFwowyhieYnOJb/d18gRNe7UUdGnj3sAjsuo009mQqFHkqTkAkuU1dfROeWJsRMhxfv7UtCECocd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WwOJgg9e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0025ef1efso13531025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711703238; x=1712308038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trqMODpsIhhm8jYppx91hSLinbtKoTmnbiwFELvPFk0=;
        b=WwOJgg9eVte0maMaH7PFWXurb2GL308tKYIJubT42EoWVJHmNMjJux/uj4xd6nm7iT
         vUosIsu5LXCXdGvtVgm3RF99pTUct/Pk5grFa5FQh7GHk6eYbqd5e/4izC15wDYkTPNn
         87BOEbOzvmCZGu4fMCviHZ2LCTxbgol0S0cXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703238; x=1712308038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trqMODpsIhhm8jYppx91hSLinbtKoTmnbiwFELvPFk0=;
        b=PioGj5oYYIE4ApQowmVXE4Zd5NKAYlRnQKWkJAfGv5sH6OVbTQuxO7jPjp3RRA6KfV
         s58rUcFYSEVefsoCDzZQYRpo5TaZm0Ma00XxblVn5RBKyT8HKrvKlVRgjwbS9qV6IiBM
         Z/N1iHsohW01ezFLWZzQiR//L7O2dtKxwjgVJ4Fv9aLjI+47+2P+ts4c7t5xg/ttu6qr
         +BLoJa/r1kUdo7d1AbEnRnUOOrodDkgGowd8fDX50Yo7buPDHhnoWF35cggMI4tB2wPA
         vsj4o8w7KA/x530Tnwe/Cd9e/MTH3rkI2PPcv+tudsLdwFPZNl+OC+2Q4kDH4B9HqlBA
         DOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpUYnvsaEh5Zf2sqwM0dwLq9ywvvTR+HHPpRLWt3vrtecdeuLKM8S7DUmaDFXHh6It6t1NAdE3r91HRF0lCTDhxMohAV2YftTAnIcN
X-Gm-Message-State: AOJu0Yww2/N1R1Pz7KQDKgJca14EpS7MJlXY6IRBgqn9s0tTj8fD1CPp
	GcnKDJ+MUI5hpO3vnRNHnwzQrPKkUHIoPgv24TF3di2r43Toi7KXsW5EMgHRGw==
X-Google-Smtp-Source: AGHT+IFjV84gXiP/i/Evod+K04pCptnzt8bY2N+jkT5KFPFU1TVRG+7hC1lnO6hvyrpk4aINbKcrXQ==
X-Received: by 2002:a17:902:a3ca:b0:1e2:179d:66d1 with SMTP id q10-20020a170902a3ca00b001e2179d66d1mr1760681plb.19.1711703238474;
        Fri, 29 Mar 2024 02:07:18 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:889e:22ed:efac:44b6])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001e0fdc6e4e7sm3008108plx.173.2024.03.29.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:07:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: add limit to recompression
Date: Fri, 29 Mar 2024 18:06:44 +0900
Message-ID: <20240329090700.2799449-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce "max_pages" param to recompression device attribute
which sets the upper limit on the number of entries (pages) zram
attempts to recompress.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  5 +++++
 drivers/block/zram/zram_drv.c               | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index ee2b0030d416..091e8bb38887 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -466,6 +466,11 @@ of equal or greater size:::
 	#recompress idle pages larger than 2000 bytes
 	echo "type=idle threshold=2000" > /sys/block/zramX/recompress
 
+It is also possible to limit the number of pages zram re-compression will
+attempt to recompress:::
+
+	echo "type=huge_idle max_pages=42" > /sys/block/zramX/recompress
+
 Recompression of idle pages requires memory tracking.
 
 During re-compression for every page, that matches re-compression criteria,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..a97986c52476 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1710,6 +1710,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	char *args, *param, *val, *algo = NULL;
+	u64 recomp_limit = ULLONG_MAX;
 	u32 mode = 0, threshold = 0;
 	unsigned long index;
 	struct page *page;
@@ -1732,6 +1733,17 @@ static ssize_t recompress_store(struct device *dev,
 			continue;
 		}
 
+		if (!strcmp(param, "max_pages")) {
+			/*
+			 * Limit the number of entries (pages) we attempt to
+			 * recompress.
+			 */
+			ret = kstrtoull(val, 10, &recomp_limit);
+			if (ret)
+				return ret;
+			continue;
+		}
+
 		if (!strcmp(param, "threshold")) {
 			/*
 			 * We will re-compress only idle objects equal or
@@ -1788,6 +1800,9 @@ static ssize_t recompress_store(struct device *dev,
 	for (index = 0; index < nr_pages; index++) {
 		int err = 0;
 
+		if (!recomp_limit)
+			break;
+
 		zram_slot_lock(zram, index);
 
 		if (!zram_allocated(zram, index))
@@ -1816,6 +1831,9 @@ static ssize_t recompress_store(struct device *dev,
 			break;
 		}
 
+		if (recomp_limit > 0)
+			recomp_limit--;
+
 		cond_resched();
 	}
 
-- 
2.44.0.478.gd926399ef9-goog


