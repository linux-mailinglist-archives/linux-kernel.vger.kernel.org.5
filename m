Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416FA7B7576
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbjJCXq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjJCXqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:46:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66B90;
        Tue,  3 Oct 2023 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696376811; x=1727912811;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6GK598Ys0x4CTUm7I5dEo18AfNIpeD89Epow/8DL42A=;
  b=R2PA3oY7OwnanvkMpxVWb7R+s9oTJs1x/XJseO85e0Qm8/pLpBdxn61H
   GZGF1z0k0wpYKjQS5KjJZbgCRDO6oMQFht1uPD7dOM5uC4O3nxUFDjtuZ
   BKXeTEVYY8YMwvbTeyFTyd9MdmOxf7lNwuEG9i7k7NWdxshL0ELzgJLCr
   BSeoo7j9z48L8Px7suiEGPXEDsD0ANWmA4RFhxpmE3dHVn+hHkj8Vo2OR
   WNG0q8wShXY/6nruGJ6QlavDTYOxGxAdUnJM9gxne9GolCrBiffgsEkWP
   ct21aVQH46jHPB/J3alen62Riy84ExMR7nBjgaKTlRbgDyziWDRXjv/jS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363275671"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363275671"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821440501"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="821440501"
Received: from ddiaz-mobl4.amr.corp.intel.com (HELO [10.209.57.36]) ([10.209.57.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:46:50 -0700
Message-ID: <7f8479be-e4fd-07a8-2a3f-d85740d14f86@intel.com>
Date:   Tue, 3 Oct 2023 16:46:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 14:54, Justin Stitt wrote:
> Note: Ingo Molnar has some concerns about the comment being out of sync
> [1] but I believe the comment still has a place as we can still
> theoretically copy 64 bytes into our destination buffer without a
> NUL-byte. The extra information about the 65th byte being NUL may serve
> helpful to future travelers of this code. What do we think? I can drop
> the comment in a v3 if needed.

The comment looks fine to me as you've left it.  It _might_ be better to
say something like:

	Empty space in 'message.str' needs to be overwritten
	but does not need to be NULL-terminated.

But I wouldn't bother messing with it any more.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

I'll stick this into the tdx branch tomorrow unless someone has stronger
feelings about it.
