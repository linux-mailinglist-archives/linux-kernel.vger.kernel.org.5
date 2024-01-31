Return-Path: <linux-kernel+bounces-47155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305068449ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC461F251DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDE39AFD;
	Wed, 31 Jan 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlcpbFoC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BE39AE7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736202; cv=none; b=IUy87xvrQrA46HwnCzC+Qm8vlgpfDEoAp6wCLHf4MpwvglAgKP31G2q6CA4SS/matgbj5mcUNG1sisn9kYrgwgs/OmASgITt3CdwL5tFBETvflHq3B56so3GZq8k+E8b5UxVwHBeYSs254TKY9bvYy9wh5PiyER9mJmraIxn6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736202; c=relaxed/simple;
	bh=sAhbOlDb44L9hk5QBq3xACN+xKKAzLYllfmyUp+p388=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L8ybwqQaR6suIcPoQzk0z8LDdi147rYQokLS/xgx+qNoA7N4/QDxgvrEUyb84Wi6EPu7Ts/xiagnSpb52lNup8AM0S70uX6Cwpayh5u/cUF7VeNZ7xutYLNgvke5jNuSFpQ9g3KPg805LLeUAdBSMIVshXvPxRJItawI1CqgPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlcpbFoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706736199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p1ekHVDWh5pLVrV01J8vyQc6iY2OOdwz+cigb0lu9YY=;
	b=VlcpbFoC/FbdRKfjcszL8X9cxLFbIS2MQr1+fcuT80PujwkPBQyrwCvukCPzZdHxOgIm51
	xajdQGf3YOEoNgzBxsVU6G8EfNrg1JonuqhqZX+nRBUTJ7PvWEmt0PFNnMyxaDtpeZD2Os
	s6t/W4bs3kUp7NtMB43PVu5GWRsWdkM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-KRYTsgRtPTSdorN9K2R9-A-1; Wed,
 31 Jan 2024 16:23:15 -0500
X-MC-Unique: KRYTsgRtPTSdorN9K2R9-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D5E61C04346;
	Wed, 31 Jan 2024 21:23:14 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1BD2026D66;
	Wed, 31 Jan 2024 21:23:14 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 4A64C30C14EB; Wed, 31 Jan 2024 21:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 466B93F7DC;
	Wed, 31 Jan 2024 22:23:14 +0100 (CET)
Date: Wed, 31 Jan 2024 22:23:14 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tejun Heo <tj@kernel.org>
cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
    damien.lemoal@wdc.com, houtao1@huawei.com, peterz@infradead.org, 
    mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com, 
    kernel-team@meta.com, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 7/8] dm-crypt: Convert from tasklet to BH workqueue
In-Reply-To: <20240130091300.2968534-8-tj@kernel.org>
Message-ID: <ddf2e764-a6e5-1024-4ae9-ef42f7a86cbe@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

This seems OK.

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>



On Mon, 29 Jan 2024, Tejun Heo wrote:

> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts dm-crypt from tasklet to BH workqueue.
> 
> Like a regular workqueue, a BH workqueue allows freeing the currently
> executing work item. Converting from tasklet to BH workqueue removes the
> need for deferring bio_endio() again to a work item, which was buggy anyway.
> 
> I tested this lightly with "--perf-no_read_workqueue
> --perf-no_write_workqueue" + some code modifications, but would really
> -appreciate if someone who knows the code base better could take a look.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Link: http://lkml.kernel.org/r/82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: dm-devel@lists.linux.dev
> ---
>  drivers/md/dm-crypt.c | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 855b482cbff1..619c762d4072 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -73,11 +73,8 @@ struct dm_crypt_io {
>  	struct bio *base_bio;
>  	u8 *integrity_metadata;
>  	bool integrity_metadata_from_pool:1;
> -	bool in_tasklet:1;
>  
>  	struct work_struct work;
> -	struct tasklet_struct tasklet;
> -
>  	struct convert_context ctx;
>  
>  	atomic_t io_pending;
> @@ -1762,7 +1759,6 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
>  	io->ctx.r.req = NULL;
>  	io->integrity_metadata = NULL;
>  	io->integrity_metadata_from_pool = false;
> -	io->in_tasklet = false;
>  	atomic_set(&io->io_pending, 0);
>  }
>  
> @@ -1771,13 +1767,6 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
>  	atomic_inc(&io->io_pending);
>  }
>  
> -static void kcryptd_io_bio_endio(struct work_struct *work)
> -{
> -	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
> -
> -	bio_endio(io->base_bio);
> -}
> -
>  /*
>   * One of the bios was finished. Check for completion of
>   * the whole request and correctly clean up the buffer.
> @@ -1800,21 +1789,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
>  		kfree(io->integrity_metadata);
>  
>  	base_bio->bi_status = error;
> -
> -	/*
> -	 * If we are running this function from our tasklet,
> -	 * we can't call bio_endio() here, because it will call
> -	 * clone_endio() from dm.c, which in turn will
> -	 * free the current struct dm_crypt_io structure with
> -	 * our tasklet. In this case we need to delay bio_endio()
> -	 * execution to after the tasklet is done and dequeued.
> -	 */
> -	if (io->in_tasklet) {
> -		INIT_WORK(&io->work, kcryptd_io_bio_endio);
> -		queue_work(cc->io_queue, &io->work);
> -		return;
> -	}
> -
>  	bio_endio(base_bio);
>  }
>  
> @@ -2246,11 +2220,6 @@ static void kcryptd_crypt(struct work_struct *work)
>  		kcryptd_crypt_write_convert(io);
>  }
>  
> -static void kcryptd_crypt_tasklet(unsigned long work)
> -{
> -	kcryptd_crypt((struct work_struct *)work);
> -}
> -
>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  {
>  	struct crypt_config *cc = io->cc;
> @@ -2263,9 +2232,8 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  		 * it is being executed with irqs disabled.
>  		 */
>  		if (in_hardirq() || irqs_disabled()) {
> -			io->in_tasklet = true;
> -			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> -			tasklet_schedule(&io->tasklet);
> +			INIT_WORK(&io->work, kcryptd_crypt);
> +			queue_work(system_bh_wq, &io->work);
>  			return;
>  		}
>  
> -- 
> 2.43.0
> 


