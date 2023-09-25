Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADA7AE1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIYWis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIYWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:38:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0727126
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0fDLKihRWQLrfuSj3jvyM87kiZ324I5dyke0dlSl6/U=; b=gVOU3bZEWFPlb/ZscqM+AjKdYV
        bCmLwRJ+59OVEzBJriTe2B7GbFwbQ6vEVu9iPU7z0GJ2T6cQ8ENFzjfR9YCl4aUUD7fr/my2J2C+n
        zSj36KmLk3alHQJqWSesv90jvAZgD+6Alq+PVVVYsmRVHvrf9SgLPjw+Hqgm6i26FW7Hzi+QP/1wW
        tbjtLgdagf77505qd5gO0L9Rja0Zm1fFfiC1274yQhTS6PpBAO6fsZreRVAnJqBKaOANLNqBPHDbc
        4StzGMWtGZwnKGvWLytSfTmNf0h141i7DtUYN5cL/52Q9Mt1DIPxyCtAaqWL7LosUXNyXLTwTIHE2
        yKDoHDaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkuDZ-0043Wy-Lo; Mon, 25 Sep 2023 22:38:18 +0000
Date:   Mon, 25 Sep 2023 23:38:17 +0100
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
Message-ID: <ZRIL2XaGQl1nQJVq@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <d09b9c35-2856-f749-6a13-64dfe6415ef1@google.com>
 <ZRIKTFaPOmD8RFDQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRIKTFaPOmD8RFDQ@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:31:40PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 01:28:14AM -0700, Hugh Dickins wrote:
> > Prefer the more explicit "pgoff_t" to "unsigned long" when dealing with
> > a shared mempolicy tree.  Delete confusing comment about pseudo mm vmas.
> 
> Yes, with three quibbles

Actually, a fourth has occurred to me

> >  struct sp_node {
> >  	struct rb_node nd;
> > -	unsigned long start, end;
> > +	pgoff_t start, end;
> >  	struct mempolicy *policy;
> >  };

This data structure is unused outside mempolicy.c today, and you don't
add any.  Perhaps we could move it from mempolicy.h to mempolicy.c?
