Return-Path: <linux-kernel+bounces-154701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1F8ADFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CD81C2271D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6A5644E;
	Tue, 23 Apr 2024 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw5HL3Az"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C3535DB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861600; cv=none; b=TZ9mrIfF3vf8mkAgA1WQLVwmSCDpehRfB2MiBgV934/wdDqYiadYundI+q3NiqTZyRmYLMA+wgh/NS267X8jRxaPi6by5IqYAuAbgi4sjNhgFHrPBQy5TX5NUi9h7QnUdKguGAF0zHqwkQh/OiH5dw0fZfVkhnFa4637v0fTanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861600; c=relaxed/simple;
	bh=hUxnuqL2PMoKNdJqLthpwjtho1qwOuyydpUkgGnYWrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYX8n6O/gIq+MCBpuvWJaNZRiOSVCro5IfDzGmrh6l2remuqULXmCY1SsahehDDNU3nBUvwjpRUj0pqMUvMkdvk68rjNxOEnfTOfa7VjICwXUn5PuwQ1xbRO8IwOB0IXcjNTa5zW8LZVYlPcF7MJsRj63ZVpFmjOLusBuUgMHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw5HL3Az; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so5237055b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713861598; x=1714466398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ihD3jb/Us/Z6Kem6hQCYxCXpK+hNZKDWnNmjR4ycrQ=;
        b=Yw5HL3Azp/P1qPMmeJiHLU8H59ruGN5kYluNlc3bEEg3cyKCgT7d4Ix0wi/YLUWXCq
         SXbv6qR2hEw0F+NaxHC+xvSS5Vd2Dsjx23F3FF3rGPv8W/7DBirATCGxPWebtEg8njbh
         yrlMYeQmWtbcQb7teFoA9lRog6CQ0lIVPbJ1vXSy5wVjvQ6nNNnD1YKWr0OkPadgsSFm
         HRF5SPHiXX4YPOQfWpl6NIt1uQuQ4EutRZVzx4GT42PA0dMeRvc5AUC9CARTxqkRSRDh
         zfw9IE6s674bdwOo0t3V/qpwYuvPaYYVqPcpwR1crEgr8ExR/gyo1H3dfh5++Iaj8nw4
         L7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713861598; x=1714466398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ihD3jb/Us/Z6Kem6hQCYxCXpK+hNZKDWnNmjR4ycrQ=;
        b=r/96iSCyN7RDrs0NX6prvg9kfLhA/pzeuXjyhdgbPiknvU88mlhEbfhmPEeY3Kz8kN
         bre4n9Gwbj8mOsc/u4nFaGc8wudWy4mdiNIzbgS/TTDXcE2yFJwM1nT8JhpbjS3qS6I9
         GKokmn4EFP3xQ69ZENHx4GltO4TDRkhUGNJFs8CBO4csBo1XlgkE91xtAP8CWYWysUVN
         nbZOVykCvkzQsjUPpks18eHNnZB+cPN0C4dBKrUSaI2hnsGSPX5CM4LTbJGk0IO12R8o
         FpDK2YZnE3NubAbUEV9x+R2alRIBNtoWySAFRcj/NGUnAlt+eFYtAZ3H+0Rd/XZ301BV
         871A==
X-Forwarded-Encrypted: i=1; AJvYcCWxYK6cy6l9+vq9rq28CKp9eu7A7zzPUK1d68iUoIzj9EkwqO/qWz7U0mpagVNKkQKZL72GaMwlPVdFZHFiY1L0re5oiI8YYYdqa7bL
X-Gm-Message-State: AOJu0YzUJfkfl8NUfnsA7nEx1j8mnMSeRO3S4/EDMarf0gyTKnFZ/amH
	3hukPiMJZ0ua5MP4O4nT459ZO4TrPJE6PIciquY5VMIhCYpNBMVA
X-Google-Smtp-Source: AGHT+IEthgN1iS58ClxkD1qG3g2hjq8TWRx3fBXvqLxwb+i8a3emvKfEUAX+vdn1KvxNMCNoV3w66w==
X-Received: by 2002:a05:6a20:9708:b0:1ad:3d93:b71e with SMTP id hr8-20020a056a20970800b001ad3d93b71emr3743979pzc.59.1713861598439;
        Tue, 23 Apr 2024 01:39:58 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.252])
        by smtp.gmail.com with ESMTPSA id v7-20020aa78087000000b006f0b820022dsm7565155pff.75.2024.04.23.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:39:58 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support large folio
Date: Tue, 23 Apr 2024 16:39:51 +0800
Message-Id: <20240423083951.1380-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
References: <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Baolin,

[...]
@@ -4727,9 +4725,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
[...]

The mm counters have been moved from updating out of set_pte_range(), so we
we may need to rebase against Kefeng's patch[1].

+	int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
	set_pte_range(vmf, folio, &folio->page, nr_pages, addr);
+	add_mm_counter(vma->vm_mm, type, nr_pages);
[...]

[1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/T/#me2827c26ff453c0fa86f2af9f68f245978b08774

Thanks,
Lance

