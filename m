Return-Path: <linux-kernel+bounces-147805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F94A8A79E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B82282A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44E17C2;
	Wed, 17 Apr 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMckk3EH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D207FB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314035; cv=none; b=WaiCgoZbl5vNGf2dJ3jbLmskNE5pH3bRJqDlfzYs2DqrOWCw04y/GhAUzL+8y5sOeGY/J3puFCXTUUvId1EfzqoO8FauVzUs8wjYzroFzlTS7LE/5KMbl5QSmCGLSXwVUMAv9WCbFFsEUEz+kQEUjIYAOxvjV8COJcAF7uYM5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314035; c=relaxed/simple;
	bh=O5JndRQ/MudVsyg2eTBSjmyvq/vvAcGXbLRnx4IsGNI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h9Zy+/f3N0d5AC3UGMUWhjwlnkI84pFdroZsKS2A2ydGcNMNKztJES95Ops3e3xjBVS1V86WZN9s2BN0/YmrTPAEMRhajel/UEzstgGg7Ph2pF4MMsVLgtkda/NVYLz6+6yIGrdqpCIm66fiToNV8qLaAT/Fro9lYi68PfVbva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMckk3EH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab7fc5651so47065977b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713314033; x=1713918833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JBoignij4b6pxPqMg3EJqNELA9RvRPHOElI8T13Mar4=;
        b=rMckk3EHCjBa6M/8O5rba444TTtI+9d3NVH66np0JAZWqtO0lW9n+1cqUGfp6KI55n
         E9+oYQ5KNLnOf8B+4zHDHA7UPcQQPi5Er1OdFRv8WWsIY+vnLkUNJg04SE87VTUSkxVk
         DW7jjp4guuFQ3jtc2GA4YcaIs8LZiOIL4ATIu7VN+ZA8XSX5eEU52bUk5exQTmJ5lm0b
         XQ64oqNkms1BvdGh7pPQi5EyF2VMsbqZwNrwP2Jw/0S0iUGD6T5S3v4vwZQeDa7H58fl
         i+j3sV9WfUbcZuEcu6Zq4Y6idzRONT+lQNMtJGzklitUE+W4IGC5LtwsVFNNjvNvpGO0
         RNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713314033; x=1713918833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBoignij4b6pxPqMg3EJqNELA9RvRPHOElI8T13Mar4=;
        b=EL1FNKHa2J1HNa7PzB/YN0pCrcYdy93b098l8VglYsoUfuKQ1L8y7WuR3H+3jo7jnF
         8cqnLLeLf6JRSQFW/UVb9lIpwjC0S201qVmxfSnwAicDTEEUgp8qMd1UQVasFHr3LbwG
         ENigAWrv2G+HAdpY1dEoj+rsRZVTN2xDaY0iWSJWLlKRWI5vdTQb57tMKzNlkruM1XmM
         gl9f7o8EkSsM5ATabs/A5RWYrFI0Vmw44QM9hZA+gpkkfnURNkVa8bzM5bc0i/cToggZ
         3vH6sGw2rFJR9x9LGvaT2lUtgcwQ5JhenPivBPZWToA/jwPM4x0bLF+QDpApvYSVxO0z
         ET6A==
X-Forwarded-Encrypted: i=1; AJvYcCWEy9wtQs8n3r4gzcBlFACYBNCKhN41KUyw9Y0vVFIYaTmphzPhuNUV0SHXbP/4tamykkEKLQohP6L8iro7iRRv5RAAWX7+q/VKfcO3
X-Gm-Message-State: AOJu0YxrwE2NNxHmjw4Pt64ESoNaI4ePA37EyI5efPpeJjXM1uDTGfw3
	h0/5wVqasfHeCXo77egc0K5lsPJV/+YxCXwKLTW/I57MHNeQop5uHZwSkR/ckSFV9jHQK7k5LaE
	Cbw==
X-Google-Smtp-Source: AGHT+IEepxxAu7uVkUy2oePDFVu/E0erqVdTli0BxZ9jZgQ7uqWWzQPDFwEbjQEjPC6oB2DuwPWxKEWxeLQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:93dc:2d0d:fde6:7002])
 (user=surenb job=sendgmr) by 2002:a81:f10d:0:b0:61a:c438:69e7 with SMTP id
 h13-20020a81f10d000000b0061ac43869e7mr1961083ywm.2.1713314032827; Tue, 16 Apr
 2024 17:33:52 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:33:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417003349.2520094-1-surenb@google.com>
Subject: [PATCH 1/1] lib: fix alloc_tag_init() to prevent passing NULL to PTR_ERR()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, dan.carpenter@linaro.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

codetag_register_type() never returns NULL, yet IS_ERR_OR_NULL() is used
to check its return value. This leads to a warning about possibility of
passing NULL to PTR_ERR(). Fix that by using IS_ERR() to exclude NULL.

Fixes: 6e8a230a6b1a ("lib: add allocation tagging support for memory allocation profiling")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202404051340.7Wo7oiJ5-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/alloc_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index b37e3430ed92..26af9982ddc4 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -233,7 +233,7 @@ static int __init alloc_tag_init(void)
 	};
 
 	alloc_tag_cttype = codetag_register_type(&desc);
-	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+	if (IS_ERR(alloc_tag_cttype))
 		return PTR_ERR(alloc_tag_cttype);
 
 	if (!mem_profiling_support)

base-commit: 6723e3b1a668df6b8f305dea8fb62789155d965f
-- 
2.44.0.769.g3c40516874-goog


