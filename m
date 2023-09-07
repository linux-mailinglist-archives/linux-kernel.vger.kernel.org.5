Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9D797DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjIGVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIGVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:14:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4F61BCB;
        Thu,  7 Sep 2023 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694121256; x=1725657256;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K/4R11GA5GpsQdIJCNNlgg03vTNiPvCQPb3usbgQwyc=;
  b=FXQokRyV7m0AJU86COaUcAxZuruas3K+OOXs/HRxPmnNnhuDjy1KEelV
   XUtVD8Jy8lzUxzSaAe2Kmt845mE6scv63g+IVG6YeVtywBDkZKSn2nNvV
   Y8kAHrHuUoPD7I8ZIUsKXP8zaBl3cVJ6fhIt9pO4UuwpxzGOUNGw5sv5O
   +w3E+R1vaz7jHvpCRVtP6yjCrDpsajo7UonfavKtP46zUxK5yKZNTuzWf
   A+GSRJgckRT74Ow1GZIvfZ4IkCrS9G2Lkd2Cw2z2wcAIKPO9l5o3p7XoN
   lXE8MjSMri1cUovIyAQ526BCNPbZAKZNxmGK+28GIkFOK0IPLQ7bCAdr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367741043"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="367741043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807692439"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807692439"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 14:14:14 -0700
Message-ID: <4732ef96-9a47-3513-4494-48e4684d65cd@intel.com>
Date:   Thu, 7 Sep 2023 14:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
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
 <20230811214826.9609-3-decui@microsoft.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230811214826.9609-3-decui@microsoft.com>
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
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with the
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.
> 
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

