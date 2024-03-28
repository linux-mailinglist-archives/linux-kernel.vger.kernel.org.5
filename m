Return-Path: <linux-kernel+bounces-122335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129088F55B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BB529FFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04E28DA7;
	Thu, 28 Mar 2024 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVoiBAId"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2844A20
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592938; cv=none; b=YT7Ax7cjWnrYyGzf9EYdbkophlBHlcp5SIOQOfJcV2l0a7HXxzyC01SE27VIJuJmgyVfXCZfGCpPf22faLIDAHWGN+kokdbiyKSKu4fR7w8W1pR0FWG6zRvilq0kJkBcb0QfBq/Hlfxrz9PIqdKP5GwLHdBUUmfiRqqI1Oc2vAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592938; c=relaxed/simple;
	bh=uADWgqTdZPs3ooWD6DNngdj0+J6hDdu27ExPl0K+jUE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u3qq6T4DFTsoPeFx/6TxV51FqIGRcFMiWxeAOwYNFQ5CuHMD/xJKh++z40ahXVk0nDrg8DQ0FUT7onBALOhahB0wjWqwb5UE9Vvlo6k+KlHSQ6o9651tNi2c4044iuiyl0FWX9OImT9Xcc0mjXs7HsamTIgajkspDwYGcWD9kx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVoiBAId; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3417a3151c4so343850f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592935; x=1712197735; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gOKRjqt6k/vzjfUi9UjZzO7fr9ZlHBfE82m8aWUoKI=;
        b=lVoiBAIdo/RRmHNDDSFZccvri+HqIVFxz0E/2QzmA+eT+rlMPaV9SYRkftJi9KkTmX
         8mKSqQJrSwACG4fn5ePesyXPBW2jkmRb8LyYpPD1Ldky3Zpa5YApa6m5yfaO/LB0Apn5
         NAEJhN7nbXAAOcBbaBeZaIETdU8n4k1hzLgOe675EDB+8eCGGEWlWH5pCUvk6rX689l4
         jBFIJx31+whzHkb2K4lExxgsHGv5K6syaJlxGznmPtZ+OxggRzKGXwAqwJtgGY4lA8bG
         jhYKAbIBmQaMLAqCdxEO3mYOVtZwUESe88KxMH60wt28aoWerDfQpZM32Vtg903Z9I9O
         3AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592935; x=1712197735;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gOKRjqt6k/vzjfUi9UjZzO7fr9ZlHBfE82m8aWUoKI=;
        b=uPjst6yBpwJTtyhLtHYYSj6VN64lRzlM7L/aZlT0z5oeu3TGsjt5fKvjKXBK3mkh3T
         zIuLz4cKIS8b84XzemgvOPtegq/9fjRAy6JcXQZn6jO+CojKHlYoiLW2l43sN7Yh/TVn
         ZNsuCDJd4+HnmzAVlGr60eMIAs6vZp4oiu7dhxbtGYkdhTXBUwHje2wY7YTs2zPTt3l6
         kdxgkWtpfotdrjwjKi+yEJGWynVMs1j/lS9EdwPcFvHqmO6T75Xvu5G5tHb9kJhGEKHl
         jt4SSBlGxi1VVwpNWRlu/rCmoFqx+H/bFKllUQFLkESRxk2lLyFcp0kE1T/P/HKiga0D
         UgVA==
X-Forwarded-Encrypted: i=1; AJvYcCVVZL9MhzubhR378hLLpBk7eQB5sSwidUMgaSfLnLzBkXdluwYtuq/AllHtNhY1RzcD1QJh5kCf0ZHNGI8kur3n0zT/Zj/gOUlwtXZR
X-Gm-Message-State: AOJu0Yy7LZGMQMpV5NM/pmz6zxhFvWZYvFnToaFl94KYHCZpU/EonWIA
	Mknt6gCYkVo0MUNQXgW4/oD5ZjNRH1hCzaR7ivdoSQCapoZx+0HLMfKE8Sj0IDY=
X-Google-Smtp-Source: AGHT+IE2aSwd2FQhf+wCqQRipttnI/KVBRKK0bTibmASYfKHwsPXnO4pHQNtnJ7JJ51a7HmCgcqzjA==
X-Received: by 2002:adf:e643:0:b0:341:c14b:598a with SMTP id b3-20020adfe643000000b00341c14b598amr1410352wrn.23.1711592935176;
        Wed, 27 Mar 2024 19:28:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709062ec700b00a46abaeeb1csm191336eji.104.2024.03.27.19.28.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2024 19:28:54 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] x86/boot/e820: not necessary to iterate whole overlap_list
Date: Thu, 28 Mar 2024 02:28:29 +0000
Message-Id: <20240328022830.22802-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

We are sure there is only one entry to be removed from overlap_list.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/kernel/e820.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..ecbeb76ed08f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -377,10 +377,11 @@ int __init e820__update_table(struct e820_table *table)
 		} else {
 			/* Remove entry from list (order independent, so swap with last): */
 			for (i = 0; i < overlap_entries; i++) {
-				if (overlap_list[i] == change_point[chg_idx]->entry)
-					overlap_list[i] = overlap_list[overlap_entries-1];
+				if (overlap_list[i] == change_point[chg_idx]->entry) {
+					overlap_list[i] = overlap_list[--overlap_entries];
+					break;
+				}
 			}
-			overlap_entries--;
 		}
 		/*
 		 * If there are overlapping entries, decide which
-- 
2.34.1


