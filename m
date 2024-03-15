Return-Path: <linux-kernel+bounces-104225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD187CAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52075B21BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B41865B;
	Fri, 15 Mar 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zI25mVXR"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB218641
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496562; cv=none; b=b8DNQ/3qk2QSsF3ZDcgrNjw7KMTPHw1piq2RucweuZQC0EI53GSwuNFMEesxOH+JXLp3F7DZL6FKvv5qcVd3uibIGnCVD++zkJfkLTrqtSFcHD8EHj81BJSG7qZ2JdgYmlnkhmE/vRZiACLNK2lW9cOihXlVEqwXaYYjg+AIwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496562; c=relaxed/simple;
	bh=UpjrXGq/g3tgFes1ozbu0h8lPjYOb9PiPDF8TJqBjtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azV0JOqKM0BQmJzCusbfhlRKc7ylbvDR37aTFgYJrsRQJn80cE34doKzZgMx+JYPf2mNhcWjDGQjBHdV8c9duD/DU9OupcoOV46X9x7fdmp32FL+egjdsZqpmS8k05HsvQEvpuBa/NPYOqmBzfPSP69dhL+loy5+bd3f19CU8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zI25mVXR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789de1f59feso94017985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710496558; x=1711101358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8DLBLZhMwvsJMasT6dA48of753EzUhCWq2nn2xC2I8=;
        b=zI25mVXRtakIm2bvb1G8DKbXS4Kld4rO75/uzMZHbD/foTsUKrXeX6XKhpGWgD/+4/
         hlIr4pxWlM2dTh0P0rqvGPJPXqu5O7d9mUY/yTIwMUQH0c0wLDXp9EZgmdJ4xFKnWjlr
         VIo3X8JIZg44jAgFIzT8O8q+j6pWjUytmKbcpwohkq44JqsPoJZ/4NVCl7J1zt66qLrK
         ZDCNgS96PFQd/OFfWNItL4rS96nMBRpZicMg3xjJl+WXN8cX60vADmzg4DsE29fRAjNw
         ejsP0hMwn1ounUA6wPed0rFFksNnijJCSIGw8A3w5D8dH9zgwvlNzBXbZ0MrV8M0oilq
         JD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710496558; x=1711101358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8DLBLZhMwvsJMasT6dA48of753EzUhCWq2nn2xC2I8=;
        b=MWxZqrjpTL7JJLtdjWliXJdMideE9h9mDBFWYO9b85M6ANpUr8v3ggdVF2+NdZ8cyT
         7zSBO9NuwJm44pg9teAHAQxGgrjx9jpdzaE3PMAifhqgS45HXP+1atvpphZwF5Rcm3Nu
         GjKh5diO09DlR0oRJpokz2FOcJ9E1Ug4rnkNb5p81F/zt1LCnegXq6PYewhRCgykCgz5
         dwwjWH2QFol891vC41CLHcndrAmISC7UuK3qYFFcwHPPVdmOlVvXUK6FhVXk7k4f7LJD
         cmq7ZfpNV6vDIzWpRIUSz7zDFTBET7TG+QUhY4VRvf/5mn1mRGC1wpFrMcT4ZmpNRAjd
         a6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUItclXKt+CZqWZlF0AL8Y7gQEZRqdWe8mMUUUcW+aLV6B42lexFvkIxwq5woCK1iuE1sZtVy/oXrjQVYeeOYWUE3BkOK8cpCuSnga2
X-Gm-Message-State: AOJu0YysKX17paJbj7+UBFbSFuJUMRDWT0lB3m11Ui0pfq/SL6HYHdWs
	oJre8mo+n40TuYzBFO2a64LfqhpD7nMNn/MYgKZa9S5sncAunZ0N3G8EydbFcGQ=
X-Google-Smtp-Source: AGHT+IGqdyVJcHEqMFL6dzsYvM35wxkwqkDcYmiyATzk0Yp3/lLfa1fMIPNUlRZ6h6Xw3PeJ/dCR7w==
X-Received: by 2002:a05:620a:1490:b0:789:d553:9233 with SMTP id w16-20020a05620a149000b00789d5539233mr4227652qkj.30.1710496558668;
        Fri, 15 Mar 2024 02:55:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id qr3-20020a05620a390300b00789e220b7b0sm921448qkn.0.2024.03.15.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:55:58 -0700 (PDT)
Date: Fri, 15 Mar 2024 05:55:56 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] mm: cachestat: fix two shmem bugs
Message-ID: <20240315095556.GC581298@cmpxchg.org>
References: <20240314164941.580454-1-hannes@cmpxchg.org>
 <1551fa14-2a95-49fd-ab1a-11c38ae29486@linux.dev>
 <20240315093010.GB581298@cmpxchg.org>
 <ae197190-6a15-49c5-ab3c-3eaac6dd4c5c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae197190-6a15-49c5-ab3c-3eaac6dd4c5c@linux.dev>

When cachestat on shmem races with swapping and invalidation, there
are two possible bugs:

1) A swapin error can have resulted in a poisoned swap entry in the
   shmem inode's xarray. Calling get_shadow_from_swap_cache() on it
   will result in an out-of-bounds access to swapper_spaces[].

   Validate the entry with non_swap_entry() before going further.

2) When we find a valid swap entry in the shmem's inode, the shadow
   entry in the swapcache might not exist yet: swap IO is still in
   progress and we're before __remove_mapping; swapin, invalidation,
   or swapoff have removed the shadow from swapcache after we saw the
   shmem swap entry.

   This will send a NULL to workingset_test_recent(). The latter
   purely operates on pointer bits, so it won't crash - node 0, memcg
   ID 0, eviction timestamp 0, etc. are all valid inputs - but it's a
   bogus test. In theory that could result in a false "recently
   evicted" count.

   Such a false positive wouldn't be the end of the world. But for
   code clarity and (future) robustness, be explicit about this case.

   Bail on get_shadow_from_swap_cache() returning NULL.

Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Cc: stable@vger.kernel.org				[v6.5+]
Reported-by: Chengming Zhou <chengming.zhou@linux.dev>	[Bug #1]
Reported-by: Jann Horn <jannh@google.com>		[Bug #2]
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 222adac7c9c5..0aa91bf6c1f7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4198,7 +4198,23 @@ static void filemap_cachestat(struct address_space *mapping,
 				/* shmem file - in swap cache */
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
+				/* swapin error results in poisoned entry */
+				if (non_swap_entry(swp))
+					goto resched;
+
+				/*
+				 * Getting a swap entry from the shmem
+				 * inode means we beat
+				 * shmem_unuse(). rcu_read_lock()
+				 * ensures swapoff waits for us before
+				 * freeing the swapper space. However,
+				 * we can race with swapping and
+				 * invalidation, so there might not be
+				 * a shadow in the swapcache (yet).
+				 */
 				shadow = get_shadow_from_swap_cache(swp);
+				if (!shadow)
+					goto resched;
 			}
 #endif
 			if (workingset_test_recent(shadow, true, &workingset))
-- 
2.44.0


