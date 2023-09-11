Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B685979B26F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbjIKVeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbjIKRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:05:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BFE127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694451922; x=1725987922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XT1Fhj5zVr7oJ3ZdkTPkoK9hJinc8oa7HuWQwhYkPSk=;
  b=KpvhJVXO1cTqGsHvYxkKl3w0onJyRoHL6TDmNUSPZAhhC+tmTpDZ756e
   G4BSdTLi1e101K5iBmF+4tcBKBJIKaEqSXT9Ls60hKsqi/Um5O+p6Fnft
   cjmLPHgJUJSKlQ1G13NmgjNVka0Jgumh9FU8f2B9mdlXKOKbQwoVU2MZM
   JYjH70pBfwuGUgFXIkvm8MAZ/9MbGYNj0XRai/NPgxysju7d7KrWHgiYX
   N6nBp18bpv7WwhYQOlrVFk+BEmOuBOKwkoQcVC3dUM8ZFEMoM3SviSbzK
   8ukkgXT5a8KhVNJdDUIkI33wBKo0AuGWzNlZrjpRYgMchdRys4O+xP6Ej
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363181912"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363181912"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813463264"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813463264"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:55:38 -0700
Message-ID: <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
Date:   Mon, 11 Sep 2023 09:55:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZP9D0q5MSVFobNbZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 09:44, Matthew Wilcox wrote:
>> static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>>                 pte_t *ptep, pte_t pte, unsigned int nr)
>> {
>> 	pgprot_t prot = pte_pgprot(x);
>> 	unsigned long pfn = pte_pfn(pte);
>>
>>         page_table_check_ptes_set(mm, ptep, pte, nr);
>>
>>         arch_enter_lazy_mmu_mode();
>>         for (;;) {
>>                 set_pte(ptep, pte);
>>                 if (--nr == 0)
>>                         break;
>>                 ptep++;
>> 		pfn++;
>>                 pte = pfn_pte(pfn, pgprot);
>>         }
>>         arch_leave_lazy_mmu_mode();
>> }
>>
>> Obviously completely untested. 😄
> After fixing your two typos, this assembles to 176 bytes more code than
> my version.  Not sure that's great.

Heh, only two? ;)

Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
much.  I'd much rather have that than another window into x86 goofiness
to maintain.

Does that 176 bytes translate into meaningful performance, or is it just
a bunch of register bit twiddling that the CPU will sail through?
