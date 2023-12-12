Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36580F26E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjLLQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLLQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:27:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD99AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:27:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D207C433C7;
        Tue, 12 Dec 2023 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702398443;
        bh=t3KKiYi0IdU2y9j91oE71YEklgKddavq7ESsXn9uET4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmrX47b7FO9QssAD09a7oHhvNJ1/DSXBvjQ4RvCYchuZ6/sTAh9XBDG970mIzERJp
         TTo902Q+yAcmPS1hPuve25ZZ4rI0Mz6S66LXqWrUYSqaoCxBkx6XcimchzuR06NnkM
         fS3Q/VztSu9++JBc+V14I/GMbW9RQyg439T3PihA=
Date:   Tue, 12 Dec 2023 08:27:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v9 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Message-Id: <20231212082722.13e857daf589bd49d5e877d9@linux-foundation.org>
In-Reply-To: <e424982c-8a2f-4c98-83aa-fdb0ee765776@arm.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
        <20231207161211.2374093-4-ryan.roberts@arm.com>
        <ff7a3e9c-53cb-4283-9298-781d4fb7c7f8@redhat.com>
        <e424982c-8a2f-4c98-83aa-fdb0ee765776@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 15:32:29 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> > Why not perform lock/unlock only once in surrounding code? :)
> 
> I was nervous that sysfs_streq() may be unhappy in atomic context... Unfounded?
> 

Yes, unfounded.
