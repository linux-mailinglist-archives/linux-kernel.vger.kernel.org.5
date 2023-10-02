Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227E47B55D6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjJBO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbjJBO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:58:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51510DC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:58:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65afba4cfadso85631696d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696258713; x=1696863513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sFWixVT1aJ1xZnbcfQwd2hXqQRNB5cMO+e1QJYiddA=;
        b=AAAtEirevuhi4YSLfcquhi4MOppQCXgDWlVgt8IyN+ygmJMOOTrxmdBXBL1tMEkzX7
         zQpoFrBNjD9fMGVzF5sr0FNetXUshg5lK7KER460N0KinpzcfcxwXXysXiOufFGBfWq8
         z6BSl2aFJuQTkBzh6GCgzIUzKQ0wqmjamvBwIFt3ECPc9hnkjP5/VfM2iTpsDCCajE3l
         VelvASqHIxAMSFj7ZCiGgkJlLUc4bVYPkokBrZTUEZsVHdotaKy5sRjgZuZyzVAiTvtK
         jdmMLMaJBPmOWOXMDpVA2S2dibhAyrzWL/yHiVgHWBULZwejbsIuIamj8onf0l/OSgRf
         CI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258713; x=1696863513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sFWixVT1aJ1xZnbcfQwd2hXqQRNB5cMO+e1QJYiddA=;
        b=esp58SFLbxvYTnqz7HXq+4/AREWLQy28sd/r4xBSarQjyc1Wjkna7MFG6yJQ7FlwzG
         nMGocwthmwL/MP5Ejuprz4zTbxrUv3nQnyWAmWRwo5z/cPGFVe7K8TYD1e2UU9gYMjRZ
         ToDz/N3VZNZlCwBEF7IeAmG6vtz7cVXPytC4gdSKOV5WMpLv/AKYD5N+i80bwFzcD5T+
         Fr/nxS3PRUJFybctRRk8z+hKMB5kUMDKIiIpVynGbN6Dh4v5vpF7rskgfEezNZFV//Ah
         EpVeA0YMPUCrWO3erahL9P99Q3iK5lP0dgRP2FUExMGuhB1eC+RTZVGMV+r587vxam2+
         Zmsw==
X-Gm-Message-State: AOJu0Ywc83lBncyB/uP9PyQMpn+kfN7WJG0Hsk+tWhN8EEEH5TUgJrcL
        UW/afDcxOE7nXqtm9BfsQlblPg==
X-Google-Smtp-Source: AGHT+IEYMyB6kO3EaICU1eCypYWYXZYQCfEUvn2XQ+5lFcitH6GpMhzkUOZ5TPGoksk8znqkDZF4+w==
X-Received: by 2002:a0c:c302:0:b0:65a:f9f3:e779 with SMTP id f2-20020a0cc302000000b0065af9f3e779mr11660343qvi.34.1696258713315;
        Mon, 02 Oct 2023 07:58:33 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id t9-20020a0cde09000000b0065d0dcc28e3sm3440408qvk.73.2023.10.02.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:58:33 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:58:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20231002145832.GC4414@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <87y1gsrx32.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230927145115.GA365513@cmpxchg.org>
 <87pm20p9ra.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm20p9ra.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 12:26:01PM +0800, Huang, Ying wrote:
> I have done more test for the series and addon patches.  The test
> results are as follows,
> 
> base
> perf-profile.children.get_pfnblock_flags_mask	     0.15	(+- 32.62%)
> will-it-scale.1.processes			618621.7	(+-  0.18%)
> 
> mm: page_alloc: remove pcppage migratetype caching
> perf-profile.children.get_pfnblock_flags_mask	     0.40	(+- 21.55%)
> will-it-scale.1.processes			616350.3	(+-  0.27%)
> 
> mm: page_alloc: fix up block types when merging compatible blocks
> perf-profile.children.get_pfnblock_flags_mask	     0.36	(+-  8.36%)
> will-it-scale.1.processes			617121.0	(+-  0.17%)
> 
> mm: page_alloc: move free pages when converting block during isolation
> perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 15.10%)
> will-it-scale.1.processes			615578.0	(+-  0.18%)
> 
> mm: page_alloc: fix move_freepages_block() range error
> perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 12.78%)
> will-it-scale.1.processes			615364.7	(+-  0.27%)
> 
> mm: page_alloc: fix freelist movement during block conversion
> perf-profile.children.get_pfnblock_flags_mask	     0.36	(+- 10.52%)
> will-it-scale.1.processes			617834.8	(+-  0.52%)
> 
> mm: page_alloc: consolidate free page accounting
> perf-profile.children.get_pfnblock_flags_mask	     0.39	(+-  8.27%)
> will-it-scale.1.processes			621000.0	(+-  0.13%)
> 
> mm: page_alloc: close migratetype race between freeing and stealing
> perf-profile.children.get_pfnblock_flags_mask	     0.37	(+-  5.87%)
> will-it-scale.1.processes			618378.8	(+-  0.17%)
> 
> mm: page_alloc: optimize free_unref_page_list()
> perf-profile.children.get_pfnblock_flags_mask	     0.20	(+- 14.96%)
> will-it-scale.1.processes			618136.3	(+-  0.16%)
> 
> It seems that the will-it-scale score is influenced by some other
> factors too.  But anyway, the series + addon patches restores the score
> of will-it-scale.  And the cycles% of get_pfnblock_flags_mask() is
> almost restored by the final patch (mm: page_alloc: optimize
> free_unref_page_list()).
> 
> Feel free to add my "Tested-by" for these patches.

Thanks, I'll add those!

