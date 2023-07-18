Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA0758656
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGRU4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjGRU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:56:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F75BD;
        Tue, 18 Jul 2023 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689713788; x=1721249788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L2CHxsdqnuMK/0tTAv6QiGDs4KnYWikJEDc+5R9q3y0=;
  b=norCXKuIqDkYtRAyqLibra2b/IiQ8n3fgdGxD5yua8L5UWayNcdmbmIp
   V2EBSFW4eapd4JsB7C8VAiDS0PBy3E/j51/pngLsG6LLPyhWgRxKILwwl
   SCpHuUBpJzpKi8dBP0hIDTenwYEcAc0xvWBL7ThU3LakCwFo+t2QKe5GE
   oIW/MQL6h10hMBpLP32YbDqwpkAi0DNPi5o6D31wOc4nVkhdKxiUpjNfo
   5mC5qpECu2qVJCPQtN6/ZXsnip859IG3UFIfzfqIZ9zWcYhnfGn87rc7U
   VA1/lCwYNU4NTtZP1BbSzOngEBnIaPkdQggNdf1oIw7WNfo22fTQIaIyF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397158587"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="397158587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789203306"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="789203306"
Received: from unknown (HELO [10.209.37.195]) ([10.209.37.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:56:28 -0700
Message-ID: <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
Date:   Tue, 18 Jul 2023 13:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 13:32, Haitao Huang wrote:
...
> Ignore VA pages for now. Say for a system with 10 page EPC, 2 enclaves,
> each needs 5 pages non-SECS so total demand would be 12 pages. The ksgxd
> would only need to swap out 2 pages at the most to get one enclave fully
> loaded with 6 pages, and the other one with 4 pages. There is no chance
> the ksgxd would swap any one of two SECS pages.
> 
> We would need at least one enclave A of 10 pages total to squeeze out
> the other B completely. For that to happen B pretty much has to be
> sleeping all the time so the LRU based reclaiming would hit it but not
> pages of A. So no chance to hit #PF on pages of B still.
> 
> So some minimal pressure is needed to ensure SECS swapped. The higher
> the pressure the higher the chance to hit #PF while SECS is swapped.

What would the second-to-last non-SECS page be?  A thread control page?
VA page?

As long as *that* page can generate a page fault, then you only need two
pages for this scenario to happen:

1. Reclaimer takes encl->lock
2. #PF occurs from another thread, blocks on encl->lock
3. SECS is reclaimed
4. encl->lock released
5. #PF sees reclaimed SECS


