Return-Path: <linux-kernel+bounces-10028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FBC81CEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821EAB20EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7C2E655;
	Fri, 22 Dec 2023 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z193J0aP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80F2E648
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA249C433C8;
	Fri, 22 Dec 2023 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703274154;
	bh=nDWWksDB83wq7+5rcHDqTkkuYXwlD3psmR7EtZm78Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z193J0aP48+JB7rhR3bF+x9ObZ4UYQQbQTTeHxrTWT7grGrdtJ/FcsPlJHoaGsXJF
	 qXO7N3r4Z1THDIHvTnXAZdhqw51R1jLMG0Xt0ohiMMMuaQGatXm9NTt2O2bfuDJ043
	 PXha5Si4+tFlHFMtaGGaf+zVtK4Cb20B8hM4dcC4=
Date: Fri, 22 Dec 2023 11:42:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: naoya.horiguchi@nec.com, linmiaohe@huawei.com, tony.luck@intel.com,
 ying.huang@intel.com, fengwei.yin@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memory-failure: Re-split hw-poisoned huge
 page on -EAGAIN
Message-Id: <20231222114233.68a4fcf2428ae50da6b249f4@linux-foundation.org>
In-Reply-To: <20231222062706.5221-2-qiuxu.zhuo@intel.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
	<20231222062706.5221-1-qiuxu.zhuo@intel.com>
	<20231222062706.5221-2-qiuxu.zhuo@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 14:27:06 +0800 Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:

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
> Furthermore, if the h/w-poisoned huge page had been mapped for the victim
> application's text and was present in the file cache and it was failed to
> be split. When attempting to restart the process without splitting the
> h/w-poisoned huge page, the application restart failed. This was possible
> because its text was remapped to the hardware-poisoned huge page from the
> file cache, leading to its swift termination due to another MCE.

So we're hoping that when the worker runs to split the page, the
process and its threads have exited.  What guarantees this timing?

And we're hoping that the worker has split the page before userspace
attempts to restart the process.  What guarantees this timing?

All this reliance upon fortunate timing sounds rather unreliable,
doesn't it?

