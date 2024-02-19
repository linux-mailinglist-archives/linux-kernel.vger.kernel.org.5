Return-Path: <linux-kernel+bounces-71540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B028685A6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C69E28120A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30C381AD;
	Mon, 19 Feb 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeopLyq9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890E31EA80
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355187; cv=none; b=NuYoZCfiATrTNNLdzSlx6hyk7c73AulBlY836ub3HPBTGvcyiwF6TSaqXjjivJnFRckAxvwuoP8V+DClJqKRXyeLWnHKaTNELN7nq2FpSs3mfc1Nyo1gFSPt/nJnZS6ZaGwdy4fE13EuiINgO3LSecpmFbmif8OkrX6BIupVUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355187; c=relaxed/simple;
	bh=xujvCyNAGwSt8/pxhQ8N9r2IAcQcDpwpPaKRWKwxogI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNwTk/zgV7tQP3Nx2Kxs4xY+H12kNjLDDuDeCJc42eItY7rQpBTAL9O+QavWorwhnkWVtV16pCfQigSmgZb7N7eP1U8DJa/cFQveX6yJKheMYT+2o8PqAaH58h2sNFHGyRpSGDJpOw647z02Vdqz57ssxgc3WxAWxyUaaOOaOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeopLyq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708355184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHnTRavFzccEVzSoX1iUfpV/3djTz6kfAI7fI53+wUc=;
	b=DeopLyq953Ddatsf4E0xN0/tiRz1UoewgkHOLugVleTH2c/Z/l06rhrePNI90q+Gle7nQv
	fGa310rUT2bYVsXcH15sFyNy4vox49+6TEJZz+Q45HHzFZQij6a/sGJ6vlgIniHOikYmgA
	C0RS+5IiJp8/xSTtpqlz88KSO6JXGMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-1AJLftrBPSisvJTcIv_9rg-1; Mon, 19 Feb 2024 10:06:20 -0500
X-MC-Unique: 1AJLftrBPSisvJTcIv_9rg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAC4E106D112;
	Mon, 19 Feb 2024 15:06:18 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.107])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 83A7340C9444;
	Mon, 19 Feb 2024 15:06:13 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:06:10 -0500
From: Phil Auld <pauld@redhat.com>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH v4] sched/numa, mm: do not try to migrate memory to
 memoryless nodes
Message-ID: <20240219150610.GB184804@lorien.usersys.redhat.com>
References: <20240219041920.1183-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219041920.1183-1-byungchul@sk.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Mon, Feb 19, 2024 at 01:19:20PM +0900 Byungchul Park wrote:
> Changes from v3:
> 	1. Rewrite the comment in code and the commit message to make it
> 	   more clear. (feedbacked by Oscar Salvador)
> 	2. Add "Reviewed-by: Oscar Salvador <osalvador@suse.de>"
> 
> Changes from v2:
> 	1. Rewrite the comment in code and the commit message becasue it
> 	   turns out that this patch is not the real fix for the oops
> 	   descriped. The real fix goes in another patch below:
> 
> 	   https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/
> 
> Changes from v1:
> 	1. Trim the verbose oops in the commit message. (feedbacked by
> 	   Phil Auld)
> 	2. Rewrite a comment in code. (feedbacked by Phil Auld)
> 
> --->8---
> From 98f5d472c08e3ed5b9b6543290d392a2e50fcf3c Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 19 Feb 2024 13:10:47 +0900
> Subject: [PATCH v4] sched/numa, mm: do not try to migrate memory to memoryless nodes
> 
> Memoryless nodes do not have any memory to migrate to, so stop trying
> it.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..3e3b44ae72d1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1828,6 +1828,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	int dst_nid = cpu_to_node(dst_cpu);
>  	int last_cpupid, this_cpupid;
>  
> +	/*
> +	 * Cannot migrate to memoryless nodes.
> +	 */
> +	if (!node_state(dst_nid, N_MEMORY))
> +		return false;
> +
>  	/*
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.
> -- 
> 2.17.1
> 
> 

Sorry, hadn't gotten far enough to see this version when I replied to v3...

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil

-- 


