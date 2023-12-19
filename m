Return-Path: <linux-kernel+bounces-4582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE02817F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3221F247A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9763AC;
	Tue, 19 Dec 2023 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UME3Rd6j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065E5CA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Dec 2023 11:17:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702952253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4TtHcq2TsQinuDWqHZmTllB2P81yCAywzsZcw90ozs=;
	b=UME3Rd6jOx+6ABruQyvRk7rn9I34Rg6jpkAmKCkH52EWEfumChHEUEMTwavXXBQGnN7lKR
	fJsJiQO4iRHn0KGJ5iphl/993ZCsLO/yiAyO+FGwKdvlS2kM19/WcU1FmhmQMYdlU9PY7k
	SXiPI0G9/C3imBGdnEj2Ugf7Yxh1G1M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: naoya.horiguchi@nec.com, linmiaohe@huawei.com,
	akpm@linux-foundation.org, tony.luck@intel.com,
	ying.huang@intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page
 on -EAGAIN
Message-ID: <20231219021723.GA158136@ik1-406-35019.vs.sakura.ne.jp>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 15, 2023 at 04:12:04PM +0800, Qiuxu Zhuo wrote:
> During the process of splitting a hw-poisoned huge page, it is possible
> for the reference count of the huge page to be increased by the threads
> within the affected process, leading to a failure in splitting the
> hw-poisoned huge page with an error code of -EAGAIN.
> 
> This issue can be reproduced when doing memory error injection to a
> multiple-thread process, and the error occurs within a huge page.
> The call path with the returned -EAGAIN during the testing is shown below:
> 
>   memory_failure()
>     try_to_split_thp_page()
>       split_huge_page()
>         split_huge_page_to_list() {
>           ...
>           Step A: can_split_folio() - Checked that the thp can be split.
>           Step B: unmap_folio()
>           Step C: folio_ref_freeze() - Failed and returned -EAGAIN.
>           ...
>         }
> 
> The testing logs indicated that some huge pages were split successfully
> via the call path above (Step C was successful for these huge pages).
> However, some huge pages failed to split due to a failure at Step C, and
> it was observed that the reference count of the huge page increased between
> Step A and Step C.
> 
> Testing has shown that after receiving -EAGAIN, simply re-splitting the
> hw-poisoned huge page within memory_failure() always results in the same
> -EAGAIN. This is possible because memory_failure() is executed in the
> currently affected process. Before this process exits memory_failure() and
> is terminated, its threads could increase the reference count of the
> hw-poisoned page.
> 
> To address this issue, employ the kernel worker to re-split the hw-poisoned
> huge page. By the time this worker begins re-splitting the hw-poisoned huge
> page, the affected process has already been terminated, preventing its
> threads from increasing the reference count. Experimental results have
> consistently shown that this worker successfully re-splits these
> hw-poisoned huge pages on its first attempt.
> 
> The kernel log (before):
>   [ 1116.862895] Memory failure: 0x4097fa7: recovery action for unsplit thp: Ignored
> 
> The kernel log (after):
>   [  793.573536] Memory failure: 0x2100dda: recovery action for unsplit thp: Delayed
>   [  793.574666] Memory failure: 0x2100dda: split unsplit thp successfully.

I'm unclear about the user-visible benefit of ensuring that the error thp is split.
So could you explain about it?

I think that the raw error page is not unmapped (with hwpoisoned entry) after
delayed re-splitting, so recovery action seems not complete even with this patch.
So this patch seems to just convert a hwpoisoned unrecovered thp into a hwpoisoned
unrecovered raw page.

Thanks,
Naoya Horiguchi

