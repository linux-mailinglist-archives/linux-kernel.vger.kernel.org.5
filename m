Return-Path: <linux-kernel+bounces-152773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498D18AC412
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EFA1C21983
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3B3FB3B;
	Mon, 22 Apr 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAbYWG/D"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70553210EE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766655; cv=none; b=lUKfr/yqvulSoob/BdkLkS6N4DTvMAt3MltwjqKlOGUcznY/FxDsZp57dQq22GJoo2cvggHieJ5C4Ph1oY9QcsBW5lp97aYB5112fPITKu0cx/9R3dX5A3gVcdVd1ntgJvkB94ND2zrD5T/le81EOd1tIyYs4Lt0Tz7MOau85cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766655; c=relaxed/simple;
	bh=NxPO7O93n/NVo1oNufs2aAxGuHZaow1+ANLaG8nmtfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViqBD9jL7SWtjV8J3Pz4p95968yPXP2OwJuttwkFtfkBDJzIclCR4Ryacz57c9srCAGzHY8oJMT/lKohJ3t8kCL5Sh3oRAFruyxWmnNPYvqFIIvVcCygLqEGR3sIUMNEvFKHY5KGFk3wGBEHm4juY3WQJCv+RuRrgV5cUnsWV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAbYWG/D; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so3301926a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713766654; x=1714371454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1b+z/goVjx9YkRKhoEzKM+xLmhhl6Fzo8qCm3eFOPU=;
        b=eAbYWG/D85zs6EGktd4NMoaA9vIW6MpYXSMzyGHX5cInbla87wWaX9Hmc1knLSHtxb
         DGp0n7/OCWA60QL07byhkC0BFn1VRBW03iMhYmWCH4baxKT5tzPArr5V6a73GKsiwMo4
         jD43R5SqeFQankR/PUieyjvWeBqCkDLwMUk0tl6+dHHfBLx1GxtpXGa9Hf1wkwpXMIXb
         puiwzCykmpCdN/cIdF4IYeALTv9HzDhWMVCj2SI9T5LM70zzVQ8wQuIQNRPaznnvSry3
         HADLe/JUMK+BhzR1UvjrY5FV0sFxYGWzxewUx/e2E8R+3icmPGnP4floVj0f+S/IOILY
         7aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713766654; x=1714371454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1b+z/goVjx9YkRKhoEzKM+xLmhhl6Fzo8qCm3eFOPU=;
        b=XqKIU2X7e2utcf9cWx7plcP1sGB4QLnRLCj+91AnQo3CnjJO1kJPOEdsAryvWuf2nv
         gGC8DNHPZCqRfh2WYpnR0WpMyvNkv+BCV11BJVrLHHNLoQ2f8Cd/fG6symYlB0O2CBuz
         LUPsW7RlxgKFsMhxQv3EjRvLrkDWyY35eYqVrxe9DDO5LFAizlDHgbV3FC6nOF+vGGqO
         VPf85q2nruPXaXhp+edCNMF9wvGWXSLsC5zGg5YZzQVc0eNJU/1ulO5TTGXHnKCRoF6+
         0/daH7lDUx0wObJ3se5h9U8ghif5CnUQrjuyS0UHjMnVVNxdDYZIZzQtu4jdkFOdcsCP
         Ux7A==
X-Forwarded-Encrypted: i=1; AJvYcCUuqhsgC5KpR9KXfL6/k6qkPH99BFOMH3QoQjyGQDVA6ycUXTt2KrW4n8gKV9+EXHFb31LCZDwwsOejoE7Tt1ro56p3GBQ2XEK0KwzN
X-Gm-Message-State: AOJu0YxjzvjIIu3ng05IKoLi7uVe5XDzm8S0Oi6x9sqG/DoiHKiuByAu
	4NKONv7e6oYHglGNmuGNhviceMKewJb+lOpzycV75CrHf2oUNloa
X-Google-Smtp-Source: AGHT+IEf6w3kycs5FuY4nHyDOASb8CcoZfA5ks13u+jzfHMWAF5DwtIYKhLPRQb4OlJkNGWYLoRcTQ==
X-Received: by 2002:a17:90a:5b0d:b0:2a2:bd4b:764f with SMTP id o13-20020a17090a5b0d00b002a2bd4b764fmr7750171pji.3.1713766653545;
        Sun, 21 Apr 2024 23:17:33 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a5d8c00b002a474e2d7d8sm8626944pji.15.2024.04.21.23.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 23:17:33 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: david@redhat.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH] mm: huge_memory: add the missing folio_test_pmd_mappable() for THP split statistics
Date: Mon, 22 Apr 2024 14:17:20 +0800
Message-Id: <20240422061720.61697-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
References: <a5341defeef27c9ac7b85c97f030f93e4368bbc1.1711694852.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Baolin,

Maybe I spotted a bug and made a change to this patch as follows.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 824eff9211db..f3c4e08c6d30 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2994,6 +2994,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	int order = folio_order(folio);
 	int extra_pins, ret;
 	pgoff_t end;
 	bool is_hzp;
@@ -3172,7 +3173,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		i_mmap_unlock_read(mapping);
 out:
 	xas_destroy(&xas);
-	if (folio_test_pmd_mappable(folio))

IIUC, if we split the folio successfully, it won’t be large here.

+	if (order >= HPAGE_PMD_ORDER)
 		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
 	return ret;
 }

Thanks,
Lance

