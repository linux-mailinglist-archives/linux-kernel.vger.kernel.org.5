Return-Path: <linux-kernel+bounces-118980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C388C22F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA061C3E360
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EC56B6D;
	Tue, 26 Mar 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="h5pIR1Bp"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE321CA9C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456492; cv=none; b=cNlXqXpRPZNdZcbq58KQFpjK22m/QO94sv3F8yAk5RWOVujDUO5n2fKXKKGw2V/VvONs7Oc399XPK0Bf32s7F5s8fSxD5MFPxHLq02WDlAECX7TrFRvq6F0VAlepv0voVvlYIbidrx5bmZbnowASsg9W31Hh961WbVKnxbeA1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456492; c=relaxed/simple;
	bh=XqT/GRU2KxFQU9+aJVASNWVsRMUJ+kpeULwTP3zw6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3gQ5ECzI70YYk75sZlgMcdy4vWSjidwG7z249dBwOD7+kfy9ax80GMiDiqkvntH0VJsQFXQCdpw3WkvKQArL/09W6HIG/nPfWEE7DOzkj9/GbyoKupdn5ETL1h2rDCq+sOBSblYuXARr3+fxWs5KjYkGOUbqDKuGfTX9qbFjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=h5pIR1Bp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3266359b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711456488; x=1712061288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLhSmKap/8NhcrPPuisW3sLtoAISq9zwTAJR88n1HH8=;
        b=h5pIR1Bp+jqAJnS9ELpmP05K6AjTAwf9QCW33jBON4P13Vl81vShhQf5byxXK6yYmU
         RSmPsh/RZCqqvqrrJxAsQnSze/RqMXX0FOYkid9xkmgr0EuyjIAeR1L7LiujpCJDwoZn
         FLdZliu55eX4zE7r5riBzK8HCoLm0WHEJj/Xe5Rh7fao1KLd/zEVBFN+lqmBiVuJCQky
         6TAjjmlsS5cxlcL7/qrhzBr/CBStW2VOYDVmZEehPx9cGnxltyL7eMGqsojro+LlEWkH
         MX0LJGX+UPRwmxgr3CEEm//c4gpkRJVjtEcOUrt4/L9cE0SeWsKzBMqP3SLvtqwxZ9AS
         or+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456488; x=1712061288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLhSmKap/8NhcrPPuisW3sLtoAISq9zwTAJR88n1HH8=;
        b=o/ao5hOYewiuduwZVkzqd3knz9sB5iC52//wg2Vfe8VJZUtBamGwgC7szcQWz4QB9C
         cSs02mERhc5MSSIMQN3x8Eg/BKIRPDuhgMQFmWSFM5Kt5UvdunV7ArZzkjnI9rBpc05h
         D4w7QXNQWFXXJL32n7MeLBC/+GPW1wewzi2jz+HmX7IQeUKOw2j/ad/wEKSERTnO6P5t
         sn0R0oyX4FFGhKe8hqsdbvZdXzAh/Q3gi9F4LdkbiWIuoQ7QHJPVGKdqfnLhE6hQGkl+
         X3JDDN3+LDMAelL8EDI/xGfyUWqX/sdMpcqd3myLzFWTCX0nCH1HhUK7P4KKp9llSIRu
         qxog==
X-Forwarded-Encrypted: i=1; AJvYcCUA3JKjmv7czRDRln2tK9M+IvVdT/C86wSnK2pmxrnaDhK2M7Y349xSy3U5GP21mgtv3Yqe+1VMlI7Agyvk3XItfqu+joaULPwKmeDy
X-Gm-Message-State: AOJu0YzMyGnd3v41+tPu94n/uztYD7QgndSiCUwT+lR3t7HXPCXquBJd
	V25dArV8AplswpcSU3Iu4CtX8wk1kVAOWxr/wpZNfTNA42iEfZQmuCKrEgQTLws=
X-Google-Smtp-Source: AGHT+IHFwjvbdUEtQgGG/iRcu/LkHH5mq23uCIK1+e4WJCT6zbP5CZMoAFleDB7POR5LXun8sTh+9A==
X-Received: by 2002:a05:6808:1782:b0:3c3:d496:e5e0 with SMTP id bg2-20020a056808178200b003c3d496e5e0mr924730oib.44.1711456488019;
        Tue, 26 Mar 2024 05:34:48 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id fy15-20020a05622a5a0f00b00430911bac01sm3635429qtb.74.2024.03.26.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:34:47 -0700 (PDT)
Date: Tue, 26 Mar 2024 08:34:42 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
Message-ID: <20240326123442.GA229434@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
 <a0879316-31de-4fec-ad1f-caabbfff2e48@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0879316-31de-4fec-ad1f-caabbfff2e48@suse.cz>

On Tue, Mar 26, 2024 at 12:28:37PM +0100, Vlastimil Babka wrote:
> On 3/20/24 7:02 PM, Johannes Weiner wrote:
> > Currently, page block type conversion during fallbacks, atomic
> > reservations and isolation can strand various amounts of free pages on
> > incorrect freelists.
> > 
> > For example, fallback stealing moves free pages in the block to the
> > new type's freelists, but then may not actually claim the block for
> > that type if there aren't enough compatible pages already allocated.
> > 
> > In all cases, free page moving might fail if the block straddles more
> > than one zone, in which case no free pages are moved at all, but the
> > block type is changed anyway.
> > 
> > This is detrimental to type hygiene on the freelists. It encourages
> > incompatible page mixing down the line (ask for one type, get another)
> > and thus contributes to long-term fragmentation.
> > 
> > Split the process into a proper transaction: check first if conversion
> > will happen, then try to move the free pages, and only if that was
> > successful convert the block to the new type.
> > 
> > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> >  	/* Take ownership for orders >= pageblock_order */
> >  	if (current_order >= pageblock_order) {
> > +		del_page_from_free_list(page, zone, current_order);
> >  		change_pageblock_range(page, current_order, start_type);
> > -		goto single_page;
> > +		expand(zone, page, order, current_order, start_type);
> > +		return page;
> 
> Is the exact order here important (AFAIK shouldn't be?) or we could just
> change_pageblock_range(); block_type = start_type; goto single_page?

At the end of the series, the delete function will do the
(type-sensitive) accounting and have a sanity check on the mt. So we
have to remove the page from the list before updating the type.

We *could* do it in this patch and revert it again 4 patches later,
but that's likely not worth the hassle to temporarily save one line.

> >  single_page:
> > -	move_to_free_list(page, zone, current_order, start_type);
> > +	del_page_from_free_list(page, zone, current_order);
> > +	expand(zone, page, order, current_order, block_type);
> > +	return page;
> >  }

