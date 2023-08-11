Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39170779B84
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjHKXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHKXm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:42:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A510F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691797347; x=1723333347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nxfz98YvKO2IhXuDSX4anhW7xumPStYBa5bS/VYz+7o=;
  b=VvtU/Z8tEolfLAxBRaTCajnqQEd32tqOX8uEPFOguLCBTSmZfAqaj8WS
   DV6X53OERNEnk3QfwDUdqMEvOJBObjnuNJEUOwUT+2Negs9moFDGb3M/v
   t16JrZJp5/fgiBPg6vUWItUh8oH5U1AyR0U8iYE9x7OoFVvEk/Jc4jdkT
   PEiDYhPQhyvW8/xtRStDfG8o9y84FDEtwFrQUcFTAJqO+m3Y4a6APi9tA
   E9eTK+icMtlY9QIx9dBm3EyISVasSGXWWjHMJYfqR6Cq8ywM+4YpxkFzo
   8kfTpZvRt2pOe8/yBSirupv5v2VPWd26Cwr5mddiF4fOZism7m9hPrJoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="371789572"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="371789572"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 16:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="709691910"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="709691910"
Received: from jgarrett-mobl1.amr.corp.intel.com (HELO [10.252.128.99]) ([10.252.128.99])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 16:42:26 -0700
Message-ID: <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
Date:   Fri, 11 Aug 2023 16:42:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        sohil.mehta@intel.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
 <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 16:27, Jo Van Bulck wrote:
> On 11.08.23 14:36, Jo Van Bulck wrote:>   static enum pti_mode {
>>       PTI_AUTO = 0,
>> +    PTI_FORCE_AUTO,
>>       PTI_FORCE_OFF,
>>       PTI_FORCE_ON
>>   } pti_mode;
> 
> I introduced a new PTI_FORCE_AUTO value here to make pti=auto override
> any mitigations=off parameter. However, I realize now that this may
> inadvertently affect other functions that test for pti_mode == PTI_AUTO
> (eg in pti_kernel_image_global_ok()).
> 
> Having 2 constants PTI_AUTO and PTI_FORCE_AUTO is arguably not very
> neat, so we should better get rid of this. I see several options:
> 
> - not have pti=auto override mitigations=off
> - have a global var to indicate pti= argument was passed
> - set pti_mode = PTI_AUTO in the pti_mode == PTI_FORCE_AUTO if branch
> 
> Not sure which option would best match kernel coding guidelines?

This sound like it's getting a bit out of hand and reaching far beyond
cleaning up some (mostly) harmless warnings.

I bet we have a billion command-line parameters that conflict with each
other.  mitigations=off and pti=auto is probably the least of our
worries.  Nobody in their right mind is going to say, oh, I *only* want
PTI, I don't care about any other mitigations.  That's nuts.

mitigations=off is the big hammer.  If you set that, you're basically
shouting from the rooftops, "moar speed!!"  You don't get security after
that.

pti=auto does *not* need to override mitigations=off.
