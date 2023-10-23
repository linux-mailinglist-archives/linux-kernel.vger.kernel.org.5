Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEE7D417E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJWVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:10:56 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF55AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:10:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9b2ca542e5so3584730276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698095453; x=1698700253; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+lMwsOA5igTui7DZ6kBh3YAl4UcBGgcd2WaOCaIFgE=;
        b=qe5+TlSbcTzsIarZ0V3yOtdThqwGSmNVpwKABxo5FObZpMNpdlCPoFbzfppacc6l0I
         Q5pfpPAnZhIMfepA0rUqjbTSxCa/AM2fGlq6VmM5uxsZrNLidV392a4PRmKVberjZKMl
         qn55hqJmbuwrRc3OSNvXsqppJTF2PFhRrL35oJ1QQfzqPQQA5+5SeAl6lqzwDhmyPpw2
         5l7MP5QlHtn3Nx9gi5/OitwOphURDGru8YD4eHRF/KPvtvtIvJc4W9F6+tyAXZtPvY/I
         V8l8YtX8ow3R8iHbvIAKNTTWb4f+cU+wiTEn99Wl04tQTkSxwnpF19ufsRkk8iuFaQBX
         DVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095453; x=1698700253;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+lMwsOA5igTui7DZ6kBh3YAl4UcBGgcd2WaOCaIFgE=;
        b=iz2d7tGkHpNcuvpoiFedt2S4OkRAdqyv/m4G/hK/N51v6KI0um1K+bmZo1jBal9KVs
         ZQVEPoAQL9EMsvAeiVDnI35xXOMi+PbYRxteZGfqByl4UAfJaMaPg4Qx5Jc7uNVvsDL8
         Wy3mzlTDBNz1ULyZkwIRoNLI7OUg6OH5ePdkZgMLKAzkxUgOOcMUgbDEFS8dCFTyCd/x
         iab+ZuWUyJFv/nGQUnafyAwh8BtZTO7Syrq0Uhd+L1K4iT0nOfhnB1LSfqxSZIYlT8Ke
         qmDfVv+ABeQiyM1iFrHYLN1bUJWlXWu4i4MyBwzv356ziTDt3yhlFUPvg9AM8uiILVOU
         7kZA==
X-Gm-Message-State: AOJu0YxWvO7Gzaam9Ar6+Vu9zOSY4YxocWPd474LhpGtp4++5tts+4BS
        ozNBVMU3Hkz+r1+Owklj1uvMag==
X-Google-Smtp-Source: AGHT+IGfGiVKxuRbPKyaWQkR1oR/FVsCb+/X6ny8t6swEnVMaTITl2VbihOLUBWoHKAJjdrK8ep42g==
X-Received: by 2002:a25:97c3:0:b0:d9a:d184:8304 with SMTP id j3-20020a2597c3000000b00d9ad1848304mr9817584ybo.35.1698095453004;
        Mon, 23 Oct 2023 14:10:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 16-20020a250910000000b00d749bc5b169sm2962754ybj.43.2023.10.23.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:10:52 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:10:38 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
In-Reply-To: <61FB8BFF-E3CB-4C99-8A6D-845A69E4E76F@nvidia.com>
Message-ID: <8c933f5b-983e-a332-e410-6ee6872f839f@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <74e34633-6060-f5e3-aee-7040d43f2e93@google.com> <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com> <61FB8BFF-E3CB-4C99-8A6D-845A69E4E76F@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023, Zi Yan wrote:
> On 19 Oct 2023, at 16:39, Hugh Dickins wrote:
> > @@ -1170,6 +1170,15 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
> >  			break;
> >  	}
> >
> > +	/*
> > +	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NULL
> > +	 * when the page can no longer be located in a vma: that is not ideal
> > +	 * (migrate_pages() will give up early, presuming ENOMEM), but good
> > +	 * enough to avoid a crash by syzkaller or concurrent holepunch.
> > +	 */
> > +	if (!vma)
> > +		return NULL;
> > +
> 
> How often would this happen? I just want to point out that ENOMEM can cause
> src THPs or large folios to be split by migrate_pages().

The only case I know of it happening was when a file was mapped, then that
file truncated (cutting out the source page) before migrate_pages(&pagelist)
reached it - rather a syzbotty thing to do, not of great reallife concern.

I won't assert that's the only way: I've a ghost of a memory of another way,
that I can't quite resurface, from a long-ago version of queue_pages_range().

But in the end just didn't care enough about it, because this is really just
to save a bisection point from crashing - the possibility goes away in the
11/12 commit which follows this one, which takes VMA out of it altogether.

Hugh
