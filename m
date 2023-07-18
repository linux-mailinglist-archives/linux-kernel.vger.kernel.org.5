Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2F758518
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGRSyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGRSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:54:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52411C;
        Tue, 18 Jul 2023 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689706429; x=1721242429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UU2P+3ZsQXzcmH+F69dxcKHPXFKakkdB8q53cPswhJA=;
  b=m2t1mNm+c8vv+noVFrNalW1BAr0JQ1RsOvHFQv8bnPqD3OMfpanrnyAj
   cI/E0C7TXV5I1RTF58IZHhDr9UG2xMUwY9TOjpv7taQx6mHlKE4l1W/gO
   vPx4n9XXab/O4NjAOt21uH9UZknaasw8YMl4kF7auayxfeB8s26Jk0RSt
   7bgqrNaeZ0uXyBzgIrhMKWaldiWAj5shJS6PkV8uY28Zn/9XZLm/V2kFq
   /Bqw4Pyz/gHfikD6fZBOXvq6Wr5fCm9BmUzpl0eIklKR3/i4iApituW8M
   zcnw5hfwSeu+GRfMoGDFAv/h9O29MBijxzbBomXeQRY54cscF//xnaWTg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351156310"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="351156310"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 11:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867201456"
Received: from unknown (HELO [10.209.37.195]) ([10.209.37.195])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 11:53:49 -0700
Message-ID: <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
Date:   Tue, 18 Jul 2023 11:53:47 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 11:11, Haitao Huang wrote:
> On Tue, 18 Jul 2023 09:27:49 -0500, Dave Hansen <dave.hansen@intel.com>
> wrote:
> 
>> On 7/17/23 13:29, Haitao Huang wrote:
>>> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
>>> cgroup worker) may reclaim the SECS EPC page for an enclave and set
>>> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
>>> the SGX #PF handler without checking for NULL and reloading.
>>>
>>> Fix this by checking if SECS is loaded before EAUG and load it if it was
>>> reclaimed.
>>
>> It would be nice to see a _bit_ more theory of the bug in here.
>>
>> What is an SECS page and why is it special in a reclaim context?  Why is
>> this so hard to hit?  What led you to discover this issue now?  What is
>> EAUG?
> 
> Let me know if this clarify things.
> 
> The SECS page holds global states of an enclave, and all reclaimable
> pages tracked by the SGX EPC reclaimer (ksgxd) are considered 'child'
> pages of the SECS page corresponding to that enclave.  The reclaimer
> only reclaims the SECS page when all its children are reclaimed. That
> can happen on system under high EPC pressure where multiple large
> enclaves demanding much more EPC page than physically available. In a
> rare case, the reclaimer may reclaim all EPC pages of an enclave and it
> SECS page, setting encl->secs.epc_page to NULL, right before the #PF
> handler get the chance to handle a #PF for that enclave. In that case,
> if that #PF happens to require kernel to invoke the EAUG instruction to
> add a new EPC page for the enclave, then a NULL pointer results as
> current code does not check if encl->secs.epc_page is NULL before using it.

Better, but that's *REALLY* verbose and really imprecise.  It doesn't
_require_ "high pressure".  It could literally happen at very, very low
pressures over a long period of time.  Please stick to the facts and
it'll actually simplify the description.

	The SECS page holds global enclave metadata.  It can only be
	reclaimed when there are no other enclave pages remaining.  At
	that point, virtually nothing can be done with the enclave until
	the SECS page is paged back in.

	An enclave can not run nor generate page faults without without
	a resident SECS page.  But it is still possible for a #PF for a
	non-SECS page to race with paging out the SECS page.

	Hitting this bug requires triggering that race.

> The bug is easier to reproduce with the EPC cgroup implementation when a
> low EPC limit is set for a group of enclave hosting processes. Without
> the EPC cgroup it's hard to trigger the reclaimer to reclaim all child
> pages of an SECS page. And it'd also require a machine configured with
> large RAM relative to EPC so no OOM killer triggered before this happens.

Isn't this the _normal_ case?  EPC is relatively tiny compared to RAM
normally.
