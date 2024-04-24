Return-Path: <linux-kernel+bounces-156554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4268B0473
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD67B1F24973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED9E15887D;
	Wed, 24 Apr 2024 08:37:14 +0000 (UTC)
Received: from mail-m25499.xmail.ntesmail.com (mail-m25499.xmail.ntesmail.com [103.129.254.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6D15666E;
	Wed, 24 Apr 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947833; cv=none; b=VLbWOt5lbtwOf8OwRqriHTOjH/jI2R7EO5fYOzAS15wgsRWcQM/ji47nm/bKllb8vMr0cCSZGQK8xKF2kcx7n8bDELnmLRna36w4QB/LsUrwK63UxnH4549K7fza450m8DAyQt2rq2pdcjSlMozvO94vdwIrf+SAuxu1LNHvNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947833; c=relaxed/simple;
	bh=XLHqJM6NlUvUMGQhytIuH3WUrI1lKV09/R3wMpcgh+A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=enA8MDDt9A6uVEn+W+GmNviHJG0sAbcyYeG2oP81t913AhJQLuK8iaQs0bYVfhtHFxHOebdGcl1lqNGoAUX5lXWQ+xJBY3gsfcikptUKOdHECogdcJ+3ZlVfQNuWB2ffQfrYrbZKm1MOfPlyIsxwkmm1nX4PS44nQtYIhEfVvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.129.254.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B62EA86024B;
	Wed, 24 Apr 2024 16:36:32 +0800 (CST)
Subject: Re: [PATCH 5/7] cbd: introuce cbd_backend
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dongsheng Yang <dongsheng.yang.linux@gmail.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-6-dongsheng.yang@easystack.cn>
 <5166cbf7-2680-4f84-9dee-aa214862f2a8@nvidia.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <29b01fbc-080a-28da-72c1-5434635b2d3b@easystack.cn>
Date: Wed, 24 Apr 2024 16:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5166cbf7-2680-4f84-9dee-aa214862f2a8@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGExLVkwfQ04fGh4ZQk5MSlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f0f3fd6c0023ckunmb62ea86024b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6KTo*LTcrMxA4PlFWKFEQ
	HjQKCQpVSlVKTEpIQk9MTEJITk9NVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBQkNOSjcG



在 2024/4/24 星期三 下午 1:03, Chaitanya Kulkarni 写道:
>> +
>> +struct cbd_backend_io {
>> +	struct cbd_se		*se;
>> +	u64			off;
>> +	u32			len;
>> +	struct bio		*bio;
>> +	struct cbd_handler	*handler;
>> +};
>> +
> 
> why not use inline bvecs and avoid bio page allocation for reasonable
> size ? instead of performing the allocation for each request ...

inline bvecs sounds good, Iwill use it in next version.
> 
>> +static inline void complete_cmd(struct cbd_handler *handler, u64 priv_data, int ret)
>> +{
>> +	struct cbd_ce *ce = get_compr_head(handler);
>> +
>> +	memset(ce, 0, sizeof(*ce));
>> +	ce->priv_data = priv_data;
>> +	ce->result = ret;
>> +	CBDC_UPDATE_COMPR_HEAD(handler->channel_info->compr_head,
>> +			       sizeof(struct cbd_ce),
>> +			       handler->channel_info->compr_size);
>> +
>> +	cbdc_flush_ctrl(&handler->channel);
>> +
>> +	return;
>> +}
>> +
>> +static void backend_bio_end(struct bio *bio)
>> +{
>> +	struct cbd_backend_io *backend_io = bio->bi_private;
>> +	struct cbd_se *se = backend_io->se;
>> +	struct cbd_handler *handler = backend_io->handler;
>> +
>> +	if (bio->bi_status == 0 &&
>> +	    cbd_se_hdr_get_op(se->header.len_op) == CBD_OP_READ) {
>> +		cbdc_copy_from_bio(&handler->channel, se->data_off, se->data_len, bio);
>> +	}
>> +
>> +	complete_cmd(handler, se->priv_data, bio->bi_status);
>> +
>> +	bio_free_pages(bio);
>> +	bio_put(bio);
>> +	kfree(backend_io);
>> +}
>> +
>> +static int cbd_bio_alloc_pages(struct bio *bio, size_t size, gfp_t gfp_mask)
>> +{
>> +	int ret = 0;
>> +
>> +        while (size) {
>> +                struct page *page = alloc_pages(gfp_mask, 0);
>> +                unsigned len = min_t(size_t, PAGE_SIZE, size);
> 
> alloc_page() call should be close to below check ..

that's right, it should be alloc_page rather than alloc_pages with order 
of 0.
> 
>> +
>> +                if (!page) {
>> +			pr_err("failed to alloc page");
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		ret = bio_add_page(bio, page, len, 0);
>> +                if (unlikely(ret != len)) {
>> +                        __free_page(page);
>> +			pr_err("failed to add page");
>> +                        break;
>> +                }
>> +
>> +                size -= len;
>> +        }
>> +
>> +	if (size)
>> +		bio_free_pages(bio);
>> +	else
>> +		ret = 0;
>> +
>> +        return ret;
>> +}
> 
> code formatting seems to be broken for above function plz check..

thanx for pointing it.
> 
>> +
>> +static struct cbd_backend_io *backend_prepare_io(struct cbd_handler *handler, struct cbd_se *se, blk_opf_t opf)
>> +{
>> +	struct cbd_backend_io *backend_io;
>> +	struct cbd_backend *cbdb = handler->cbdb;
>> +
>> +	backend_io = kzalloc(sizeof(struct cbd_backend_io), GFP_KERNEL);
> 
> will above allocation always succeed ? or NULL check should be here ?

sure, it should be checked here. thanx
> 
>> +	backend_io->se = se;
>> +
>> +	backend_io->handler = handler;
>> +	backend_io->bio = bio_alloc_bioset(cbdb->bdev, roundup(se->len, 4096) / 4096, opf, GFP_KERNEL, &handler->bioset);
>> +
>> +	backend_io->bio->bi_iter.bi_sector = se->offset >> SECTOR_SHIFT;
>> +	backend_io->bio->bi_iter.bi_size = 0;
>> +	backend_io->bio->bi_private = backend_io;
>> +	backend_io->bio->bi_end_io = backend_bio_end;
>> +
>> +	return backend_io;
>> +}
>> +
>> +static int handle_backend_cmd(struct cbd_handler *handler, struct cbd_se *se)
>> +{
>> +	struct cbd_backend *cbdb = handler->cbdb;
>> +	u32 len = se->len;
>> +	struct cbd_backend_io *backend_io = NULL;
>> +	int ret;
>> +
>> +	if (cbd_se_hdr_flags_test(se, CBD_SE_HDR_DONE)) {
>> +		return 0 ;
>> +	}
>> +
>> +	switch (cbd_se_hdr_get_op(se->header.len_op)) {
>> +	case CBD_OP_PAD:
>> +		cbd_se_hdr_flags_set(se, CBD_SE_HDR_DONE);
>> +		return 0;
>> +	case CBD_OP_READ:
>> +		backend_io = backend_prepare_io(handler, se, REQ_OP_READ);
>> +		break;
>> +	case CBD_OP_WRITE:
>> +		backend_io = backend_prepare_io(handler, se, REQ_OP_WRITE);
>> +		break;
>> +	case CBD_OP_DISCARD:
>> +		ret = blkdev_issue_discard(cbdb->bdev, se->offset >> SECTOR_SHIFT,
>> +				se->len, GFP_NOIO);
> 
> any specific reason to not use GFP_KERNEL ?

Using GFP_NOIO is intended to avoid memory allocation loops in the I/O 
path, but in this case, it's actually handling remote I/O requests, so 
theoretically using GFP_KERNEL should also work.
> 
>> +		goto complete_cmd;
>> +	case CBD_OP_WRITE_ZEROS:
>> +		ret = blkdev_issue_zeroout(cbdb->bdev, se->offset >> SECTOR_SHIFT,
>> +				se->len, GFP_NOIO, 0);
> 
> any specific reason to not use GFP_KERNEL ?

ditto
> 
>> +		goto complete_cmd;
>> +	case CBD_OP_FLUSH:
>> +		ret = blkdev_issue_flush(cbdb->bdev);
>> +		goto complete_cmd;
>> +	default:
>> +		pr_err("unrecognized op: %x", cbd_se_hdr_get_op(se->header.len_op));
>> +		ret = -EIO;
>> +		goto complete_cmd;
>> +	}
>> +
>> +	if (!backend_io)
>> +		return -ENOMEM;
> 
> there is no NULL check in the backend_prepare_io() not sure about
> above condition in current code unless you return NULL ...

backend_prepare_io should check NULL :)
> 
>> +
>> +	ret = cbd_bio_alloc_pages(backend_io->bio, len, GFP_NOIO);
>> +	if (ret) {
>> +		kfree(backend_io);
>> +		return ret;
>> +	}
>> +
>> +	if (cbd_se_hdr_get_op(se->header.len_op) == CBD_OP_WRITE) {
>> +		cbdc_copy_to_bio(&handler->channel, se->data_off, se->data_len, backend_io->bio);
>> +	}
>> +
>> +	submit_bio(backend_io->bio);
>> +
> 
> unless I didn't understand the code, you are building a single bio from
> incoming request, that might not have enough space to accommodate all
> the data from incoming request, hence you are returning an error from
> cbd_bio_alloc_pages() when bio_add_page() fail ...
> 
> bio_add_page() can fail for multiple reasons, instead of trying to
> build only one bio that might be smaller for the size of the I/O and
> returning error, why not use the chain of the small size bios ? that
> way you will not run out of the space in single bio and still finish
> the I/O by avoiding bio_add_page() failure that might happen due to
> bio full ?

"bio_add_page" should only return an error when "bio->bi_vcnt >= 
bio->bi_max_vecs". However, in our case, "bi_max_vecs" is calculated 
when "bio_alloc_bioset" is called, so "bi_vcnt" should not exceed 
"bi_max_vecs". In other words, theoretically, "bio_add_page" should not 
fail here.
> 
>> +	return 0;
>> +
>> +complete_cmd:
>> +	complete_cmd(handler, se->priv_data, ret);
>> +	return 0;
>> +}
>> +
>> +static void handle_work_fn(struct work_struct *work)
>> +{
>> +	struct cbd_handler *handler = container_of(work, struct cbd_handler, handle_work.work);
>> +	struct cbd_se *se;
>> +	int ret;
>> +again:
>> +	/* channel ctrl would be updated by blkdev queue */
>> +	cbdc_flush_ctrl(&handler->channel);
>> +	se = get_se_to_handle(handler);
>> +	if (se == get_se_head(handler)) {
>> +		if (cbdwc_need_retry(&handler->handle_worker_cfg)) {
>> +			goto again;
>> +		}
>> +
>> +		cbdwc_miss(&handler->handle_worker_cfg);
>> +
>> +		queue_delayed_work(handler->handle_wq, &handler->handle_work, usecs_to_jiffies(0));
>> +		return;
>> +	}
>> +
>> +	cbdwc_hit(&handler->handle_worker_cfg);
>> +	cbdt_flush_range(handler->cbdb->cbdt, se, sizeof(*se));
>> +	ret = handle_backend_cmd(handler, se);
>> +	if (!ret) {
>> +		/* this se is handled */
>> +		handler->se_to_handle = (handler->se_to_handle + cbd_se_hdr_get_len(se->header.len_op)) % handler->channel_info->cmdr_size;
> 
> this is a really long line, if possible keep code under 80 char, I know
> it's not a requirement anymore but it will match block drivers ..

That's indeed long. I'll try to make it more concise in the next version.

Kulkarni, thanx for your review, all each comment helps :)

Thanx
> 
> -ck
> 
> 

