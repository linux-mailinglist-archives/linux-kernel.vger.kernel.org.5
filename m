Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCA7B3BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjI2V1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2V1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:27:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92D1B0;
        Fri, 29 Sep 2023 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696022864; x=1727558864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FLVd/ohpJACj32KeVgVSBeUww7ddTyoGFDmzYTsHN9o=;
  b=aaRC5oWhjTqFFABNQGpeWIPUEe/LvrmznLuRVIwkAIfggzGUr2JSlVF0
   qkBCtUpUd1Tk0UWLv6+SZm+z33OytQ7uBFGdKGAOR92TIZx26q7bunxI/
   Q3qVdR5CYE0ZApKwo/J9lsaIL5Xud3gwDaFpNT9QXb1NkhGZG/u5VNNNZ
   okb5YzuFFDJYh4/kclki0jUvv3neVDvzf0uzaumInmO3zj3A4bsQlylpJ
   o+qWVgzNtgp4/9Z47ZgHoHaxLaaVTR24VgzjnRuYuwRB+aOHO6ps34vl2
   fDqhShNOjc0pRxfaW77fUvMIXR/x9BG/x6sICvl+8FKuMA55Th4bIpAo6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386250138"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386250138"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 14:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="815719573"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="815719573"
Received: from alitchfi-mobl1.amr.corp.intel.com (HELO [10.209.69.33]) ([10.209.69.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 14:27:40 -0700
Message-ID: <51164807-4860-b1cc-e3de-4230795808df@intel.com>
Date:   Fri, 29 Sep 2023 14:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 11:33, Kees Cook wrote:
> On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
>> `strncpy` is deprecated and we should prefer more robust string apis.
>>
>> In this case, `message.str` is not expected to be NUL-terminated as it
>> is simply a buffer of characters residing in a union which allows for
>> named fields representing 8 bytes each. There is only one caller of
>> `tdx_panic()` and they use a 59-length string for `msg`:
>> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
>>
>> [...]
> This appears to be trivially correct, so I can take it via my tree.

Sorry about that, I was being clear as mud as to what I wanted to see
here.  I was hoping for another more clear changelog at least.

The changelog makes it sound like there's a problem with not
NULL-terminating 'message.str' when there isn't.  That makes it hard to
tell what the patch's goals are.

As far as I can tell, the code is 100% correct with either the existing
strncpy() or strtomem_pad(), even with a >64-byte string.  This _is_
unusual because the hypervisor is nice and doesn't require NULL termination.

Would there be anything wrong with a changelog like this?

	strncpy() works perfectly here in all cases.  However, it _is_
	deprecated and unsafe in other cases and there is an effort to
	purge it from the code base to avoid problems elsewhere.

	Replace strncpy() with an equivalent (in this case)
	strtomem_pad() which is not deprecated.

In other words, this fixes no bug.  But we should do it anyway.
