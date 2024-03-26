Return-Path: <linux-kernel+bounces-120130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96888D2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0C1321220
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CAA13E8B7;
	Tue, 26 Mar 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxIOQJOi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242C13E888
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494908; cv=none; b=U3lpNxuKiYtF5LaSNxtAEEqDRotzgZXFBogAjGdoRR4CJQ7CtO7uXnppwBBAzUILAG2NligON8Tj+eRPd0Z+ADk2lg8/fXkPP8TDUDAJjQLmkGvSkwN8UwEivcQRE3Qx5rX9xKUKRszWYPFjkq1p7EZ0Fp1ZZU/xC65sNMmhj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494908; c=relaxed/simple;
	bh=HbJgaS7gzZEz1vcQZs5xP6L0oBbDSnuM2uCN/FSokC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PzXy8j/ZtI5gNFNzKYah2/bCbQtvKbZQ0NT7r7wXc40Koops4pf6r7KKVmyi385I4PVNgGiwye/gNqPvUTIYDVrYIjYNMwxfMMDlSH4/olsUB6C1BohBoFaxJZLUlVcgFAkK+eUzjQ3qYTpWbj+W3ikVp93U/TGEJ4vjoO+kTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxIOQJOi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2b53b99eso110845537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494906; x=1712099706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+F+6usxqDQhF/mNYRky7Fdiwo1Edv3mXCHc/EHtaoE=;
        b=dxIOQJOiDuB+UbNPSzKPL9+ViSXOVFVV7KnXIwfo4FAJqk1zJtnBL3XSps+ornbGlz
         80i0r9sgavlBPC9nHFR8klwcTBsMs6Y8DmpZRdt74XiIDWsUEZWm7lOaBCQqX2j84f2M
         zWl544Vh/SLfbIR3qFRMUH6wvRTo5VP0+vNh+qj5db6zooAcP4aMpMxna/CsPwNYBd0H
         dG9Wa84IsIzMTohScwIlJIqjdSTiIpAzdm6Ah+/Lxz0tuKiBJqUSH0WjYzGCZWa1G9fp
         JY/h6LQ1FGP5E76aG4P7PqmcDRCjaGPGnVyaX8sNGj2Un8Q+xUF2u9em8D/2/+wONfqc
         8fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494906; x=1712099706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+F+6usxqDQhF/mNYRky7Fdiwo1Edv3mXCHc/EHtaoE=;
        b=h+3BmGD+0v4bkM2xfxkU5O6jO+wcxbsHn0bmyj/UBJn/JPS0aB/ZMKHyvIOjYGNLfc
         R9+SCueUL2Z527P6BXgk1GSI+VFvRcSIInVTeuGmcN6uwqncayNzOadmpW2TETYUJzub
         ZuHsQ+X9Kn4CkJPrZhwg6B/z/LQ85SqslSiwWa+4jLmWLZjZYE3qKeL7hvI+TL1apoHp
         4OOBlZLjntW7HjBFhBXc/im7GUgLUL4zbuB4js0Wqgew4Qa24hQd+HZ3HxH8NzxqLTs6
         11O1pFfShGu5p6Owc3N+H24bo4HQh9SjF3VaCP/o1eH+v0n6hvnF60vmHrgtGQYDSszi
         TZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXEub4zLjczx8rVCqI2lqGbjGHp/4d1gtcvlvuF5sq43oDkqNlOk4iPROVtRv6YF9M7xG8V/66rj7Lo64ukplVONma1oCpO0kszj1Ws
X-Gm-Message-State: AOJu0YxJve911pYh7BtTvEjBf/YTn0XfQv4aZd9FCnWCKoE6DeFlduqb
	u7jEyYfml8uFyt8e6pOUTDQQwK3jKzW6OVmq1QQFaJlwCUhfs+T7ZrHCmRaCeTEAflWYHqbZYQZ
	i5g==
X-Google-Smtp-Source: AGHT+IEh1gX6lXyECJLY1fMCVWwqQ3VywgG+w8JbXje6jjWeQBputCgI/GB+VIFN+4ob3wSD6xLD2bTaduM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a05:6902:1b07:b0:dda:eee6:8e52 with SMTP id
 eh7-20020a0569021b0700b00ddaeee68e52mr1314590ybb.7.1711494906302; Tue, 26 Mar
 2024 16:15:06 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:51 -0700
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326231453.1206227-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-6-surenb@google.com>
Subject: [PATCH 5/6] Documentation: mm: percpu: undo _noprof additions in the documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With kernel-doc script change to handle xyz_noprof() names, the previous
documentation changes and not needed anymore.

Fixes: b3942167cb9f ("mm: percpu: enable per-cpu allocation tagging")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index dd7eeb370134..474e3683b74d 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1726,7 +1726,7 @@ static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t s
 #endif
 
 /**
- * pcpu_alloc_noprof - the percpu allocator
+ * pcpu_alloc - the percpu allocator
  * @size: size of area to allocate in bytes
  * @align: alignment of area (max PAGE_SIZE)
  * @reserved: allocate from the reserved chunk if available
-- 
2.44.0.396.g6e790dbe36-goog


