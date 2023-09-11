Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E879BBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbjIKWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbjIKSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:51:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEFCC4;
        Mon, 11 Sep 2023 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694458266; x=1725994266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MrJyaTDd2hAlFLBeIlMXNYKXT1O3LLXpwKb2zoKLzg0=;
  b=EsxrjiQIe/aCOwPo4F40FiWSQIPaie7ZeLYBjiF/dCh17qLWk2Yun743
   tHyAaHkEIdFNIr8mmZn6kqyWGgMFpzmxySS1KZZFroHbBKGZOk+Fq69ix
   mpsbCuYsYiCqK61W5/WQA58ww4I8UTW/uoy5aJM2VuRVftVXUnWJ8IdYm
   oaTQal0ntm/9XUICnh82kTFhUpHzf7vO1tegOoV6boYdUIlt4KZ5fZTPz
   DoVk+9QPQn0Wpd5LE7C3fTg0yHXYNn4g/ybx0EChtdfxMFoi8+CuENHvH
   TxIzaJeQ7/dII7RLiKSBvlMW53a9z50zNeHu0XsdgICnQCa7bCd+fh2+e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464537765"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="464537765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990220512"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990220512"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:51:04 -0700
Message-ID: <69643667-4564-0266-1b26-13833191842c@intel.com>
Date:   Mon, 11 Sep 2023 11:51:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 11:27, Justin Stitt wrote:
> `strncpy` is deprecated and we should prefer more robust string apis.

I dunno.  It actually seems like a pretty good fit here.

> In this case, `message.str` is not expected to be NUL-terminated as it
> is simply a buffer of characters residing in a union which allows for
> named fields representing 8 bytes each. There is only one caller of
> `tdx_panic()` and they use a 59-length string for `msg`:
> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";

I'm not really following this logic.

We need to do the following:

1. Make sure not to over write past the end of 'message'
2. Make sure not to over read past the end of 'msg'
3. Make sure not to leak stack data into the hypercall registers
   in the case of short strings.

strncpy() does #1, #2 and #3 just fine.

The resulting string does *NOT* need to be NULL-terminated.  See the
comment:

    /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */

Are there cases where strncpy() doesn't NULL-terminate the string other
than when the buffer is full?

I actually didn't realize that strncpy() pads its output up to the full
size.  I wonder if Kirill used it intentionally or whether he got lucky
here. :)
