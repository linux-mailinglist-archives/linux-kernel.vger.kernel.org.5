Return-Path: <linux-kernel+bounces-140446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBA8A14C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF6128B748
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FF3D556;
	Thu, 11 Apr 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlZz7Xai"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9D228399
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839076; cv=none; b=gtJjFn/myi0SZqF/ObOdWYPaHe9PUrOBHHg1eYEp3H6zR7McJ703r7ak/H9ejVpspKSqWjExhJEykN1fFK+D/HhKBuPz6uBau5rRUEOy6+0ygJRe8/zdzA0TbPkaEJDJ596sAV5vzRdOb5uKkhucVXCD0QmjqFc9R3mAmndRMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839076; c=relaxed/simple;
	bh=CIVy0SsUlg0fUMKX1CWqt9cbJE+qBzIZsfDGQR1WG34=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ij+SAT297fm5jdO5egSvhe7xjpclEATVjkdoS5Q+vPTKOw3VeYZiGnhpg5R21p1dtXmjwywuGmE5r7hkcAju6q3mu+Yo9kN+m4dUN8iHbNE/kWxZyP11hlg6Lv+fSvtCePTbBnT4/28Fpuc7w8xcdF/prAxNv5MrMDvk3JpK4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlZz7Xai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712839073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJHSGS6DZn5w0lI3N34lZqsw+keKCQ5HV+u+tB7G5X4=;
	b=RlZz7Xaitl0bINAgfwn4j/Kwp0rWwFRVZkeWT3kH89XaBSPCE+/V6f6etOO2zdjOvZUYFr
	mYdss7lfS1lG7lzzWMicORHCpywqmiAC/gsfvWg8zTXWnvKotq4ieVXmn0qexdw+xqr4tW
	PzqP94/wHyRbjxc7QFRLs8injQnpaEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-s809NAxbMm-yId62tKkBHQ-1; Thu, 11 Apr 2024 08:37:50 -0400
X-MC-Unique: s809NAxbMm-yId62tKkBHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 510BD802A6F;
	Thu, 11 Apr 2024 12:37:49 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E7F2026962;
	Thu, 11 Apr 2024 12:37:48 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 3CD3F30BFEC2; Thu, 11 Apr 2024 12:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 37CE43FD73;
	Thu, 11 Apr 2024 14:37:48 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:37:48 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Li Lingfeng <lilingfeng3@huawei.com>
cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
    torvalds@linux-foundation.org, tglx@linutronix.de, 
    linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
    msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com, 
    bob.liu@oracle.com, houtao1@huawei.com, nhuck@google.com, 
    peterz@infradead.org, mingo@elte.hu, yukuai3@huawei.com, 
    yangerkun@huawei.com, yi.zhang@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH 6.6] Revert "dm-crypt, dm-verity: disable tasklets"
In-Reply-To: <20240411091539.361470-1-lilingfeng3@huawei.com>
Message-ID: <7c17f31a-2cc3-1597-e2b5-832355de7647@redhat.com>
References: <20240411091539.361470-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi

I NACK this.


On Thu, 11 Apr 2024, Li Lingfeng wrote:

> This reverts commit 5735a2671ffb70ea29ca83969fe01316ee2ed6fc which is
> commit 0a9bab391e336489169b95cb0d4553d921302189 upstream.
> 
> Tasklet is thought to cause memory corruption [1], so it was disabled in
> dm-crypt and dm-verity. However, memory corruption may not happen since
> cc->io_queue is created without WQ_UNBOUND [2].
> Revert commit 5735a2671ffb ("dm-crypt, dm-verity: disable tasklets") to
> bring tasklet back.
> 
> [1] https://lore.kernel.org/all/d390d7ee-f142-44d3-822a-87949e14608b@suse.de/T/
> [2] https://lore.kernel.org/all/4d331659-badd-749d-fba1-271543631a8a@huawei.com/

Regarding [2] - if you add mdelay, you can make the race condition less 
reproducible, but it is not a proper fix and the race condition stays 
there unfixed.

Workqueues and ksoftirqd may be scheduled arbitrarily, there is no 
guarantee that they will be executed in a particular order, even if they 
are executed on the same CPU.

Mikulas

> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>  drivers/md/dm-crypt.c         | 38 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm-verity-target.c | 26 ++++++++++++++++++++++--
>  drivers/md/dm-verity.h        |  1 +
>  3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index aa6bb5b4704b..a60d91d02e28 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -75,8 +75,10 @@ struct dm_crypt_io {
>  	struct bio *base_bio;
>  	u8 *integrity_metadata;
>  	bool integrity_metadata_from_pool:1;
> +	bool in_tasklet:1;
>  
>  	struct work_struct work;
> +	struct tasklet_struct tasklet;
>  
>  	struct convert_context ctx;
>  
> @@ -1775,6 +1777,7 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
>  	io->ctx.r.req = NULL;
>  	io->integrity_metadata = NULL;
>  	io->integrity_metadata_from_pool = false;
> +	io->in_tasklet = false;
>  	atomic_set(&io->io_pending, 0);
>  }
>  
> @@ -1785,6 +1788,13 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
>  
>  static void kcryptd_queue_read(struct dm_crypt_io *io);
>  
> +static void kcryptd_io_bio_endio(struct work_struct *work)
> +{
> +	struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
> +
> +	bio_endio(io->base_bio);
> +}
> +
>  /*
>   * One of the bios was finished. Check for completion of
>   * the whole request and correctly clean up the buffer.
> @@ -1817,6 +1827,20 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
>  
>  	base_bio->bi_status = error;
>  
> +	/*
> +	 * If we are running this function from our tasklet,
> +	 * we can't call bio_endio() here, because it will call
> +	 * clone_endio() from dm.c, which in turn will
> +	 * free the current struct dm_crypt_io structure with
> +	 * our tasklet. In this case we need to delay bio_endio()
> +	 * execution to after the tasklet is done and dequeued.
> +	 */
> +	if (io->in_tasklet) {
> +		INIT_WORK(&io->work, kcryptd_io_bio_endio);
> +		queue_work(cc->io_queue, &io->work);
> +		return;
> +	}
> +
>  	bio_endio(base_bio);
>  }
>  
> @@ -2291,6 +2315,11 @@ static void kcryptd_crypt(struct work_struct *work)
>  		kcryptd_crypt_write_convert(io);
>  }
>  
> +static void kcryptd_crypt_tasklet(unsigned long work)
> +{
> +	kcryptd_crypt((struct work_struct *)work);
> +}
> +
>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  {
>  	struct crypt_config *cc = io->cc;
> @@ -2302,10 +2331,15 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
>  		 * it is being executed with irqs disabled.
>  		 */
> -		if (!(in_hardirq() || irqs_disabled())) {
> -			kcryptd_crypt(&io->work);
> +		if (in_hardirq() || irqs_disabled()) {
> +			io->in_tasklet = true;
> +			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> +			tasklet_schedule(&io->tasklet);
>  			return;
>  		}
> +
> +		kcryptd_crypt(&io->work);
> +		return;
>  	}
>  
>  	INIT_WORK(&io->work, kcryptd_crypt);
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 49e4a35d7019..0bb126eadc0d 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -701,6 +701,23 @@ static void verity_work(struct work_struct *w)
>  	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
>  }
>  
> +static void verity_tasklet(unsigned long data)
> +{
> +	struct dm_verity_io *io = (struct dm_verity_io *)data;
> +	int err;
> +
> +	io->in_tasklet = true;
> +	err = verity_verify_io(io);
> +	if (err == -EAGAIN || err == -ENOMEM) {
> +		/* fallback to retrying with work-queue */
> +		INIT_WORK(&io->work, verity_work);
> +		queue_work(io->v->verify_wq, &io->work);
> +		return;
> +	}
> +
> +	verity_finish_io(io, errno_to_blk_status(err));
> +}
> +
>  static void verity_end_io(struct bio *bio)
>  {
>  	struct dm_verity_io *io = bio->bi_private;
> @@ -713,8 +730,13 @@ static void verity_end_io(struct bio *bio)
>  		return;
>  	}
>  
> -	INIT_WORK(&io->work, verity_work);
> -	queue_work(io->v->verify_wq, &io->work);
> +	if (static_branch_unlikely(&use_tasklet_enabled) && io->v->use_tasklet) {
> +		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
> +		tasklet_schedule(&io->tasklet);
> +	} else {
> +		INIT_WORK(&io->work, verity_work);
> +		queue_work(io->v->verify_wq, &io->work);
> +	}
>  }
>  
>  /*
> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index db93a91169d5..7e495cc375b0 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -87,6 +87,7 @@ struct dm_verity_io {
>  	bool in_tasklet;
>  
>  	struct work_struct work;
> +	struct tasklet_struct tasklet;
>  
>  	char *recheck_buffer;
>  
> -- 
> 2.31.1
> 


