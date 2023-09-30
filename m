Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648B7B3E00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 06:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjI3EUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 00:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjI3EUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 00:20:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B92E5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 21:20:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d8181087dc9so16365901276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696047642; x=1696652442; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwtKmPvCMIR2EIv34/KoCTCLjCkr+A/C7qE9mBWX5MY=;
        b=F9qyS1fJE+pENW30QmyKbhAVUUns6aJaJLj3Ooqd8bwzEX1wIZfIEnSttOvenx4LoG
         4PbQTjKkt6dRKY+JhB9IJvgKbFWpo9nbU9Mea7Q3IpG48sQ9RRaIWVexsrcFqowfghCh
         5SjJMBOJppvxa9KXvEr3EYeokomzNKRRtXCA0LAgoo/X7FWlzzSPphOUWpJiqNot2oBp
         SKwIWSYEuca9WD3k34v0S/dRetr33YN6EBUQ4CB2OmZl9y01G6Ew8hl6DO7mbt9ZWQdC
         qLkytTXyfMro5m2Z/KnAnivOlF56QPmRH/cvWx6xE4/TOOD5I3mH3PEfHBlc0jgA2+CY
         U5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696047642; x=1696652442;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwtKmPvCMIR2EIv34/KoCTCLjCkr+A/C7qE9mBWX5MY=;
        b=W7+65vplxqdkleNnfHpRWeHDns42JZrLJ+t+uGj9aUMGGQHOCDz3Es6CkCKSHM+X3E
         LEdEwTJByYEa15ARJOvFc/BF0fogjUI2UtKF6vkQRz6mPXreMCNJFmsbQ2FrP/QQAV2m
         pHHnpoYEB+gZG74p4YuUGLzb2Y8n0Q6FRF6xRmOk+zXWuTFw1ifsaB5k6f7gdtV2Etyu
         x3aek/PsfceszAQBsGSj5FHpxsQfOUfBsfI2EWoV5+h/+WSNZIgTXh+whETmHdoG1piZ
         Li5D33QgNcM0IvE947QA2OWRd7wC/eg6w/LRHovcd2rpZUnSPWPI4Mvzk6JIVRY9cVTT
         XCMw==
X-Gm-Message-State: AOJu0YxpT5259thTRa7HOmIYTUcJxvl8BV9DYlpY9x9F7BjpCtaacgWn
        vb6TM8aGkqJKeW0+BjY5HilSUA==
X-Google-Smtp-Source: AGHT+IHUA18m9biIbxpaGmipd7DQbu+U5iTITctyN7T2GGKvk8Ng6u5/6qw0vOOPwqD9qb0zUnRo7A==
X-Received: by 2002:a25:8204:0:b0:d86:55a1:3e5f with SMTP id q4-20020a258204000000b00d8655a13e5fmr5923440ybk.48.1696047641999;
        Fri, 29 Sep 2023 21:20:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o5-20020a056902010500b00d865e9d394asm4345301ybh.14.2023.09.29.21.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 21:20:41 -0700 (PDT)
Date:   Fri, 29 Sep 2023 21:20:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
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
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 03/12] mempolicy: fix migrate_pages(2) syscall return
 nr_failed
In-Reply-To: <87sf70rqlw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <119e243a-b3f0-b6d-4b8b-9dab1acfc34@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <ddad2cee-cbad-7b5d-935a-59f961b7c3a@google.com> <87sf70rqlw.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> > -static int queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> > +static void queue_folios_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
> 
> I don't find that "ptl" is used in the function now.  So, remove it?

Yes indeed, thanks for spotting that, I shall remove it.
And I think addr, end are also unused: I'll remove them too.

...
> > +		if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
> > +		    !vma_migratable(vma)) {
> > +			qp->nr_failed++;
> > +			if (strictly_unmovable(flags))
> >  				break;
> > -			}
> > -
> > +		}
> 
> IIUC, even if !(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) or
> !vma_migratable(vma), the folio will be isolated in migrate_folio_add()
> below.  Is this the expected behavior?

Yikes, I think you're right, thanks a lot: it was okay up until I realized
the "qp->large" issue, and had to separate out the migrate_folio_add()
failure case.  Late changes...

> 
> > +		if (migrate_folio_add(folio, qp->pagelist, flags)) {
...
> > @@ -731,22 +714,22 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
> >  /*
> >   * Walk through page tables and collect pages to be migrated.
> >   *
> > - * If pages found in a given range are on a set of nodes (determined by
> > - * @nodes and @flags,) it's isolated and queued to the pagelist which is
> > - * passed via @private.
> > + * If pages found in a given range are not on the required set of @nodes,
> > + * and migration is allowed, they are isolated and queued to the pagelist
> > + * which is passed via @private.
> 
> s/@private/@pagelist/

Right: or even better, simply "queued to @pagelist."

...
> > @@ -1201,8 +1187,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
> >  	lru_cache_enable();
> >  	if (err < 0)
> >  		return err;
> > -	return busy;
> > -
> > +	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;
> 
>         return min_t(long, nr_failed, INT_MAX);
> ?

I may be the odd man out, but I read it more easily how it is:
so will stick with that, unless others object.

Very helpful comments: thank you,

Hugh
