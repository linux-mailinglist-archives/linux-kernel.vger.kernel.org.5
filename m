Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5933B7589E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGSAGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGSAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:06:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B97B3;
        Tue, 18 Jul 2023 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689725205; x=1721261205;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=cVVByayn/bZnw82uquNHaQDWac1HyKeux0qRQyUY51g=;
  b=C2klXh6Hl5jMNBeSFcJt0hWmhmX/IPVJaM5CiMUZ0bnkOxYEzvtGat57
   Xb5s8FQYhGrpoBTLSjqfyjdGthDu/lPxGyNGEjtdTa+Oa4T4eLpTLsP34
   H/bhJ5pqymTDUibcXdPbR7A9UfUauFawADciV3yOwULaIqS3MYW9HezDq
   7okH/KZ5E7WHd5IZkD/VrtayME2vxOD83AJZNFObi1sW+qqIgg/Ms4G1Q
   yXxTFuj5oT1BhYSGQkNP4cHuQpDxmslCWKMAPxoPPmY2P577hf2b+VKAw
   QUHqhi7NDHD7nylHmoq8zzy86WOdpXOWS11gOogXXE7kzS5lcZex3OM0a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432521633"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432521633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674099508"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="674099508"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 17:06:33 -0700
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
 <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
 <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <891d530f-fa84-aed7-7465-b4722e983e92@intel.com>
Date:   Tue, 18 Jul 2023 19:06:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18ayk61kwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <891d530f-fa84-aed7-7465-b4722e983e92@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 17:05:59 -0500, Dave Hansen <dave.hansen@intel.com> =
 =

wrote:

> On 7/18/23 14:57, Haitao Huang wrote:
>> Okay, that explains. I would consider it still triggered by high
>> pressure blips =F0=9F=98=84
> I'm talking about a "blip" being a single allocation.  It's *LITERALLY=
*
> the smallest (aka. lowest) possible quantum of memory pressure.
>
> So go ahead and try to write the changelog without "high" or "low".
> But, sheesh, if you and are somehow using "high" and "low" to describe=

> the exact same condition, I think that's a rather large communication =
or
> understanding problem somewhere.  It doesn't bode well for this simple=

> patch.

Sorry that did not come across right. I'll send v3 (please skip v2) with=
  =

the comments added as you suggested.

Thanks a lot for your time and the review.
BR
Haitao
