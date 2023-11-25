Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8EC7F8BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjKYPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKYPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B2FF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:10:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441A3C433C8;
        Sat, 25 Nov 2023 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700925039;
        bh=FlMufzO053ZuJAQw/jq0Rz/Fa4Pj3XjQjS1W/sgM/ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3uJ3Mfdj4/jbleZ6R9YAwVbDGrKkoBTnctw/nCVyE2a13FUqaDD3AEWvVZHE5nsl
         gV0dzsN9pRkXTDin54Zbo0Cuqe8RLvqf9yOipfJ5BMTdNRlipnXVQDhkLruLTIf/Ev
         D2LGYPWN0MN24TPXHgc852V5wZ+no1lqUOPSjUGg=
Date:   Sat, 25 Nov 2023 15:10:36 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values
 in `#[pin_data]`
Message-ID: <2023112514-laziness-valium-7a25@gregkh>
References: <20231125125024.1235933-1-benno.lossin@proton.me>
 <20231125125024.1235933-2-benno.lossin@proton.me>
 <2023112525-impatient-untwist-ee3d@gregkh>
 <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 03:02:00PM +0000, Benno Lossin wrote:
> On 25.11.23 15:26, Greg KH wrote:
> > On Sat, Nov 25, 2023 at 12:51:09PM +0000, Benno Lossin wrote:
> >> This patch adds compatibilty for generic parameters defaults by using
> >> the newly introduced `decl_generics` instead of the `impl_generics`.
> > 
> > This says _what_ is happening here, but not _why_ this is needed at all.
> > 
> > Try taking a look a the kernel documentation for how to write a good
> > changelog text to make this much better.  It's often times the most
> > difficult portion of making a kernel patch, the code is easy, writing a
> > summary of why everyone else should agree that this code is acceptable
> > is hard.
> 
> The reason is hidden in the third patch.

Please do not hide things, patches need to be stand-alone and
understandable that way, otherwise they will be rejected as no one can
understand why they would be needed.

> Without this, the `#[pin_data]
> macro would not allow specifying const generic parameter default values
> and instead emit a compile error.

That's nice, but it still doesn't tell me _why_ this is needed.  Why
would I want any generic paramter default values at all?  Who needs any
of this?  What will it be used for?  What does it actually do?

thanks,

greg k-h
