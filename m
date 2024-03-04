Return-Path: <linux-kernel+bounces-91130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71AA8709E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6B1F23309
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25879957;
	Mon,  4 Mar 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QtWSVN+b"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F478B52
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578180; cv=none; b=GJJMnOGMYsjnt4CxqtXylmt+bSKWOH+y9Tx+TihRUv2A4IizZKUsKZHWuYbFH5zbP6sj9vGoTQfSEmjKwfXeXihLBUdB4nuhGRnZj+ntiL8YIGscE0EzcRn8826oLDROSdsey7X8qDRYwlf54M9+GC/WH9+XcVpZc86nnCO+fSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578180; c=relaxed/simple;
	bh=wVlg4Ywlqm3758Z/+rtNyin5k6LCR9PFs+qzYTfk1+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3rK2zTWa7VlcXQWpF3l4Ap8GtFM/L+BdIbjpypWQ3I6Hptd2PfczSRCK8xlAhY0YwtJSTUiECgSTFCEoz+8c6G/Q3NE6fLFF3trhcP860B/cCa70r9+6V/FiYcbh/ZTJ2B7/s3davxnQSvmfZtPWJ5BeIiOjxikTbg5kL4BQoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QtWSVN+b; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so2941125b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709578178; x=1710182978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eg+OHwarPCDDbCJMvwZ5D9ntaRfgGqvBfyy5rCCcVU=;
        b=QtWSVN+biVvOgumsC5IFUE1vZ+34tur9nBswjI6nqffLeoPL+bkKPDSv6J0st99OOD
         dkVSC2n5aZomvj3tP14ymJt8A3qaAtV+UncE1/n6Y5cQlRSJYtsn8Dic9E8JOr704Rf4
         z2/8nf3ufHIaNR3NZI8JQVQ0wgfDiOSTxC9z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578178; x=1710182978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eg+OHwarPCDDbCJMvwZ5D9ntaRfgGqvBfyy5rCCcVU=;
        b=kHg5YCUAgYwoyeZ+iX4F46tHvZbsmEAt5xgYF8FprIjyCu94ezRRgRherYEXdHNFQF
         Bjzb+oaBNU7VslvEYJFR8NmO9uv/8FRX7S8s4/Ql5J9wddmJTUFsRKPa5/b6SHo75tsW
         0cQe6SXPfyt/S7SQHuF5XQXnGPhSP6TE55pDBG2hkX2eVz3GJdbW5685h+fF8r03BJsk
         dRxtfD5aiSVlfepLW/tbgXS2lSSTxCeMqaJ7g93gEVgs3UzviQODVd9uMX6GVnTMtfhh
         JopToaEdhWCDB/rruKApa5ynrG2keGOzu4ONw9mSBnaO3vVW8h8RSisrm0UcEtO1M/FK
         mEpw==
X-Forwarded-Encrypted: i=1; AJvYcCVidk0wbJujP28/DDvWDWLC/ru7wCJ8LPSq3MJShEz44qXiSDNY0nplknlRiX1PNYAK+xnZ074Sw9HadAzQ3ux31WHZyReoTFkcVQEw
X-Gm-Message-State: AOJu0YyMvj7vVzkfD8GLuFX9jaPVRIOvQFdgwKrEmSjhEoI7AfA7yxAH
	s928PjiDMMmRSO1MICbkFDOWe3Rrq2V2wucpUCcewY7f7z7YL+7zll7OA+pLdg==
X-Google-Smtp-Source: AGHT+IGLXRXXimciJBhdk/dIb4Wb2zbKj+H0Uz/ceqDu67vjZT0fdQjMBcnwKVhjTqa97KV6aSVCaA==
X-Received: by 2002:a05:6a00:2d1e:b0:6e0:50cb:5f0a with SMTP id fa30-20020a056a002d1e00b006e050cb5f0amr397502pfb.12.1709578177665;
        Mon, 04 Mar 2024 10:49:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q67-20020a634346000000b005dc49afed53sm7759425pga.55.2024.03.04.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:49:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] mm/util: Use dedicated slab buckets for memdup_user()
Date: Mon,  4 Mar 2024 10:49:32 -0800
Message-Id: <20240304184933.3672759-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304184252.work.496-kees@kernel.org>
References: <20240304184252.work.496-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=keescook@chromium.org;
 h=from:subject; bh=wVlg4Ywlqm3758Z/+rtNyin5k6LCR9PFs+qzYTfk1+I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5he8UYVHiwP9jlErQNW8kOwDMEcuQZnM208D3
 8K1ECbNwiWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeYXvAAKCRCJcvTf3G3A
 Jl+iEACLE6xmcDHNPJUI5v4X0mux03kdgYRX+BLElIYHYI7U0wjiKpXajjtdiBhgakpjXtztCWM
 P2osPYx1h7voVbtUuUWxNhSonJpnB0Nm+gAimqzvFzjmcT3+iOzWMdkuQIrnE6UmT3zpJFc6XCU
 g2QFAVxdiGa3N2vDovfT4v30vBd49SiQha0Ku6yG7HjCQGZlzRr99NRAgutT/m9cF15+jsLLygf
 27uNjMhYBScQ/t1LffYt6H0XCkJx/H2JYQjJ+BPC2G+PF99sedHnXOHDSkQv8x5Hl4PIhPslxFR
 91ZyIfi2gek3k1qy2AtzadMoj202Ge/xe12M85LUqMOsf6P+R5s8/g8DiXl4l7Id7cPOTD5r9BS
 SNlQ7S2KaIK2wznKMO/HoLjyqgjZhMD7IeID0qZ3TfjZ8BbqOuvRGqLMgn8tzc3LAB8agyecsTT
 g0+xAUJYNoc8NRwjsjVNz+QckpIFcvn8kiUHKXwiZ2Qmorl1p9Fd9x1CQ9sTiJa59YI8DAUJ7Hb
 dQsvxWmevu1RLkIB1tmDdAS2pqIFmK+0m57zvWu5UJnhkIQV+kiDxu0Dd/kq0opljR4/anmfMur
 7WnTU2xy/QXL6JGYC1RXjxC4niOzOIZjfPwGZsXbo32sj+XkZkGkZ/jNwB4eNjVnoNor7p7CxLD i3hiwyQiWnJh+Xw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The prctl() PR_SET_VMA_ANON_NAME command can be used for exploiting[1]
use-after-free type confusion flaws in the kernel. This is just one
path to memdup_user() which is designed for contents coming from
userspace. Avoid having a user-controlled size cache share the global
kmalloc allocator by using a separate set of kmalloc buckets.

After a fresh boot under Ubuntu 23.10, we can see the caches are already
in use:

 # grep ^memdup /proc/slabinfo
 memdup_user-8k         4      4   8192    4    8 : ...
 memdup_user-4k         0      0   4096    8    8 : ...
 memdup_user-2k        16     16   2048   16    8 : ...
 memdup_user-1k         0      0   1024   16    4 : ...
 memdup_user-512        0      0    512   16    2 : ...
 memdup_user-256        0      0    256   16    1 : ...
 memdup_user-128        0      0    128   32    1 : ...
 memdup_user-64       256    256     64   64    1 : ...
 memdup_user-32       512    512     32  128    1 : ...
 memdup_user-16      1024   1024     16  256    1 : ...
 memdup_user-8       2048   2048      8  512    1 : ...
 memdup_user-192        0      0    192   21    1 : ...
 memdup_user-96       168    168     96   42    1 : ...

Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..818e74d11fb6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -181,6 +181,16 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
+static struct kmem_buckets *user_buckets __ro_after_init;
+
+static int __init init_user_buckets(void)
+{
+	user_buckets = kmem_buckets_create("memdup_user", 0, 0, 0, UINT_MAX, NULL);
+
+	return 0;
+}
+subsys_initcall(init_user_buckets);
+
 /**
  * memdup_user - duplicate memory region from user space
  *
@@ -194,7 +204,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmem_buckets_alloc(user_buckets, len, GFP_USER | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1


