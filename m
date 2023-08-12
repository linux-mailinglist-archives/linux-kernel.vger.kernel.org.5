Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B385779BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjHLAJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjHLAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:09:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529B120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691798954; x=1723334954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UKbqCeNoLclM67qKBxmUgblSpoxVGcwYHqrUUd67pgc=;
  b=NDF33phfI+i4vdnEVlKecrdI377Bgm7uMKvwQ9UjRRiJkPZ7/H+eMVQn
   ybJ63kM5uc30n8TctvXbOfG3HdNSadMRvNqLAbix5IRwvWLdp6kOzh8iO
   1n1ZuJtrjykfTCsxMvCUfTno8ruqQZ9PzpYcgjdogfF1lt7JTtOB1KEeI
   2IoSCjmVLOGFZyv2G0IjXhXrW0pG/Gzcjjg9Va4vTzRejDGFFdyz5TGi/
   kF8+fCHeQG1SpDbsh+0aqLkd7UtOuA6INmQsAMjRlLpu5LQPmdKrlmxSr
   FHRJjzJAk+N0KCUQEKq3YyAX4xPBwlcVRrAunaWfQxZXqnFB6QacVgCAi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402765708"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402765708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063459662"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1063459662"
Received: from jgarrett-mobl1.amr.corp.intel.com (HELO [10.252.128.99]) ([10.252.128.99])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:09:01 -0700
Message-ID: <b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com>
Date:   Fri, 11 Aug 2023 17:08:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
 <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
 <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
 <3a4bf401-0781-492f-a952-3c96c1507551@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <3a4bf401-0781-492f-a952-3c96c1507551@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 16:58, Sohil Mehta wrote:
> On 8/11/2023 4:42 PM, Dave Hansen wrote:
>> On 8/11/23 16:27, Jo Van Bulck wrote:
>>> Not sure which option would best match kernel coding guidelines?
>> This sound like it's getting a bit out of hand and reaching far beyond
>> cleaning up some (mostly) harmless warnings.
>>
> I agree this doesn't have to be this complex. PTI_FORCE_AUTO is unnecessary.
> 
>> pti=auto does *not* need to override mitigations=off.
> I think only pti=on needs to override mitigations=off i.e. the User is
> saying turn off mitigations but keep PTI enabled. This should be fairly
> easy to achieve with the current enum. If it is not then it's not worth
> the hassle.

It's worth *ZERO* hassle.  The docs say:

>         mitigations=
...
>                         off
>                                 Disable all optional CPU mitigations.  This
>                                 improves system performance, but it may also
>                                 expose users to several CPU vulnerabilities.
>                                 Equivalent to: 
...
>                                                nopti [X86,PPC]

That's 100% unambiguous.

If you do "mitigations=off pti=auto", you might as well have done
"pti=auto nopti" which is nonsense.

The kernel shouldn't fall over and die, but the user gets to hold the
(undefined) pieces at this point.

Please let's not make this more complicated than it has to be.
