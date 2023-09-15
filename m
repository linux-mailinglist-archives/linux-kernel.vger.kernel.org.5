Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BCE7A1EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbjIOM1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjIOM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:27:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87989D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:26:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401f68602a8so22457505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694780813; x=1695385613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFkbQV8kHqHZYhFs0q2QsxQc1W5gCML7Z01N1NeyXyU=;
        b=ZNQMfGSqnLwwjOu0ALmjqM8nkkVHBiIButjc9t9ba0XQwRAZCUubzP+5ZJgMqZ2oy6
         3xA2G8pDdAc80H+xZsp+7RG3OvbCNvg+hiIIOhytcMQT4LTXH3ZrPLip+1k/RE1up7SB
         S8/qMM1S55ULOBq0NgHIQlfoIfkX1ZahhVwc2iezgA54S1QD22qqfB2xkdgtYHavhrF8
         qB+Jd8vHomsyDOMUStplQ+KUXTZ/nNlo83y8FN0I9DPyr4m0haCsHRWeWF9Qoqz+jOI1
         opR6V3NWHtmPcCNiB1dDb/6zZt6ow96Nh9KfUoWgPn8aLEHWYUlNqqQ6DTa1pRWC/pWd
         2yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780813; x=1695385613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFkbQV8kHqHZYhFs0q2QsxQc1W5gCML7Z01N1NeyXyU=;
        b=GVshMXNVFvEI7kUtbk7jUH76eDPpNo1jZ/bPcNfnWQ5TdTPuFb/RMJecyP4lPDqYtv
         775bxraWLPLboGpHYVXL4gPzXMhs/ASYmC999LbEUyTMKujqmunqiCT7DC4u2/Gp6kR6
         Hi1FOaJzQbIn+yEMQFJOyJ0BL1P/Lq8bRVVS+wa5EQMnre9bzN5r2G1GSJ3PqRDb7ocv
         DGxZUhbkefoWV8ssHcasLbFANU9pxyCh2wzfB1MIocfzXEndPAVDpazfMj/5rMN9cixs
         LY4Ro9EXXIkl4gVNP+XxNFnkQ31bMYMsPR8YwumvhVSTPOGrGKBG3yw9oxSmTMx1ynlv
         a5/Q==
X-Gm-Message-State: AOJu0YwYpKOUCPcqGHwQrZ9Pc88BtY7Wwovd69GV3FGIAf3oW7OdYeat
        TpB+KggDRO38z4KidJCI1rQ=
X-Google-Smtp-Source: AGHT+IGPHuiGvXxuxaazx/atfFzxcS2p5ZicTw4t0r75oFIqXjc9Xy983d1ra+YsIf77RIghUGETag==
X-Received: by 2002:a1c:7419:0:b0:401:bf89:b013 with SMTP id p25-20020a1c7419000000b00401bf89b013mr1301911wmc.19.1694780812749;
        Fri, 15 Sep 2023 05:26:52 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b00401e32b25adsm4562061wmr.4.2023.09.15.05.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:26:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 14:26:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kai Huang <kai.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, jpoimboe@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com
Subject: Re: [PATCH] x86/tdx: Fix __noreturn build warning around
 __tdx_hypercall_failed()
Message-ID: <ZQRNiTVQu23wFC/d@gmail.com>
References: <20230915121208.307807-1-kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915121208.307807-1-kai.huang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kai Huang <kai.huang@intel.com> wrote:

> LKP reported below build warning:
> 
>   vmlinux.o: warning: objtool: __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn annotation
> 
> Turns out the __noreturn must be annotated to the function declaration
> but not the function body.
> 
> Quoted from PeterZ:
> 
> ---
> FWIW, the reason being that...
> 
> The point of noreturn is that the caller should know to stop generating
> code. For that the declaration needs the attribute, because call sites
> typically do not have access to the function definition in C.
> ---
> 
> Fix by moving __noreturn annotation from the __tdx_hypercall_failed()
> body to its declaration, which is in <asm/shared/tdx.h>.
> 
> Note <asm/shared/tdx.h> is also included by TDX related assembly files.
> Include <linux/compiler_attributes.h> only in case of !__ASSEMBLY__
> otherwise compiling assembly file would trigger build error.
> 
> Also, following the objtool documentation, add __tdx_hypercall_failed()
> to "tools/objtool/noreturns.h".
> 
> Fixes: c641cfb5c157 ("x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309140828.9RdmlH2Z-lkp@intel.com/
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c           | 2 +-
>  arch/x86/include/asm/shared/tdx.h | 4 +++-
>  tools/objtool/noreturns.h         | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 3e6dbd2199cf..4710d8dd700b 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -38,7 +38,7 @@
>  #define TDREPORT_SUBTYPE_0	0
>  
>  /* Called from __tdx_hypercall() for unrecoverable failure */
> -noinstr void __noreturn __tdx_hypercall_failed(void)
> +noinstr void __tdx_hypercall_failed(void)
>  {

It's not a bad idea to document the __noreturn nature at the definition 
site either, so I don't think we should remove it.

Thanks,

	Ingo
