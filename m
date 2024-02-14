Return-Path: <linux-kernel+bounces-64766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E421E85429B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F651F28088
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F411193;
	Wed, 14 Feb 2024 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UURaazVn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0711183
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890760; cv=none; b=ifwPPZx9BysdhbvE0Eh9ltawvyuDqjo9m076ozcLNsebaqqWK+l/5+wswhVf+4rzp4yQTIfdac39IHc+HSMQ2yH7/BwBdisCSzZoCINabU7h/4SibFtxaFXQBfHKrWTVui2L3IiYVd4MU5MuIoSJObKfdevUQAPJpN+GKsRt3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890760; c=relaxed/simple;
	bh=4tibeQEGw8nZW9VjvipN0HrxQMZ117NBTnKNMUrDr1M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e7uoI4K7iohqpK3VMg21pFoUf/Os0fGcgBOuYIvJO6Fjo9Hl8qT3veFSf/Jwn0lozdgHROqtN9lHgYg5E0AEeMOW47aP+bOT8LYZdn3QOrN5KDTXHwNx02BLPiKY4nJua1qat65zLvSsKoPByDP0Y1kGr0PyXl7jWFh8IhmXeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UURaazVn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so8176792276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890757; x=1708495557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tO+j6VP5gx0nxk/midcgHLSWwgpuiscaWbOyhmHxPio=;
        b=UURaazVnXkjyoXk+SaiJJBwgWKEGEz39bDSZpz3NsBn5C1LPpdDTjgblEfloKDoEXS
         HwNnsdSdJCEA65A0H5yyRTU5abn6OLP939gbgQtmKLt+r96vga0J5aWVdKbrG4DuWJx3
         HKKBKL1EMj8if9UStaVo47qi6zMeawkSuKjzJu/D/TBS1d44ZXl/F3E0ZGWJiCXkJATK
         ueM6w4fNvKsasNpjEiZ1lCvtwf5N9CexHzB9/6BuKClITuPxhBU7aoqhAPqc12KMFc8f
         uJnBSC7+7wXy1XSz6dNQFNQCTWM7EzXXfNw8JV3rZ9CHU/HpSC7kbx8wkoW0q3s3Zoj2
         ierA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890757; x=1708495557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tO+j6VP5gx0nxk/midcgHLSWwgpuiscaWbOyhmHxPio=;
        b=SNADoE2nDXm3Mz6xA2rW0trTAP6+55YyAMukV0ip+JXLtW3IsDpCxqjrMa2ToZyFHk
         rkJaz3wSMz7t/chcn11LuoRZVm25LzeQnT3oHptJ/ThPd/g0fB0Tb5f0CDJp4HqHq8x/
         tMNbHogffSsWC6/xt3KfuNFqhPqZZ1uqJg4ctexYB40ctTyQkzESSL5EWebKvNwqcizb
         BmYkebmkIdACUiW9yuFaqamjkebixFIZ+Q8d4gqQbnfim2eqVzztXpfsHobax0rNfGX/
         kzQTBAakGX5YYKymZinY/MqXO3FKPFKcYHCjVeY3/skp+8pyDs37dIhMPFe6GDRv8Vvg
         P8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNC+rbQgxO2LvlHkDJ2/P9vJeLWVp6GbFSO56XEb3QGTfnAkM4eqPmyX4IUGOurq7eXlvMt2HfpWLXmvGGDzZrYkGzVKiCZ8LVF6Z2
X-Gm-Message-State: AOJu0YxNZJ+3okvj4bCrVhm981M6U1RHy3v+62/iPbLy3OYaHhhBkMVm
	NKE8UDs5AgoKqoK07WxWVIKK5HvpK3gkOr1cp7qyQJqxALcYjHCGgmxLZS/7vcS57N8/HMcWCl4
	iWnatlaNfXA==
X-Google-Smtp-Source: AGHT+IEgBF4c944RJd3cQCweLbx8vH+a+ydCYR04V0MZVqfw7DEMXf56cIakMwYakhT2XmYDobhAmDLnwMk+WQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:114d:b0:dc6:d2c8:6e50 with SMTP
 id p13-20020a056902114d00b00dc6d2c86e50mr318495ybu.7.1707890757468; Tue, 13
 Feb 2024 22:05:57 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 0/5] mm/mglru: code cleanup and
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is a follow up to the comment:
https://lore.kernel.org/7baea98a-90ff-4c2d-9d00-d3ddc715c235@linux.vnet.ibm.com/

This provides MGLRU code cleanup and refactoring for better readability.

Kinsey Ho (5):
  mm/mglru: drop unused parameter
  mm/mglru: improve should_run_aging()
  mm/mglru: improve reset_mm_stats()
  mm/mglru: improve struct lru_gen_mm_walk
  mm/mglru: improve swappiness handling

 include/linux/mmzone.h |   6 +-
 mm/vmscan.c            | 142 ++++++++++++++++++++---------------------
 2 files changed, 74 insertions(+), 74 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


