Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F67A8B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjITSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjITSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:11:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F72D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695233500; x=1726769500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UfXDF7vmJ3p4o1hrc4blpL6pXeqqgur0nc4CHtDJYss=;
  b=RtsUjfZuFESeiFKtlXRkcE1ydZcjHh3YmXahpKkfshJfhrNGZEqUJF/W
   UmIWiJJDxh/FnSKn+LYwIDKHNkXQEXGIMiir4j8p3x8N/dbPPPIBzFYq0
   h/Wql9uXXgXSqVfczcpazjRtCVTcg01sMM9RnFZIQRqt9SEMJrRQi74MB
   pyLPV46KA5eWGSnDLf7fJE4Kb8zBNWIv3onCGHPZo+QywiAHc00yEF58A
   7PwlfI3D6Ftb18UvIpRI3fz+3Z/twhownlYDBIMt61jYKcCHJirukx/6F
   VoaCRlEq2ts6X2ImuBv3w5Fu0amqJ6dk4BmAOQfmI7Sx9hf+ArqfHjxKU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365364359"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365364359"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920391403"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="920391403"
Received: from awiese-mobl.amr.corp.intel.com (HELO [10.251.18.38]) ([10.251.18.38])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:11:36 -0700
Message-ID: <d7ce06dc-32c1-b957-9f32-1ba71b80fd75@intel.com>
Date:   Wed, 20 Sep 2023 11:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230920131633.ig6ldmwavpu7uhss@box.shutemov.name>
 <0031e031-10a8-43b1-a29c-8e1cf913eaad@linux.intel.com>
 <20230920175248.6foe67cwfe5oaa7u@box.shutemov.name>
 <f56b6e51-d2b6-49b3-a3e0-a9d9c90019c5@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f56b6e51-d2b6-49b3-a3e0-a9d9c90019c5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 11:08, Kuppuswamy Sathyanarayanan wrote:
> My thinking is to allocate it when we really need it. We only need this memory if the
> GetQuote hypercall is successful. We can also allocate it at the top and there is
> nothing wrong with it, but it will not be used in failure cases. Since top declarations
> are not a requirement, why allocate it early? 

Do folks *REALLY* want this patch set to be a trailblazer where we can
all nitpick the nuances of how we want to deal with this snazzy new
__free() mechanism?

Or, do you want it to be old and boring and do it the way we've done it
forever?

Your choice.
