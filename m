Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9080AC0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjLHS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:29:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8290
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:29:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cec976b197so1228148b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702060167; x=1702664967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYr+i/5NYC3JxHFPI2U93kF4hGY9T4auZhKGKiOPNQ0=;
        b=kHVnjikMJ8sBJkpxzMJH8TGeYPDCRNcWe0xMt9OuB/ulypTZPHYi+fTnQSgz1g6gVM
         7lfMOdf8ZmsFg0HVpyBjTxEGA9DWqzjsfwsfsdnk6r9rfmLGVtioc6Qkmubo7Rn2GB8y
         SuvlggiglrNgLjK7M047un0d4ZF00oX3FJh8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060167; x=1702664967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYr+i/5NYC3JxHFPI2U93kF4hGY9T4auZhKGKiOPNQ0=;
        b=V1M4F/GeyK905ApoKwZheMwH+TIKdXJb+xKJJn4h4mmnkj9dNOoTXNFGxVOPvCRbUQ
         x5T7xWPTiQ1n/jzzsWXBF0syAt3wd+9YRNNWqQzbKLmaUzd3Kkaj872bT9KSlT+aZVDR
         4Xp9v/AQwOHkiN3JrauyxCB9HcctChsMq5ff7XDbq0yvTwljvl4bywDdhMyNk5QVSMay
         JzW/2I8ATK0qgSxhvpTf9xzTtlLIIb+g7MWu4CjXYi7A2YIka0+uWSZgbKyPRF0IVZdd
         vigRUnK643zPeXAHm4p9dqrTsus3OlxNCKKtaVoX7CvjWPeoETWNaPnpWSwqBhyxvy/O
         75Yg==
X-Gm-Message-State: AOJu0YzAdps6ITNU+pSikws3Ki9Gfgg42GSclTp5/PnICM5oKLFj3DGY
        IpggBKqHnyBZBKjw50fm3g6SRQ==
X-Google-Smtp-Source: AGHT+IEma1zSM6Y9S/+UI5j3p/5Dq4kkVNLpVZGExv6IrOEFo4uGT5o+AV+5AuIOPLXchpFMpklmRA==
X-Received: by 2002:a05:6a00:15cb:b0:6ce:49f9:d3e1 with SMTP id o11-20020a056a0015cb00b006ce49f9d3e1mr494561pfu.12.1702060166997;
        Fri, 08 Dec 2023 10:29:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b006ce742b6b1fsm1900019pfb.63.2023.12.08.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:29:26 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:29:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <202312081027.BA44B7B3@keescook>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 05:57:05PM +0300, Alexey Dobriyan wrote:
> On Wed, Dec 06, 2023 at 12:47:27PM -0800, Kees Cook wrote:
> > Can't we have a generic ARCH_AT_PAGE_SHIFT_MASK too? Something like:
> > 
> > #ifndef ARCH_AT_PAGE_SHIFT_MASK
> > #define ARCH_AT_PAGE_SHIFT_MASK
> > 	NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, 1 << PAGE_SHIFT)
> > #endif
> > 
> > Or am I misunderstanding something here?
> 
> 1) Arch maintainers can opt into this new way to report information at
>    their own pace.
> 
> 2) AT_PAGE_SHIFT_MASK is about _all_ pagesizes supported by CPU.
>    Reporting just one is missing the point.
> 
>    I'll clarify comment: mmap() support require many things including
>    tests for hugetlbfs being mounted, this is about CPU support.

I significantly prefer APIs not being arch-specific, so I'd prefer we
always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
1 << PAGE_SHIFT, but it might be incomplete.

-- 
Kees Cook
