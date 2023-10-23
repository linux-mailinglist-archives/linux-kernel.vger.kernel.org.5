Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E687D3FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjJWTGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:06:00 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FABB94
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:05:57 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581b6b93bd1so2184983eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698087956; x=1698692756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJT4jfY3CvkrAsPNDoMHVpWpbleU6NBvUL9f6Zwuc+E=;
        b=HbpFXpmnwTrFEEXGKmuN5wdo6IYeCvhSdQrFB1yPszSpJC6xC9ADU1toxTvjlCe61L
         0djEWOAxtrtsgrfnI7I4Fkld1Ibdaq5bhLD08WwFhSLYoppMKo6Q4Yy/TJr+iArQhley
         RlU4wGAfiw96oqWN6UT3HPHirtz9/XSElfLRPWhV0x0Fd0Tl99k4GKWJHjA+VugdnUDV
         D3Rh28VzrTUxBeBVTS4n6pWJYhJU4mDko4fsEhnuYzlJ1XhYs3W6iURyJZCXKyAmZYEL
         8MimEPUlkNtrg+2JOva3WHZ8Ko0lveKMTp/eye+yX6uum62cYxoLiLFsxgIbYc85/dHu
         MCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087956; x=1698692756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJT4jfY3CvkrAsPNDoMHVpWpbleU6NBvUL9f6Zwuc+E=;
        b=texmW2aFODGJgo6lHityDiwE3kIg6LfwlPiJM3mnsGEGyMIym4750G332OJJ3CmSRB
         HT8h+Y9c7K1Z7fX83k5nVMxY1jMsz/dKc2GwE9lvjDq51ejXgvJ6tEui/OokLYS454K3
         wXKLLUArz42J9CqUsoN7Oa42MlKxCcMDiLVy4abtb5j8fj44pi9FIU29tqcq3Md/A9kx
         cMFhElVppxf3P6yMyHfU8nUDeYoR4SVSxq3F6VNxSWq+qJp2Unqc4+4OXq0Nt8dH6miq
         ruH5VQo92L+Aee2EFlO/1wJR2dRU9+QYPmAhqtkpQH9C3KNUECdaVN+3z7gpg8ANgJHs
         XSKg==
X-Gm-Message-State: AOJu0YzHVrzvgx8QE62QNy/jy+Fia9B5rYUgksUf0VDcwudKk/zqXhsM
        L96ov+vWi3y2zjeUXJ7s9RFn6A==
X-Google-Smtp-Source: AGHT+IErO3ABVE+c36xRgbzOY401WH0mzlzh5jiHlM3x2w/kFEwmNdKfxp8iD//AwWm+/PfcZ8BwOQ==
X-Received: by 2002:a05:6359:1a44:b0:168:d1ba:e3c8 with SMTP id ru4-20020a0563591a4400b00168d1bae3c8mr6159850rwb.19.1698087956589;
        Mon, 23 Oct 2023 12:05:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:f369])
        by smtp.gmail.com with ESMTPSA id jy12-20020a0562142b4c00b0065823d20381sm3074118qvb.8.2023.10.23.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:05:56 -0700 (PDT)
Date:   Mon, 23 Oct 2023 15:05:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     domenico cerasuolo <mimmocerasuolo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
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
Message-ID: <20231023190555.GA1964810@cmpxchg.org>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <74e34633-6060-f5e3-aee-7040d43f2e93@google.com>
 <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
 <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
 <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org>
 <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:10:32PM +0200, domenico cerasuolo wrote:
> Il giorno lun 23 ott 2023 alle ore 19:53 Andrew Morton
> <akpm@linux-foundation.org> ha scritto:
> >
> > On Mon, 23 Oct 2023 18:53:26 +0200 domenico cerasuolo <mimmocerasuolo@gmail.com> wrote:
> >
> > > > Rebased to mm.git's current mm-stable, to resolve with removal of
> > > > vma_policy() from include/linux/mempolicy.h, and temporary omission
> > > > of Nhat's ZSWAP mods from mm/swap_state.c: no other changes.
> > >
> > > Hi Hugh,
> > >
> > > not sure if it's the rebase, but I don't see an update to
> > > __read_swap_cache_async invocation in zswap.c at line 1078. Shouldn't we pass a
> > > mempolicy there too?
> >
> > No change needed.  zswap_writeback_entry() was passing a NULL for arg
> > `vma' and it's now passing a NULL for arg `mpol'.
> 
> Problem is that alloc_pages_mpol is dereferencing mpol, when I test the zswap
> writeback at 397148729f21edcf700ecb2a01749dbce955d09e it crashes, not sure if
> I'm missing something.

I don't think you are. The NULL vma used to go to get_vma_policy(),
which fell back to

	pol = get_task_policy(current);

Now the NULL pol gets passed to alloc_pages_mpol() directly, which
dereferences it. Oops.

I think Hugh's patch needs zswap to pass get_task_policy(current)
instead of NULL.
