Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863678BD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjH2DsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjH2DsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:48:14 -0400
Received: from out-247.mta1.migadu.com (out-247.mta1.migadu.com [IPv6:2001:41d0:203:375::f7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78D185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:48:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693280889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=in59HebODKGtW69dO+fJwJBRohG/et2KpWztX/mIYGc=;
        b=TmZ/epwtdjXXctwQH//NyVySMEyAS/9pGHcwueamQoZbOSBnIjm7o7lztJw0lygbbpCnmg
        VGlKUbbCrq4MvHUlRds13QU48TwHrksryd/jP9o1o2D+krl6YAzbO4qiywgmBvGzBB0c3e
        F7inyvPtlSAvheSYN6616nlFcpxt0ak=
Mime-Version: 1.0
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230828164459.GA3290@monkey>
Date:   Tue, 29 Aug 2023 11:47:30 +0800
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Linux-MM <linux-mm@kvack.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A40FA5C3-B119-47BF-9B95-7AF455CA1884@linux.dev>
References: <20230825190436.55045-11-mike.kravetz@oracle.com>
 <202308261325.ipTttZHZ-lkp@intel.com>
 <d0930856-15cb-559c-4205-5d1352b075f7@oracle.com>
 <20230828164459.GA3290@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 29, 2023, at 00:44, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> On 08/28/23 10:42, Joao Martins wrote:
>> On 26/08/2023 06:56, kernel test robot wrote:
>>> Hi Mike,
>>>=20
>>> kernel test robot noticed the following build errors:
>>>=20
>>> [auto build test ERROR on next-20230825]
>>> [cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 =
linus/master v6.5-rc7]
>>> [If your patch is applied to the wrong git tree, kindly drop us a =
note.
>>> And when submitting patch, we suggest to use '--base' as documented =
in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>=20
>>> url:    =
https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-=
flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
>>> base:   next-20230825
>>> patch link:    =
https://lore.kernel.org/r/20230825190436.55045-11-mike.kravetz%40oracle.co=
m
>>> patch subject: [PATCH 10/12] hugetlb: batch PMD split for bulk =
vmemmap dedup
>>> config: s390-randconfig-001-20230826 =
(https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lk=
p@intel.com/config)
>>> compiler: clang version 17.0.0 =
(https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>>> reproduce: =
(https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lk=
p@intel.com/reproduce)
>>>=20
>>> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202308261325.ipTttZHZ-lkp@intel.com/=

>>>=20
>>> All error/warnings (new ones prefixed by >>):
>>>=20
>>=20
>> [...]
>>=20
>>>>> mm/hugetlb_vmemmap.c:698:28: error: use of undeclared identifier =
'TLB_FLUSH_ALL'
>>>     698 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
>>>         |                                   ^
>>>   2 warnings and 1 error generated.
>>>=20
>>>=20
>>=20
>> TLB_FLUSH_ALL is x86 only so what I wrote above is wrong in what =
should be
>> architecture independent. The way I should have written the global =
TLB flush is
>> to use flush_tlb_all(), which is what is implemented by the arch.
>>=20
>> The alternative is to compose a start/end tuple in the top-level =
optimize-folios
>> function as we iterate over folios to remap, and flush via
>> flush_tlb_kernel_range(). But this would likely only be relevant on =
x86 only,
>> that is to optimize the flushing of 3 contiguous 2M hugetlb pages =
(~24 vmemmap
>> pages) as that's where the TLB flush ceiling is put (31 pages) for =
per-page VA
>> flush, before falling back to a global TLB flush. Weren't sure of the =
added
>> complexity for dubious benefit thus kept it in global TLB flush.
>=20
> Thanks Joao.
>=20
> I added my share of build issues to this RFC as can be seen in the bot
> responses to other patches.
>=20
> My assumption is that these build issues will not prevent people from
> looking into and commenting on the bigger performance issue that was =
the
> reason for this series.  The build issues would of course be resolved =
if
> there is some concensus that this is the way to move forward to =
address
> this issue.  If the build issues are a stumbling block for anyone to
> look at this bigger issue, let me know and I will fix them all ASAP.

No need to update. But I need some time to look.

Muchun,
Thanks.

