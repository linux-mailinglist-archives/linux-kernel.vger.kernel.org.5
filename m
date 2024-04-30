Return-Path: <linux-kernel+bounces-164343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AC8B7C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9947284473
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4152176FA1;
	Tue, 30 Apr 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mceUQrBv"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B41527B1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493686; cv=none; b=H8kHmUYNm8HSlmaKN8zTX7niSEQH2ssdUCStq9Waq+V2zjRODdsARJJO6fMKD0vCO4LV8WOovySl6IZSmpI1sRuekDHav7MuOBEhG4S0owgLrDaxlaNv5Dm5oe8BBI8sNcTybLHb8k8Re66qcvgpOIzTq8qnYkYEZpWK+q3LxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493686; c=relaxed/simple;
	bh=4sVE14YqM1ge48W7lF6thDauNbOqwVTnPNy511jrKVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DosWbSNbaFQkRAADQsrLZZpCeWNAwQy+2MEWMFrPfT0LnulS1nqdmS/6exklHEf/VaOBDpEe0Y8o6lHF+j/T6P7jwGOqVKOROEy9+B/Xwrz9BOCYz9bR9deUzM4s0GJZzqgVJCbiOz0kGbZ+/hAluuExzktQnV+3qDZffBn/p/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mceUQrBv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e8f59d1d9bso65763455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714493684; x=1715098484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIciEpuWNLnk1gns0ydqprcy+C4ILYsBvN54hbVxkpI=;
        b=mceUQrBvPUcvm7jJSpgCc+9Rqt+5dBpodo7S4Y1gZUh3SJTCLrvP4faT53lyDZsM88
         Shk/QG5vhLJLek2Czkc6EgRnD4GJ/oYzcIc1woA5w9sftvpr2/a/mb8zL0xEONToWOAt
         R/xfoi3QHcy4m3MkksDnqNtPM/yZma7xwiunv8kIxU/cxuJ8l75GXiCUAUS81P1rlfr9
         IqNiqK3fy1oWq9PbfmA6KotwepJwmkC6LmdwdsBDEUOKK2zFU6optnuj9ZMpuppcd3n8
         6mOdgk+d4LLpQMvMYOmUVFWdABK1Y6IyGZq/4rZdSwKo15/TMFxoet5QsXTbbF/ekyiW
         BHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493684; x=1715098484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIciEpuWNLnk1gns0ydqprcy+C4ILYsBvN54hbVxkpI=;
        b=V8uDEowLK/U2lunbikFrmUnu7KGfRPkxYClqcHap08+8ijQGtSaOs2K4Nn4NtDcz7l
         RxXDhIOFEEJ/dTC8F26yB0ZmEqsb55KByrGshUJ1hIoOGtxmESPUVJKuHUmG3MatMILG
         x7nHZbe5e52pa2Xuh9iBflSm/uEois6uOL+5cIMeRLoofMunSn/znWFIF6kQYXQouz4Z
         I3XcnnvKNaT79M7OWC7R6Hl9kZrbYOJfftUuR+8F7eNTHRgoCD7xE8Ff8mHbeOOhDG5m
         xrW3VnJT4dcx5F31wssngqR9woR3QtSykatatNamRkLwMHMv/YgwWMZPFCFt6wTgfI7F
         EJ2g==
X-Gm-Message-State: AOJu0Yxx5FsktRW7eKgKvsQaGLIrE/RW6y/Iqk4uemVFdmE7WSFYyfeu
	uhEEAzj6KvjowRhHDfXtOw8ke02qzUqLVdHl5OEd06m/9GFwrqhwNY6zHby/bJS+K7H2Eg==
X-Google-Smtp-Source: AGHT+IFiuqHf8Bdc9itzeJU5mtt9Kt5Vy97V7tjmiaiUTiwgh4BpQuWSkEcek6UijTJHvchO1p58+2tt
X-Received: from fvdl-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:46ab])
 (user=fvdl job=sendgmr) by 2002:a17:902:d4ce:b0:1e8:37ea:d17 with SMTP id
 o14-20020a170902d4ce00b001e837ea0d17mr1158848plg.1.1714493684169; Tue, 30 Apr
 2024 09:14:44 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:14:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430161437.2100295-1-fvdl@google.com>
Subject: [PATCH] mm/hugetlb: align cma on allocation order, not demotion order
From: Frank van der Linden <fvdl@google.com>
To: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Align the CMA area for hugetlb gigantic pages to their size, not the
size that they can be demoted to. Otherwise there might be misaligned
sections at the start and end of the CMA area that will never be used
for hugetlb page allocations.

Signed-off-by: Frank van der Linden <fvdl@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Fixes: a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5dc3f5ea3a2e..cfe7b025c576 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7794,7 +7794,7 @@ void __init hugetlb_cma_reserve(int order)
 		 * huge page demotion.
 		 */
 		res = cma_declare_contiguous_nid(0, size, 0,
-					PAGE_SIZE << HUGETLB_PAGE_ORDER,
+					PAGE_SIZE << order,
 					HUGETLB_PAGE_ORDER, false, name,
 					&hugetlb_cma[nid], nid);
 		if (res) {
-- 
2.45.0.rc0.197.gbae5840b3b-goog


