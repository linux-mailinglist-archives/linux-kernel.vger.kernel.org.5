Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB497AAAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjIVHrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIVHrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:47:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A6CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67+5P8IA4r3ycxzRXf9uS+CTU1WKObU4FRulN1vPJqY=; b=cxr2t9ScchXsLUU+e23rbVT7xR
        waa3pq1G0/U4lpu/hr8mLFb0NK8610MBJ9/aNrfANM6JOzPGUww5F/J0MlLFPTcHiAxnjggB2ACGf
        jcjBEU5J9pdpaQ4n5IavkDn7lB5M1Otr+oKn2MSDRAQ2UpaElZpwRxLC/+s7uNBlCaZw+cSGnSCgn
        ZHNRvW+Eik4mgACbxn8iSwOoAc8mromv2wPhREoGW7JH5bfOtWu6jJWbfFjdRf9fi/fOg81nPl/5W
        /9ugviXGfIKw1uulzx9num4yJu4nrYXHTrYk1xerZVYQnd2GbG+apqj16/1OnakmcMYmcOHC/ia4n
        HI0pI04A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjasd-00H0QI-U7; Fri, 22 Sep 2023 07:47:15 +0000
Date:   Fri, 22 Sep 2023 08:47:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, david@redhat.com,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/4] mm: pass set_count and set_reserved to
 __init_single_page
Message-ID: <ZQ1Gg533lODfqvWd@casper.infradead.org>
References: <20230922070923.355656-1-yajun.deng@linux.dev>
 <20230922070923.355656-2-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922070923.355656-2-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:09:20PM +0800, Yajun Deng wrote:
> -		__init_single_page(page, pfn, zone, nid);
> +		__init_single_page(page, pfn, zone, nid, true, false);

So Linus has just had a big rant about not doing bool flags to
functions.  And in particular _multiple_ bool flags to functions.

ie this should be:

#define INIT_PAGE_COUNT		(1 << 0)
#define INIT_PAGE_RESERVED	(1 << 1)

		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);

or something similar.

I have no judgement on the merits of this patch so far.  Do you have
performance numbers for each of these patches?  Some of them seem quite
unlikely to actually help, at least on a machine which is constrained
by cacheline fetches.
