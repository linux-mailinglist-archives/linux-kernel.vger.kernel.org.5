Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE347B55CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbjJBOm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbjJBOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:42:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3CAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:42:52 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4196ae80fc3so31793121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696257772; x=1696862572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9gT0sJ6bxJ7LFGJ3qcn0lur/HHwUZlrfxhEFRGE3Lc=;
        b=c6OXd9YFBsot277vrDT83xXwBobB0wm3QiKoEK3jxGefiNII0hx0/53I6hHHWBXXVI
         PjFknMvxds4R53+FJpAlBJ054OExLeKNeXw7qmnc4NxhEvXGplheOaY1MxMALVEdpnEm
         W9xaYOEaB8aSe+ML2F/9TOrJtMvONMM7IqgjwKu4XXCQXF2/cTBOxwCBeOnLp3QkJYMR
         JT0J8y/YwBi84rPL28BZJBtN5ohIIA/Rz8NRLRykwAuige0IT+Hi03kYU4VokLkQ+4dT
         su6T6pt0wlQHfEpCPdEAQscQR4fNXz7ttI3OKWzyE9lr6OI8GD7BTbehBqmSuPE8mkIC
         kwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257772; x=1696862572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9gT0sJ6bxJ7LFGJ3qcn0lur/HHwUZlrfxhEFRGE3Lc=;
        b=v61kcplc8qyxAnRGBlXflZZe16u5fPn7LPz3kHjPr/ZXu12aYnL3XSqgjgO45lEcqg
         zLWKDjtoSQYHj+4TEAyiCoMc94TWVpUygRPKdJrzNm/t7X9OwDjK5RW/yql27nhE2/HT
         vt49Q14LCEQWx8vVdQ7smB86SvDuZHktAsC8BWet+co2kaqzCYQAKb7Ie3slnOLXj/Xw
         5SEUgeVik5JUoNLfCcOrU1LvNvRRXI9NosPawAw/W1dZkmiQUTIANWmI/Fi/gYccEJcm
         up1qvuJsT9GzqGoBrBoq25AfBg/hMIVkDxXYArwLVyj1Ltw9JOhV/p/H68TEILNJ3QcM
         3AyA==
X-Gm-Message-State: AOJu0YwfOZaNmA9bj/EW5LSjJezSDA9nFRdFun/0Xl50rng0BhqM2saB
        7h+eaQ0i9cRzgnx459QaEL0rhw==
X-Google-Smtp-Source: AGHT+IFa+AtbCwYbo1F1bL/0dGXEiEXwwHQPJD08WSpIXpwHS50M5VhohUTqeEfXszT9O2DE8i1vpg==
X-Received: by 2002:ac8:588a:0:b0:417:95e7:a2f7 with SMTP id t10-20020ac8588a000000b0041795e7a2f7mr12774184qta.19.1696257771693;
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id h20-20020ac846d4000000b0041812600a47sm6261207qto.59.2023.10.02.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:42:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20231002144250.GA4414@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
 <20231001232730.GA11194@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001232730.GA11194@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:27:30PM -0700, Mike Kravetz wrote:
> On 09/27/23 14:47, Johannes Weiner wrote:
> > On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > 
> > So that if you use 80% hugetlb, the other memory is forced to stay in
> > the remaining 20%, or it OOMs; and that if you don't use hugetlb, the
> > group is still allowed to use the full 100% of its host memory
> > allowance, without requiring some outside agent continuously
> > monitoring and adjusting the container limits.
> 
> Jumping in late here as I was traveling last week.  In addition, I want
> to state my limited cgroup knowledge up front.
> 
> I was thinking of your scenario above a little differently.  Suppose a
> group is up and running at almost 100% memory usage.  However, the majority
> of that memory is reclaimable.  Now, someone wants to allocate a 2M hugetlb
> page.  There is not 2MB free, but we could easily reclaim 2MB to make room
> for the hugetlb page.  I may be missing something, but I do not see how that
> is going to happen.  It seems like we would really want that behavior.

But that is actually what it does, no?

alloc_hugetlb_folio
  mem_cgroup_hugetlb_charge_folio
    charge_memcg
      try_charge
        !page_counter_try_charge ?
          !try_to_free_mem_cgroup_pages ?
            mem_cgroup_oom

So it does reclaim when the hugetlb hits the cgroup limit. And if that
fails to make room, it OOMs the cgroup.

Or maybe I'm missing something?
