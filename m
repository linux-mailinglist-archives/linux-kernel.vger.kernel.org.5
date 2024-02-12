Return-Path: <linux-kernel+bounces-61503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061C18512F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3AA1F23F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F843B797;
	Mon, 12 Feb 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJjVrxZr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C63BB23;
	Mon, 12 Feb 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739310; cv=none; b=rjZk/RTc95aFmRg6DLwcss6DjDEJeWYfMhp1gPDrj54uLQ17c1NxmNL4hcZ2u709PLjIYPlD94YpfLfkZM62KmMbYQYj6j83/C48vby0EcWVe/qmgQOmay+BOnmDA09X9EOr5FAUeZ7JRrIEYyvwSNX1UVlQqhh1a8jS50HCvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739310; c=relaxed/simple;
	bh=Zbm7OvR5CTMJxI3KIhd7PWN3VnpiSouivKvRc06eL7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRG0sQ6T6wlGNNWtBmDS9YGK0yfCDArC8YxGFjeSgzaeXtwqHY28yJNa0Tf74DSKVWPlzXuZxiuWSOD2oOO5WhjSZFWhVeiHIjIirIbkl5HwODn2hVHt+yzxVX4SQyyKlGEDIkwdvmbeJwsc/D3kUDTgcLlpGYW+Wdz9WRVRFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJjVrxZr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739310; x=1739275310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zbm7OvR5CTMJxI3KIhd7PWN3VnpiSouivKvRc06eL7M=;
  b=bJjVrxZrcKuayAKBR646Bg8JiIDtlBpd4fZtrdlCXvSWOd1prGMjZrQk
   Ja8XOWBaxXnJD7BWP6Q8aJTPnUgPD2OF3LiqpxOutMS4czGF0wi91LKdG
   Wfb550+q7to5uoQbTIgYZZK2D05frWkBqIHr7AfCU/eqpUahbZt+FcA0t
   rXiQaxB46i/obSGSRhscBGejyRpxKu3s/wkVT/QdMnYtsz4GTCU/Ux/pR
   Vlw1RjQPgdYlGWK8Tt+UbVwEUV6BRAzK/oiYBrOirxO3u85yJ0AhdzQEH
   QlqTRr54f58L740DmfkqImCzIKwgJ7wbXoiZ/V8+sUAdtr8papmymTHgZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19124904"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="19124904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="7228547"
Received: from hadjchai-mobl.ger.corp.intel.com (HELO [10.213.230.110]) ([10.213.230.110])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:01:46 -0800
Message-ID: <c470ce0e-f52c-4240-9d5f-c1dfd9b46675@linux.intel.com>
Date: Mon, 12 Feb 2024 12:01:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: Add flex arrays to struct i915_syncmap
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240208181318.4259-1-erick.archer@gmx.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20240208181318.4259-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/02/2024 18:13, Erick Archer wrote:
> The "struct i915_syncmap" uses a dynamically sized set of trailing
> elements. It can use an "u32" array or a "struct i915_syncmap *"
> array.
> 
> So, use the preferred way in the kernel declaring flexible arrays [1].
> Because there are two possibilities for the trailing arrays, it is
> necessary to declare a union and use the DECLARE_FLEX_ARRAY macro.
> 
> The comment can be removed as the union is now clear enough.
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, refactor the "__sync_seqno" and "__sync_child" functions due
> to now it is possible to use the union members added to the structure.
> This way, it is also possible to avoid the open-coded arithmetic in
> pointers.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Looks good to me too so I've pushed it to drm-intel-gt-next, thanks!

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/i915_syncmap.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_syncmap.c b/drivers/gpu/drm/i915/i915_syncmap.c
> index 60404dbb2e9f..df6437c37373 100644
> --- a/drivers/gpu/drm/i915/i915_syncmap.c
> +++ b/drivers/gpu/drm/i915/i915_syncmap.c
> @@ -75,13 +75,10 @@ struct i915_syncmap {
>   	unsigned int height;
>   	unsigned int bitmap;
>   	struct i915_syncmap *parent;
> -	/*
> -	 * Following this header is an array of either seqno or child pointers:
> -	 * union {
> -	 *	u32 seqno[KSYNCMAP];
> -	 *	struct i915_syncmap *child[KSYNCMAP];
> -	 * };
> -	 */
> +	union {
> +		DECLARE_FLEX_ARRAY(u32, seqno);
> +		DECLARE_FLEX_ARRAY(struct i915_syncmap *, child);
> +	};
>   };
> 
>   /**
> @@ -99,13 +96,13 @@ void i915_syncmap_init(struct i915_syncmap **root)
>   static inline u32 *__sync_seqno(struct i915_syncmap *p)
>   {
>   	GEM_BUG_ON(p->height);
> -	return (u32 *)(p + 1);
> +	return p->seqno;
>   }
> 
>   static inline struct i915_syncmap **__sync_child(struct i915_syncmap *p)
>   {
>   	GEM_BUG_ON(!p->height);
> -	return (struct i915_syncmap **)(p + 1);
> +	return p->child;
>   }
> 
>   static inline unsigned int
> @@ -200,7 +197,7 @@ __sync_alloc_leaf(struct i915_syncmap *parent, u64 id)
>   {
>   	struct i915_syncmap *p;
> 
> -	p = kmalloc(sizeof(*p) + KSYNCMAP * sizeof(u32), GFP_KERNEL);
> +	p = kmalloc(struct_size(p, seqno, KSYNCMAP), GFP_KERNEL);
>   	if (unlikely(!p))
>   		return NULL;
> 
> @@ -282,7 +279,7 @@ static noinline int __sync_set(struct i915_syncmap **root, u64 id, u32 seqno)
>   			unsigned int above;
> 
>   			/* Insert a join above the current layer */
> -			next = kzalloc(sizeof(*next) + KSYNCMAP * sizeof(next),
> +			next = kzalloc(struct_size(next, child, KSYNCMAP),
>   				       GFP_KERNEL);
>   			if (unlikely(!next))
>   				return -ENOMEM;
> --
> 2.25.1
> 

