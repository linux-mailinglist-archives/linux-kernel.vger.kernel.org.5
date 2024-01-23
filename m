Return-Path: <linux-kernel+bounces-34521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98DA837DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8D1C24975
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55C161584;
	Tue, 23 Jan 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTHcGwC+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69115FB34
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970179; cv=none; b=Lmo8i4B3MNo+82QTcDwpdlQA27vEQUuClSNgATSI/eVeJlvEiREUFgWHYnO+Ov30HzuOkGVpMTWW3qrgSg66ckw1r2Mui8HzCUItmF2LwFme8rcJPX37UX2uTS/yLsQWo+2e9d0nGk2Ue61iCaOHnIvOlDxRZSHSi2uGrpIv9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970179; c=relaxed/simple;
	bh=38q5dA08W/MDhiiAfLHBMjgxLmUPPANEZSbZB460/eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pt2SXoFImS1X8TpDuYKx0O5NRVZw23GNLCU6DOLX/3+nsloyzz+TLBeN+PbPlk+lohYpvJxQw3BoZULbLdTW1nOH4gmIrsc+JrWfkNJNfX8OJ97z41KZQP4CFlsFN7qh8pOnjink/Zs5y4X9CCJIYhChDeS8tsp8RZ1lhfknrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iTHcGwC+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so21191365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970177; x=1706574977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NeuRUk433ZNKdRiqKX8mhaA8jznwDCQBGOUrYcR3Zw=;
        b=iTHcGwC+TxdH8wNfXLwBDKEVQDF89Cssi7u45AB0zh+smdib7LGaXLygjz0Z8mTWG/
         xRou3eED4hvdmVeqOqGy1nyGA4SBGp2UfP0bpElZBo3tQSpUS+r8V8Udkjmh40t2MBQg
         DRCb4cf28W5gBhnGrM0j6SDfw6XZlDl1w5QKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970177; x=1706574977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NeuRUk433ZNKdRiqKX8mhaA8jznwDCQBGOUrYcR3Zw=;
        b=Ywcw7JkvxGwrp9qFGmXZXvX7YLVCa44GhL+Zw5O8u7az7FL/bSBfujkDsh1fwGujXj
         NoWjW6XPk24MWBFcXT91oWa8GX7Zs4pzCYsuK5xog8fK0y8hRlkSH9+xslnah/suoJGz
         kqDXBc288C0DaK/gOpvrBLOXFGdkFN/eZ3sFF2Wg53N1BcQs+aAOMcKVwWWWy9fzuKo9
         v6k4CFAhQ28epUNaeIfrb2GgL45X5tJ3a944IRe3lmni3L7pXSlrs4jzpgyXD/fPFCfl
         qvVE4zyRgKP0sev5vYm9WCa28mU9sk9Quqf1VpZ9LTf5bUClPA1Eaf4qAsKU7OuWqPu5
         YT7A==
X-Gm-Message-State: AOJu0Yyym0hxjmX30i1FWHRJgVpmr7/lMlQ7qtVMfdcjs+Xd8w3eBq7n
	yc382I1URIw6P7lCOItWeEqO7gq4qqmb1yu9acGXpUFSPj5AuhUvGkS180eAvQ==
X-Google-Smtp-Source: AGHT+IGzeIhLGStyUXkk+prqRHH7Hh0fJDcXpjpuBSpJSnr3lUskSGrUG6ndGqpvhP7k6BsWTy450Q==
X-Received: by 2002:a17:902:e882:b0:1d7:600c:cc33 with SMTP id w2-20020a170902e88200b001d7600ccc33mr1403863plg.3.1705970177668;
        Mon, 22 Jan 2024 16:36:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ky11-20020a170902f98b00b001d76ced199esm143464plb.31.2024.01.22.16.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:10 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/82] mm/vmalloc: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:08 -0800
Message-Id: <20240123002814.1396804-33-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=keescook@chromium.org;
 h=from:subject; bh=38q5dA08W/MDhiiAfLHBMjgxLmUPPANEZSbZB460/eg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHVlKrqE6Nde4ZbwV5OP6txkBJRZom0feq8
 p5yVXsvnAKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JmDjD/45jgwtrPqGoB+jlF1mDgiUg9Ze61xsHyqXZi5GyOp0rRLZfu6w2qW/aeqxQOzjPHho3hN
 L2/snj7oP3CEPVZ0AsZx5pNEw4AdCtJLMAqBMw8/yxliXAWWX8mdo3JSCpQSuGT0wNY3HEJ6m3l
 767XUkSfXo0VMs7+zd9DD+QTPMbV8GiSHrIfuaQMWoFDTr2PGGuOkEJfKLkVm8xcx68Q3gXonHh
 HOulIEvVuQ1wZ/971AY053i6TtPwkVQwttgTrT2I7qKM1rpF4801pZ6otFPevs/V20afhyDicxd
 MYf8bStbkOH8rXCaMRPbidxMQjMXvYBiFsbP+mWpuT0JkM6pBI2LDqDlh8wSwQZgl8lebVhoHsE
 XK0CCEBLvbN+lIUob2oN9JnImaQHOqI3vVnVdhxbYb1UfWeyb+9l7M52MDTY2cu+v7FIrIQxQaT
 Fp3QVNpjmkPKha2+jQyIAdAzfh6eFs21bZ92fq1gfnflXD1g5DYntbs9alZUEupfryc0jVwHArb
 5cG743scfNC8Ph2+PXR6mQ/CI27ccqmUA2og/teJ1KqdKi31qS5E4P+XgGkowzLSabVuBBnq6t5
 T8sabUmzoJL8AOtQMe0b06WPwGDOieCgh/OR6kZEHeys+Dj/7McgMk4ZPYPsu1HFh7LgL0n/nRL JTk2zIhWKJNoPYA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/vmalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..7932ac99e9d3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1223,6 +1223,7 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
 	unsigned long align, unsigned long vstart)
 {
 	unsigned long nva_start_addr;
+	unsigned long sum;
 
 	if (va->va_start > vstart)
 		nva_start_addr = ALIGN(va->va_start, align);
@@ -1230,11 +1231,11 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
 		nva_start_addr = ALIGN(vstart, align);
 
 	/* Can be overflowed due to big size or alignment. */
-	if (nva_start_addr + size < nva_start_addr ||
+	if (check_add_overflow(nva_start_addr, size, &sum) ||
 			nva_start_addr < vstart)
 		return false;
 
-	return (nva_start_addr + size <= va->va_end);
+	return (sum <= va->va_end);
 }
 
 /*
-- 
2.34.1


