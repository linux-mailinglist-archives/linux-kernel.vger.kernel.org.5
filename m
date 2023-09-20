Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D587A8AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjITRxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjITRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:53:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4594
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695232376; x=1726768376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8I2IGkNC/baJK58DapJVr5UzrlSeyECeNh/uWrx8ZqU=;
  b=MoNpV9WX53xwwFIohkixwv4eqg4iMIg5kSjI7g1fbfJfK9zPiXsEQIks
   VR1QoFYIo15je+KEmVXU3ThTNEF3pXo8Cl2+u+sfcdAUje/oIQ75RF2jD
   C8FmhyROylLp+vJ/g81cQstueGRLudc79OQEv+gmKu/hhXMMLpkI9XDsM
   ip0fAD5sxe3fKeKLRVILUCe7/JbHpEehJ+TgF9fDvPjXam7D9yKmsFWiN
   gOtX4fVPX2sG9P8HNItCxeEFN8f4eKtmOAePkIRykH1Wt4ibd/nPko6r/
   LXA05yCQdZGs6DoGl0L1gNtz4FqMwpO8ksJhVTWd4N7jsCGOYdC0kIjuA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359680534"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359680534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:52:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870465270"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870465270"
Received: from zhijingf-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.218.227])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:52:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EDF8A109E26; Wed, 20 Sep 2023 20:52:48 +0300 (+03)
Date:   Wed, 20 Sep 2023 20:52:48 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <20230920175248.6foe67cwfe5oaa7u@box.shutemov.name>
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230920131633.ig6ldmwavpu7uhss@box.shutemov.name>
 <0031e031-10a8-43b1-a29c-8e1cf913eaad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0031e031-10a8-43b1-a29c-8e1cf913eaad@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:27:39AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 9/20/2023 6:16 AM, Kirill A . Shutemov wrote:
> >> +static u8 *tdx_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> >> +{
> >> +	struct tdx_quote_buf *quote_buf = quote_data;
> >> +	int ret;
> >> +	u8 *buf;
> >> +	u64 err;
> >> +
> >> +	if (mutex_lock_interruptible(&quote_lock))
> >> +		return ERR_PTR(-EINTR);
> >> +
> >> +	/*
> >> +	 * If the previous request is timedout or interrupted, and the
> >> +	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
> >> +	 * VMM), don't permit any new request.
> >> +	 */
> >> +	if (quote_buf->status == GET_QUOTE_IN_FLIGHT) {
> >> +		ret = -EBUSY;
> >> +		goto done;
> >> +	}
> >> +
> >> +	if (desc->inblob_len != TDX_REPORTDATA_LEN) {
> >> +		ret = -EINVAL;
> >> +		goto done;
> >> +	}
> >> +
> >> +	/* TDX attestation only supports default format request */
> >> +	if (desc->outblob_format != TSM_FORMAT_DEFAULT) {
> >> +		ret = -EINVAL;
> >> +		goto done;
> >> +	}
> >> +
> >> +	u8 *reportdata __free(kfree) = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
> > __free() is new to me. Good to know.
> > 
> > But are we okay now with declaring variables in the middle of the
> > function? Any reason we can't do at the top?
> 
> Declaring variables at the top is no longer a hard requirement. The main reason
> for declaring it here is to use __free cleanup function. If we use top
> declaration, then we have free it manually.

What's wrong with allocating it it there too?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
