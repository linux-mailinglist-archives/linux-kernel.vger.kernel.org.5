Return-Path: <linux-kernel+bounces-43740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ABB841885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43018282FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2D364A3;
	Tue, 30 Jan 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uqwkN1v1"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DB36119
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578938; cv=none; b=HFTz2lj4e5sxqaT+YtzO5bD1a6w6c5boL4Bg3Nyhr4pZTCVMLOejgJJ6dZW9RnA2lUaKKyclRig1YsuQBOa/sBpAe1eoBio33U6AK2p6rij1P/YG5CcJ1qJtdbCzeBuJXTzX8HSOAjplw0CyZFnaV1FiW5yZh3MwXCjdAUnch4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578938; c=relaxed/simple;
	bh=T3SlR01LXPCA/d3uGBn94fFn0fTJP74UII1LlEvglvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnOTX6zO3qyBX2iwv+mlWeQrh8S/u3t7q6+fbT6V9X4R8+PUrlKWhH0Pp5anxeoid4FNFDIQk3kTn5TCpinuhdaEkkjT6h/rJazV8SKUo3AwgZnnFLwl+cHGduqkN6jyZq4tP21EeEeXsgb9mXG/rB5M4cfPQAQT+OWO7jyaoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uqwkN1v1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783045e88a6so349529385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578935; x=1707183735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shLTg8CbwWEN2YIGT7dz17BRQIDu5G+tg/uQhre6QiQ=;
        b=uqwkN1v1f/8NSvrP3loCd23fQEdQvj6q8b3PNfpd6P8CXL6t+K3KsWDj/mvpEeKorG
         N+9zOED8eaRXbhcLh72HC3Srw1r+ovOlDi7mmEpzvDKR0aNKINej2PFD58ii9hCLlI0s
         nZrpYfljr4u2nKLZ1rn+zWHgQ9QlcB8PpA4ysZzM0KVUHdwMGwo8YanGUGgeBYykL1PF
         fhB1oP5EIQ+8EXo2LiKdsWIjiZwaENB9sx7jtn69KQkfjTXh10DU/Dp5b08BK3ZJzkz0
         WBojLNgo4VHAXZtUXjLcqiTmVThUr4suzMhK7+Q+kdjDEOGqJPEg2qcYAbMxG+pFfevY
         FJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578935; x=1707183735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shLTg8CbwWEN2YIGT7dz17BRQIDu5G+tg/uQhre6QiQ=;
        b=EzcrHkPQF7sEYrRc1eyhgMRMlMGKGGNJqks/if3IhlCBhQ21RKMGSOG/boS4hIgEWY
         xgIsqeT53TQMifs3y4898eicjcXnjMjLFCQ1T74cu/HzTG/aue9S6YSLGEebV3KlrgLa
         c1oS4sc23ka37PIG/uY+jajgL0F+RZiWdsf+YUQ9Bb5atczDTikzZi//fydUfpd5b8X1
         FlVRFBb4gvAz1txVRHlMNvzaIwL5zcbF8uXdUOVkK7RfCAq2A6CpAMTejGprsgPuMRN2
         YLLup2vJmi4KDCWaNicfBjF5ybwd/osm05rGvGNCRyjj+Mxthz6cgneMBl4LGaxf9Tk0
         YiPQ==
X-Gm-Message-State: AOJu0YyVQA3U+2yHeqUojFSObCwOWW5xq+QQmcTA6AqEa9AyrrPHpiJx
	VsYx0TBAByZxeKk/INi3xipGzPKM7gqvdTa+hpxjIHssClzfeNk5BtqKVOBhZfTA7Cs9xcLio0u
	c
X-Google-Smtp-Source: AGHT+IE9qj83y7G4z9fihmAKWWcQVG1MGvLQrnNFWv+a/2imYaxhEYRxeU9+t7c0pWlonGDYF9KF1A==
X-Received: by 2002:a05:620a:15ae:b0:783:8a70:f64 with SMTP id f14-20020a05620a15ae00b007838a700f64mr6881421qkk.65.1706578935257;
        Mon, 29 Jan 2024 17:42:15 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id o26-20020a05620a111a00b00784046b7868sm794053qkk.90.2024.01.29.17.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:15 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] mm: zswap: rename zswap_free_entry to zswap_entry_free
Date: Mon, 29 Jan 2024 20:36:37 -0500
Message-ID: <20240130014208.565554-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a zswap_entry_ namespace with multiple functions already.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7f88b3a77e4a..173f2e6657de 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -520,7 +520,7 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
  * Carries out the common pattern of freeing and entry's zpool allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
  */
-static void zswap_free_entry(struct zswap_entry *entry)
+static void zswap_entry_free(struct zswap_entry *entry)
 {
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
@@ -555,7 +555,7 @@ static void zswap_entry_put(struct zswap_entry *entry)
 	WARN_ON_ONCE(refcount < 0);
 	if (refcount == 0) {
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
-		zswap_free_entry(entry);
+		zswap_entry_free(entry);
 	}
 }
 
-- 
2.43.0


