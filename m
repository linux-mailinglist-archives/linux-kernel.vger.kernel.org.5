Return-Path: <linux-kernel+bounces-154773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9798AE0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398B282CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556D5788E;
	Tue, 23 Apr 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWiYY/s3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013056444
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863641; cv=none; b=dd4HjHD4v8OOK9/89yicJMOa+aA1e4n3Dg6GNMLe/vWNEfjAbHToFXU+9z8rjxX46/YJcCExTTr9teNshpJCHPJBi7Wksb6hOcGd/hDFpZ5dGA0GnsK4Rr5qW5LEGM9LNgO3zj3MUaS9AiBSixedaS1eW/K0pmJGxzj0kT0BNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863641; c=relaxed/simple;
	bh=+HYC9r8wTCRmGIBMgAS0O5zj7Qmlb2jFg4GebaRKIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvtZYGtZqMB52NbZ96nZo4zdMOScFLcgF9iMDA4ABaaPhVc2vPRm03Cg7sYbIFxVSEUyG70KnEcOqrPtCnHmWEiVzfI5Nv+AlgdhugFvB/lAo2nNcgk+kctJAnjsHddp2sC/iJE3vTZnFrzC3zPN5cncMPB9Lnq8eNWR+x4xfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWiYY/s3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713863638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xckAbIaUxfV2U1fI0YjievZgsT18mecVG8rOgbjUb8=;
	b=CWiYY/s36hHtEL67Bm+5EWyU+LCfEG1UpfLWnEVIbXz0KuWAko7PgPVD3dk4UJWqNe6Cy8
	pipte2Mok/ZysRZpH8n9oy09LCjzYr+mUm9XpGEmOY9faaMhPiWTv3NELmf1vqiUg0UCrj
	XVldl4laWxKDdJksranNVMNeFhmUpjQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-XR9TCmclOKWARBv67SXIMQ-1; Tue, 23 Apr 2024 05:13:56 -0400
X-MC-Unique: XR9TCmclOKWARBv67SXIMQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34b0b409775so1030081f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713863635; x=1714468435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xckAbIaUxfV2U1fI0YjievZgsT18mecVG8rOgbjUb8=;
        b=XuXsh95VIRzoEUmL1681Zj2+AtvinJXEUwcWkTNDLJizdPaV2bwl9JYRaedtrVD3Lm
         gpD0M0dGOlmjc0YLpIuP5m45JB3lK9m3ah7KLLGi+Z48UysZycvejKPhLzFkpiqMRje6
         ImgIDtAcbF+azKua4W+6wti1emlzhiaEoLsDvEDfkd5f06Yfj2D1MEo2+cwcU23f95aj
         zn+i+P8A989UlB/avpeW1FdYmfX7DkGCq+hExhyR0ViLyfWrh2YDYYW2ehBfRC6yZGVt
         lexv388SKF34FbfSq59EuqSEFhDcYixVCmNU5WYo9kRdAgTOLeYbuEr+nsNWOEp3RJpT
         fJSA==
X-Gm-Message-State: AOJu0YzK7YuftdXhNuAq80krmanY/OYtOM7hfYI8EeyOjf1L9a2Ar2Tk
	aSx+GMXxDZpOzIWRsZF4zapBlWeKDMyzmRJ9m2MKKTB3V6rKy3z0hJCKBpl4FLeum3VOFx2YHdQ
	OOe73zOhEmJBMPzeftESEjba5Mz6LAURNA/y90G79kYP5FmdOCtA83qUyAG5/AA==
X-Received: by 2002:a5d:6d8d:0:b0:343:f335:2489 with SMTP id l13-20020a5d6d8d000000b00343f3352489mr9334356wrs.59.1713863635393;
        Tue, 23 Apr 2024 02:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrpMdpbG8FFAw85brCrIe+xZ/QGNjBiBptgCa0RJlLmPxE7ErKfP7eMNOPOzyyRh2eNOA1Bg==
X-Received: by 2002:a5d:6d8d:0:b0:343:f335:2489 with SMTP id l13-20020a5d6d8d000000b00343f3352489mr9334339wrs.59.1713863634871;
        Tue, 23 Apr 2024 02:13:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm14071319wrp.39.2024.04.23.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:13:53 -0700 (PDT)
Date: Tue, 23 Apr 2024 05:13:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
Message-ID: <20240423051151-mutt-send-email-mst@kernel.org>
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
 <20240423034109.1552866-3-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423034109.1552866-3-pizhenwei@bytedance.com>

On Tue, Apr 23, 2024 at 11:41:07AM +0800, zhenwei pi wrote:
> When the guest OS runs under critical memory pressure, the guest
> starts to kill processes. A guest monitor agent may scan 'oom_kill'
> from /proc/vmstat, and reports the OOM KILL event. However, the agent
> may be killed and we will loss this critical event(and the later
> events).
> 
> For now we can also grep for magic words in guest kernel log from host
> side. Rather than this unstable way, virtio balloon reports OOM-KILL
> invocations instead.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 1 +
>  include/uapi/linux/virtio_balloon.h | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1710e3098ecd..f7a47eaa0936 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -330,6 +330,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
>  		    pages_to_bytes(events[PSWPOUT]));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..b17bbe033697 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -71,7 +71,8 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>  #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>  #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
> -#define VIRTIO_BALLOON_S_NR       10
> +#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
> +#define VIRTIO_BALLOON_S_NR       11
>  
>  #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>  	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \

Looks like a useful extension. But
any UAPI extension has to go to virtio spec first.

> @@ -83,7 +84,8 @@ struct virtio_balloon_config {
>  	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
>  }
>  
>  #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
> -- 
> 2.34.1


