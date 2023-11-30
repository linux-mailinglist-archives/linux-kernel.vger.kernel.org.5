Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04687FEF77
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjK3Mqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjK3Mqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:46:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81932D50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:46:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607AAC433C8;
        Thu, 30 Nov 2023 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701348405;
        bh=Turv8447m0iSBp/1OD7/8HA4BfAu143dTXX+sHwM0FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqekIxo6sLR+ZJAdumnjYlqU2xkYUbQi9E5yxc7xwxXoiHS8WTSoDX0k4CjTjTNrR
         mBpKj8soTxt0h5dT2M1MGA24pCTg3NAesXV4tzAC9rhTph2SKpsKTbwyGUr5AGKDt0
         BKmvPGyXA1E1rXsB0Z63r3ja5QnXla6gxH+w2XWJA/IZGsFVlUrcKe1XXdzwkbV39B
         JO9RtBINtp9hZHoTwT3yS/3fbPClifFhi6JVfwLdzwOFWnQJOaz7pFJhZQs5tGLxq1
         YQOCR3pEWHtg3zf9Nrm8ATXKwUppSWBHxpCnrNUtsCElu0jKG+SGXVteOhAYrDjsf5
         ZjTutNZycpi8w==
Date:   Thu, 30 Nov 2023 13:46:36 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231130-wohle-einfuhr-1708e9c3e596@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129164815.GI23596@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:48:15PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 05:28:27PM +0100, Christian Brauner wrote:
> 
> > > +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> > > +				  struct pid_namespace *ns)
> > > +{
> > > +	return task_tgid_nr_ns(tsk, ns);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
> > 
> > I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> > why they are needed? Because they are/can be static inlines and that
> > somehow doesn't work?
> 
> Correct, because Rust can only talk to C ABI, it cannot use C headers.
> Bindgen would need to translate the full C headers into valid Rust for
> that to work.
> 
> I really think the Rust peoples should spend more effort on that,
> because you are quite right, all this wrappery is tedious at best.

The problem is that we end up with a long list of explicit exports that
also are all really weirdly named like rust_helper_*(). I wouldn't even
complain if it they were somehow auto-generated but as you say that
might be out of scope.

The thing is though that if I want to change the static inlines I know
also have to very likely care about these explicit Rust wrappers which
seems less than ideal.

So if we could not do rust_helper_*() exports we'd probably be better
off.
