Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF96797DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjIGVNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIGVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:13:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281092;
        Thu,  7 Sep 2023 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694121196; x=1725657196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ATv4nr0jor+ybaNsuU8i5dNae7rgPN3o2fEMEB3/Ofw=;
  b=KTftFbeaO/8+F+aJagAxWPgHGDsaiSE+zazJ7jUfjNyjD70AzSqiJ98W
   jCjiHBwZy5zu/0fKDI3AzvpQy/887Sa4qtGAauRL4FJUT5AjZZjOeQwqN
   B4TGpdmuumRumCfLgOY4zDchqbVNCpVgbwcyXBhKhw0FQHJqlyyFNpB/j
   qBnHBe0LeoL4HddBv4vfK3bBTV+aFEEHW80JtCW7VPoW7+1YZqMoOMShD
   T1vCu2Ox5wovKt4uUua5kS8GN4J4HaiV7uB/e/g01yzx3cakrcgDHp5L+
   lhjbAJn+/EsOy9X3gx8YaS0GcTZ9dSL1mOG4cmo6Vjdnfs1TtQpHjXZqX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367740823"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="367740823"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807692363"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807692363"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:13:13 -0700
Message-ID: <66a888f8-45ec-ee9f-0a33-71460e41e540@intel.com>
Date:   Thu, 7 Sep 2023 14:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tianyu.Lan@microsoft.com, rick.p.edgecombe@intel.com,
        andavis@redhat.com, mheslin@redhat.com, vkuznets@redhat.com,
        xiaoyao.li@intel.com
References: <20230811214826.9609-1-decui@microsoft.com>
 <20230811214826.9609-2-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230811214826.9609-2-decui@microsoft.com>
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

On 8/11/23 14:48, Dexuan Cui wrote:
> TDX guest memory is private by default and the VMM may not access it.
> However, in cases where the guest needs to share data with the VMM,
> the guest and the VMM can coordinate to make memory shared between
> them.
> 
> The guest side of this protocol includes the "MapGPA" hypercall.  This
> call takes a guest physical address range.  The hypercall spec (aka.
> the GHCI) says that the MapGPA call is allowed to return partial
> progress in mapping this range and indicate that fact with a special
> error code.  A guest that sees such partial progress is expected to
> retry the operation for the portion of the address range that was not
> completed.
> 
> Hyper-V does this partial completion dance when set_memory_decrypted()
> is called to "decrypt" swiotlb bounce buffers that can be up to 1GB
> in size.  It is evidently the only VMM that does this, which is why
> nobody noticed this until now.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Is there any reason that this needs to go into the stable trees?  If so,
Fixes: and Cc:stable@ tags would be nice.
