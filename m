Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693B7D5870
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjJXQdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjJXQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:33:02 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4A111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:32:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so4464016276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698165179; x=1698769979; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZPaVFmaQu36ybSH1tOD+8dMQ/zySnsYpid63BLeaO8=;
        b=J4iU1KxYecBj0fwomOaB3l4KJEsxMdVKQpJgeicTdkYzad1Knc2t7yfcBPWJeT2oy9
         qbFgU0MkXeydZa8E33XxE+jY/+0WeZ1+Nf/S7G6Z3EWlxwDvVQkceR5rZvNGSLTrc7+m
         SgkhH/fXLjz+Zn75d+wSg5mvE7RoVUjd2FQBnN/sQ4GA2YjFGuhEQoYDeQjIuQH1O3+R
         UXlA1hqnBIsktDl2CWyAqX/b30q1HyahLHyMGK0d6XtiLZ6cjU2yxVEp0tLfXFrsNL+0
         iahpGs9BVwku2jmfshMvLVW8FOIEAlo08LHGzLQgNCkMJ7e8ZiVIfvmxjRBLMZWDB7WO
         b2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165179; x=1698769979;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZPaVFmaQu36ybSH1tOD+8dMQ/zySnsYpid63BLeaO8=;
        b=iAG0JdySXTdIZB6fDvxtde5tHTiT1aARIBkNhHaARYalxmYl6vD9jqMPxFeU3XOgoV
         XanKn0mAHN4xUZnujMPlS5MDx8yEPQ0KUfNP+7de2DtjD+gBH4kNRutKclUnk9OUr2JU
         T6sw6fstgxtGIIC8i/4TGMWsds7VgLQD0IPHaCbZHhgTZVL8u68DttKUh2pJx7TI40Rn
         xbKznCWG2wBGATqtG+FpE3XYn+jQB/rXH0lZOjjljle0jqWVmP77OLQvcobce4oksz4u
         ol/5w+pT8stLpKhusoj4+gDrlJcprMwmqOBW+OQ6bcClDArC/ZVJ05FJSJbHq9Shm4I9
         zKaQ==
X-Gm-Message-State: AOJu0YzgiX/tu7dCxowlgeruTLg0wByQHeOcrwAGuFOiqDky6TatFuEG
        eLu0ONNlsSKh/P6MsRpCWMQk9A==
X-Google-Smtp-Source: AGHT+IG5cxpDFx0pwTrv4cdkOqCGMzhlQ+/6LRH3W8ygXnW19y/KuyT/3fCUVSO+WXmiXopiH78nNQ==
X-Received: by 2002:a25:2302:0:b0:da0:50a9:a748 with SMTP id j2-20020a252302000000b00da050a9a748mr1775256ybj.11.1698165178508;
        Tue, 24 Oct 2023 09:32:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d191-20020a25e6c8000000b00d0b0bbe574asm3699140ybh.44.2023.10.24.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:32:57 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:32:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>,
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
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mempolicy: migration attempt to match interleave nodes:
 fix
In-Reply-To: <20231024151827.i7e2f6cheet4k5h5@revolver>
Message-ID: <5b570bcd-e0fb-4473-7cfc-81b8b53d7712@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com> <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com> <3311d544-fb05-a7f1-1b74-16aa0f6cd4fe@google.com> <20231024151827.i7e2f6cheet4k5h5@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 24 Oct 2023, Liam R. Howlett wrote:

> * Hugh Dickins <hughd@google.com> [231024 02:50]:
> > mm-unstable commit edd33b8807a1 ("mempolicy: migration attempt to match
> > interleave nodes") added a second vma_iter search to do_mbind(), to
> > determine the interleave index to be used in the MPOL_INTERLEAVE case.
> > 
> > But sadly it added it just after the mmap_write_unlock(), leaving this
> > new VMA search unprotected: and so syzbot reports suspicious RCU usage
> > from lib/maple_tree.c:856.
> > 
> > This could be fixed with an rcu_read_lock/unlock() pair (per Liam);
> > but since we have been relying on the mmap_lock up to this point, it's
> > slightly better to extend it over the new search too, for a well-defined
> > result consistent with the policy this mbind() is establishing (rather
> > than whatever might follow once the mmap_lock is dropped).
> 
> Would downgrading the lock work?  It would avoid the potential writing
> issue and should still satisfy lockdep.

Downgrading the lock would work, but it would be a pointless complication.

The "second vma_iter search" is not a lengthy operation (normally it just
checks pgoff,start,end of the first VMA and immediately breaks out; in
worst case it just makes that check on each VMA involved: it doesn't get
into splits or merges or pte scans), we already have mmap_lock, yes it's
only needed for read during that scani, but it's not worth playing with.

Whereas migrating an indefinite number of pages, with all the allocating
and unmapping and copying and remapping involved, really is something we
prefer not to hold mmap_lock across.

Hugh
