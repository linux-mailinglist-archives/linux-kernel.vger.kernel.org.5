Return-Path: <linux-kernel+bounces-30038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFB4831836
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E71C24A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98A25106;
	Thu, 18 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjsLNuiI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D996250E1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576309; cv=none; b=ab6PX7laIEaTjmXjWAhcqUczpDDqS2iNK+5kJ/gN07pXWh+pzUarCe82EmJwWpGz5T3JFYU7BfGgNX7FfbqPfcvgV5dYZHJ+wAIWr+wZHY8++oRvEHR7SW+1SLgeIvuYu5TrVYcbZng2yvuR7YLvuFlgtColXH9Gv6hw61Qvm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576309; c=relaxed/simple;
	bh=EqW7jc7DVH+vVsBXp8KOGtXAxEdSJsfQ40/OG3oOCrg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=VTQBlpdumTZk82rwfYExWEdrR26MdQqscpE2Q6c1D7hcurOPiXUXQWq9QFbIAtoSw5kRG6BzxM3TAMjsJmS3PGw4lp+tqbe9CAStYM+1o9QZwJOonOLITn4ZCuKmX61NmWzjA3Up4Sqx5BXlC/eD8JIrw4DDZkjsVrsHqV7DjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjsLNuiI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso8475997a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576307; x=1706181107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZZoI8vzJz6uaOc3IP6SaeIVpVjWcCgJVsn6AMZhjDQ=;
        b=fjsLNuiIdorbIqu6SnQ3DyJw7U7oLlq6K3NH8xkyvNr7EbUtKHLxKZtFPzQvQXk6ie
         hNYP56ku3FD4yacZGRyBYD0irVZGoVHkn4TwYQqtJjnpWAKCPstnvXtWpdZ2p//Myfrp
         O8VbdkPv6Qouo8pqUuj6u0Gr9JlEhxAjZWnI9OFfY+FDcnNRwV1K3WXrnubGfv8ZAEI6
         8DdC2uTXJoZ4abzlinehG1UHztrrlfAz9vBTL2IowPeoyVbxfM/oKSTbSLVqyIl/APdd
         df+gzIJ10C4z+AN2a3tSs+/TlzWpP3/3+GGOEEfV+gsDHVHFnwknxoo36PoHcznk7Md2
         3oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576307; x=1706181107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZZoI8vzJz6uaOc3IP6SaeIVpVjWcCgJVsn6AMZhjDQ=;
        b=ug8NfpIWSBO+Hc+Saq/YovAwY4YnecIiXYQyRdOXs+cuAUFWzWEumZgEMZWA1wQcy+
         qsoqn51UM/jNKA5nR4NwBKM6972cjk0a+62sJazbo4/Pb2ys8bSVBwYq+qAyYjvwUXV4
         GYLk3byj83AkQmQCVV72w/TiCh+IP3cWXDMRDDOJDgyKwijIb90rAENvO56AnKc6d0Mj
         /awFMa2R2R5ldkFTRo3/4BZbhkz6AnQ+mgWojWv8sEKggavr7av9HevJDl0/gPrrY9ig
         h06mGSU4gC26C6bmWLIca52oHjtk+iTKyjcDDAy0FtaIoYPLUvSEpzhAR9jbyiUDGe5R
         vZzw==
X-Gm-Message-State: AOJu0YyLEGfPdKTvg8qdtue8jR76/J+r+IO0OvUMrCmHHylq3mT8VlUW
	5V6o18qj9JqZP8CLzOzCRP2KZl4gNZEU/hozkWxvbfWoq0uBs9AJ
X-Google-Smtp-Source: AGHT+IGrNGM+/9wCFNZHoUn+TpVS1dFfrjzlPUiB7OyAY2gO2fREpkC0FCj3Devi0x2OTNRIh4y8Ug==
X-Received: by 2002:a05:6a20:9f9b:b0:199:e4ab:691c with SMTP id mm27-20020a056a209f9b00b00199e4ab691cmr731200pzb.8.1705576307486;
        Thu, 18 Jan 2024 03:11:47 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:11:47 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 3/6] mm: swap: make should_try_to_free_swap() support large-folio
Date: Fri, 19 Jan 2024 00:10:33 +1300
Message-Id: <20240118111036.72641-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

should_try_to_free_swap() works with an assumption that swap-in is always done
at normal page granularity, aka, folio_nr_pages = 1. To support large folio
swap-in, this patch removes the assumption.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..f61a48929ba7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3714,7 +3714,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * reference only in case it's likely that we'll be the exlusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == 2;
+		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
-- 
2.34.1


