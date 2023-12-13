Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B9F811F00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442509AbjLMTfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjLMTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:35:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07365AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:35:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d08a924fcfso68481295ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702496107; x=1703100907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ttEJmwOfFPg4dyyo48XQBXEPlFS3JK9/Eb3g52bvV2c=;
        b=HdSYZ+Rlt1kWmT46bbXaflDm+/1pwDeZwYtfIqLV/dUewHeJQ5Qnb1SQRrNht+qSnd
         EMRlVkPRcdn5WZ+mPwRYrWdUwpmz7SrILISMDEFW9X5F8rmK0z3voMNUNsxR17asaa5a
         wTat7gA4fb4PzsekaRA7cXM4pBT/UZp3kL5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496107; x=1703100907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttEJmwOfFPg4dyyo48XQBXEPlFS3JK9/Eb3g52bvV2c=;
        b=M9xZ7d71p2lGlGttYMaBQc9UFcsImBEHraGkZjZHqLZRWK5TzG8xgVCIVBdL5nNnnj
         YFnAa9nCEOEw2D3i9U4K1u/m8TJRTfv40M4BgLhCODZVz3jfLWZk7P9YZ4lDUJJ/cGxl
         R0TRiykn124xiR7j8JoFXCXBmnCRv1e38AF4ZKE9jqUgt9SdAip4zmPwQDIp/SmQjPSf
         jEvHufCZY2+OuJtbvq9hzjjTw2RmAjBJR+rG0KTRN6GtHFthvhY2neoti5jLWIsIT7us
         vJr3AjuHW5N6j4kF/TFMX+eI+sPZcuox6kw2WTovb0KuD253C2ejCQlfDtKDg+lrPBLN
         25Kg==
X-Gm-Message-State: AOJu0YyU7Gga8IX2rw7XNMHeqRsAfgDLEol7jKYFniS43yU+vdMqk8Hy
        QOPcPxi6N42p/7u3Uw+0u5hm3w==
X-Google-Smtp-Source: AGHT+IF4/fKIdL6ujzk6XlIo1i2yhsQEzRVErQDBQru9JHnbSf6YHVNRS6vt2G7Eru9MYelslDEWdQ==
X-Received: by 2002:a17:902:7e84:b0:1d3:141:cb06 with SMTP id z4-20020a1709027e8400b001d30141cb06mr6392448pla.113.1702496107474;
        Wed, 13 Dec 2023 11:35:07 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q20-20020a656854000000b005b7dd356f75sm8909940pgt.32.2023.12.13.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:35:06 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:35:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Wang <wanglikun@lixiang.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Changbin Du <changbin.du@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        gcc-patches@gcc.gnu.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Roth <michael.roth@amd.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yuntao Wang <ytcoode@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Dan Li <ashimida.1990@gmail.com>
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
Message-ID: <202312131132.639E8802B@keescook>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com>
 <20230327093016.GB4253@hirez.programming.kicks-ass.net>
 <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
 <CAE+Z0PFZaa2bwtfY5P7ZDYH4JjMxKpJgqz0m+KJ_ks4dctzAKA@mail.gmail.com>
 <4a84af95-6270-6764-6a40-875ec20fc3e1@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a84af95-6270-6764-6a40-875ec20fc3e1@lixiang.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 05:01:07PM +0800, Wang wrote:
> On 2023/12/13 16:48, Dan Li wrote:
> > + Likun
> >
> > On Tue, 28 Mar 2023 at 06:18, Sami Tolvanen <samitolvanen@google.com> wrote:
> >> On Mon, Mar 27, 2023 at 2:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>> On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
> >>>
> >>>> In the compiler part[4], most of the content is the same as Sami's
> >>>> implementation[3], except for some minor differences, mainly including:
> >>>>
> >>>> 1. The function typeid is calculated differently and it is difficult
> >>>> to be consistent.
> >>> This means there is an effective ABI break between the compilers, which
> >>> is sad :-( Is there really nothing to be done about this?
> >> I agree, this would be unfortunate, and would also be a compatibility
> >> issue with rustc where there's ongoing work to support
> >> clang-compatible CFI type hashes:
> >>
> >> https://github.com/rust-lang/rust/pull/105452
> >>
> >> Sami
> 
> 
> Hi Peter and Sami
> 
> I am Dan Li's colleague, and I will take over and continue the work of CFI.

Welcome; this is great news! :) Thanks for picking up the work.

> 
> Regarding the issue of gcc cfi type id being compatible with clang, we 
> have analyzed and verified:
> 
> 1. clang uses Mangling defined in Itanium C++ ABI to encode the function 
> prototype, and uses the encoding result as input to generate cfi type id;
> 2. Currently, gcc only implements mangling for the C++ compiler, and the 
> function prototype coding generated by these interfaces is compatible 
> with clang, but gcc's c compiler does not support mangling.;
> 
> Adding mangling to gcc's c compiler is a huge and difficult task，because 
> we have to refactor the mangling of C++, splitting it into basic 
> mangling and language specific mangling, and adding support for the c 
> language which requires a deep understanding of the compiler and 
> language processing parts.
> 
> And for the kernel cfi, I suggest separating type compatibility from CFI 
> basic functions. Type compatibility is independent from CFI basic 
> funcitons and should be dealt with under another topic. Should we focus 
> on the main issus of cfi, and  let it work first on linux kernel, and 
> left the compatible issue to be solved later?

If you mean keeping the hashes identical between Clang/LLVM and GCC,
I think this is going to be a requirement due to adding Rust to the
build environment (which uses the LLVM mangling and hashing).

FWIW, I think the subset of type mangling needed isn't the entirely C++
language spec, so it shouldn't be hard to add this to GCC.

-Kees

-- 
Kees Cook
