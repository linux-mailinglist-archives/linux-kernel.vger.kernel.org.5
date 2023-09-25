Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5847AE1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjIYWcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYWcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:32:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D389C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FuX7ZhPNdsEfp0dIlYaP4PSQgtbMhjdLDod/EvVvJts=; b=FQG3po5l7sdfeoZyvP9SU45Ivx
        lcCEwkGaJpPAuy6e3Vhm5avyqWlcGtyC27leG1CA07UKWBak/ae6WfO2n8rF272f2qX4f9geeOIuc
        Xxs/vMs83cLU9VH1gyYgDrf1XYxGw7KO56csB1Az9aGd70jN6eLQS3C7870eUGVbm2/0GHPQ1yYqA
        5fxLY12M7tcAfrjglmCZfL4QJqTy4yaf8UUNu/sOINfpLZrH8CfLO45Fa5XfQSiWZdRKdCloouAG9
        vfyciH1DqP/ae5n0rGVPF3Gu3bb1yx8XLeRmU7gmJj/qB4cMgZQwi2cafwYl9eKJYXdkJ779VY1LF
        FKaj+dmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qku7A-0043Gc-Pl; Mon, 25 Sep 2023 22:31:41 +0000
Date:   Mon, 25 Sep 2023 23:31:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZRIKTFaPOmD8RFDQ@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <d09b9c35-2856-f749-6a13-64dfe6415ef1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09b9c35-2856-f749-6a13-64dfe6415ef1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:28:14AM -0700, Hugh Dickins wrote:
> Prefer the more explicit "pgoff_t" to "unsigned long" when dealing with
> a shared mempolicy tree.  Delete confusing comment about pseudo mm vmas.

Yes, with three quibbles

>  struct sp_node {
>  	struct rb_node nd;
> -	unsigned long start, end;
> +	pgoff_t start, end;
>  	struct mempolicy *policy;
>  };
> -
>  struct shared_policy {

Did you intend to delete the blank line between these two structs?
That's not our normal style.

> +++ b/mm/mempolicy.c
> @@ -2444,7 +2444,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>   * reading or for writing
>   */
>  static struct sp_node *
> -sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
> +sp_lookup(struct shared_policy *sp, pgoff_t start, pgoff_t end)

While you're reformatting anyway, mind joining these two lines?

> @@ -2499,7 +2499,7 @@ static void sp_insert(struct shared_policy *sp, struct sp_node *new)
>  
>  /* Find shared policy intersecting idx */
>  struct mempolicy *
> -mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
> +mpol_shared_policy_lookup(struct shared_policy *sp, pgoff_t idx)

Ditto

