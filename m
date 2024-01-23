Return-Path: <linux-kernel+bounces-34517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9C837DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0703E1F24FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F42815FB18;
	Tue, 23 Jan 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFC2D/w8"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CE15EA90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970176; cv=none; b=CPRvF2+PaxPkcwIgRdvEEFD0KxuRDgckKO9UAac4i/Pr7CmKzWBkKtocYLuWeQofLvvda6IUHRpNIuNWIvdtpV1F/G6H9UE1ucBqfWj6wVqBFTJGSjTodaV2TBQ5Vvods7b2FPRxOPPVBlVNl7wMjm/icDcMF4e2byN5GPA8bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970176; c=relaxed/simple;
	bh=O50T+ehgWO04+/PTwK/XEjtbdWM1siGuxiWx5Y9VWF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkLCuvKljkHhLvWPBYLeZNHc7Qg8sqXyE7gVGwRy+CrHUQ7wVpCtS+/1VObruGkQw+2RT4zeAVZ7f1Fd0ZVfhuBtC3rWC+iZ2b5MJ3qQ5r8jE8AhmYTsHZ9ertDWd8txxFz0mOGPMw5gGPvNBOOKfb6t61oUu+XzLXAG1PxYqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HFC2D/w8; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0af93fdaaso3439645a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970172; x=1706574972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKixWzqfowMzvUX6r00bx/1VlD3LFsId3tPJIJRuIR0=;
        b=HFC2D/w8uclQu1y30dfKDrOf3EDdjqB5rPeIVnPGsAqsah4CP4enAkdphiBcykqKpz
         EAo95xODZqXsiNOS4A+vkjjOuGBI+mWHfVKsgsH/IR798pDBAST9TLl5ibXCe0VYwil3
         AGFLKlu8M/+rFzg6fRtzH7YaH9yB+Xewexpk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970172; x=1706574972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKixWzqfowMzvUX6r00bx/1VlD3LFsId3tPJIJRuIR0=;
        b=xIGtwu/GfBxPEyPL0VKh1roaoHsGFf7PyzCFgSswdTna7XkOTE/v89Cj/K5SrjiMxB
         jZco43lPm8sGikN75g/qTW3gb2I5+fZqk3cEAcofcgoD2t+Gigp62QsSR71fpBZ8OuPG
         DlosqG/snWxaMzvXR7yf2iE6P3LV3+QUl9m4hlZNLK66qOJy3ufEhdwe7CTpLUj3A/8s
         rBTKZ6/nG8fj0BiObpEm0vcRlpI0s2TubPiC8YNkDDn4k60wIw1p7XooREqiFflZC5VT
         EMiJDa9mEfYjwMrrvcZGXdrrd1VkTxY8cU3F4IdEayijY+Xut/EYYfGHDezJNjL/ugOY
         VDUg==
X-Gm-Message-State: AOJu0YyAT2TGWv1gxVOMPv9QzbYbefFsdqU5cog5Q/uRvZon3ijeSv2W
	J6QIA6T1AuOFZkKPrA8suIRmH6lh9HEvdB39VoF4ENjht+1i/U36w8n3jMxvhQ==
X-Google-Smtp-Source: AGHT+IHGoYZGs2buOqQkiIhEJDExn82aWCutmrbis2Hs9LbtRGU/qouIkWFMc0AMtn7Yh4iOMq5Tmw==
X-Received: by 2002:a05:6358:719:b0:176:5d0d:4c6a with SMTP id e25-20020a056358071900b001765d0d4c6amr1659265rwj.29.1705970172214;
        Mon, 22 Jan 2024 16:36:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sb12-20020a17090b50cc00b0028cef2025ddsm10440436pjb.15.2024.01.22.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/82] dma-buf: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:26:50 -0800
Message-Id: <20240123002814.1396804-15-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=keescook@chromium.org;
 h=from:subject; bh=O50T+ehgWO04+/PTwK/XEjtbdWM1siGuxiWx5Y9VWF8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgFQ84pwHJOpkJM7cBBjZQ+dyB2q0GyyRoUN
 phvzaNFVByJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBQAKCRCJcvTf3G3A
 Jju2D/9msHfBekreecuP9d0fYucPYwOuP/5LSP35dnh1uQL9A/+S6Af8H21MOl+me8AiycS0dk2
 0Nd3au8vn2Nl78aIRV+C7DFP3rFOa3KdUfS/qJRRlEE9tAeJXHJECtKEMp7t9CehEJHacXZIT45
 r8trE7qdtUW4JMqG9sya72KThUcsRNHfVbJQQ536OU9zvx/NhCHm1onTJ2C9o3h+1II4GGGKmlJ
 1zJ3W0eVSeM24egFgMxHcqvYy+Cue+A5RfFDwojwaBnfmWhBtXesTBwFJTsQanPGWE9JxbSxsbz
 CglnWiNPjq9pDs31mtBqwR8DgmONGfQIo9NhxiQ+1Cdjx4VWvmPO49vDUmd1yNPDgbj/QxI/cRq
 ARVjAjmWNHxVGH0lTnwUrrDgtkF+R44Iuhdim/nvBSBZrpaG8yrRA+4NFpPtsZOwVdXMSnfI7wQ
 gE0joPsgazTDQFUqzcRtfyqrcvYXIeIiXdh/Y4Ej/km9tQ0/0DLxTbTCqoGtnoSuEVfvCzs+unU
 tfzaCnbjn45fawrtcGUb6pVdFQzPQRUw9P1lmZqDc+GxwioZP4dCvcu/bG0+essTAlw/09sdKqu
 O/ci8K7u1AkUc7NcLes5iGCNf8aWaXBCSkX8vB/mu6PUk7piIN/1FYcQTY+LYW8Hq5cLwHBPmQn wygzmyMo3p0bqsw==
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
wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8fe5aa67b167..3743c63a9b59 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1458,6 +1458,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BUF);
 int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		 unsigned long pgoff)
 {
+	unsigned long sum;
+
 	if (WARN_ON(!dmabuf || !vma))
 		return -EINVAL;
 
@@ -1466,12 +1468,11 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		return -EINVAL;
 
 	/* check for offset overflow */
-	if (pgoff + vma_pages(vma) < pgoff)
+	if (check_add_overflow(pgoff, vma_pages(vma), &sum))
 		return -EOVERFLOW;
 
 	/* check for overflowing the buffer's size */
-	if (pgoff + vma_pages(vma) >
-	    dmabuf->size >> PAGE_SHIFT)
+	if (sum > dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
 	/* readjust the vma */
-- 
2.34.1


