Return-Path: <linux-kernel+bounces-149357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6648A9007
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1021C20DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C162C15D1;
	Thu, 18 Apr 2024 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpAptudi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1563C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400116; cv=none; b=X9roo6DXSku1+gTBSe0OYEg21NUCfrid1t2TYAiT7t1ZrdOLdG+UpdurVd65Uy/6cj/6yYf9ZE3ijo5KKEgMzK6AjLawLy1t2zHLkaLi8Pyyo5d5GokgoAsdHkjdRX5/pHEIDuGwU8qX+QduK5Juxm1QZSuD8tKysdAPJlCCPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400116; c=relaxed/simple;
	bh=E4arsPzMD+QIZBCLrwwJ9l3JEyK6f+j621bQZwrrbNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7COiQ/gCkl69I2dQklnu83XgYP6X3DaU7eBr6pCOTOy4MucPUEe6b6B/aylclbQ/du6R9PuSVVzihsmAX04MOTFOZHTqc1uF3IIW+rrgq87CZ1vHEtQ6XDxyMcSS6/qJqLGvwDayJrqsPFuIPww4EFjBb5Rw15HCYqpKtXuYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpAptudi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713400113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jV3NxPG2VkGcFSCoj+CqZoFen5LhNgf3imIldjqPCo=;
	b=LpAptudiZqQE0Cra/LOagUkqKfxyTJWZwTu0SFUZQapzNHo6XqBi7R3k5Lh4SXWCtXiKqe
	mO4b10Joi9g/I0kiSaBvRtmxvtViJRO0t6JPktmbWczX+AWtITrM2pmsdnYaUzvNBhGiL8
	wh0Axua7ewbIEwEPOF6UQ1kIznDnehE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-3DayUSGKPAmcTJ5N2NTsVA-1; Wed, 17 Apr 2024 20:28:32 -0400
X-MC-Unique: 3DayUSGKPAmcTJ5N2NTsVA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e604136b6dso4415275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713400111; x=1714004911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jV3NxPG2VkGcFSCoj+CqZoFen5LhNgf3imIldjqPCo=;
        b=Dsk3xJuBn/LklhiWBn1yCvZgWHOMV6eDIbYzdmIWO+QzSyX4eNfLJDMFaVFwwIuUgB
         b7fG37QbV20939jOeItqXMw9xklr5cJXsntn0lN3BKCin/Bs1+KjgAFTgeAnehtyS/AX
         TlSyG5eQI3gISymRnlCNPdUk7vQXj5wpePrXy862Cgnh0qXiU41Hos5ZpbIr9fuh+6uK
         l4oykWobnYvP5PCFt2/B4PAbDVegE+r/eVy638WiL5FCpN0wijQwSZsFk8w9yJ9KzJ21
         KlKtcpDPFUUk2ZheKLs1FK50AELxoFdKSLVUSck//5VmJDYzOElgU4ZIJSiQaJ3a92Gl
         kNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGUVwHHtoVxaJpwLaq8S1PVA2Slvd/EGQgUalWGd5OPwWyAeR2ihEwWTnU/jl2e0v5kpJ8nE5h5lpF+JtSTPvx2vFnjMbYQUpOZzG1
X-Gm-Message-State: AOJu0YyhnKKX+Hv/KBCr8xFpcdjnXqUIBAkBCqthGkRMxf47n6hLlz/4
	kSt9e8kJUDWbZ8adUU0Dpl+rnEmeSW+TbPk5ErMXP1tds40WDDVcYDh6ftOYDwig4Ml1CA+myTO
	9qS2Th3mbUsm3e7D/x2vRXdWYOqFyzHOU7FSf0V7K1E68Mpn0e8rM9zbzZArGDQ==
X-Received: by 2002:a17:902:a70b:b0:1de:e6a5:e51d with SMTP id w11-20020a170902a70b00b001dee6a5e51dmr1125487plq.16.1713400111269;
        Wed, 17 Apr 2024 17:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnGifVjUZc6JYr8+X4V1IU5XrfsR1gvJ+hBF0QCqo64SetRIuf3s/amABGErI5D2wT3b3w3Q==
X-Received: by 2002:a17:902:a70b:b0:1de:e6a5:e51d with SMTP id w11-20020a170902a70b00b001dee6a5e51dmr1125472plq.16.1713400110923;
        Wed, 17 Apr 2024 17:28:30 -0700 (PDT)
Received: from [10.72.116.40] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001e042dc5202sm238888pln.80.2024.04.17.17.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 17:28:30 -0700 (PDT)
Message-ID: <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>
Date: Thu, 18 Apr 2024 08:28:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
 Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 ceph-devel@vger.kernel.org
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-5-ryncsn@gmail.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240417160842.76665-5-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/18/24 00:08, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
>
> page_index is needed for mixed usage of page cache and swap cache,
> for pure page cache usage, the caller can just use page->index instead.
>
> It can't be a swap cache page here, so just drop it.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> ---
>   fs/ceph/dir.c   | 2 +-
>   fs/ceph/inode.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 0e9f56eaba1e..570a9d634cc5 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -141,7 +141,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
>   	if (ptr_pos >= i_size_read(dir))
>   		return NULL;
>   
> -	if (!cache_ctl->page || ptr_pgoff != page_index(cache_ctl->page)) {
> +	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
>   		ceph_readdir_cache_release(cache_ctl);
>   		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
>   		if (!cache_ctl->page) {
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 7b2e77517f23..1f92d3faaa6b 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1861,7 +1861,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
>   	unsigned idx = ctl->index % nsize;
>   	pgoff_t pgoff = ctl->index / nsize;
>   
> -	if (!ctl->page || pgoff != page_index(ctl->page)) {
> +	if (!ctl->page || pgoff != ctl->page->index) {

Hi Kairui,

Thanks for you patch and will it be doable to switch to folio_index() 
instead ?

Cheers,

- Xiubo


>   		ceph_readdir_cache_release(ctl);
>   		if (idx == 0)
>   			ctl->page = grab_cache_page(&dir->i_data, pgoff);


