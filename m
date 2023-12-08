Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BC80AE75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjLHU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjLHU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:57:33 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841771738
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:57:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d0a7b72203so22390275ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702069059; x=1702673859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tys/vW6TJrvqB1xe5pT6Lgn/PsDKvZ4BwsQlECLsYBs=;
        b=PRTW3BZCfbXCMbIbbjF0R2L8LA7Rn1g9VuJIVK5dZwH/WiNsRPjf/4jsvdnNXVJdlw
         eNquk2M244ZrHbTzsS4ZDV/0qCadMIZXIQb9drDLfvjfeJ9jDxh2MrcbC9awGCXYKjqY
         RpjbVGc0c8Ssr9nw3Nf55/N4DPq1EuKooGaf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069059; x=1702673859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tys/vW6TJrvqB1xe5pT6Lgn/PsDKvZ4BwsQlECLsYBs=;
        b=kfzQfsqk9Kc8lraohtJvetRUa/X7/L0ZdxqJtPEjbOGjrkswcnnE9DsHsg3Hp3mGqI
         VWFnNwroJC6uiYx+20fZjAnX0Fub6hgQXEPPg4Gqrf8FcEIP4nOTiTGJFiVhqOrWBEgJ
         SzQOlDM7pOdv+1ozqL3g3YvISnAefMTl8bVQhDFvlNKtvjd3xiKkW4ZOuxBxqrcxrMw6
         Fl8kM7XY8fpDPDfEb6rpnhtTf8MSdHJ+U6/dnQZL8v8IhYmebp6N0PJboyX0DDQsKBz0
         TYCWUOeVNzHX9BNd+8MT2jHDa+o0QK6rkUwBUkDLGXrxUVqpzHiVIVLsklEF83GCJZRe
         2E9Q==
X-Gm-Message-State: AOJu0YxnZF5T18DnE2o0MwdTB1O5N9gBNICAjkNyg+EkRSdI1wiBucMJ
        9y9JhV5Ef5YzQFtryssCNz9tuA==
X-Google-Smtp-Source: AGHT+IGBI3DTSz3M2P/N3EoKLc20ALho3WNNQ9FkBDmD8W5/Jq1bLWYaPm1D7IkQUUnQMxuOVi4Hng==
X-Received: by 2002:a17:903:2585:b0:1d0:6ffe:9f1 with SMTP id jb5-20020a170903258500b001d06ffe09f1mr611230plb.79.1702069059024;
        Fri, 08 Dec 2023 12:57:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm2131874plo.237.2023.12.08.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:57:38 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:57:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <202312081251.A5D363C0@keescook>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
 <20231208165702.GI28727@noisy.programming.kicks-ass.net>
 <202312080947.674CD2DC7@keescook>
 <20231208204501.GJ28727@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208204501.GJ28727@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:45:01PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 08, 2023 at 10:18:47AM -0800, Kees Cook wrote:
> 
> > Even if we look at the prerequisites for mounting an attack here, we've
> > already got things in place to help mitigate arbitrary code execution
> > (KCFI, BTI, etc). Nothing is perfect, but speculation gadgets are
> > pretty far down on the list of concerns, IMO. We have no real x86 ROP
> > defense right now in the kernel, so that's a much lower hanging fruit
> > for attackers.
> 
> Supervisor shadow stacks, as they exist today, just can't work on Linux.

Yeah, totally agreed. I still wonder if we can extend KCFI to cover
return paths (i.e. emitting cookies for return destinations and doing
pre-return cookie checking for return destinations).

> Should get fixed with FRED, but yeah, this is all somewhat unfortunate.

Agreed.

> > As another comparison, on x86 there are so many direct execution gadgets
> > present in middle-of-instruction code patterns that worrying about a
> > speculation gadget seems silly to me.
> 
> FineIBT (or even IBT) limits the middle of function gadgets
> significantly.

Right -- for indirect calls we are at least able to restrict to
same-prototype (KCFI) or "actual function" (IBT).

Regardless, for the case at hand, it seems like the Rust wrappers are
still not "reachable" since we do BTB stuffing to defang these kinds of
speculation gadgets.

-Kees

-- 
Kees Cook
