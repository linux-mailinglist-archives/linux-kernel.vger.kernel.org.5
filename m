Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3979D797
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjILRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjILRco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:32:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0F10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:32:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4142ca41b89so40097351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694539960; x=1695144760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkTdSj2foDtzrxHFb+zU+yddoMluyMCPvY7ZkzAWYro=;
        b=ONKQxvVBg25/bX/YqEXt9xeIcNXj1CwUOS5IrQTwjgDxT0vAnD/lriPPNFNA/FdIiz
         A+METnUigsjmaBbLkOtr++a1JwAA8DobS3or+GWxs6bS4C3u88qoO4IOynEA+3wzCYp+
         zKnvRdw7FgjPw2XskYa6/FZ3cJTf0R3WWnpjLy7h495AOIoTwHbHohXsY+2L4PzPxvFH
         LxpLDkpueQ3w9r9xs3Ps4OIrN5iPL3yYz4/jUmkl3yiXvcdFD705pU0t7nNBlAcuUAoK
         m1ILw1wKln/Ets7NP8U1kdj7vVjWnH3mvPtAfipy2L0TVMsXYrhbPbWiqZOs1yc0rHYc
         d50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539960; x=1695144760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTdSj2foDtzrxHFb+zU+yddoMluyMCPvY7ZkzAWYro=;
        b=RyaMkXL+4+HdyJZGAprlT9bmV68rYYTE9I/Y1FYUpz0TqwmIXa0czRpkgG9JN0dQGo
         Z34v+cMsdxRc8Oma+V5zSF/fNn5k3mLrRuc9FMb86yVExTI5k/PAOauOXCeXa6BcGhbs
         A7+W9064f7uT5Y76PjJ/BU3pR7X3Td8OKHuSt35ONurRs3LBdmEGdAKMSiD+lyVicT5A
         /f8KReuma2UPP1M7gBnOwQge6FepBxm3SEfS7DgAY9J9GDTg2FpdOA4FqF7XJLUEy0z7
         f67nCks+7c2EbbwvjeP2xL7JnxelS/0V/W1jIb4xtg92Zos+7dy6lhs8kJ0mYK/NB5R9
         ad5w==
X-Gm-Message-State: AOJu0YwHRHQNjOX0uCKzfJW30anH2t/z0MMb3LQ65PT+kAz9pCvjurwV
        9dFWb5gntFz+iv67anei6V5Rrw==
X-Google-Smtp-Source: AGHT+IF+2qXb5xOBVmUJtnCYUR9grAByfiyi0C3FAXfr3C3jVJRxj8S4Rc6RDWDdSrEajMIRxOz9hQ==
X-Received: by 2002:ac8:4e53:0:b0:412:a69:3a01 with SMTP id e19-20020ac84e53000000b004120a693a01mr18116847qtw.6.1694539959945;
        Tue, 12 Sep 2023 10:32:39 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b0040ff387de83sm3441715qtc.45.2023.09.12.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:32:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:32:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm/compaction: add support for >0 order folio
 memory compaction.
Message-ID: <20230912173238.GB34089@cmpxchg.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912162815.440749-2-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:28:12PM -0400, Zi Yan wrote:
> @@ -1439,7 +1478,8 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>  	if (!page)
>  		return;
>  
> -	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
> +	isolate_freepages_block(cc, &start_pfn, end_pfn, &freelist, 1, false);
> +	sort_free_pages(&freelist, cc->freepages);

Can you make isolate_freepages_block() put the pages directly into a
sorted struct free_list?

AFAICS, the only place that doesn't technically need it is
isolate_freepages_range(). But that's then also the sole caller of
split_map_pages(), which can be made to work on struct free_list too
without notable overhead.
