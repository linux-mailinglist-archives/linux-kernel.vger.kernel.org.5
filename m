Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB77946C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbjIFXBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjIFXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:01:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFC019B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694041277; x=1725577277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=awpKATS8jUdcDj7eQHRvrOutVUUwskNG8zGevD2cdnE=;
  b=d9oUVRCDnv7iV3cDPVhldrvUYyKH/l7d3JaWRmzyh0gqBuGQL51+TwIQ
   PTbecqiIaByiAHA4FOG8WaDnDT1Whow3c6PFjwMTFu3BBxHojc98TxvuL
   EgfLZvtzZqGvHrbgHZOcBDb0I5WS5WqvyjAMPtoEGv2YZs6E2sxsLyF+S
   N71Vhm66++PSLjmtguOzkPBh0ohVCMLknQtDCUpePuaWQ0T0NBs8SetGq
   iskunEh7SAbWFikpca2+R33aE4gRJPYalw6iXrWZuUeLpFrjoT9oCx4Ne
   cMRtAEN9gfe3kf42Ywi8kw5l9M9YsWmu8Hnrw47GvDh3fiz+1FDlDZqrU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367427703"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="367427703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915463005"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="915463005"
Received: from lmgabald-mobl2.amr.corp.intel.com (HELO [10.212.242.149]) ([10.212.242.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:01:16 -0700
Message-ID: <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
Date:   Wed, 6 Sep 2023 16:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Content-Language: en-US
To:     Adam Dunlap <acdunlap@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
References: <20230906224541.2778523-1-acdunlap@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230906224541.2778523-1-acdunlap@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 15:45, Adam Dunlap wrote:
>  static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
> -				unsigned char *buffer)
> +				unsigned char *buffer, bool is_early)
>  {
> -	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
> +	if (is_early) {
> +		memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
> +		return 0;
> +	} else {
> +		return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip,
> +			MAX_INSN_SIZE);
> +	}
>  }

This isn't the normal way we do these kinds of things.

If we go with this solution, they next guy who tries
copy_from_kernel_nofault() will hit the same issue, and start plumbing
their own 'is_early' through _their_ little chunk of arch/x86.

Usually, we'll add some gunk in arch/x86/boot/compressed/misc.h to
override the troublesome implementation.  In this case, it would make a
lot of sense to somehow avoid touching boot_cpu_data.x86_virt_bits in
the first place.
