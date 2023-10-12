Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780E7C6BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbjJLLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLLHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:07:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4890
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697108852;
        bh=6OsxE8kV2xPTFulSGmBi28q09UFtUYgFyf1Emr7m/7A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VDx3tQ87D/n3Su76DDY5c5gznJtSvPRang3Mx9bCeIPCjwjUPr9G0mCFm0PxhngwL
         ZCuZ5Od7n3VtI386qVODEFFFPcwMufDJEpQaKTGSouVZhqzc0ZLQRHKkVnfw5ltSqA
         comqa8d0qr4bMVfi4uo1E42BuYfqs1+wmBJ4XF0NXNiK46ZMmcgO7AFEzh3MWjC+fS
         W013YuBkEp1d2MuCeoNIdH1GJ+42bNX13Ni/DI1DZinNx0moSCelY02xmTwLTCnh9C
         rrDEUR/yJEgCktS2SOt3WRXHgxqdqq1fhNOz3UHeeWsETZLNZ3kqOkyGP3wpYr6AcN
         FXBlsp5E6oekQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5n0g1rM6z4xMC;
        Thu, 12 Oct 2023 22:07:31 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
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
In-Reply-To: <20231009172029.e558c08dd90d9b94fec3a036@linux-foundation.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-5-ryan.roberts@arm.com>
 <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
 <87fs2mrqld.fsf@mail.lhotse>
 <20231009172029.e558c08dd90d9b94fec3a036@linux-foundation.org>
Date:   Thu, 12 Oct 2023 22:07:26 +1100
Message-ID: <87o7h4qett.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Sun, 08 Oct 2023 09:54:22 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> > I don't know why powerpc's PTE_INDEX_SIZE is variable.
>> 
>> To allow a single vmlinux to boot using either the Hashed Page Table
>> MMU, or Radix Tree MMU, which have different page table geometry.
>> 
>> That's a pretty crucial feature for distros, so that they can build a
>> single kernel to boot on Power8/9/10.
>
> Dumb question: why can't distros ship two kernels and have the boot
> loader (or something else) pick the appropriate one?

I'm not a grub expert, but AFAIK it doesn't support loading a different
kernel based on CPU/firwmare features. I'm quite sure it can't do that
on powerpc at least.

We also have another bootloader (petitboot) that is still supported by
some distros, and can't do that.

The other problem is like David says, distros are generally reluctant to
add new kernel configurations unless they absolutely have to. It adds
more work for them, more things to track, and can confuse users leading
to spurious bug reports.

cheers
