Return-Path: <linux-kernel+bounces-167901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AEA8BB0D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BE81C21ADA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15C155389;
	Fri,  3 May 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="LBH6VMKf"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED06FCA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753447; cv=none; b=mZtKl8NENmFEj3vGV7/aaUCMD2D46unQPv/nngc04WUllT45r23+AxzoU/PAFWOPeQ0VcbtbcaXQoad5vNfrfXQey5miIscoCqq04kI/hv3cfAgh/009LPByDJCk18VH0k9eFlTggc5wsBTvKWnMtJDlaMEepi8zvcQrrn8glew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753447; c=relaxed/simple;
	bh=lWHMKTA8AI5dQka1opJ8AqlNGbIDIajTwjCFEN6wnHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OyqHhCGdC0Te0juj/uqAxyQEdaQZ8IcmGRUsrD9elVowYRr1ijkooQjPzKiABZxR5P2kaCZQUtOaWZF68I9TCe3tMH50gpbKs1tcaZOUM7wBujHQYlrfoe6BHdv3XUfrfOWqR+/13tqOvlsJjFvhHluaUBZqFnDMfiI0/My8K+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=LBH6VMKf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 704DD4076733;
	Fri,  3 May 2024 16:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 704DD4076733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714753435;
	bh=j0BypKPSgd111WFp/2PqwbTfAeOP3LB0h8x+mRVyzVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LBH6VMKfSXwCi14lfVx4WN3+o9fayl1EoQI8tugzGjdlX8Mot/ewT8cCqJcwEEczz
	 SjGkDo0v8cgkFOuZCIgOPzCi37pZhW8CqPuq1xHMc0fu+z2O0ZvRloHwVpMhsXN6cB
	 tCu/XwQgjRhBVLqU+2lQFxl6gN4wrKx/Yxfp3FoI=
Date: Fri, 3 May 2024 19:23:48 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Barry Song <21cnbao@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation
 error handling
Message-ID: <20240503-d09628dce22e71e600ebd907-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c474453-fc89-42b2-9ddc-fdc3a2893064@arm.com>

Robin Murphy wrote:
> On 2024-05-02 5:18 pm, Fedor Pchelkin wrote:
> > If a kthread creation fails for some reason then uninitialized members of
> > the tasks array will be accessed on the error path since it is allocated
> > by kmalloc_array().
> > 
> > Limit the bound in such case.
> 
> I don't think this is right... The put_task_struct() calls on the error 
> path are supposed to balance the get_task_struct() calls which only 
> happen *after* all the threads are successfully created - see commit 

Thanks, Robin! You're right. Now I see this..

> d17405d52bac ("dma-mapping: benchmark: fix kernel crash when 
> dma_map_single fails") - although I now wonder whether that might have 
> been better done by replacing kthread_stop() with kthread_stop_put(). It 
> doesn't look like we've ever actually tried to free any previous threads 
> from the point of allocation failure.

It should have looked like the diff below, as you say. And it's probably
better to merge the two patches together so that we eliminate task leaks
in case kthread_stop_put() returns error like it is below.

Will rework that in v2.

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..3b7658ce1599 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -118,6 +118,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
                if (IS_ERR(tsk[i])) {
                        pr_err("create dma_map thread failed\n");
                        ret = PTR_ERR(tsk[i]);
+                       while (--i >= 0)
+                               kthread_stop(tsk[i]);
                        goto out;
                }
 
@@ -141,7 +143,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 
        /* wait for the completion of benchmark threads */
        for (i = 0; i < threads; i++) {
-               ret = kthread_stop(tsk[i]);
+               ret = kthread_stop_put(tsk[i]);
                if (ret)
                        goto out;
        }
@@ -170,8 +172,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
        }
 
 out:
-       for (i = 0; i < threads; i++)
-               put_task_struct(tsk[i]);
        put_device(map->dev);
        kfree(tsk);
        return ret;

