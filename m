Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C39801DC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjLBQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjLBQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:36:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF2114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 08:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701534973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yt4yCDhbgJbVqEjZGY+0zrwL/gtoQ/Q8nFWZ1u+3nY8=;
        b=cyGcmui40LxaaDL147+fL4K1GV5zvfXhAQqptcYdDztAPPbtFhWLAEXnQKkS7upnB1cBqp
        HrX6PokkYHfCy37HnizIrg51TG2+B5adPsT6qKSSGK/qLNA/2r29UttZFNfLWDemlml1lK
        SuoLPbq5UKPXcSn0hKJNdlH3Z8lG5Fo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-clfMpRNYN6KO0aAbx0B9JA-1; Sat, 02 Dec 2023 11:36:11 -0500
X-MC-Unique: clfMpRNYN6KO0aAbx0B9JA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-db8d6cadc6aso327196276.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 08:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701534968; x=1702139768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt4yCDhbgJbVqEjZGY+0zrwL/gtoQ/Q8nFWZ1u+3nY8=;
        b=pCy0q0JlLLGC/zJk9dYnJ1/8OjO9c5NsS2JkWtkaNv7GyFY9DmVkAtmJ7xWoQxMf8y
         KE9Zl8H/P2R6C+ZuX0C9dUV3mRDRN8dpu0Xe2GcLuXGWq8DcAccoPT5/TiqOAsiA+HBd
         q/JcUr8VUWMCGo72U8spcu2JhE9QpDtkT2AlqoUZKrJZz64CQsE8z26+NvQst1Kt55I/
         Dp631lifAhNTjJPwJakyFsDA7Mi4TjheTCPBJ5OYRu66EJkklCFQLiCI2pebyseyL0h1
         O6vSQWTN1I8g8j5VCPaxWGCy4clqJToxurhoGS2/xsTc6wAhX5OPIpZrAdZSdO0nPjGN
         RY6w==
X-Gm-Message-State: AOJu0YyUAGRhv0epxLvrHTNtJxG0fa2UeyEHmsfuJhHMRc9ivZiT4QEM
        WQUFqMr3lodCLGbjwgnA3TCCxcYTNZJf+CNm8eKLfaPJG5ckpQsYwTnEAU5GdeWnxYimFCJXQBi
        nUvAJvNV+zd5Aria5mpU/FQlu
X-Received: by 2002:a25:ae8c:0:b0:db7:dacf:59e4 with SMTP id b12-20020a25ae8c000000b00db7dacf59e4mr769295ybj.88.1701534968783;
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEftyDWBBv+mMnPECb2rVK9oTYatxunIoB2W4Ql4AbzgDHuw14U6JLB0Zeu8QENlNaWlUxpXw==
X-Received: by 2002:a25:ae8c:0:b0:db7:dacf:59e4 with SMTP id b12-20020a25ae8c000000b00db7dacf59e4mr769287ybj.88.1701534968536;
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
Received: from treble (fixed-187-191-47-119.totalplay.net. [187.191.47.119])
        by smtp.gmail.com with ESMTPSA id b25-20020a67e999000000b0046450681113sm698807vso.9.2023.12.02.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
Date:   Sat, 2 Dec 2023 10:36:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
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
Subject: Re: [PATCH 0/5] jump_label: Fix __ro_after_init keys for modules &
 annotate some keys
Message-ID: <20231201204400.wckmtoe3kroiyv4s@treble>
References: <20231120105528.760306-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120105528.760306-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:55:23AM +0100, Valentin Schneider wrote:
> Hi folks,
> 
> After chatting about deferring IPIs [1] at LPC I had another look at my patches
> and realized a handful of them could already be sent as-is.
> 
> This series contains the __ro_after_init static_key bits, which fixes
> __ro_after_init keys used in modules (courtesy of PeterZ) and flags more keys as
> __ro_after_init.
> 
> [1]: https://lore.kernel.org/lkml/20230720163056.2564824-1-vschneid@redhat.com/

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

