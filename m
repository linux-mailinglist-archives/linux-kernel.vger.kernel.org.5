Return-Path: <linux-kernel+bounces-135254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739089BDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC041F22538
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157A657BD;
	Mon,  8 Apr 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KV/DZvAL"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84F524AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574731; cv=none; b=cMBuB6EVjvyMOuoNMC8RweiC+CvcamC9Cql3zDo8AztfJF0cvBOvUiOMx+t/beu8H33mc7TgRjmxCGrfZvKw5P1k8r315JnVKl81HycSWRKy9TU5WtblNlOdSN1ykslJe0NnpE4yKpIAKOX7OsK+aFtJprVVh3yMAC6nAAb0bnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574731; c=relaxed/simple;
	bh=WIo8Cob0ubQ6cNbEg1jHYOeFb/hVRTAaOywGwnSVCZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W/eNcTpH3HG3p17zj8Vqh+qsjiH1yCettZDEacT3bgzkWCp4Qk7r36hlbuGB6lOg+71fvZayF5NfJqK6h/YJ1y/7PAEETKwovciL2ohNx5oGKNDqVKLboVF++XBPYlOus+93WzoymnQd57uwpmeLzBClzVWTZ2RKQmVUC3PL+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KV/DZvAL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed112c64beso1246639b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712574728; x=1713179528; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lk5jTXS1R3gpG4dXLk9/g/Ee95SLR84MxNk7dz4nLRQ=;
        b=KV/DZvALUH02cvXJMPzCPukLwYOFlKOMGIkSUb2qBs+QdvG2qnEAjPxCsFA1AZY/+x
         NAfjy2zzSwuBHUzAqI7rVyRhWXJlJMN2wgZZ8ezIoYJfwq9Iym015BOBJpIGPjwdft+1
         lxSAHe0Ex+ncwJXzUNH1HO3vbSTEiHn+QgE7lKoYRAKzrNR1ns4NrxAtVJJuloSoMpuL
         Pe6Qrrx9RZ/3zgcuJWvi6JDY/ple8oNdis6v7jR06LzwBrFVbu65btylH8V57mBf6YHu
         hUV4ZNQPzB0bSnKEuRPshaFR8h96RG6gKUreQ8kyeShLF/q2UnLyDe7I32WHWwLcIaxF
         /yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574728; x=1713179528;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk5jTXS1R3gpG4dXLk9/g/Ee95SLR84MxNk7dz4nLRQ=;
        b=W01Acb/7g9fB1z81uAcFiDu9N6ijtz4m454U1RcofyHm+sxwng0HU0A7kY+2tXJ3H1
         lJaLImHBnRpsUKB3KLLbe20Iu5xrK3r7EKSM0mQPHGuEqIJetrxvtV9E+a6HYfQO3wHH
         JWbYMWYpJbiHHp6SSFVrPehwMXWJl1qJDXQ091edruqnOjrxmEm+Wch0SrwkQ4x0OgAP
         VgR2hRaH4B2xxgiV1WyXjWRek2PwOWAR5/7bK56LtlhgU/cV6cAjJ1DKtDvQsharJXM3
         E681C5lH4AZgekmNK9hKf3uhMey10kUoYAP58eeg8YdYdDF/OZ3LVz3jXKvD8YF9IYn+
         VYBQ==
X-Gm-Message-State: AOJu0Yye9BMRFBjSo1pcpe4+JF2HxH+19//Xb7javeRwO0ecFdRiBtzB
	kvSlhHjDPrkwMAJzdiwdeRz6dUTBwNpk7hXyuzR6Fv2+QoihDOJoU1nDIsb+t7M=
X-Google-Smtp-Source: AGHT+IGxWgFAYAAKSFxIF5EE744SLY4BtRE9LJ7wuwdIv1a+mdSvFV/QQYTJ/sE9FCGni7alyXx5hw==
X-Received: by 2002:a05:6a21:789f:b0:1a5:6f20:d131 with SMTP id bf31-20020a056a21789f00b001a56f20d131mr8291893pzc.42.1712574728571;
        Mon, 08 Apr 2024 04:12:08 -0700 (PDT)
Received: from bytedance ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001e2bb03893dsm6711958pld.198.2024.04.08.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:12:08 -0700 (PDT)
Date: Mon, 8 Apr 2024 19:12:03 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: liuzhaoyu.zackary@bytedance.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: calculate pages via roundup() in
 __swapin_nr_pages()
Message-ID: <20240408111203.GA203766@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use roundup() to replace while&shift. When the "pages" is large,
using roundup() will be faster than while&shift.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
---
 mm/swap_state.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 642c30d8376c..d34dc95d0910 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -590,12 +590,8 @@ static unsigned int __swapin_nr_pages(unsigned long prev_offset,
 		 */
 		if (offset != prev_offset + 1 && offset != prev_offset - 1)
 			pages = 1;
-	} else {
-		unsigned int roundup = 4;
-		while (roundup < pages)
-			roundup <<= 1;
-		pages = roundup;
-	}
+	} else
+		pages = roundup(pages, 4);
 
 	if (pages > max_pages)
 		pages = max_pages;
-- 
2.25.1


