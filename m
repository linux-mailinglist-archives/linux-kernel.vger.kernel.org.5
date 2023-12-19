Return-Path: <linux-kernel+bounces-5110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268D8186A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFFCB237CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A518E21;
	Tue, 19 Dec 2023 11:51:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBE218C05
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SvZkx1mLYzMp0Y;
	Tue, 19 Dec 2023 19:50:33 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 494BD18006C;
	Tue, 19 Dec 2023 19:50:47 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 19:50:46 +0800
Subject: Re: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page on
 -EAGAIN
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <akpm@linux-foundation.org>, <tony.luck@intel.com>,
	<ying.huang@intel.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <81eebf23-fce3-3bb3-857d-8aab5a75d788@huawei.com>
Date: Tue, 19 Dec 2023 19:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2023/12/15 16:12, Qiuxu Zhuo wrote:
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
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks for your patch. Except for the comment from Naoya, I have some questions about the code itself.

> ---
>  mm/memory-failure.c | 73 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 660c21859118..0db4cf712a78 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -72,6 +72,60 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> +#define SPLIT_THP_MAX_RETRY_CNT		10
> +#define SPLIT_THP_INIT_DELAYED_MS	1
> +
> +static bool split_thp_pending;
> +
> +struct split_thp_req {
> +	struct delayed_work work;
> +	struct page *thp;
> +	int retries;
> +};
> +
> +static void split_thp_work_fn(struct work_struct *work)
> +{
> +	struct split_thp_req *req = container_of(work, typeof(*req), work.work);
> +	int ret;
> +
> +	/* Split the thp. */
> +	get_page(req->thp);

Can req->thp be freed when split_thp_work_fn is scheduled ?

> +	lock_page(req->thp);
> +	ret = split_huge_page(req->thp);
> +	unlock_page(req->thp);
> +	put_page(req->thp);
> +
> +	/* Retry with an exponential backoff. */
> +	if (ret && ++req->retries < SPLIT_THP_MAX_RETRY_CNT) {
> +		schedule_delayed_work(to_delayed_work(work),
> +				      msecs_to_jiffies(SPLIT_THP_INIT_DELAYED_MS << req->retries));
> +		return;
> +	}
> +
> +	pr_err("%#lx: split unsplit thp %ssuccessfully.\n", page_to_pfn(req->thp), ret ? "un" : "");
> +	kfree(req);
> +	split_thp_pending = false;

split_thp_pending is not protected against split_thp_delayed? Though this race should be benign.

Thanks.

