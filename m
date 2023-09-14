Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708D7A063D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjINNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbjINNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:39:55 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E044498
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:37:50 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-450711d9bf1so542519137.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694698669; x=1695303469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UjaH6awq5V/b/h5EjTWTj3DotldQx6AS4c6JYOsrlY=;
        b=f/Z4cmnj6enPrTWIXfYtVYxLN/CuOVi/hJmahdCSxfkLgWuObcXL2lVi4MU73/mlxd
         JtkjE11DJvw9BW/m9VEeL8yRwgEqIP4j2g7Z+bW6S3L5WzmFbOshHOZhzB8m/YoZimzM
         oofKzUIl+ifzdSdc4fv2h6hjTp/pYYqipmqIiojKtUMUO0RYmvNvQV2nTkNg3BXXjUDl
         MPhiML5iW6jnXawv6lPfdMs1Ega7J4XL2l2MId32YMHy8WalCepieaEDO6bw7/vyn/DP
         Df2zcegRn/c3QmxJ/0qX66hMDNwscsdkM3unsQgxl22AQsRnqgXGrsEQZtlXEGJvzIoH
         LBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698669; x=1695303469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UjaH6awq5V/b/h5EjTWTj3DotldQx6AS4c6JYOsrlY=;
        b=ITgHVHlPADfFy8HSFkXBTSRm2auM4j71zso930FY11zSIeilsZLze479ksMdK8KKdr
         gsGRp6YBET4Yw0Ep7oyfDIt+YpEljOraMjDIWxFCVcs7QqzSJDnM/tHCXrD2ufkUZCA9
         H6yvZjXy4E04mmmDM7OikijaMm65rq/RXXKTOsHIql0f7BJj8G0wZzRMBdFaZw2+zinL
         OCmJwdoTfR5njsqde9Hx/gT+GjgxJ+aqeB5m/oLpw4ymNBBkBttVRC/QypLK778HIrdQ
         siQP1oDoTLKrbOxJfYVhiArl/9+jiN+nBzdLoI2GjZrbUggFN5Bv7ngQcrWwP71lFhy8
         SiWw==
X-Gm-Message-State: AOJu0YyB7ltds+FpNUHio0vMQdxrn1vYVQDZtMbAqDTX5WCfzeMGALsG
        1V40FCfgcecohbd/hl9AhhUFNQ==
X-Google-Smtp-Source: AGHT+IHw2m/QzL3fWk6Anxsy/+dsxwjlnmmZnMwridhM308Ybhxzx8YwAeHDxESxqJxU9dr3tEIeCA==
X-Received: by 2002:a67:f84d:0:b0:44d:634c:1125 with SMTP id b13-20020a67f84d000000b0044d634c1125mr5277278vsp.13.1694698669249;
        Thu, 14 Sep 2023 06:37:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id h16-20020a0cf410000000b0064713c8fab7sm476813qvl.59.2023.09.14.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:37:48 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:37:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: page_alloc: fix move_freepages_block() range
 error
Message-ID: <20230914133748.GE48476@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-5-hannes@cmpxchg.org>
 <2f2985f0-f1a7-f085-fd18-107f3fba9478@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2985f0-f1a7-f085-fd18-107f3fba9478@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:40:48PM +0200, Vlastimil Babka wrote:
> On 9/11/23 21:41, Johannes Weiner wrote:
> > When a block is partially outside the zone of the cursor page, the
> > function cuts the range to the pivot page instead of the zone
> > start. This can leave large parts of the block behind, which
> > encourages incompatible page mixing down the line (ask for one type,
> > get another), and thus long-term fragmentation.
> > 
> > This triggers reliably on the first block in the DMA zone, whose
> > start_pfn is 1. The block is stolen, but everything before the pivot
> > page (which was often hundreds of pages) is left on the old list.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> > @@ -1652,7 +1652,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
> >  
> >  	/* Do not cross zone boundaries */
> >  	if (!zone_spans_pfn(zone, start_pfn))
> > -		start_pfn = pfn;
> > +		start_pfn = zone->zone_start_pfn;
> >  	if (!zone_spans_pfn(zone, end_pfn))
> >  		return 0;
> 
> Culdn't we also adjust end_pfn to zone_end_pfn() so we don't just ignore the
> last half-pageblock for no good reason? (or am I missing any?)
> Also would stop treating end_pfn as inclusive here and in move_freepages(),
> it's rather uncommon.

You raise a good point here and in the reply to 5/6. Let me reply to
the other email.
