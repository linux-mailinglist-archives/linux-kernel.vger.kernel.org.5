Return-Path: <linux-kernel+bounces-157742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E88B1542
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61503B22D58
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0EE156F5B;
	Wed, 24 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FIdBORo9"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90766156999
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994870; cv=none; b=Ic9FXJblM+3tjPBen8glPvutfBzT1WwgOpClcjzuJRp8UmAQeKMyvHL0zIT4wk3Ceo1C6cX3G5zsuFin8Leat9oD5LuC5Xb4XwoReIZ7BiIAeVjPjMoWbk+5E3qNaAG3gbyTw1eMP8/GGL7Bl016Rn/jrDKeX4Kvqyj+43FyzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994870; c=relaxed/simple;
	bh=dMZ82hcwMjPtLdK0cTsVIA5XzWAQXcfcJoTMZY0cUd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWE9RxejAl7YUS5JP1EyuKxZcn8+cf/o5IojUzRKN6HpRP4NzbLk+aLUSyg37HG2loJywnSIhNxn6KjJgFllMkMmSlQ7BQ6CrXbsFsKCyBPg1jfvJo9+/NDW9ahOOLRa+3CqSvIXQaUeptnTreMaorWqtJsQDdvlBpTf6zZA5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FIdBORo9; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb7ee5a776so226606a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994866; x=1714599666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DE0gOuM6fqjcPRbynz9LQpOkql4Ebi3pYsD8G1TJgY=;
        b=FIdBORo9AaGGGzddaCAjitXb1Cywj0IxdJ7FRFSKoKEDio4C1vlyUkc1/gVptC1VAh
         QWMh7h0ldujnzpmBSuI6DswWZocKg6fKPo42+m1lgAPa75yupMC9e+1oIY7pgRopcCVp
         HwEpBS2QGNWnV5nFHiW5Cr2GzBFX9lGdZZxjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994866; x=1714599666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DE0gOuM6fqjcPRbynz9LQpOkql4Ebi3pYsD8G1TJgY=;
        b=brWCxtJUZJ2UUYUpeP6FmiXBSlQSbKkcLkO9jS4mgd4Yqp06U6kJjJeOIljIrcfwis
         L+iifdzcYgUdsCLS4d1Gu8qeR9pQKGyhz72ybSzvWJS/Ix5sMBMKQXVPNskGxAylRh8F
         PZ5yNixYeKV8WRE4xMHoRGn/j8xPMDugmNVLFl46cwVwOeozpryf/W6McdvlrLy1Mcgj
         L7vwI8xduvEYwYukxgccQG6dK5AIDeW/QBVkSUF/EmQ21EBpW2XQep61HQSVdheEv1hg
         Ur/QxbICPEk9fIAQXhy7sysi1pyjcgNSrqIytianGOHR6kOBMnjWsS8MgnAvpe6ohF2b
         bxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQjD4u1oGOC/1ARGAzIZpdzNJBjRk0lqFWxwMUjj7z2WFd/n/cs9MXU3cWHjSW4uDjaq2dGkR3eZbx1lF151y6Rdpo2+lqP6kOIkw1
X-Gm-Message-State: AOJu0YyfPvBvKujMPcT4+3hdE5k2VTf9J+ojB5Mx6eXLYj5+WwGYQpB2
	HPbNAJe+kNfjhvluD8ctjOpmU7Ascpe3sLPR09IAwmcFBRNaaCuJVY1w52PnVA==
X-Google-Smtp-Source: AGHT+IEqM/ZyN3r0s9cglQZ0+oH+dar1+xY2j0+uac8cA/8FmytsL1pSqxY54sZztW/PC55nIBocHg==
X-Received: by 2002:a05:6830:1d61:b0:6e6:b125:b8d0 with SMTP id l1-20020a0568301d6100b006e6b125b8d0mr4471407oti.13.1713994866613;
        Wed, 24 Apr 2024 14:41:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i193-20020a636dca000000b005f7ff083182sm9774009pgc.36.2024.04.24.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:41:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/6] mm/slab: Introduce kmem_buckets typedef
Date: Wed, 24 Apr 2024 14:40:58 -0700
Message-Id: <20240424214104.3248214-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=keescook@chromium.org;
 h=from:subject; bh=dMZ82hcwMjPtLdK0cTsVIA5XzWAQXcfcJoTMZY0cUd4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxu1YqNqwqk+P9UKDsX65CurgWZ4S/pDrKwg
 o4x/WCX9JeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 JgHJD/47Q2MOcnzIviSgiD9VouiFmZpwzwVRRYkpLKsHQDoOvqMkZvk/eKBcgJq7gI4b4L0nlze
 3A4oC+r7H2g5vpgNw2p9z0EvkqMxob05GHM58weuoSuAoQlXoGaw8CGnTLUzMStUBs7/mjNJP7N
 jOKumU3iDrflgcJc8zmRfTB9E2KEATWvOZpmZXea50xRjV/3n4cNGXAFgjVoaJv0vle6qpuUpb6
 4OjdpzYsgmcST6rSqXidR/GKMAB9VIysWDYtFpipd8ZaFlRYrPqxbk9P/tbMGhgzbo+vVyvufOf
 9GZtcQ8ed6xSFYIBM/lH9glEEfR8YyZQxwBlds599HevRmXmoSWUPAj2emDPcIvv9Nf/tBXqHHH
 EWle9HYub+cnGXO/ZZ7LHLFRn/1xE9ZnjnDir4uCUoHG2fQSN2yQimLPC7cQJ+aTFR+m0dAh/c/
 IuScgHhC15yj0hphSDAQKOWHZdYclS69YaXCB6e8Z3GigOOs7SyRG+YXT5td5GtFI7ySlTKt9ql
 FdT7fBLlt3yFZUbcU9V/WM/2KZIR5WW8tMM2o74bV5l26yXIbdLO/yM3/Xy7OqmuhR4PIKn84Hb
 XLjEi93Mic+97/CkVzIvgfpa1UrRqOJQZVeWYgnDsADwKhZyn5oSzRhJesWrnlZSD/WDntlCm6P 3QTXTa8PTS1ijDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Encapsulate the concept of a single set of kmem_caches that are used
for the kmalloc size buckets. Redefine kmalloc_caches as an array
of these buckets (for the different global cache buckets).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 5 +++--
 mm/slab_common.c     | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4cc37ef22aae..c8164d5db420 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -426,8 +426,9 @@ enum kmalloc_cache_type {
 	NR_KMALLOC_TYPES
 };
 
-extern struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
+typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
+
+extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
 
 /*
  * Define gfp bits that should not be set for KMALLOC_NORMAL.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8664da88e843..db9e1b15efd5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -653,8 +653,7 @@ static struct kmem_cache *__init create_kmalloc_cache(const char *name,
 	return s;
 }
 
-struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
+kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES] __ro_after_init =
 { /* initialization for https://llvm.org/pr42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
-- 
2.34.1


