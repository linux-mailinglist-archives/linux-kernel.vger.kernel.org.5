Return-Path: <linux-kernel+bounces-120128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071488D2B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D6321405
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB713E6C8;
	Tue, 26 Mar 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfUX7aQB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E913E40D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494904; cv=none; b=Oefh8pVxKsh2WjG9sgTzBljT30x8SNo0pGF/e7Nx5c4ZwLFA2SF3M41b6k8wPATponCqGblE9fq31Ed+0dC0FERLhIqvgUUKzUhWaOx0qgqMmg3TNwGaeAEt8BD5sf2k3lRTNphtUeXHutDW4EJ3gB0EzUO5Mqdo6H0Sv9IZGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494904; c=relaxed/simple;
	bh=K/Haww6ZkDCiv4hHYW13vR+vxYOjNYf1Vh9vwwpPIEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jS0iru5EdUqCIJ+0BU3Gea/bxWJsxkL08s/dvAnoXuuGpfy0srVPEy7SJRcPWqOGDXitT/1ITe32OMfaFiLy3sEY4srDrt4kH/4gjFvDfjR5GtY0wb5yRIrtAt3MC+bRFwvoIk1QMFqeiyOkQog4wmBb3Tarp77HZWtNEKodWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfUX7aQB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd041665bso112693287b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494902; x=1712099702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNPrBtsuBxYoCga3hg7dsxkL5n71oRPjdq2Ff7FyuGU=;
        b=SfUX7aQBkFisZYvPHaIlbBlDVhXjrtkigwNDZWL5DkOWkZQD61GON37T7o8zRMPp0i
         tapAJAY6ODwIJcgaR/Qulscc+iz1JAv9Qo6FnTkX45H90HvaM2+Vba6VxFoCFZYq+URs
         mqg+vqFNewuAJ6OYbOFeOKE5RHJAvudzPam9yzo328Nweqj5CxeS0iIB+zVYW38UPBVA
         ZRCCkSQ90Xb/dcMdV4owUxiGAw0GeyyScY8qsqJNfm5RC6jlq7Yymh0/Tv8DNWSZfptX
         uQbmXfqKIri8xa7ipZzqKZQwkb8zv89LUuXh+CriH3qpLpdBkpVzzf6+W7EruylkWI4k
         rSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494902; x=1712099702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNPrBtsuBxYoCga3hg7dsxkL5n71oRPjdq2Ff7FyuGU=;
        b=ITToEXX/Yc27aOBKmPCzgvej0/dQzbqww9G+iEFUqqEowY3XC01pHbS6m4rRUM/b5G
         CRXVSMGyLYPLwShQi9PMtVehumiLc3+ql1x3vZPb4ytFCS7Jtzc1xcC4nu06sgdnwddb
         kH1U0tmKTLioTeHpHCNAH3TtihjCsNwA/poRrXIgzideXVzuKcw4eYkaozg5YZqD8CpT
         Iu+COyKaXl84ajkBsWApJGsu6MKMGdhcfXxkz6MlK4fLGH4sy/gpHwz8HZZ8JMYjgkQn
         gpNtDpygfcJVMb5oJp7Okd9rnX2AJxOs8ts/2mMtc2vgB1Sb0uiLnB7zKcARH7LjNUok
         HkrA==
X-Forwarded-Encrypted: i=1; AJvYcCVmxtNCo557Orv9rBVERzXQmQZfRQqGQVr7U8H3fOsv66KPSPVRrdtjGIHTOoz0qTFUMRsz3Oha5Om+S9E1Un53lAiSlMxiVKC/FzCR
X-Gm-Message-State: AOJu0Yw1MHvSCp7LTX0ZAAqk/1TA+0svcl4CcTMtTqj0pJ+tLFsDc45i
	VxRdyJGNiSW3KNAWXCy1cXFX2Ylv9bfk+JY5zoKZC48I14/lsXsmPh5qCNJz/05OgEypZBql8UG
	v8g==
X-Google-Smtp-Source: AGHT+IEFpm0+0XVVGFx4jqfgVrxVNTvceJn+pxqS2nttVFrZvKzj/QKeYmY7MqyITw9teVftPomx36l4W78=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a0d:ea41:0:b0:609:4293:6a9b with SMTP id
 t62-20020a0dea41000000b0060942936a9bmr2737532ywe.9.1711494902234; Tue, 26 Mar
 2024 16:15:02 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:49 -0700
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326231453.1206227-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-4-surenb@google.com>
Subject: [PATCH 3/6] Documentation: mempool: undo _noprof additions in the documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With kernel-doc script change to handle xyz_noprof() names, the previous
documentation changes and not needed anymore.

Fixes: 01d3a2ac5e7f ("mempool: hook up to memory allocation profiling")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/mempool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 602e6eba68d3..63d4e3778bbd 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -366,7 +366,7 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 EXPORT_SYMBOL(mempool_resize);
 
 /**
- * mempool_alloc_noprof - allocate an element from a specific memory pool
+ * mempool_alloc - allocate an element from a specific memory pool
  * @pool:      pointer to the memory pool which was allocated via
  *             mempool_create().
  * @gfp_mask:  the usual allocation bitmask.
-- 
2.44.0.396.g6e790dbe36-goog


