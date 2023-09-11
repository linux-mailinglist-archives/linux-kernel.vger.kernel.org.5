Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84E79C02B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbjIKV1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjIKPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:35:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2DE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694446498; x=1725982498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zm/fyZaPMSdCXnW917uk4EPzTwyVK6jhAhdlA1UwJq8=;
  b=m2H/Eeznnfx1rLQRW6KsCuEvWg40bxUEOPsfdxzqh3cYgRzHvDMrGviv
   2l0bryGDPvwO5X7VdE/aV3+jp8wj9EIj3/Xnr+sJT0bWItcd9tBc4SHeE
   e4enrSZzQOVU40HU1SEMEgvGQWWH2GiLdLMZlZZEADhrILULe9JQzj5O+
   LEnBMN7v8M2IWivXeOYoEqvj0iAhxojdfDAzJaEhVYy+7p/mO9mAXFx3H
   6wTKL5ll81D80EhzKxhoqw2b8h4uaf9xRjT5EvujFky2eVVrgINDBkJiU
   y/Tij90IJPAdzuA/9JtNZr0g+d7nxyy5D0FFMZVdOT/oUogS4UuIAUT76
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358408569"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358408569"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990119092"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990119092"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:34:57 -0700
Message-ID: <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
Date:   Mon, 11 Sep 2023 08:34:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>
Cc:     syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZP8VcUIXTjvR3z54@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 06:26, Matthew Wilcox wrote:
> @@ -231,7 +235,10 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> -		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +		if (__pte_needs_invert(pte_val(pte)))
> +			pte = __pte(pte_val(pte) - (1UL << PFN_PTE_SHIFT));
> +		else
> +			pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
>  	}
>  	arch_leave_lazy_mmu_mode();
>  }

This is much better than a whole x86 fork of set_ptes().  But it's still
a bit wonky because it exposes the PTE inversion logic to generic code.

Could we do something like this instead?  It'll (probably) end up
repeating the PTE inversion logic each way though the loop, so it's less
efficient than what you have above.  But unless I buggered something, it
"just works" without exposing any of the inversion logic to generic code.

The trick is that pte_pfn() undoes the inversion and then pfn_pte()
re-does it on each trip through the loop.

static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
                pte_t *ptep, pte_t pte, unsigned int nr)
{
	pgprot_t prot = pte_pgprot(x);
	unsigned long pfn = pte_pfn(pte);

        page_table_check_ptes_set(mm, ptep, pte, nr);

        arch_enter_lazy_mmu_mode();
        for (;;) {
                set_pte(ptep, pte);
                if (--nr == 0)
                        break;
                ptep++;
		pfn++;
                pte = pfn_pte(pfn, pgprot);
        }
        arch_leave_lazy_mmu_mode();
}

Obviously completely untested. :)
