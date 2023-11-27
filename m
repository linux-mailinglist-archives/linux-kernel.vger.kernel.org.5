Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483917FAD69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjK0WXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjK0WXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:23:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91C2113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:20:47 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd3cf2e21dso70898197b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123647; x=1701728447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oznesxFwrvBjWVLV8MzMnU76lp7dsyZKrsJygxTLUfs=;
        b=uSglpwttk5Fyc0kVd9ilOFq7e5RjvY3YcgqHqS8KNCXnzcUgktluRBwDqGP3zlo2tm
         Ah/GuhXDMQ/Vs4mXsrpuyWft83AUzRGaCs6+POLNx7uadwyIGJx/0M9SPhYEH5xc5jKs
         VYH1d0Od/gvDozUdntLP5hhnSMnWO3CR9XKCoyTd5SBvwZxHgM9I9KF8Wqpw7epKfJxY
         gboFmdX89mSmvJ/L2aFAYmmRxVUYMjLc38Hbv79dLY5fGx3vtt8LpopXmbhlB7QvVOs0
         AaXQAU2b1s633wVpSGBa4R3FheeLjJBva+tg8SXgn4uBPXo4Y36jlojET+yz66PRTica
         6NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123647; x=1701728447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oznesxFwrvBjWVLV8MzMnU76lp7dsyZKrsJygxTLUfs=;
        b=NVER6OMLyfFnMaRCyUZvz8Rk2kef6UhUWBNqbBmdw/6iy+f0Ph8UT4sfs/oSRbt7PR
         OEPlDtIK5HonMEOfSp+8xQzKuOSqOr5joxWOQGkVMmuAOrvNvWSDanKeLHosDlSFRP0d
         zFb3gwyHhThwpFyfGbmnoUYzAp9Ft0JP3jSP7keD3Hzlz1gjJ/zzh0Qo2LJ0as+EUVvG
         oWYLzt+7z21hDmGiXNBLRfQJXi9jPP5BPE3rsx/LQmQ8W8KSZs16KALB7+xVfRlHeRNR
         2mxyzb3acPviV08ziYhufhkQ1MC/SOtQLrw5zGuA4ZOEyESzV6YxVo42XC4Lw5aLBvR3
         GBKw==
X-Gm-Message-State: AOJu0YxqrfHNzjVf4xR+It1ItonOiSzJrfgA9EuU8kL7/PrH+8wb9UsX
        nX16PchHRjV3uyUZivm+7fSsfuqfIcM=
X-Google-Smtp-Source: AGHT+IFwra0+HV5FKvUpEQxDt3kN8Dy+vJAehp6awy7CFsSorhFrKshysFPUsywbqDFjIVgQl8OCUKb9/sk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4406:0:b0:5cb:6639:8024 with SMTP id
 r6-20020a814406000000b005cb66398024mr417245ywa.6.1701123646847; Mon, 27 Nov
 2023 14:20:46 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:20:45 -0800
In-Reply-To: <20231120105528.760306-4-vschneid@redhat.com>
Mime-Version: 1.0
References: <20231120105528.760306-1-vschneid@redhat.com> <20231120105528.760306-4-vschneid@redhat.com>
Message-ID: <ZWUWPQJLY4rzHXFR@google.com>
Subject: Re: [PATCH 3/5] x86/kvm: Make kvm_async_pf_enabled __ro_after_init
From:   Sean Christopherson <seanjc@google.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023, Valentin Schneider wrote:
> kvm_async_pf_enabled is only ever enabled in __init kvm_guest_init(), so
> mark it as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
