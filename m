Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323177C3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjHNXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjHNXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:13:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2310F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:13:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc63ef9959so41899295ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692054837; x=1692659637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DU30yTGenjwr8H/p0lpH7CNdRUrwWJdI1Z1Jmc0+2Vk=;
        b=B+UBhYRWcaaB0nF1PSoMyqS4qeWPfUbK+TEQp0Xz+nb9+YJm+OLQIVvXNlTkflG3od
         fhQiyV/iWRViJ30fmfywnpUSqv+ZUu/wHolkiLrlRXgZ1S2+NQk+mpL9Rze5S/Tu/ftF
         lv0kUgKX0VbPef7KtkvaOzisUdSyop7bHweUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692054837; x=1692659637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DU30yTGenjwr8H/p0lpH7CNdRUrwWJdI1Z1Jmc0+2Vk=;
        b=AJ5GHwDGjHHVhMDPo3B/AzEH6EmXAsZhdUlMJIkDLuV2QPCAJLdqKt7R0Jv1/u10Y/
         jg/z25fjQmv8BvJTZp5XKfIjNhkXnLskcueq67OCrT3CYht8UT3jtF/8LRjihqANTdEU
         /9uW/f00gwMWvtt6W7EWFpcAiW6tN7N7SdlYlxiLr/tviWZ69JGstoKZ4XXfn+7GmcGY
         BdSQAfmA+M1PmDyYFDZRNYvhqBlEjEvSPllnxK0f49f/btuW/VjKdTe4DGDBIbml6jUC
         3iaToVv5ixxqAj2WMrkuBfjkjgyTwiYX3WrABAv2jWIK8wG+PsQeIVe8hz10RKTa274V
         GOSw==
X-Gm-Message-State: AOJu0YxWCyfpoutBtd/p1NxOJnHINyB4qUihkTUz7fwQPc/m5egq2HST
        sA0B+Uxslg4PwMWxvSXmXpwtXA==
X-Google-Smtp-Source: AGHT+IG5ZiEaSz4ENoyRdjcIg38pZM9w7tQfNTdMqDXt8HFdYmHBsWQAGJWWYXHDCX1kAl5yiRQHzw==
X-Received: by 2002:a17:902:d490:b0:1bd:e64c:5c7e with SMTP id c16-20020a170902d49000b001bde64c5c7emr3923448plg.61.1692054837613;
        Mon, 14 Aug 2023 16:13:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm9671965plk.100.2023.08.14.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:13:56 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:13:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] powerpc/ps3: refactor strncpy usage attempt 2
Message-ID: <202308141612.818819C6@keescook>
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
 <20230811-strncpy-arch-powerpc-platforms-ps3-v1-2-301052a5663e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-2-301052a5663e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 09:19:20PM +0000, Justin Stitt wrote:
> This approach tries to use `make_field` inside of `make_first_field`.
> This comes with some weird implementation as to get the same result we
> need to first subtract `index` from the `make_field` result whilst being
> careful with order of operations. We then have to add index back.

I think for readability, it's better to avoid the function composition.
The index subtraction undoes the earlier addition -- I say just leave it
separate.

i.e. I like option 1 of 3 the best.

-Kees

-- 
Kees Cook
