Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC347B26A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjI1UdD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:33:01 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527A193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:32:59 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 0A99E1608A0;
        Thu, 28 Sep 2023 20:32:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id F31731E;
        Thu, 28 Sep 2023 20:32:54 +0000 (UTC)
Message-ID: <106c8bdb960da1568d0b3879efa76cd2acec032e.camel@perches.com>
Subject: Re: [PATCH] rust: Use awk instead of recent xargs
From:   Joe Perches <joe@perches.com>
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 28 Sep 2023 13:32:54 -0700
In-Reply-To: <20230928202116.2298150-1-mmaurer@google.com>
References: <20230928202116.2298150-1-mmaurer@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: F31731E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: 67tkdiae9ogk9pwpmkepescmsduebrbn
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Bt12lxOUK/nQPPHuW9jhdiJDE/X/B1DU=
X-HE-Tag: 1695933174-351742
X-HE-Meta: U2FsdGVkX1+Bb+eXtRzmfDkcJalEWFI1h+DdroDZ98TU2VBln2kEz1QIrF3HVTUf6bRGFWH/SU3QbNwxK/6cEUXTwms7Iu+5s/vpLULeFxUuaY/m1Av9DBokc8Vw0NQB0ZNMs/yK+e5wgo3cKbx3f/qYalKvE84nqPSsZ0junjAMxa9bV3i/92HnC21/nqnY6nfQi8PO5+qoZvse8Z6OC8ekbMpc72x+ymTzzajbC1Nw85rb3b2LCc1qIByoUUlAg5YlIKy0Rb0TeZzECDqHqV+TObjQY9Je5bpjaOoplPFWoCQTByAHOoC+Zj2c1sbX
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 20:21 +0000, Matthew Maurer wrote:
> `awk` is already required by the kernel build, and the `xargs` feature
> used in current Rust detection is not present in all `xargs` (notably,
> toybox based xargs, used in the Android kernel build).
[]
> diff --git a/rust/Makefile b/rust/Makefile
[]
> @@ -365,8 +365,7 @@ quiet_cmd_exports = EXPORTS $@
>        cmd_exports = \
>  	$(NM) -p --defined-only $< \
>  		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
> -		| xargs -Isymbol \
> -		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
> +		| awk 'NF {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$0}' > $@

Perhaps remove the cut as well and use $$3 instead of $$0 ?
Maybe integrate the grep as well.

