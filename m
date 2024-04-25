Return-Path: <linux-kernel+bounces-159335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807918B2D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813DCB21058
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB381514D8;
	Thu, 25 Apr 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaSeLntn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941E631
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085157; cv=none; b=cXh6aZOCghO1ZiTS5kPJm2X9qAJ/eHP8G+aM78QkyZR6aCfi1mns4pXKRY3A3YcKORSnELxlZtQs/ed0C7xT83swM4qztW7jr5VOcfLN7tkn++1raH5AuQNzxHZ6mZPz+nR4zVDJ+hP3cDmCCUcuEEnkqXc8Ancqn43rfTCAZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085157; c=relaxed/simple;
	bh=jxeYLbFIO3qrKWZkoNdHv4O2h0rfDqP4aBN95HlAjIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr5aOeJuugfAanUliWvnfeXyYKdN0xRPdCNV7w67o8DqIRU0T8ZaDLHEXvjsryY3oKQM1buOapIBNiDg33WBWBxcJClgoQ8NljnW3Gt/yeA8Bd1AznEUDpsRlZiCZ1C8BOg6ySldo5s4nCwvw3hta7U8/VSRctXj4QdOhdJaOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaSeLntn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714085153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nUaSmzGbXoW6XdSxqdYrfPKfpk8zIxCfRz2a71nXGU=;
	b=UaSeLntnA8IXyvdprbvdt3Jq38koMd2vBxCJ6sgok8cfizHb0nppCFBWUhtHaYTxyfEE/l
	sXBoowMsIeIn3JPM0IABa4jz9VdjGwH9fuMuF0XqvwGfpWvQNn7yQwkS3zLmk08hj+WTYr
	r6+bRTscJEg8oAXxEWQi+jmQyriutlg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-U4A8_P_XMee3EGFkN8VkZA-1; Thu, 25 Apr 2024 18:45:52 -0400
X-MC-Unique: U4A8_P_XMee3EGFkN8VkZA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a5457a8543so1704683a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714085151; x=1714689951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nUaSmzGbXoW6XdSxqdYrfPKfpk8zIxCfRz2a71nXGU=;
        b=k/t75XApXjmw9drOCVB6yAyQomRDLufzljHtK6lcCHACb69hKDYDJ/auZRknn8y4ao
         Nh6EWogElHiJUrAnWpFqkkJrMINZU5288Zvz5YTkfGLsPUJpIq/r4Dz3anLoeEYxuymM
         8yZ5dJf62jpgc9QlGFuFU/VzqV3oO/wdQfYZxOoBlNyETz0cMHT6E5WdLIpN50InZelS
         4w6oixPdka4mTsYL0AhMRiuJypUflSyiYMiMzpU2xe8v3NHP4prDPnEb7akuHKIhSUpJ
         U1pMuzmWYoEmQVDJOz4tFKU7mJqKZ7aNxC0DmJZo9AUPgqyosqtIOOh7Q0GjLuNCheL8
         xRJw==
X-Forwarded-Encrypted: i=1; AJvYcCWV+9TsqSsLnub7SjvNmqc8GBBuAotfPU7yWYPYjMCAGu/xyxQi1+kuwXFLRGXXoCTdO0veLXLn9rt2b4rOwqcU0pz8sWekBYoeaeAx
X-Gm-Message-State: AOJu0YxRmEXHe/r3MZQfq+yP9wP5mJpIyUPN9ugnENECMjK+Zt4Jf1WR
	4ZfkJIId3chCHs3JxMbPxjJlzChW6EIc62mQ/sO9BFtMC4jdn5AgBgKLJ5bGIIR26kbHLTX3RYt
	e/2g63SQPAdC0etw+2zMvnmCtNH9uhdpNmsRCdL3fS+6SMWLXCusCVccT88k0tw==
X-Received: by 2002:a17:90a:e641:b0:2af:ff3:e14a with SMTP id ep1-20020a17090ae64100b002af0ff3e14amr988541pjb.16.1714085151122;
        Thu, 25 Apr 2024 15:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnxWn5UoPJJ42z8vEJ1hDvOvdFClinMSMRuOccHoaQeuvslKornt6YigcRd8+yX/ZUX5Pd3Q==
X-Received: by 2002:a17:90a:e641:b0:2af:ff3:e14a with SMTP id ep1-20020a17090ae64100b002af0ff3e14amr988527pjb.16.1714085150743;
        Thu, 25 Apr 2024 15:45:50 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id ck16-20020a17090afe1000b002a2f6da006csm13512078pjb.52.2024.04.25.15.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 15:45:49 -0700 (PDT)
Message-ID: <9237d933-406d-4120-a5fd-34a238f2ccdb@redhat.com>
Date: Fri, 26 Apr 2024 08:45:44 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vhost: Improve vhost_get_avail_head()
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, shan.gavin@gmail.com
References: <20240423032407.262329-4-gshan@redhat.com>
 <202404260448.g7F06v7M-lkp@intel.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <202404260448.g7F06v7M-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 06:42, kernel test robot wrote:> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on mst-vhost/linux-next]
> [also build test WARNING on linus/master v6.9-rc5 next-20240424]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/vhost-Drop-variable-last_avail_idx-in-vhost_get_vq_desc/20240423-112803
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20240423032407.262329-4-gshan%40redhat.com
> patch subject: [PATCH 3/4] vhost: Improve vhost_get_avail_head()
> config: i386-randconfig-141-20240426 (https://download.01.org/0day-ci/archive/20240426/202404260448.g7F06v7M-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404260448.g7F06v7M-lkp@intel.com/
> 
> smatch warnings:
> drivers/vhost/vhost.c:2614 vhost_get_vq_desc() warn: unsigned 'head' is never less than zero.
> drivers/vhost/vhost.c:2614 vhost_get_vq_desc() warn: error code type promoted to positive: 'head'
> 
> vim +/head +2614 drivers/vhost/vhost.c
> 
>    2581	
>    2582	/* This looks in the virtqueue and for the first available buffer, and converts
>    2583	 * it to an iovec for convenient access.  Since descriptors consist of some
>    2584	 * number of output then some number of input descriptors, it's actually two
>    2585	 * iovecs, but we pack them into one and note how many of each there were.
>    2586	 *
>    2587	 * This function returns the descriptor number found, or vq->num (which is
>    2588	 * never a valid descriptor number) if none was found.  A negative code is
>    2589	 * returned on error. */
>    2590	int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>    2591			      struct iovec iov[], unsigned int iov_size,
>    2592			      unsigned int *out_num, unsigned int *in_num,
>    2593			      struct vhost_log *log, unsigned int *log_num)
>    2594	{
>    2595		struct vring_desc desc;
>    2596		unsigned int i, head, found = 0;
>    2597		int ret, access;
>    2598	
>    2599		if (vq->avail_idx == vq->last_avail_idx) {
>    2600			ret = vhost_get_avail_idx(vq);
>    2601			if (unlikely(ret))
>    2602				return ret;
>    2603	
>    2604			/* If there's nothing new since last we looked, return
>    2605			 * invalid.
>    2606			 */
>    2607			if (vq->avail_idx == vq->last_avail_idx)
>    2608				return vq->num;
>    2609		}
>    2610	
>    2611		/* Grab the next descriptor number they're advertising, and increment
>    2612		 * the index we've seen. */
>    2613		head = vhost_get_avail_head(vq);
>>   2614		if (unlikely(head < 0))
>    2615			return head;

Thanks for the report. @head needs to be 'int' instead of 'unsigned int'
so that it can hold the error number from vhost_get_avail_head(). I would
give it more time to see if there are other review comments before I revise
it to fix it up.

Thanks,
Gavin


