Return-Path: <linux-kernel+bounces-161320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885B8B4AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04C9B2135A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5F524AA;
	Sun, 28 Apr 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P08Xzlyl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62635026C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291843; cv=none; b=cFlpBdDBFr0TNIav9fUVLu3OYV7K0yRfTthBXjVgtgsZT+X1U7xpyxQoB26m9oMp/+2+ikEbMqWDmzGtVYDNbEigOgntxmMseKNo9mjBkYMOhOJA+TrNHMo9a1gb4w7a7yZ87uxksYNE8Xy4MAAENr/EEaXKNm6rEyhedP0jUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291843; c=relaxed/simple;
	bh=oP8HzgcB1FMYyJdJyci4YMdsOey+dfF/cOSQFEhy8L8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EEZaGk00S8K+XKHvf5Tx3+kFIKHSv7ASgDNlZbD3x/LGij/LeZzDeT04S3oKMKYythBPToxXHV089gI7UileqAqodsotyJneDqTMc71yDxDi8xTU9C8EnSZ9yOOd34BhI0H/DwUetLLAqmGnDENe6u/GPjyhrRO/pxgYW6J4+FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P08Xzlyl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eb1cb1a8f1so107365ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714291841; x=1714896641; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3VQv9/zq8mi30peX/7MTevdNHF8DZN9NDCIotlMS04=;
        b=P08Xzlyl6z7dW0tLg/XK80F9WARPBB7miFv5KLhTQ0KwCLAJ7d7PmmR5IEAyPSBD8B
         WvKi56oLbMaeQpWE2xITEzcS44Z6w8mgDBuRKDcbgWRYyVGPdId/S88mxC8xLRBOwkpk
         VYsJ4VfTuhD4de7/r0LjVUx35rik+nRVxbM/1jDP/KOWlJdarL3kAcVrFzZnwIqFCC/F
         DZwz4Qr00zKJZrwe6h4PcqRrSPG3oEkPlRGQnKrRN90UGMKxv9niJN31/xUBr0WqrX38
         /fCNsaJ5fHD5EBWzfICsAiEHNMwrVtAdafPrKmaJnAz3F6EM4FZ4Azj0WrdAHIU6U478
         dOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714291841; x=1714896641;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3VQv9/zq8mi30peX/7MTevdNHF8DZN9NDCIotlMS04=;
        b=Q5XLkdIfJ887OVlKUyvDFKLc7SddJ5d/4ZFlMRbbTEa0wqXC2cNWXbUCUu82bhNl7P
         GM4VDxwYe22trkNid/2cQvVHwL3wbsh7oqVM78rlRTkI6b6YQc8t3M8omUSxxXsAyrIQ
         cvfALqI3oeoVjo76hn+2cRYwb8t+j2q1bwvWH2N+CFfkc2rvGbefIBxyMibzCJlbnZrg
         0op+wGz7r4iu6hjDZ383Ha8pJAfN1Xycv4Z6L9EpMfXZAzKCZ92V8KMntCP+gMOxzjVO
         KmwmoXkrOD/xeqmGDTxedBUFCSprVw/uyVE21iNOJt/7fEXae20AF3+WvN3qQAkh8JWO
         4FcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROsDNlNbNfGjIhe6FA6UR77KqXXwq62vFP56uMY6bCMPCveQTwc9wCBgnQzE4ETxmjSkcf/YluOpiRe4bHr6IWhX+lp9q7rMN0jg6
X-Gm-Message-State: AOJu0YyYW7L6SELj2F2QszATt5b2IvUq1EhkiY4Eg3Skmg9FEZjMGZTu
	E0+mWdI5ffcymvyVgY3g+EKKV67j97m5k8mRA+d6dPqXwHubw9LWtP50/qry3w==
X-Google-Smtp-Source: AGHT+IEhYH7+1MRJ1fUfB80ujG9kMa1BLh5L7BL/3FgNdxfB0pfgNa40gnRtNf5ctZvpA4rVm+Zhrw==
X-Received: by 2002:a17:902:d588:b0:1e4:35b9:cce0 with SMTP id k8-20020a170902d58800b001e435b9cce0mr157957plh.9.1714291840626;
        Sun, 28 Apr 2024 01:10:40 -0700 (PDT)
Received: from [2620:0:1008:15:46db:4823:ceac:2ea3] ([2620:0:1008:15:46db:4823:ceac:2ea3])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e45572a253sm18481547plb.14.2024.04.28.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:10:40 -0700 (PDT)
Date: Sun, 28 Apr 2024 01:10:39 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: linke li <lilinke99@qq.com>
cc: xujianhao01@gmail.com, Christoph Lameter <cl@linux.com>, 
    Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: mark racy access on slab->freelist
In-Reply-To: <tencent_579220610AF1240FE3735A3443DBB01F9D07@qq.com>
Message-ID: <1096134d-df6f-185d-240f-8a774d66f98f@google.com>
References: <tencent_579220610AF1240FE3735A3443DBB01F9D07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 27 Apr 2024, linke li wrote:

> In deactivate_slab(), slab->freelist can be changed concurrently. Mark
> data race on slab->freelist as benign using READ_ONCE.
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
> 

Thanks!  Do you have a data race report to copy+paste into the commit 
description so people can search for it if they stumble across the same 
thing?

> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0d700f6ca547..bb0e05a321e9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2813,7 +2813,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	struct slab new;
>  	struct slab old;
>  
> -	if (slab->freelist) {
> +	if (READ_ONCE(slab->freelist)) {
>  		stat(s, DEACTIVATE_REMOTE_FREES);
>  		tail = DEACTIVATE_TO_TAIL;
>  	}
> -- 
> 2.39.3 (Apple Git-146)
> 
> 

