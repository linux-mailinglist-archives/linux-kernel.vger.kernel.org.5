Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53597BEFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379168AbjJJAVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbjJJAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:21:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128D8A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:21:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9ABC433C7;
        Tue, 10 Oct 2023 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696897264;
        bh=M2oTNjw+9oq9sArieyw8dMMJbRTMAqtdZlPZHyT7WZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uQroNQB6k9niizpuC63Fv9XYLdlrpW9Bngk5KLAi5UgTJ0dWDAlqM1+rDzHRmGwqd
         lLJ3q8SiOEEdslQ7bN/Q4s/CPzA7AyOORjiP90Km+SwxICg3mRocb8bvgCiY+4DJfw
         Mc5plxr0GwlubQrxCTRJ0fTbVOWmk3liNJnBW7i0=
Date:   Mon, 9 Oct 2023 17:20:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 4/9] mm: thp: Introduce anon_orders and
 anon_always_mask sysfs files
Message-Id: <20231009172029.e558c08dd90d9b94fec3a036@linux-foundation.org>
In-Reply-To: <87fs2mrqld.fsf@mail.lhotse>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
        <20230929114421.3761121-5-ryan.roberts@arm.com>
        <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
        <87fs2mrqld.fsf@mail.lhotse>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Oct 2023 09:54:22 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> > I don't know why powerpc's PTE_INDEX_SIZE is variable.
> 
> To allow a single vmlinux to boot using either the Hashed Page Table
> MMU, or Radix Tree MMU, which have different page table geometry.
> 
> That's a pretty crucial feature for distros, so that they can build a
> single kernel to boot on Power8/9/10.

Dumb question: why can't distros ship two kernels and have the boot
loader (or something else) pick the appropriate one?
