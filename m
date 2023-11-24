Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D17F83CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345971AbjKXTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbjKXTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:20:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FE2D70
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:21:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B112BC433C8;
        Fri, 24 Nov 2023 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700853660;
        bh=nQVW2dMy9yA8GkygUW3RYmgYGtlSCcH2tlyJG94T0vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFOanidtMr9Mclmk1xNHvjSbwLvUxMF3K5iuXJnSUpHnEW20JOv4kv9f83H3MDLIr
         1SNwStuejzoeq0JmX+Gx7lEEsaMNiv72t2LW8VVbCExfPIcQ5HQkhj1+6kZw+NuxrS
         yTZDDaNyH1MdqBsizgPxrMDi31upEH5xZwDxHxbk=
Date:   Fri, 24 Nov 2023 11:20:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/gup: Fix follow_devmap_p[mu]d() on page==NULL
 handling
Message-Id: <20231124112059.3519d6fdfe71f846f8bf726f@linux-foundation.org>
In-Reply-To: <20231123180222.1048297-1-peterx@redhat.com>
References: <20231123180222.1048297-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:02:22 -0500 Peter Xu <peterx@redhat.com> wrote:

> This is a bug found not by any report but only by code observations.
> 
> When GUP sees a devpmd/devpud and if page==NULL is returned, it means a
> fault is probably required.  Here falling through when page==NULL can cause
> unexpected behavior.
> 

Well this is worrisome.  We aren't able to construct a test case to
demonstrate this bug?  Why is that?  Is it perhaps just dead code?
