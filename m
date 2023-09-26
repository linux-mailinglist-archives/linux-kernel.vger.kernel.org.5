Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A3F7AF651
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIZWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIZW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:29:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3167A9B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:19:23 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso11301385276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695763162; x=1696367962; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftGtzNCK4oOVyfSI32wzRjgE/k4q/Apr++atuhh5XZo=;
        b=oqbmQ2iW3+prSHhngWmo6ifuNGiTjPh/RvqFT87rTRCjnvHCI89GqhlERxopw3qsrJ
         B0f1tqXZYLDxasu3YPLMfCiNQfvl3XzFoWgjKbQQHzgcxXUm0ivFR0MmYF4zglvJkzjn
         kSGtpJrw8bgUAKXiqdnnuVTU3OSW6A75Wia29cjg8+Lx4f4C4hjIOwmrIHDPv2odusET
         WsxOzJjU9iR9pPcCdpnlO748mIpZlu8DfgXQWocqsVDBshhfqPOuKAvJXNdjiXPhY+fj
         24cELyZjZkGJD3K2nBZqC4jKYAl5jekqwi+249MtiW+DrHKIkDXMjF4syFzQ6JnjgqS8
         WZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763162; x=1696367962;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftGtzNCK4oOVyfSI32wzRjgE/k4q/Apr++atuhh5XZo=;
        b=oZINtEqPltLm7/srLrhxegXVgU5gljzzNxjQq+00UCh/7a/ZK4nEENOORd9s+MiXT3
         I/dxYqeR1yjPMcwqK2T6JjUYF3UTokmt/9Bb/rvCyO7258gZjOL7N9g3SnGa3hKW1wjp
         9kSuFyzSEnYezcysZNl6UQH3W5CQXfD/dc6ij6qvHDhhDaijJfAHD4JPoVTIikQ6Xnd9
         UiYaZVcZocP+p10jsVEBmUFhrImVfM0kwajK91f9ZAYNvTfDeVnhHaOXPO2WT71wiQsl
         pcWsfj4kt38Q2IeJv4ivcU83yAPdRms+TbEsu9f4SS7NN9WK2IBs9D3S1R8lv8IQDCBY
         9eGQ==
X-Gm-Message-State: AOJu0YzYxrISOh3C54H2rVTehGp0GlWRulfQJazeif0b0ysniVEPbeOB
        eBIjgTDFXxu7s2suPXMFiI2o7w==
X-Google-Smtp-Source: AGHT+IHJdY1wmNInDIr3Oy//S0QP1jcTvv9Z3r8Gyxv3cnk9f+nHFsEK/rkIdCxcehiAZPiChY9+BQ==
X-Received: by 2002:a25:ae17:0:b0:d85:22:8215 with SMTP id a23-20020a25ae17000000b00d8500228215mr117012ybj.34.1695763162392;
        Tue, 26 Sep 2023 14:19:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b23-20020a253417000000b00d13b72fae3esm2959326yba.2.2023.09.26.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:19:21 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:19:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
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
Subject: Re: [PATCH 06/12] mempolicy trivia: use pgoff_t in shared mempolicy
 tree
In-Reply-To: <ZRIKTFaPOmD8RFDQ@casper.infradead.org>
Message-ID: <7191425-f87-99c7-58b9-d54169e3fe0@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <d09b9c35-2856-f749-6a13-64dfe6415ef1@google.com> <ZRIKTFaPOmD8RFDQ@casper.infradead.org>
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

On Mon, 25 Sep 2023, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 01:28:14AM -0700, Hugh Dickins wrote:
> > Prefer the more explicit "pgoff_t" to "unsigned long" when dealing with
> > a shared mempolicy tree.  Delete confusing comment about pseudo mm vmas.
> 
> Yes, with three quibbles
> 
> >  struct sp_node {
> >  	struct rb_node nd;
> > -	unsigned long start, end;
> > +	pgoff_t start, end;
> >  	struct mempolicy *policy;
> >  };
> > -
> >  struct shared_policy {
> 
> Did you intend to delete the blank line between these two structs?
> That's not our normal style.

I think I did intend it actually, to join both of those structs to the
"Tree of shared policies" comment above them.  But now that I'm looking
again, I think what I'd most like to do (and going against all of your
suggestions e.g. move sp_node to mempolicy.c: good observation, but isn't
keeping them together more helpful to the reader?) is swap those structs
around - struct shared_policy first for the root of the tree, then
struct sp_node showing the nodes of the tree (and still without blank
line).  Wouldn't that be the most helpful way to present them?

I'll knuckle down and do exactly as you have suggested, if you say so:
but above is my own preference.

> 
> > +++ b/mm/mempolicy.c
> > @@ -2444,7 +2444,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
> >   * reading or for writing
> >   */
> >  static struct sp_node *
> > -sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
> > +sp_lookup(struct shared_policy *sp, pgoff_t start, pgoff_t end)
> 
> While you're reformatting anyway, mind joining these two lines?
> 
> > @@ -2499,7 +2499,7 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
> >  
> >  /* Find shared policy intersecting idx */
> >  struct mempolicy *
> > -mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
> > +mpol_shared_policy_lookup(struct shared_policy *sp, pgoff_t idx)
> 
> Ditto

Sure, will do (I recall Linus much prefers them as you suggest).
But we have different indentation habits: I think it's spaced exactitude
which irritates you the most, would the style below be okay?
Or maybe you'd prefer to go over-80 with these two.

struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
						pgoff_t idx)

Hugh
