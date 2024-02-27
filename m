Return-Path: <linux-kernel+bounces-82516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77158685AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6740B1F2229F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12514C6F;
	Tue, 27 Feb 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJENvd1T"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BC4C89
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996912; cv=none; b=AG084nZWSsyc1JxLVaUvEn3bpak5OFFPJFt5gZxhvwtLnEzygrO2hbqMewuJViH2X/Y6jtSlwNKjL2OrNXmBkQbvTIiEFmsg+MNyCsT3fN3VpUogyMZjPwfDPReJaTQtoQoKOPImgxSrSKXuyxYjMGeMUMgc06dQ6uhKNmjhRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996912; c=relaxed/simple;
	bh=Y0XIMj4mA5VfF53wEN3qO0FtYomkGiP9Da1oZbODWUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBLXZLcpEjaZsEANBDh4Rtu2Bmvcjog9z4HmYUOsU37sUWH39f08a+9v2sWvXfvaTAAoOt/zzLTnLVrCcC6CnKd8PgQRO2e3ex3o8AOrwmaObI/NU6U8xeaEUTfUBEDX4bT1DiWtf8xu4a37NMebACuiZiiOEMmvk+DXomZX7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJENvd1T; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c17ac08a38so1659610b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708996909; x=1709601709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bXxNqwNbJD6O5GdbT9Dy1UrrTpDaUAcZ2ZskrOJNpI=;
        b=JJENvd1Ty3bw/zNYvF+JDpAA+qj1w0uxVJd0NHlDLdFrRKXkjrQJKaozXzEwrDu4DK
         VP0O3o07J4bRTSI3YGhka+t6nPycE/FpTwadFInRe0zFBOoXlFpl4A97r3HDA85fRZHF
         GOTzMxtB0CHKU4UgHKHCscTcVlK1VinPUevyTgiJRXgGe4J7qjd4Paz91y8ySDwGoCQs
         P8RgIN3SoXycSz8wkO38UwT5N8LxTT/Hd448PYgaCJyr6J/OApfjcZrJIMOJEU2+MX5T
         zYoXU5+ZwTrsSxvoWfTsqsJT9gA4pSB5w1A1rhHvdCaK8Zve3C7v5KGvu5w1axXqcqwL
         wFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996909; x=1709601709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bXxNqwNbJD6O5GdbT9Dy1UrrTpDaUAcZ2ZskrOJNpI=;
        b=miUHv7TNsz4JwUAlX9ZOt28o45Namf6CgkxUkQzzSDBlcnJpWo72CDRUa48qa+G5NE
         1aLA2MdZzGNLSMudgp/EwitFeezNESF7ePMaB4MTt9HYDE0FcaaduQAUQIubgS97GbsA
         CJ++YuufvcMv/TInOiTTjoTTzZpnNE3IXhn5qzZoyHWAMzRFkI9g3+giKhmyhhyUtCCp
         BKuV7pir15o33lPAVWAF+1NsCw5FcneOl0aOd4rfHoj47/aU8H3PLEX6D/J17UsB3uTL
         ZD3zjeyf3cgi9JqyDlKxvm66EHbdE8MVx24wWg1dXoka97lPvj7GqiiZkHc5jfkDai8c
         Htjg==
X-Forwarded-Encrypted: i=1; AJvYcCU19ZavKZKl1QaqO/J7T8Gk9JukLfJhzuD0DVlybBMGnJMHOa9YHrvz5SEDqEtX4x6PCX4Hc9wkySL3RklTFy9sb41jN5zilaKx6mfQ
X-Gm-Message-State: AOJu0YzkVH2Y/er2DXhun1T0JkrH8B9fYsq8vwlEJr3kW2aaQiN9Qbuu
	t7Of7D3TXiuDoYry/pLIjhpfoI7MlOLonwLzV8M2Kmq/53EDVukG
X-Google-Smtp-Source: AGHT+IEAFbS0ijHradPh292tBUy4SUWjp4a7H3ckhLynTw9fXePax/uKvPyiULegyBA1S8XpT1d6dQ==
X-Received: by 2002:a05:6808:d48:b0:3c1:1398:9eca with SMTP id w8-20020a0568080d4800b003c113989ecamr969656oik.28.1708996909531;
        Mon, 26 Feb 2024 17:21:49 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id hy11-20020a056a006a0b00b006e146124ae7sm4733847pfb.186.2024.02.26.17.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:21:49 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ioworker0@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	fengwei.yin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	zokeefe@google.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Tue, 27 Feb 2024 14:21:27 +1300
Message-Id: <20240227012127.174048-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
References: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for your suggestion. I'll use folio_pte_batch() in v2.

Hi Lance,
Obviously, we both need this. While making large folio swap-in
v2, I am exporting folio_pte_batch() as below,

From: Barry Song <v-songbaohua@oppo.com>
Date: Tue, 27 Feb 2024 14:05:43 +1300
Subject: [PATCH] mm: export folio_pte_batch as a couple of modules need it

MADV_FREE, MADV_PAGEOUT and some other modules might need folio_pte_batch
to check if a range of PTEs are completely mapped to a large folio with
contiguous physcial offset.

Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/internal.h | 13 +++++++++++++
 mm/memory.c   |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 36c11ea41f47..7e11aea3eda9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/* Flags for folio_pte_batch(). */
+typedef int __bitwise fpb_t;
+
+/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
+#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
+
+/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
+#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
+
+extern int folio_pte_batch(struct folio *folio, unsigned long addr,
+		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
+		bool *any_writable);
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/memory.c b/mm/memory.c
index 6378f6bc22c5..dd9bd67f037a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -989,7 +989,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  * If "any_writable" is set, it will indicate if any other PTE besides the
  * first (given) PTE is writable.
  */
-static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
+int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable)
 {
-- 
2.34.1 

> Best,
> Lance

Thanks
Barry


