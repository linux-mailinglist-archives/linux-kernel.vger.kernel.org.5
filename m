Return-Path: <linux-kernel+bounces-97566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF99876BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A451C216C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE85E08E;
	Fri,  8 Mar 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaNwdkEg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20C5E062
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930705; cv=none; b=rK4LUT1T2mtywYnlXAZNkRR1g1NCr85YHYcfDu4QWF2UHQFZ2fNet/KLMweGBvIVc34Be+PzrHdZfMlyLmSHxiTtWVSyAZ6OZP1Z67Kj6hRcd5TckvUAy7HgSeQguMvp7D9LEOrhOXct/evGbdP23pzJvP8u02r7OoLlVP9XUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930705; c=relaxed/simple;
	bh=apgy2KkEW0QvYg021TiAG31Or9OxNDK+m4Ju8mBkQnA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SxZW+eIwrUYpGTPKWR9oIY5ZQyyHQhHyMha346YUJIYhjemkjyf0aUoTojUMWvdy1eWoG6Lz2VZghwH8HgHcfjQExEQoTvSlNwYW8rQCBxf7ZVWM9bIkD6K+jEM3SXxe5uaODc/hGePx7caBBVCb9lPGlvz3r8nIXHb6KVy4JxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaNwdkEg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso22438407b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709930702; x=1710535502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjFL5L8F3THQHpcIMqv7B8K14lldlTAEFwF+BxbmXAk=;
        b=PaNwdkEgc+n50IyOvGKRIUaukeIWZBMg1USKb8yv3DiFzaqS4DwC2mzLDpz2LcNCkU
         SuyHje2mqTQoFIpmlGXeIcubJwKoG0YJ4LrlH41j+1sK3G09zOSsCbGYw4LOFj1FQ/ZK
         YvoztefoOfftSvpxzQAGLyF9easr5zO1MnrwhCzOFME0OrbjQXOMCx3FkQzNbOsz5Uxs
         BebKzWCYiln1QJ5RjejCB/bvrIcqNEYtElbm27H+0EXWlP+5PqAAM4N1Id5q627a+ckh
         HHChj+LOzTWpWYsz/KGTwcvM9wIKDpY6zN2Vh/Pi0UfD6esE6unp+2SZ/L17xgyFOFm1
         PRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930702; x=1710535502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjFL5L8F3THQHpcIMqv7B8K14lldlTAEFwF+BxbmXAk=;
        b=w5dsI9YMKsYttNQfIePdo0lkJmfGCJgR5dUdhOV/u6HV4BceuVkfRIsb8Tj25XjOLP
         qFfc5Bw/cXQ+U0Sp2MtmwKkuuKXljf0zkfcFvpLrxmK/lzTBb6VGbOqjsQJoMYX3/Ep7
         KYqTLerxUt1WwD+P4PNWUU+J2OJHScqC00pp9qpLXApRIudC5y9xpDpLLchTf4QwPkXC
         8751doL+MNV8PTQXH3DmfJm5ZNJ9s15n+QvfM0PABkfHaNsjG1roM0/wJZ0U5lPV4lYD
         k90Df8LQMdN+jvH9j+b9Ke92VwIzg7F/vXZ+b+EagJQcYZVHticdthAFPoS+lEncNisU
         DpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYFLTcY/DWEvOivK5nUghZub8mwG9zKfnNPU8V2ZiLSg08s7fIgXhP93zzVC2aLnj/gCoRFIvIP9SPXziI9fUxgUo7N51gRHuOpACg
X-Gm-Message-State: AOJu0Yxj27YW/MhRm/N5kzfjKpCL/btmLGZL+KIKeWRN2YMqMQCF4P/I
	7kfqwiqcliFcJlygTuuLnb0UUU6FnN6KtmLG2JEWGHnHhmY3Uhp/mrfXRbxDfQdaz+U/yjhCJjb
	h4io0i6CuoO4AjjQQefWMwg==
X-Google-Smtp-Source: AGHT+IFVU7jzq6E9xu3HneAng3sv1zQVuRlcZXLgPqus9mYRoEd/VYBSS/TAnLDzXeAh0CPebatQ84t6tDzpgKtlQA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:8bc4:6d20:8bd9:1e9d])
 (user=almasrymina job=sendgmr) by 2002:a0d:d98c:0:b0:609:371:342b with SMTP
 id b134-20020a0dd98c000000b006090371342bmr51028ywe.1.1709930702628; Fri, 08
 Mar 2024 12:45:02 -0800 (PST)
Date: Fri,  8 Mar 2024 12:44:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308204500.1112858-1-almasrymina@google.com>
Subject: [PATCH net-next v1] net: page_pool: factor out page_pool recycle check
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

The check is duplicated in 2 places, factor it out into a common helper.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 net/core/page_pool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d706fe5548df..dd364d738c00 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page *page,
 	return true;
 }
 
+static bool __page_pool_page_can_be_recycled(const struct page *page)
+{
+	return page_ref_count(page) == 1 && !page_is_pfmemalloc(page);
+}
+
 /* If the page refcnt == 1, this will try to recycle the page.
  * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
@@ -678,7 +683,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	 * page is NOT reusable when allocated when system is under
 	 * some pressure. (page_is_pfmemalloc)
 	 */
-	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
+	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
@@ -793,7 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 	if (likely(page_pool_unref_page(page, drain_count)))
 		return NULL;
 
-	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
+	if (__page_pool_page_can_be_recycled(page)) {
 		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
-- 
2.44.0.278.ge034bb2e1d-goog


