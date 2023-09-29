Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A07B3D02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjI2X3a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2X32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:29:28 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F00EB;
        Fri, 29 Sep 2023 16:29:26 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 1FD741A05D2;
        Fri, 29 Sep 2023 23:29:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id B10482002E;
        Fri, 29 Sep 2023 23:29:18 +0000 (UTC)
Message-ID: <02ce99b98cd21c67f30d5be1e5fd4fd130e0413d.camel@perches.com>
Subject: Re: [PATCH] rust: Use awk instead of recent xargs
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Sep 2023 16:29:17 -0700
In-Reply-To: <be10d55a785d4d9b983b2dae6ed65942@AcuMS.aculab.com>
References: <20230928202116.2298150-1-mmaurer@google.com>
         <106c8bdb960da1568d0b3879efa76cd2acec032e.camel@perches.com>
         <be10d55a785d4d9b983b2dae6ed65942@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: B10482002E
X-Stat-Signature: 5x7bqnseu4i4qrk95mmsjmjjnwursijh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19KqW6+BJFwy7aVcBLC/jBgbHDcPJORu8k=
X-HE-Tag: 1696030158-560548
X-HE-Meta: U2FsdGVkX19EIcvhOKccUk/K+iP+kHV0hP9ENaBwmQ8psiN52dkc7wSX+48GZZ2KcARzX4yokh3pcBT40s/ioX5czzUzm1lNUuw/CWchRfz7wkXDGyqGPdELmsykIs8/3lmw+fhhsLilM4AWnF/P8h4yAnqHpkO95g5z4EyMQnBZOa1PlwkW+6J53DBwMYG+RWPolxSDRW5x5SHmbIAdPSIyWB1QESgEjXIp3rPvBS4mJhB/R+Su8CPW3rT7YKtJfFEkMxqZ1kSLIaPe9ahqKhevDZaP96WR7Gh3avJko2GiAn5FASJFHNRhUiV2wQCZ
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 21:36 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 28 September 2023 21:33
> > 
> > On Thu, 2023-09-28 at 20:21 +0000, Matthew Maurer wrote:
> > > `awk` is already required by the kernel build, and the `xargs` feature
> > > used in current Rust detection is not present in all `xargs` (notably,
> > > toybox based xargs, used in the Android kernel build).
> > []
> > > diff --git a/rust/Makefile b/rust/Makefile
> > []
> > > @@ -365,8 +365,7 @@ quiet_cmd_exports = EXPORTS $@
> > >        cmd_exports = \
> > >  	$(NM) -p --defined-only $< \
> > >  		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
> > > -		| xargs -Isymbol \
> > > -		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
> > > +		| awk 'NF {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$0}' > $@
> > 
> > Perhaps remove the cut as well and use $$3 instead of $$0 ?
> > Maybe integrate the grep as well.
> 
> Or keep the grep and use a shell loop?
> 	grep -E ' (T|R|D) ' | while read val flag symbol; do \
> 		echo "EXPORT_SYMBOL_RUST_GPL($symbol);"; done
> 
> (The grep is typically much faster than a shell conditional.)
> 

Bikeshed:

no grep just a single awk with whatever the appropriate syntax is like

awk '{ if ($$2 ~ /^[TRD]$/) { printf "EXPORT_SYMBOL_RUST(%s);\n", $$3 } }'

