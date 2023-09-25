Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838297AE1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjIYWxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:53:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E4411C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ObkMnogjR7AT/LW1zAxdgV1u7K5H5MNfT3ojmGk6Yp0=; b=t3zEN7V96HofLExgV+tpCTi2ve
        UfkkqdQyE2SpZ00limGpIAdfAGYNqueYc0XVkjGiVFcPAP3ZlMtjQ1xbILOtj0AgKtSyl9gc7MxSD
        h6YLtz06Mxju+HOmboVu4PxIlh+Rl3WlDQsw3X2/P+neK9oENv9N6BcHp01VPpZRv96b1A63tNqqj
        QNZycvHPoizJsIOL/oprx19I5UAivPl8fKwiG2Nd/9JIpYvp0ePXHMkiX1oA9SeiDLDSEUb1mmy5n
        gRQrzPwh+KZtQMcLeQRY1THaYViadVu8S3QUy2HubWxQ1Wuu8mz8ahlxi+7k2oVSlPXmC2FRM/Gl+
        GrKoMkZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkuRR-0048aP-JD; Mon, 25 Sep 2023 22:52:37 +0000
Date:   Mon, 25 Sep 2023 23:52:37 +0100
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
Subject: Re: [PATCH 08/12] mempolicy: remove confusing MPOL_MF_LAZY dead code
Message-ID: <ZRIPNSRSDH2PfG74@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <2cb8b08a-a96c-2a61-94dd-4cd51ad0605d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb8b08a-a96c-2a61-94dd-4cd51ad0605d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:30:51AM -0700, Hugh Dickins wrote:
> v3.8 commit b24f53a0bea3 ("mm: mempolicy: Add MPOL_MF_LAZY") introduced
> MPOL_MF_LAZY, and included it in the MPOL_MF_VALID flags; but a720094ded8
> ("mm: mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
> immediately removed it from MPOL_MF_VALID flags, pending further review.
> "This will need to be revisited", but it has not been reinstated.
> 
> The present state is confusing: there is dead code in mm/mempolicy.c to
> handle MPOL_MF_LAZY cases which can never occur.  Remove that: it can be
> resurrected later if necessary.  But keep the definition of MPOL_MF_LAZY,
> which must remain in the UAPI, even though it always fails with EINVAL.
> 
> https://lore.kernel.org/linux-mm/1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com/
> links to a previous request to remove MPOL_MF_LAZY.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
