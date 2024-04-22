Return-Path: <linux-kernel+bounces-153606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B208AD04E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498942887DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8A152513;
	Mon, 22 Apr 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7CDa2d9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB605025E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798575; cv=none; b=MxXu8yr+g6UsfB8IzNfoGGO4Qq4SOCNSmWmC/2v5ls7tkPQadalS/RxTsmdRrBWDpF9GX6s6FZX2Pov/RZYQLvVEaKgSkRi+3PeUAO/jFPBsR8m71F56uWXpJJtysNDs5hj6mdvDwzjR7VXJIcqpDWFqxoFu8NXC2J34hmmTd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798575; c=relaxed/simple;
	bh=w/9gEjHueR3IL9ptPUXuXpEQV036Laml2zbcK9lSZSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzBQETyAtHrK+NlB/+24de0utJj52xkiRpMyxoyctHNT9aapSe84oiXmGn6jopjisqM8l4J9Apjsai9vWgnGCZo6xyDc3CqhAhM2odDYxN57V0FxqC3JFdXNdueeQJJnoti5I4/xqL91mfAmNF07MKHhVH0/pZVEHVecb2gbk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7CDa2d9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713798572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2l5etRFA+3zS98rLPSjEL/W080Qc09Rpjm6l7LxbWqo=;
	b=b7CDa2d9rQ7OYhBk0J2joTuOv+LwCCLB72Hk0ZWSyjynqlFcZHDVOWaqqH+ZpymK0cU3u1
	Wr4s83RLjToNM9XdGDWd05qVmr5hvcjmeq4e3Fx5JeKavsR/HBNdjpbzni1eGgmayAt4La
	55A8K6TRn6ZelEGpHqDgce83jMrHJc8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-sF2UMsMsNkyr2Vt8n1Glig-1; Mon, 22 Apr 2024 11:09:30 -0400
X-MC-Unique: sF2UMsMsNkyr2Vt8n1Glig-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2dbef696ebeso34526701fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798569; x=1714403369;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l5etRFA+3zS98rLPSjEL/W080Qc09Rpjm6l7LxbWqo=;
        b=n+OK2h8GNufs6G+PvL2YBJJlvXuHWsM3FLZd8Z3RyeMKjOOGWJmGBlxwVK/PW+5rpf
         wuKfnGcoUV0215LdIm3qdpq3bHLKBDj+3W3eQwHhalF1RHCZw5Ycd/ujXFBYdCulMISn
         d4hiIuMlFDE/qaQTG9ZmEL9ZtaUyVPnQ3Iq2F1obzsL1u/vTTyEI6K2uijF+xz+9ezzz
         3ibTCfo0aSC2PIPBjVETPwlAdox37JxtC3lUNchzaEBYNx4nkFnHxj5hYomi1CnByRfW
         Sj8a7oifpybai6kOYzS1upCAK0I0cRPEKFuDirbNu/Mzv52nELzPO3EFDIEKMX+smwG+
         8YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6vUoxgF5W2gZq1T/CQ76PguDlEm1QFVlIzvCsb8DNUCxY8oRiJpQqrx5smXpiy/qkoOuiB+dzJkNcEsEQUcOyR0pkRasN3hBiq1Em
X-Gm-Message-State: AOJu0YzplGdXu2CE/n/9grUJhL4egqfWWkh0/oUROKyMnKLgFplj6G4w
	pjBD+SMBs88LKsqBbYjvVgB/0NXJSvFaeoT3wWj6T/KITAUWkzepsKLuk6BG17ihi9L0v1XVcCy
	VDNMwNmqmmwjlqHwaf40899Khu7eHxe4ijZK7MwsqMRQq5Avx5pJz0S2qMGCgukike/p6lg==
X-Received: by 2002:a2e:98d3:0:b0:2d8:f3b:d026 with SMTP id s19-20020a2e98d3000000b002d80f3bd026mr6919199ljj.14.1713798568828;
        Mon, 22 Apr 2024 08:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH/S6k0dekbOWFX638LcGCK7Nb/JSn/s2VEj2jbLQe6bRt+XloX7Ltfx6Ru3sdcWlech/6Cw==
X-Received: by 2002:a2e:98d3:0:b0:2d8:f3b:d026 with SMTP id s19-20020a2e98d3000000b002d80f3bd026mr6919123ljj.14.1713798567402;
        Mon, 22 Apr 2024 08:09:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00417ee784fcasm16996478wmq.45.2024.04.22.08.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 08:09:26 -0700 (PDT)
Message-ID: <4328e879-f5dc-4b90-89bd-d7969afba350@redhat.com>
Date: Mon, 22 Apr 2024 17:09:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: Reset ptes when close() for wr-protected
 ones
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
References: <20240422133311.2987675-1-peterx@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240422133311.2987675-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 15:33, Peter Xu wrote:
> Userfaultfd unregister includes a step to remove wr-protect bits from all
> the relevant pgtable entries, but that only covered an explicit
> UFFDIO_UNREGISTER ioctl, not a close() on the userfaultfd itself.  Cover
> that too.
> 
> Link: https://lore.kernel.org/all/000000000000ca4df20616a0fe16@google.com/
> Analyzed-by: David Hildenbrand <david@redhat.com>
> Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 3e6ddda6f159..d2c3879745e5 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -898,6 +898,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>   			prev = vma;
>   			continue;
>   		}
> +		/* Reset ptes for the whole vma range if wr-protected */
> +		if (userfaultfd_wp(vma))
> +			uffd_wp_range(vma, vma->vm_start,
> +				      vma->vm_end - vma->vm_start, false);
>   		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
>   		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
>   					    vma->vm_end, new_flags,

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


