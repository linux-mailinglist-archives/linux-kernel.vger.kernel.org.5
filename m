Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303076F5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHCWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHCWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:43:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72741E67
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:43:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b4749013so12669175ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691102580; x=1691707380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INe5iUN8OqFkxldA5UUSZCvoiHbOkh93tbzwvbZM2yg=;
        b=AdrcoKcYKsDTC2sk5II1JfGBSGWxn+Mf/Sxnutk3q1l506vOr49iIj/50hD798HN7F
         b0OZc7JKWeDh12FhSjL1Xl4BHhP+B9RobN0klmBuKMhnefOK9+UFoMYitJo0B22Um2dY
         eJvU1iwgwiD/b9pJcn2WLq9Pd4MHq6mJciEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691102580; x=1691707380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INe5iUN8OqFkxldA5UUSZCvoiHbOkh93tbzwvbZM2yg=;
        b=L83MJN0PqC7kAhZK31Ze6ZXnlG8lj+2soUNYPg5jQzc7gJslRpKIZ0HKkEZQYcL2Lj
         XWZ836h6r/YyY3QMlDbg3MwQFo7nWUzc4arpr66GxfnlvYW0NcK6Laa4ejK7FfTDoCxr
         D9qslnZwWWjjW1uSZW/lMkGbU8bXi3DMpZSfVwxffpykgrRx4gte+pf6c4Cfon0RL0y0
         Iw3c19dzI1T26gK4493rLLrekxEaE2E1C664NwaVcuPKxUzUG4+kWeMrfXfXh7PrgZhn
         sZk0sk8c+lUd4k+6kC7kvwcc34WDoD5MJt+rlUHCwe9dqKUdlbDURgX7F1BPcJhKE8KY
         aLbw==
X-Gm-Message-State: AOJu0YyYBbwlCKRqwkKqprev0kmHATOVjdaXIvE5TyF5iNPm05/E9uJl
        t0D0C1Dxvbbl0j0PkII/IC3svg==
X-Google-Smtp-Source: AGHT+IFvgcDqbfRdpydPq4ink9vQ3N7ScSsxcZoM/8xiqyVFgUTfakh0jjBFWkrGAUhq6+xeRCxMNQ==
X-Received: by 2002:a17:903:2351:b0:1bb:a85c:23cc with SMTP id c17-20020a170903235100b001bba85c23ccmr141262plh.15.1691102579859;
        Thu, 03 Aug 2023 15:42:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902bd0700b001bc2831e1a8sm355952pls.80.2023.08.03.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:42:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/paravirt: Fix tlb_remove_table function callback prototype warning
Date:   Thu,  3 Aug 2023 15:42:49 -0700
Message-Id: <169110256709.2294259.13111562642254330671.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726231139.never.601-kees@kernel.org>
References: <20230726231139.never.601-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 16:11:43 -0700, Kees Cook wrote:
> Under W=1, this warning is visible in Clang 16 and newer:
> 
> arch/x86/kernel/paravirt.c:337:4: warning: cast from 'void (*)(struct mmu_gather *, struct page *)' to 'void (*)(struct mmu_gather *, void *)' converts to incompatible function type [-Wcast-function-type-strict]
>                            (void (*)(struct mmu_gather *, void *))tlb_remove_page,
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a direct wrapper instead, which will make this warning (and
> potential KCFI failures) go away.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] x86/paravirt: Fix tlb_remove_table function callback prototype warning
      https://git.kernel.org/kees/c/fcce1c6cb156

Take care,

-- 
Kees Cook

