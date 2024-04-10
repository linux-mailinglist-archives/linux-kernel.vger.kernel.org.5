Return-Path: <linux-kernel+bounces-139539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17618A041B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B80B248ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC33E49C;
	Wed, 10 Apr 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvXvIjwP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051614A8C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792282; cv=none; b=ly3bXeO4zlS0q7OV8u2JYg7IwEpAbhTECIWfZ8FBWj/9vQpAHOOZBKFowlPeK71Iph+L8/DBgge49gEiBgYDd/kzWG84OmeMzeO+s+57kimlgNpxcxYiwcjPxG/GXWiwKmVx/2LERdDH4GljQjQK/B/CSNobsoaqM2Dc7c9cvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792282; c=relaxed/simple;
	bh=3byiQjOlvBOYMNbK6uEXscUW916rvSbm1e6sOuZO2So=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5V/CLXh/uW/ORzejRTJztIK7byyG9msp/Wjz4MTX/MHDSuS1PWDfolF6BT4XEsV94egkqvsSX9jkPenKarpU3lUwGIaqPsFZQ8XaZjCMI61j/lbx6BLKBtzMmt6AwVFFEeTeXtkm2PDWUEatDCyf1okXK5ktXpu/xL90c5tLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvXvIjwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4B0C433F1;
	Wed, 10 Apr 2024 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712792282;
	bh=3byiQjOlvBOYMNbK6uEXscUW916rvSbm1e6sOuZO2So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvXvIjwPSCnfCmSnpW/0FRKt63OYDwaSd3sGBvBeX9ca3DM9v2IgaupUkBXqLGATm
	 LWJfndtPLFIkiAEaLFeVZHzhdqqmzSQu/+vKGEPZL+NQ7ClHdN6IvKcd3f5NNg5DT0
	 HFAaTvJHQCzRl5/Co98X+HWI98sliDpvGLuU4tWMtzs7c+EVagp1nBtPp5sqDCn36H
	 ZZrC/vG5VTKf1L47SFAMLcA5wgYhe4e1hUrEAQc6hhBm1/KYym+5nC3ZIlVR6zIj64
	 8FIxRi1f7Gd1WfWh0US0s2Pqk3w+KS9ENjxE/IrOAa8vT8uMH8BkIB8Q7Xvwo3Lh1V
	 eC2Pk0ZalgooA==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
Date: Wed, 10 Apr 2024 16:37:59 -0700
Message-Id: <20240410233759.274907-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409082631.187483-2-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Barry,

On Tue,  9 Apr 2024 20:26:27 +1200 Barry Song <21cnbao@gmail.com> wrote:

> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..b7a107e983b8 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
[...]
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}

I found the latest mm-unstable fails build when CONFIG_SWAP is not set with
errors including below, and 'git bisect' points this patch.

    do_mounts.c:(.text+0x6): multiple definition of `swap_free_nr'; init/main.o:main.c:(.text+0x9c): first defined here

I think this should be defined as 'static inline'?  I confirmed adding the two
keywords as below fixes the build failure.

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4bf5090de0fd..5fd60d733ba8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -562,7 +562,7 @@ static inline void swap_free(swp_entry_t swp)
 {
 }

-void swap_free_nr(swp_entry_t entry, int nr_pages)
+static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }


Thanks,
SJ

[...]

